package com.admin.controller.rollingads;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.admin.service.rollingads.RollingAdsService;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;

/**
 * 说明：滚动广告管理 创建人：xuxx 创建时间：2016-12-21
 */
@Controller
@RequestMapping(value = "/rollingads")
public class RollingAdsController extends BaseController {

	String menuUrl = "rollingads/list.do"; // 菜单地址(权限用)
	@Resource(name = "rollingadsService")
	private RollingAdsService rollingadsService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增RollingAds");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ID", this.get32UUID()); // 主键
		pd.put("IS_DEL", "0"); // 逻辑删除标识
		pd.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
		pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
		pd.put("CREATER", Jurisdiction.getUsername()); // 创建者
		pd.put("UPDATER", Jurisdiction.getUsername()); // 更新者
		rollingadsService.save(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 删除
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "删除RollingAds");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return null;
		} // 校验权限
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		rollingadsService.delete(pd);
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 批量删除
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception {
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		if (Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if (null != DATA_IDS && !"".equals(DATA_IDS)) {
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				rollingadsService.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			} else {
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		}
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "修改RollingAds");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("IS_DEL", "0"); // 逻辑删除标识
		pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
		pd.put("UPDATER", Jurisdiction.getUsername()); // 更新者
		rollingadsService.edit(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表RollingAds");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList = rollingadsService.list(page); // 列出RollingAds列表
		mv.setViewName("/admin/rollingads/rollingads_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 去新增页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("/admin/rollingads/rollingads_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 去修改页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = rollingadsService.findById(pd); // 根据ID读取
		mv.setViewName("/admin/rollingads/rollingads_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 导出到excel
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "导出RollingAds到excel");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("滚动广告编号"); // 1
		titles.add("滚动广告名称"); // 2
		titles.add("滚动广告说明"); // 3
		// titles.add("滚动广告图片路径"); // 4
		titles.add("滚动广告显示顺序"); // 5
		// titles.add("逻辑删除标识"); // 6
		titles.add("创建时间"); // 7
		titles.add("修改时间"); // 8
		titles.add("创建者"); // 9
		titles.add("修改者"); // 10
		dataMap.put("titles", titles);
		List<PageData> varOList = rollingadsService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("ID")); // 1
			vpd.put("var2", varOList.get(i).getString("NAME")); // 2
			vpd.put("var3", varOList.get(i).getString("DETAILS")); // 3
			// vpd.put("var4", varOList.get(i).getString("PICTURE")); // 4
			vpd.put("var4", varOList.get(i).getString("DISPLAY_ORDER")); // 5
			// vpd.put("var6", varOList.get(i).getString("IS_DEL")); // 6
			vpd.put("var5", varOList.get(i).getString("CREATE_TIME")); // 7
			vpd.put("var6", varOList.get(i).getString("MODIFY_TIME")); // 8
			vpd.put("var7", varOList.get(i).getString("CREATER")); // 9
			vpd.put("var8", varOList.get(i).getString("UPDATER")); // 10
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv, dataMap);
		return mv;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
