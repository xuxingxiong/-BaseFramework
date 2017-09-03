package com.fh.util;

import org.springframework.context.ApplicationContext;

import java.util.HashMap;
import java.util.Map;

/**
 * 项目名称：
 * @author:fh qq313596790[青苔]
 * 修改日期：2015/11/2
*/
public class Const {
	public static final String SESSION_SECURITY_CODE = "sessionSecCode";//验证码
	public static final String SESSION_USER = "sessionUser";			//session用的用户
	public static final String SESSION_ROLE_RIGHTS = "sessionRoleRights";
	public static final String sSESSION_ROLE_RIGHTS = "sessionRoleRights";
	public static final String SESSION_menuList = "menuList";			//当前菜单
	public static final String SESSION_allmenuList = "allmenuList";		//全部菜单
	public static final String SESSION_QX = "QX";
	public static final String SESSION_userpds = "userpds";			
	public static final String SESSION_USERROL = "USERROL";				//用户对象
	public static final String SESSION_USERNAME = "USERNAME";			//用户名
	public static final String DEPARTMENT_IDS = "DEPARTMENT_IDS";		//当前用户拥有的最高部门权限集合
	public static final String DEPARTMENT_ID = "DEPARTMENT_ID";			//当前用户拥有的最高部门权限
	public static final String TRUE = "T";
	public static final String FALSE = "F";
	public static final String LOGIN = "/login_toLogin";				//登录地址
	public static final String WEBINDEX = "/web/index";				//首页地址
	public static final String WEIXINERROE = "/error/weixinerr.jsp";				//微信错误
	public static final String WEIXINERROEFANS = "/error/weixinerr_fans.jsp";				//微信错误未关注
	public static final String SYSNAME = "admin/config/SYSNAME.txt";	//系统名称路径
	public static final String PAGE	= "admin/config/PAGE.txt";			//分页条数配置路径
	public static final String EMAIL = "admin/config/EMAIL.txt";		//邮箱服务器配置路径
	public static final String SMS1 = "admin/config/SMS1.txt";			//短信账户配置路径1
	public static final String SMS2 = "admin/config/SMS2.txt";			//短信账户配置路径2
	public static final String FWATERM = "admin/config/FWATERM.txt";	//文字水印配置路径
	public static final String IWATERM = "admin/config/IWATERM.txt";	//图片水印配置路径
	public static final String WEIXIN	= "admin/config/WEIXIN.txt";	//微信配置路径
	public static final String WEBSOCKET = "admin/config/WEBSOCKET.txt";//WEBSOCKET配置路径
	public static final String FILEPATHIMG = "uploadFiles/uploadImgs/";	//图片上传路径
	public static final String FILEPATHFILE = "uploadFiles/file/";		//文件上传路径
	public static final String FILEPATHTWODIMENSIONCODE = "uploadFiles/twoDimensionCode/"; //二维码存放路径
	public static final String NO_INTERCEPTOR_PATH = ".*/((login)|(logout)|(error)|(uploadFiles)|(code)|(app)|(weixin)|(web)|(static)|(main)|(pay)|(websocket)).*";	//不对匹配该值的访问路径拦截（正则）
	public static ApplicationContext WEB_APP_CONTEXT = null; //该值会在web容器启动时由WebAppContextListener初始化
	
	/**
	 * APP Constants
	 */
	//app注册接口_请求协议参数)
	public static final String[] APP_REGISTERED_PARAM_ARRAY = new String[]{"countries","uname","passwd","title","full_name","company_name","countries_code","area_code","telephone","mobile"};
	public static final String[] APP_REGISTERED_VALUE_ARRAY = new String[]{"国籍","邮箱帐号","密码","称谓","名称","公司名称","国家编号","区号","电话","手机号"};
	
	//app根据用户名获取会员信息接口_请求协议中的参数
	public static final String[] APP_GETAPPUSER_PARAM_ARRAY = new String[]{"USERNAME"};
	public static final String[] APP_GETAPPUSER_VALUE_ARRAY = new String[]{"用户名"};

