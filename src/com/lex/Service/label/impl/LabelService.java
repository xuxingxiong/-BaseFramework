package com.lex.Service.label.impl;

import java.util.Date;
import java.util.List;
import javax.annotation.Resource;

import com.fh.util.Tools;
import com.lex.Service.label.LabelManager;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


/** 
 * 说明： 标签模块粗粒
 * 创建人：FH Q313596790
 * 创建时间：2016-08-16
 * @version
 */
@Service("labelService")
public class LabelService implements LabelManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		pd.put("create_time", Tools.date2Str(new Date()));
		dao.save("LabelMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("LabelMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("LabelMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("LabelMapper.datalistPage", page);
	}

	@Override
	public List<PageData> appList(Page page) throws Exception {
		return (List<PageData>)dao.findForList("LabelMapper.appDataListPage", page);
	}

	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("LabelMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("LabelMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("LabelMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

