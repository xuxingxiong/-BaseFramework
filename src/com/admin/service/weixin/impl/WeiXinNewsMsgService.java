package com.admin.service.weixin.impl;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.weixin.entity.MaterialArticle;
import com.weixin.entity.MaterialItem;
import com.weixin.entity.MsgNews;
import com.weixin.interceptor.MpAccount;
import com.weixin.interceptor.WxApiClient;
import com.weixin.interceptor.WxMemoryCacheClient;

import net.sf.json.JSONObject;

import com.admin.service.weixin.WeiXinNewsMsgManager;

/**
 * 说明： 图文消息 创建人：FH Q313596790 创建时间：2016-12-24
 * 
 * @version
 */
@Service("weixinnewsmsgService")
public class WeiXinNewsMsgService implements WeiXinNewsMsgManager {
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	private  static final  String ADD="add";
	private  static final  String DEL="del";
	private  static final  String EDI="edit";
	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception {
		PageData base = (PageData) dao.findForObject("WeixinMsgMapper.findByInputCode", pd);
		if (null == base) {
			dao.save("WeixinMsgMapper.save", pd);
			base = (PageData) dao.findForObject("WeixinMsgMapper.findByInputCode", pd);
		}
		pd.put("BASE_ID", base.get("WEIXINMSG_ID"));
		MaterialArticle item = NewsToWeixin(pd,ADD);
		pd.put("URL",item.getUrl());
		pd.put("MEDIA_ID",item.getMedia_id());
		dao.save("WeiXinNewsMsgMapper.save", pd);
	}

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */

