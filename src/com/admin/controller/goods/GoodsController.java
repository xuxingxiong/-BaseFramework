package com.admin.controller.goods;

import java.io.PrintWriter;
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

import com.admin.service.category.CategoryManager;
import com.admin.service.goods.GoodsManager;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;

/**
 * 说明：商品管理 创建人：FH Q313596790 创建时间：2016-12-27
 */
@Controller
@RequestMapping(value = "/goods")
public class GoodsController extends BaseController {

	String menuUrl = "goods/list.do"; // 菜单地址(权限用)
	@Resource(name = "goodsService")
	private GoodsManager goodsService;

	@Resource(name = "categoryService")
	private CategoryManager categoryService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增Goods");
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
		pd.put("UPDATER", Jurisdiction.getUsername()); // 修改者
		goodsService.save(pd);
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
	public void delete(PrintWriter out) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "删除Goods");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		} // 校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		goodsService.delete(pd);
		out.write("success");
		out.close();
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "修改Goods");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("IS_DEL", "0"); // 逻辑删除标识
		pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
		pd.put("UPDATER", Jurisdiction.getUsername()); // 修改者
		goodsService.edit(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @param STORE_ID
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page, String STORE_ID) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表Goods");
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
		List<PageData> varList = goodsService.list(page); // 列出Goods列表
		mv.setViewName("/admin/goods/goods_list");
		for (PageData temp : varList) {
			PageData id = new PageData();
			id.put("ID", temp.get("CATEGORY_ID"));
			PageData category = categoryService.findById(id);
			if (category != null)
				temp.put("CATEGORY_NAME", category.get("NAME"));
			id.put("ID", temp.get("CATEGORY_ID_1"));
			category = categoryService.findById(id);
			if (category != null)
				temp.put("CATEGORY_NAME_1", category.get("NAME"));
			id.put("ID", temp.get("CATEGORY_ID_2"));
			category = categoryService.findById(id);
			if (category != null)
				temp.put("CATEGORY_NAME_2", category.get("NAME"));
		}
		mv.addObject("varList", varList);
		mv.addObject("STORE_ID", STORE_ID);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 列表
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/list_dialog")
	public ModelAndView list(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表Goods");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("STORE_ID", pd.get("STORE_ID"));
		pd.remove("STORE_ID");
		page.setPd(pd);
		List<PageData> varList = goodsService.list(page);
		mv.setViewName("/admin/goods/goods_list_dialog");
		for (PageData temp : varList) {
			PageData id = new PageData();
			id.put("ID", temp.get("CATEGORY_ID"));
			PageData category = categoryService.findById(id);
			if (category != null) {
				temp.put("CATEGORY_ID", category.get("ID"));
				temp.put("CATEGORY_NAME", category.get("NAME"));
			}
			id.put("ID", temp.get("CATEGORY_ID_1"));
			category = categoryService.findById(id);
			if (category != null) {
				temp.put("CATEGORY_ID_1", category.get("ID"));
				temp.put("CATEGORY_NAME_1", category.get("NAME"));
			}
			id.put("ID", temp.get("CATEGORY_ID_2"));
			category = categoryService.findById(id);
			if (category != null) {
				temp.put("CATEGORY_ID_2", category.get("ID"));
				temp.put("CATEGORY_NAME_2", category.get("NAME"));
			}
		}
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
	public ModelAndView goAdd(String STORE_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("/admin/goods/goods_edit");
		List<PageData> categoryList = new ArrayList<PageData>();
		for (PageData category : categoryService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("CATEGORY_ID", category.get("ID"));
			temp.put("CATEGORY_NAME", category.get("NAME"));
			categoryList.add(temp);
		}
		mv.addObject("categoryList", categoryList);
		mv.addObject("msg", "save");
		mv.addObject("STORE_ID", STORE_ID);
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
	public ModelAndView goEdit(String storeId) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = goodsService.findById(pd); // 根据ID读取
		mv.setViewName("/admin/goods/goods_edit");

		List<PageData> categoryList = new ArrayList<PageData>();
		for (PageData category : categoryService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("CATEGORY_ID", category.get("ID"));
			temp.put("CATEGORY_NAME", category.get("NAME"));
			categoryList.add(temp);
		}
		mv.addObject("categoryList", categoryList);
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 批量删除
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "批量删除Goods");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return null;
		} // 校验权限
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			goodsService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 导出到excel
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel(String storeId) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "导出Goods到excel");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("STORE_ID", storeId);// 店铺ID
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("商品名称"); // 1
		titles.add("商品说明"); // 2
		titles.add("商品照片路径"); // 3
		titles.add("商品单价"); // 4
		titles.add("商品单位"); // 5
		titles.add("商品显示顺序"); // 6
		titles.add("店铺ID"); // 7
		titles.add("分类ID"); // 8
		titles.add("逻辑删除标识"); // 9
		titles.add("创建时间"); // 10
		titles.add("修改时间"); // 11
		titles.add("创建者"); // 12
		titles.add("修改者"); // 13
		dataMap.put("titles", titles);
		List<PageData> varOList = goodsService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("NAME")); // 1
			vpd.put("var2", varOList.get(i).getString("DETAILS")); // 2
			vpd.put("var3", varOList.get(i).getString("PATH")); // 3
			vpd.put("var4", varOList.get(i).get("PRICE").toString()); // 4
			vpd.put("var5", varOList.get(i).getString("UNIT")); // 5
			vpd.put("var6", varOList.get(i).getString("DISPLAY_ORDER")); // 6
			vpd.put("var7", varOList.get(i).getString("STORE_ID")); // 7
			vpd.put("var8", varOList.get(i).getString("CATEGORY_ID")); // 8
			vpd.put("var9", varOList.get(i).getString("IS_DEL")); // 9
			vpd.put("var10", varOList.get(i).getString("CREATE_TIME")); // 10
			vpd.put("var11", varOList.get(i).getString("MODIFY_TIME")); // 11
			vpd.put("var12", varOList.get(i).getString("CREATER")); // 12
			vpd.put("var13", varOList.get(i).getString("UPDATER")); // 13
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
