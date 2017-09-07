package com.fh.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.context.ApplicationContext;

/**
 * 项目名称：
 * 
 * @author:fh qq313596790[青苔] 修改日期：2015/11/2
 */
public class Const {
	public static final String SESSION_SECURITY_CODE = "sessionSecCode";// 验证码
	public static final String SESSION_USER = "sessionUser"; // session用的用户
	public static final String SESSION_ROLE_RIGHTS = "sessionRoleRights";
	public static final String sSESSION_ROLE_RIGHTS = "sessionRoleRights";
	public static final String SESSION_menuList = "menuList"; // 当前菜单
	public static final String SESSION_allmenuList = "allmenuList"; // 全部菜单
	public static final String SESSION_QX = "QX";
	public static final String SESSION_userpds = "userpds";
	public static final String SESSION_USERROL = "USERROL"; // 用户对象
	public static final String SESSION_USERNAME = "USERNAME"; // 用户名
	public static final String DEPARTMENT_IDS = "DEPARTMENT_IDS"; // 当前用户拥有的最高部门权限集合
	public static final String DEPARTMENT_ID = "DEPARTMENT_ID"; // 当前用户拥有的最高部门权限
	public static final String TRUE = "T";
	public static final String FALSE = "F";
	public static final String LOGIN = "/login_toLogin"; // 登录地址
	public static final String WEBINDEX = "/web/index"; // 首页地址
	public static final String WEIXINERROE = "/error/weixinerr.jsp"; // 微信错误
	public static final String WEIXINERROEFANS = "/error/weixinerr_fans.jsp"; // 微信错误未关注
	public static final String SYSNAME = "admin/config/SYSNAME.txt"; // 系统名称路径
	public static final String PAGE = "admin/config/PAGE.txt"; // 分页条数配置路径
	public static final String FILEPATHFILE = "uploadFiles/file/"; // 文件上传路径
	public static final String NO_INTERCEPTOR_PATH = ".*/((login)|(logout)|(error)|(uploadFiles)|(code)|(app)|(weixin)|(web)|(static)|(main)|(pay)|(websocket)).*"; // 不对匹配该值的访问路径拦截（正则）
	public static ApplicationContext WEB_APP_CONTEXT = null; // 该值会在web容器启动时由WebAppContextListener初始化

	/**
	 * app验证token
	 */
	public static Map<String, Object> APP_SESSION_TOKEN = new HashMap<>();
	static {
		APP_SESSION_TOKEN.put("testToken", null);
	}

	public static final String APP_TOKEN_STR = "token";

	public static final String APP_RESULT_CODE = "resultCode";
	public static final String APP_RESULT_MESSAGE = "resultMessage";
	public static final String APP_RESULT_CODE_FAIL = "fail";

}