	public void delete(PageData pd) throws Exception {
		PageData base = findById(pd);
		if (null ==base)
		{
			throw new Exception("该消息已被删除");
		}
		
		MaterialArticle item = NewsToWeixin(base,DEL);
		
		MpAccount mpAccount = WxMemoryCacheClient.getSingleMpAccount();
		if (WxApiClient.delMaterial(item.getMedia_id(),mpAccount)){
			mpAccount = WxMemoryCacheClient.getSingleMpAccount();
			WxApiClient.delMaterial(item.getThumb_media_id(),mpAccount);	
			
			dao.delete("WeiXinNewsMsgMapper.delete", base);			
			PageData newpd  = (PageData) dao.findForObject("WeixinMsgMapper.msgcount", base);
			
			long count = (long)newpd.get("msgCount");
			if (0 == count){
				base.put("WEIXINMSG_ID", base.get("BASE_ID"));
				dao.delete("WeixinMsgMapper.delete", base);	
			}
		}
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception {

		MaterialArticle item = NewsToWeixin(pd,EDI);
		
		PageData newMsgpd = findById(pd);
		if (null ==newMsgpd)
		{
			throw new Exception("该消息已被删除");
		}
		
		String baseid = pd.getString("BASE_ID");
		
		if(!newMsgpd.getString("INPUTCODE").equals(pd.getString("INPUTCODE")))
		{
			PageData base = (PageData) dao.findForObject("WeixinMsgMapper.findByInputCode", pd);
			if (null == base) {
				dao.save("WeixinMsgMapper.save", pd);
				base = (PageData) dao.findForObject("WeixinMsgMapper.findByInputCode", pd);
				baseid = base.getString("BASE_ID");
			}
			
			PageData countpd  = (PageData) dao.findForObject("WeixinMsgMapper.msgcount", pd);
			long count = (long)countpd.get("msgCount");
			if (1 == count){
				countpd.put("WEIXINMSG_ID", pd.get("BASE_ID"));
				dao.delete("WeixinMsgMapper.delete", countpd);	
			}
		}
		
		pd.put("BASE_ID", baseid);
		pd.put("THUMB_MEDIA_ID", item.getThumb_media_id());
		pd.put("URL", item.getUrl());
		dao.update("WeiXinNewsMsgMapper.edit", pd);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList("WeiXinNewsMsgMapper.datalistPage", page);
	}

	/**
	 * 列表(全部)
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("WeiXinNewsMsgMapper.listAll", pd);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("WeiXinNewsMsgMapper.findById", pd);
	}

	/**
	 * 批量删除
	 * 
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS) throws Exception {
		for (String id : ArrayDATA_IDS) {
			PageData base = new PageData();
			base.put("WEIXINNEWSMSG_ID", id);
			delete(base);
		}
		//dao.delete("WeiXinNewsMsgMapper.deleteAll", ArrayDATA_IDS);
	}
	private MaterialArticle NewsToWeixin(PageData pd,String type) throws Exception{
		
		MpAccount mpAccount = WxMemoryCacheClient.getSingleMpAccount();
		
		if (ADD.equals(type)){
			List<MsgNews> newlist = new ArrayList<MsgNews>();
			MsgNews news = new MsgNews();
			news.setTitle(pd.getString("TITLE"));//标题
			news.setAuthor(pd.getString("AUTHOR"));//作者
			news.setBrief(pd.getString("BRIEF"));//简介
			news.setDescription(pd.getString("DESCRIPTION"));//描述
			news.setPicpath(pd.getString("PICPATH"));//封面图片
			news.setPicdir(pd.getString("PICDIR"));//封面图片绝对目录
			news.setShowpic(Integer.parseInt(pd.getString("SHOWPIC")));//是否显示图片
			news.setUrl(pd.getString("URL"));//图文消息原文链接
			news.setFromurl(pd.getString("FROMURL"));//外部链接
			news.setFromurl(pd.getString("THUMB_MEDIA_ID"));//封面ID
			newlist.add(news);
			JSONObject rstObj = WxApiClient.uploadNews(newlist,mpAccount);
			if(rstObj.containsKey("media_id"))
			{
				MaterialItem item = WxApiClient.syncBatchMaterial(rstObj.getString("media_id"),mpAccount);
				if (null==item)
				{
					throw new Exception("素材获取失败");
				}
				if(item.getNewsItems().size()<=0)
				{
					throw new Exception("素材获取失败");
				}
				item.getNewsItems().get(0).setMedia_id(rstObj.getString("media_id"));
				return item.getNewsItems().get(0);
			}
			else
			{
				throw new Exception(rstObj.toString());
			}
		}
		else if (DEL.equals(type)){
			MaterialItem item = WxApiClient.syncBatchMaterial(pd.getString("MEDIA_ID"),mpAccount);
			if (null==item)
			{
				throw new Exception("素材获取失败");
			}
			if(item.getNewsItems().size()<=0)
			{
				throw new Exception("素材获取失败");
			}
			item.getNewsItems().get(0).setMedia_id(pd.getString("MEDIA_ID"));
			return item.getNewsItems().get(0);
		}
		else if (EDI.equals(type)){

			MsgNews news = new MsgNews();
			news.SetMediaId(pd.getString("MEDIA_ID"));
			news.setTitle(pd.getString("TITLE"));//标题
			news.setAuthor(pd.getString("AUTHOR"));//作者
			news.setBrief(pd.getString("BRIEF"));//简介
			news.setDescription(pd.getString("DESCRIPTION"));//描述
			news.setPicpath(pd.getString("PICPATH"));//封面图片
			news.setPicdir(pd.getString("PICDIR"));//封面图片绝对目录
			news.setShowpic(Integer.parseInt(pd.getString("SHOWPIC")));//是否显示图片
			//news.setUrl(pd.getString("URL"));//图文消息原文链接
			news.setFromurl(pd.getString("FROMURL"));//外部链接
			news.setFromurl(pd.getString("THUMB_MEDIA_ID"));//封面ID
			JSONObject rstObj = WxApiClient.updateNews(news,mpAccount);
			if(rstObj.containsKey("errcode") &&rstObj.getInt("errcode") == 0 )
			{
				MaterialItem item = WxApiClient.syncBatchMaterial(pd.getString("MEDIA_ID"),mpAccount);
				if (null==item)
				{
					throw new Exception("素材获取失败");
				}
				if(item.getNewsItems().size()<=0)
				{
					throw new Exception("素材获取失败");
				}
				item.getNewsItems().get(0).setMedia_id(pd.getString("MEDIA_ID"));
				return item.getNewsItems().get(0);
			}
			else
			{
				throw new Exception(rstObj.toString());
			}
		}
		
		return null;
	}
}
