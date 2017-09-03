package com.admin.controller;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.admin.service.weixin.Uploader;
import com.fh.controller.base.BaseController;
import com.fh.service.information.pictures.PicturesManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.FileUpload;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.PathUtil;
import com.fh.util.Tools;
import com.fh.util.Watermark;
import com.weixin.interceptor.MpAccount;
import com.weixin.interceptor.WxApiClient;
import com.weixin.interceptor.WxMemoryCacheClient;

@Controller
@RequestMapping(value="/wxapi")
public class WeiXinImageController  extends BaseController {
	String[] fileType = {".gif" , ".png" , ".jpg" , ".jpeg" , ".bmp"};
	String menuUrl = "wxmsg/list.do"; //菜单地址(权限用)
	@Resource(name="picturesService")
	private PicturesManager picturesService;
	/**新增
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/imgupload")
	@ResponseBody
	public Object imgupload(HttpServletRequest request,HttpServletResponse response) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增图片");
		Map<String,String> map = new HashMap<String,String>();
		String  ffile = DateUtil.getDays(), fileName = "";
		PageData pd = new PageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "add")){
			Uploader up = new Uploader(request);
			up.setSavePath(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile);
			up.setAllowFiles(fileType);
			up.setMaxSize(1024 * 1024); //单位KB
			up.upload();
			//response.getWriter().print("{'original':'"+up.getOriginalName()+"','url':'"+up.getUrl()+"','title':'"+up.getTitle()+"','state':'"+up.getState()+"'}");
			fileName = up.getFileName();
			try{
			map.put("original", up.getOriginalName());
			map.put("title", up.getTitle());
			map.put("state", up.getState());
			map.put("url", GetWeixinUrl(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName));
			}
			catch( Exception ex ){
				map.put("state", "微信上传失败");
			}
			/*pd.put("PICTURES_ID", this.get32UUID());			//主键
			pd.put("TITLE", "图片");								//标题
			pd.put("NAME", fileName);							//文件名
			pd.put("PATH", ffile + "/" + fileName);				//路径
			pd.put("CREATETIME", Tools.date2Str(new Date()));	//创建时间
			pd.put("MASTER_ID", "1");							//附属与
			pd.put("BZ", "图片管理处上传");						//备注
			Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);//加水印
			picturesService.save(pd);*/
		}
		map.put("result", "ok");
		return AppUtil.returnObject(pd, map);
	}
	private String GetWeixinUrl(String filepath) throws Exception{
		MpAccount mpAccount = WxMemoryCacheClient.getSingleMpAccount();
		File f = new File(filepath);
		String url =  WxApiClient.uploadNewsPic(f,mpAccount).getUrl();
		f.delete();
		return url;
	}
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