	/**
	 * app验证token
	 */
	public static Map<String,Object> APP_SESSION_TOKEN = new HashMap<>();
	static {
		APP_SESSION_TOKEN.put("testToken",null);
	}

	public static final  String APP_TOKEN_STR = "token";

	public static final  String APP_RESULT_CODE = "resultCode";
	public static final  String APP_RESULT_MESSAGE= "resultMessage";
	public static final  String APP_RESULT_CODE_FAIL="fail";
	public static final  String APP_RESULT_CODE_SUCCESS="Success";
	public static final  String APP_RESULT_MESSAGE_SUCCESS= "操作成功";

	/**
	 * 技能标签
	 */
	public static final  String LABEL_TYPE_HANGYE="HY";
	public static final  String LABEL_TYPE_ZHINENG="ZN";
	public static final  String LABEL_TYPE_FANGXIANG="FX";
	public static final  String LABEL_TYPE_JINENG="JN";


	/**
	 * 身份标签
	 */
	//学生
	public static final  String USER_LABEL_DATA_STUDENT= "0";

	//老师
	public static final  String USER_LABEL_DATA_TEACHER= "1";

	/**
	 *通讯录消息类型
	 */
	//通讯录消息 拜师
	public static final  String CONTACTS_MESSAGE_TYPE_INVITE = "1";

	//通讯录消息 删除好友
	public static final  String CONTACTS_MESSAGE_TYPE_DELETE = "2";
	//通讯录消息 同意好友
	public static final  String CONTACTS_MESSAGE_TYPE_AGREE = "3";
	//拒绝拜师
	public static final  String CONTACTS_MESSAGE_TYPE_REJECT = "4";

	/**
	 *通讯录消息状态
	 */
	//已读
	public static final  String CONTACTS_MESSAGE_STATE_READ = "1";
	//初始
	public static final  String CONTACTS_MESSAGE_STATE_INIT = "0";
	//	已操作
	public static final  String CONTACTS_MESSAGE_STATE_OPER= "2";


	/**
	 * 问题类型-指定任务
	 */
	//指定任务
	public static final  String QUESTION_TYPE_SPECIFY = "0";

	//悬赏任务
	public static final  String QUESTION_TYPE_DIFFUSE = "1";

	/**
	 *问题状态
	 */
	// 问题状态-初始化(草稿)
	public static final  String QUESTION_STATE_INIT = "0";

	// 问题状态--已发布
	public static final  String QUESTION_STATE_PUBLISH = "1";


	// 问题状态--已接受
	public static final  String QUESTION_STATE_ACCEPT = "2";

	// 问题状态--问题已解答完成
	public static final  String QUESTION_STATE_ANSWER_FINISH = "3";

	// 问题状态--学生认可等待付款
	public static final  String QUESTION_STATE_ANSWER_ACCEPT = "4";

	// 问题状态--学生不认可
	public static final  String QUESTION_STATE_ANSWER_NOT_ACCEPT = "5";


	// 问题状态--学生已付款
	public static final  String QUESTION_STATE_ALREADY_PAY = "6";


	/**
	 *问题资源类型
	 */

	// 问答资源--图片
	public static final  String QUESTION_RES_TYPE_PHOTO = "0";

	// 问答资源--音频
	public static final  String QUESTION_RES_TYPE_VOICE = "1";

	// 问答资源--视频
	public static final  String QUESTION_RES_TYPE_VIDEO = "2";
	// 问答资源--其他
	public static final  String QUESTION_RES_TYPE_OTHER = "3";

	// 问答资源--文字
	public static final  String QUESTION_RES_TYPE_TEXT = "4";

	/**
	 *系统资源表类型
	 */
	// 资源表——图片
	public static final  String PICTURES_FILE_TYPE_PHOTO = "0";
	// 资源表-声音
	public static final  String PICTURES_FILE_TYPE_VOICE = "1";
	//	资源表-视频
	public static final  String PICTURES_FILE_TYPE_VIDEO = "2";
	//	资源表-其他
	public static final  String PICTURES_FILE_TYPE_OTHER = "3";




	//public static final  String APP_RESULT_MESSAGE= "resultMessage";

	
	
}
