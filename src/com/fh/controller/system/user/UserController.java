package com.fh.controller.system.user;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Role;
import com.fh.service.system.menu.MenuManager;
import com.fh.service.system.role.RoleManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

/**
 * 类名称：UserController 创建人：FH fh313596790qq(青苔) 更新时间：2015年11月3日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/user")
public class UserController extends BaseController {

	String menuUrl = "user/listUsers.do"; // 菜单地址(权限用)
	@Resource(name = "userService")
	private UserManager userService;
	@Resource(name = "roleService")
	private RoleManager roleService;
	@Resource(name = "menuService")
	private MenuManager menuService;

	/**
	 * 显示用户列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/listUsers")
	public ModelAndView listUsers(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		String lastLoginStart = pd.getString("lastLoginStart"); // 开始时间
		String lastLoginEnd = pd.getString("lastLoginEnd"); // 结束时间
		if (lastLoginStart != null && !"".equals(lastLoginStart)) {
			pd.put("lastLoginStart", lastLoginStart + " 00:00:00");
		}
		if (lastLoginEnd != null && !"".equals(lastLoginEnd)) {
			pd.put("lastLoginEnd", lastLoginEnd + " 00:00:00");
		}
		page.setPd(pd);
		List<PageData> userList = userService.listUsers(page); // 列出用户列表
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);// 列出所有系统用户角色
		mv.setViewName("system/user/user_list");
		mv.addObject("userList", userList);
		mv.addObject("roleList", roleList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 删除用户
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteU")
	public void deleteU(PrintWriter out) throws Exception {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		} // 校验权限
		logBefore(logger, Jurisdiction.getUsername() + "删除user");
		PageData pd = new PageData();
		pd = this.getPageData();
		userService.deleteU(pd);
		out.write("success");
		out.close();
	}

	/**
	 * 去新增用户页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAddU")
	public ModelAndView goAddU() throws Exception {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);// 列出所有系统用户角色
		mv.setViewName("system/user/user_edit");
		mv.addObject("msg", "saveU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}

	/**
	 * 保存用户
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveU")
	public ModelAndView saveU() throws Exception {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		logBefore(logger, Jurisdiction.getUsername() + "新增user");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USER_ID", this.get32UUID()); // ID 主键
		pd.put("LAST_LOGIN", ""); // 最后登录时间
		pd.put("IP", ""); // IP
		pd.put("STATUS", "0"); // 状态
		pd.put("SKIN", "default");
		pd.put("RIGHTS", "");
		pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("USERNAME"), pd.getString("PASSWORD")).toString()); // 密码加密
		if (null == userService.findByUsername(pd)) { // 判断用户名是否存在
			userService.saveU(pd); // 执行保存
			mv.addObject("msg", "success");
		} else {
			mv.addObject("msg", "failed");
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 判断用户名是否存在
	 * 
	 * @return
	 */
	@RequestMapping(value = "/hasU")
	@ResponseBody
	public Object hasU() {
		Map<String, String> map = new HashMap<String, String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			if (userService.findByUsername(pd) != null) {
				errInfo = "error";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 判断邮箱是否存在
	 * 
	 * @return
	 */
	@RequestMapping(value = "/hasE")
	@ResponseBody
	public Object hasE() {
		Map<String, String> map = new HashMap<String, String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			if (userService.findByUE(pd) != null) {
				errInfo = "error";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 判断编码是否存在
	 * 
	 * @return
	 */
	@RequestMapping(value = "/hasN")
	@ResponseBody
	public Object hasN() {
		Map<String, String> map = new HashMap<String, String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			if (userService.findByUN(pd) != null) {
				errInfo = "error";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 去修改用户页面(系统用户列表修改)
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEditU")
	public ModelAndView goEditU() throws Exception {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if ("1".equals(pd.getString("USER_ID"))) {
			return null;
		} // 不能修改admin用户
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd); // 列出所有系统用户角色
		mv.addObject("fx", "user");
		pd = userService.findById(pd); // 根据ID读取
		mv.setViewName("system/user/user_edit");
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}

	/**
	 * 去修改用户页面(个人修改)
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEditMyU")
	public ModelAndView goEditMyU() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("fx", "head");
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd); // 列出所有系统用户角色
		pd.put("USERNAME", Jurisdiction.getUsername());
		pd = userService.findByUsername(pd); // 根据用户名读取
		mv.setViewName("system/user/user_edit");
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}

	/**
	 * 查看用户
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/view")
	public ModelAndView view() throws Exception {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if ("admin".equals(pd.getString("USERNAME"))) {
			return null;
		} // 不能查看admin用户
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd); // 列出所有系统用户角色
		pd = userService.findByUsername(pd); // 根据ID读取
		mv.setViewName("system/user/user_view");
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}

	/**
	 * 去修改用户页面(在线管理页面打开)
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEditUfromOnline")
	public ModelAndView goEditUfromOnline() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if ("admin".equals(pd.getString("USERNAME"))) {
			return null;
		} // 不能查看admin用户
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd); // 列出所有系统用户角色
		pd = userService.findByUsername(pd); // 根据ID读取
		mv.setViewName("system/user/user_edit");
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}

	/**
	 * 修改用户
	 */
	@RequestMapping(value = "/editU")
	public ModelAndView editU() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "修改ser");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (!Jurisdiction.getUsername().equals(pd.getString("USERNAME"))) { // 如果当前登录用户修改用户资料提交的用户名非本人
			if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
				return null;
			} // 校验权限 判断当前操作者有无用户管理查看权限
			if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
				return null;
			} // 校验权限判断当前操作者有无用户管理修改权限
			if ("admin".equals(pd.getString("USERNAME")) && !"admin".equals(Jurisdiction.getUsername())) {
				return null;
			} // 非admin用户不能修改admin
		} else { // 如果当前登录用户修改用户资料提交的用户名是本人，则不能修改本人的角色ID
			pd.put("ROLE_ID", userService.findByUsername(pd).getString("ROLE_ID")); // 对角色ID还原本人角色ID
		}
		if (pd.getString("PASSWORD") != null && !"".equals(pd.getString("PASSWORD"))) {
			pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("USERNAME"), pd.getString("PASSWORD")).toString());
		}
		userService.editU(pd); // 执行修改
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 批量删除
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAllU")
	@ResponseBody
	public Object deleteAllU() throws Exception {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return null;
		} // 校验权限
		logBefore(logger, Jurisdiction.getUsername() + "批量删除user");
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String USER_IDS = pd.getString("USER_IDS");
		if (null != USER_IDS && !"".equals(USER_IDS)) {
			String ArrayUSER_IDS[] = USER_IDS.split(",");
			userService.deleteAllU(ArrayUSER_IDS);
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 导出用户信息到EXCEL
	 * 
	 * @return
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			if (Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
				String keywords = pd.getString("keywords"); // 关键词检索条件
				if (null != keywords && !"".equals(keywords)) {
					pd.put("keywords", keywords.trim());
				}
				String lastLoginStart = pd.getString("lastLoginStart"); // 开始时间
				String lastLoginEnd = pd.getString("lastLoginEnd"); // 结束时间
				if (lastLoginStart != null && !"".equals(lastLoginStart)) {
					pd.put("lastLoginStart", lastLoginStart + " 00:00:00");
				}
				if (lastLoginEnd != null && !"".equals(lastLoginEnd)) {
					pd.put("lastLoginEnd", lastLoginEnd + " 00:00:00");
				}
				Map<String, Object> dataMap = new HashMap<String, Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("用户名"); // 1
				titles.add("编号"); // 2
				titles.add("姓名"); // 3
				titles.add("职位"); // 4
				titles.add("手机"); // 5
				titles.add("邮箱"); // 6
				titles.add("最近登录"); // 7
				titles.add("上次登录IP"); // 8
				dataMap.put("titles", titles);
				List<PageData> userList = userService.listAllUser(pd);
				List<PageData> varList = new ArrayList<PageData>();
				for (int i = 0; i < userList.size(); i++) {
					PageData vpd = new PageData();
					vpd.put("var1", userList.get(i).getString("USERNAME")); // 1
					vpd.put("var2", userList.get(i).getString("NUMBER")); // 2
					vpd.put("var3", userList.get(i).getString("NAME")); // 3
					vpd.put("var4", userList.get(i).getString("ROLE_NAME")); // 4
					vpd.put("var5", userList.get(i).getString("PHONE")); // 5
					vpd.put("var6", userList.get(i).getString("EMAIL")); // 6
					vpd.put("var7", userList.get(i).getString("LAST_LOGIN")); // 7
					vpd.put("var8", userList.get(i).getString("IP")); // 8
					varList.add(vpd);
				}
				dataMap.put("varList", varList);
				ObjectExcelView erv = new ObjectExcelView(); // 执行excel操作
				mv = new ModelAndView(erv, dataMap);
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 打开上传EXCEL页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goUploadExcel")
	public ModelAndView goUploadExcel() throws Exception {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("system/user/uploadexcel");
		return mv;
	}

	/**
	 * 显示用户列表(弹窗选择用)
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/listUsersForWindow")
	public ModelAndView listUsersForWindow(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		String lastLoginStart = pd.getString("lastLoginStart"); // 开始时间
		String lastLoginEnd = pd.getString("lastLoginEnd"); // 结束时间
		if (lastLoginStart != null && !"".equals(lastLoginStart)) {
			pd.put("lastLoginStart", lastLoginStart + " 00:00:00");
		}
		if (lastLoginEnd != null && !"".equals(lastLoginEnd)) {
			pd.put("lastLoginEnd", lastLoginEnd + " 00:00:00");
		}
		page.setPd(pd);
		List<PageData> userList = userService.listUsers(page); // 列出用户列表
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);// 列出所有系统用户角色
		mv.setViewName("system/user/window_user_list");
		mv.addObject("userList", userList);
		mv.addObject("roleList", roleList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}

}
