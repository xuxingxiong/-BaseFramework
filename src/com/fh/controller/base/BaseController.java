package com.fh.controller.base;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fh.util.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.fh.entity.Page;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author FH Q313596790
 * 修改时间：2015、12、11
 */
public class BaseController {
	
	protected Logger logger = Logger.getLogger(this.getClass());

	private static final long serialVersionUID = 6357869213649815390L;
	
	/** new PageData对象
	 * @return
	 */
	public PageData getPageData(){
		PageData pd = new PageData(this.getRequest());
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME));
		return pd;
	}
	
	/**得到ModelAndView
	 * @return
	 */
	public ModelAndView getModelAndView(){
		return new ModelAndView();
	}
	
	/**得到request对象
	 * @return
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		return request;
	}

	/**得到request对象
	 * @return
	 */
	public HttpServletResponse getResponse() {
		HttpServletResponse response = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getResponse();
		return response;
	}
	/**
	 * 获取Session值
	 * @param key
	 * @return 字符串 不存在时返回空字符串
	 */
	public String getSessionToString(String key){
		Object data = getSessionToObject(key);
		if(null!=data)
		{
			return data.toString();
		}
		else
		{
			return "";
		}
	}
	/**
	 * 获取Session值
	 * @param key
	 * @return Object
	 */
	public Object getSessionToObject(String key){
		return getRequest().getSession().getAttribute(key);
	}
	/**
	 * 设置Session
	 * @param key 键
	 * @param val 值
	 */
	public void setSession(String key,Object val){
		getRequest().getSession().setAttribute(key, val);
		getRequest().getSession().setMaxInactiveInterval(3600*5);
	}
	/**得到32位的uuid
	 * @return
	 */
	public String get32UUID(){
		return UuidUtil.get32UUID();
	}
	
	/**得到分页列表的信息
	 * @return
	 */
	public Page getPage(){
		return new Page();
	}
	
	public static void logBefore(Logger logger, String interfaceName){
		logger.info("");
		logger.info("start");
		logger.info(interfaceName);
	}
	
	public static void logAfter(Logger logger){
		logger.info("end");
		logger.info("");
	}

	/**
	 * 设置结果信息
	 * @param code
	 * @param message
     */
	public Map setResultMessage(Map map,String code, String message){
		if(map !=null ){
				map.put(Const.APP_RESULT_CODE,code);
				map.put(Const.APP_RESULT_MESSAGE,message);
			return map;
		}else{
			Map newMap = new HashMap();
			newMap.put(Const.APP_RESULT_CODE,code);
			newMap.put(Const.APP_RESULT_MESSAGE,message);
			return newMap;
		}
		//header 方式
//		HttpServletResponse response = this.getResponse();
//		response.addHeader(Const.APP_RESULT_CODE,code);
//		try {
//			response.addHeader(Const.APP_RESULT_MESSAGE,new String(message.getBytes("gb2312"), "ISO8859-1" ));
//		} catch (UnsupportedEncodingException e) {
//			e.printStackTrace();
//		}
	}

	/**
	 * 获取User信息
	 * @return
     */
	public PageData getUserInfo(){
		HttpServletRequest request = this.getRequest();
		String token  = request.getHeader(Const.APP_TOKEN_STR);
		return (PageData) Const.APP_SESSION_TOKEN.get(token);
	}

	
}
