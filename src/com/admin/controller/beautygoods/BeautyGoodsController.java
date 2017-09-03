package com.admin.controller.beautygoods;

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

import com.admin.service.beautygoods.BeautyGoodsManager;
import com.common.util.PageDataUtil;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;

/**
 * 说明：商品管理 创建人：FH Q313596790 创建时间：2017-03-11
 */
@Controller
@RequestMapping(value = "/beautygoods")
public class BeautyGoodsController extends BaseController {

	String menuUrl = "beautygoods/list.do"; // 菜单地址(权限用)
	String menuUrl2 = "beautygoods/listTwo.do"; // 菜单地址(权限用)
	@Resource(name = "beautygoodsService")
	private BeautyGoodsManager beautygoodsService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() {
		logBefore(logger, Jurisdiction.getUsername() + "新增BeautyGoods");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "add") || Jurisdiction.buttonJurisdiction(menuUrl2, "add"))) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("ID", this.get32UUID()); // 商品编号
			pd.put("IS_DEL", "0"); // 逻辑删除标识
			pd.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
			pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
			pd.put("CREATER", Jurisdiction.getUsername()); // 创建者
			pd.put("UPDATER", Jurisdiction.getUsername()); // 修改者
			beautygoodsService.save(PageDataUtil.removeEmpty(pd));
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
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
	public void delete(PrintWriter out) {
		logBefore(logger, Jurisdiction.getUsername() + "删除BeautyGoods");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "del") || Jurisdiction.buttonJurisdiction(menuUrl2, "del"))) {
			return;
		} // 校验权限
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			beautygoodsService.delete(pd);
			out.write("success");
		} catch (Exception e) {
			e.printStackTrace();
			out.write("fail");
		}
		out.close();
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() {
		logBefore(logger, Jurisdiction.getUsername() + "修改BeautyGoods");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "edit") || Jurisdiction.buttonJurisdiction(menuUrl2, "edit"))) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
			pd.put("UPDATER", Jurisdiction.getUsername()); // 修改者
			beautygoodsService.edit(PageDataUtil.removeEmpty(pd));
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 根据主键查询商品信息
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/byId")
	@ResponseBody
	public PageData byId(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "根据主键查询客户信息");
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = beautygoodsService.findById(pd); // 根据主键查询商品信息
		PageData retPpd = new PageData();
		retPpd.put("GOODS_ID", pd.get("ID"));
		retPpd.put("GOODS_NAME", pd.get("NAME"));
		retPpd.put("PURCHACE_PRICE", pd.get("PURCHACE_PRICE"));
		retPpd.put("PRICE", pd.get("PRICE"));
		retPpd.put("STOCK", pd.get("STOCK"));

		return retPpd;
	}

	/**
	 * 所有商品
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/listAll")
	@ResponseBody
	public List<PageData> listAll(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表BeautyGoods");

		List<PageData> retList = new ArrayList<PageData>();
		List<PageData> goodsList = beautygoodsService.listAll(new PageData());
		for (PageData pageData : goodsList) {
			PageData pd = new PageData();
			pd.put("GOODS_ID", pageData.get("ID"));
			pd.put("GOODS_NAME", pageData.get("NAME"));
			retList.add(pd);
		}

		return retList;
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) {
		logBefore(logger, Jurisdiction.getUsername() + "列表BeautyGoods");
		// if(!(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		try {
			List<PageData> varList = beautygoodsService.list(page); // 列出BeautyGoods列表
			mv.addObject("varList", varList);
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("admin/beautygoods/beautygoods_list");
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/listTwo")
	public ModelAndView listTwo(Page page) {
		logBefore(logger, Jurisdiction.getUsername() + "列表BeautyGoods");
		// if(!(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		try {
			List<PageData> varList = beautygoodsService.list(page); // 列出BeautyGoods列表
			mv.addObject("varList", varList);
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("admin/beautygoods/beautygoods_list2");
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
		pd.put("IMAGE_ID", this.get32UUID());
		mv.setViewName("admin/beautygoods/beautygoods_edit");
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
		String flag = pd.getString("flag");
		pd = beautygoodsService.findById(pd); // 根据ID读取
		if ("1".equals(flag)) {
			mv.setViewName("admin/beautygoods/beautygoods_edit2");
		} else {
			mv.setViewName("admin/beautygoods/beautygoods_edit");
		}
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
	public Object deleteAll() {
		logBefore(logger, Jurisdiction.getUsername() + "批量删除BeautyGoods");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "del") || Jurisdiction.buttonJurisdiction(menuUrl2, "del"))) {
			return null;
		} // 校验权限
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if (null != DATA_IDS && !"".equals(DATA_IDS)) {
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				beautygoodsService.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			} else {
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
			map.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "fail");
		}
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 导出到excel
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "导出BeautyGoods到excel");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "cha") || Jurisdiction.buttonJurisdiction(menuUrl2, "cha"))) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("商品编号"); // 1
		titles.add("商品种类"); // 2
		titles.add("商品名称"); // 3
		titles.add("商品说明"); // 4
		titles.add("商品单价（售价）"); // 5
		titles.add("商品单位）"); // 6
		titles.add("商品单价（进价）"); // 7
		titles.add("进货渠道"); // 8
		titles.add("规格"); // 9
		titles.add("商品显示顺序"); // 10
		titles.add("推广信息"); // 11
		titles.add("标签1"); // 12
		titles.add("标签2"); // 13
		titles.add("标签3"); // 14
		titles.add("逻辑删除标识"); // 15
		titles.add("创建时间"); // 16
		titles.add("修改时间"); // 17
		titles.add("创建者"); // 18
		titles.add("修改者"); // 19
		dataMap.put("titles", titles);
		List<PageData> varOList = beautygoodsService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("ID")); // 1
			vpd.put("var2", varOList.get(i).getString("TYPE")); // 2
			vpd.put("var3", varOList.get(i).getString("NAME")); // 3
			vpd.put("var4", varOList.get(i).getString("DETAILS")); // 4
			vpd.put("var5", varOList.get(i).getString("PRICE")); // 5
			vpd.put("var6", varOList.get(i).getString("UNIT")); // 6
			vpd.put("var7", varOList.get(i).getString("PURCHACE_PRICE")); // 7
			vpd.put("var8", varOList.get(i).getString("FROM_CHANNEL")); // 8
			vpd.put("var9", varOList.get(i).getString("SPEC")); // 9
			vpd.put("var10", varOList.get(i).getString("DISPLAY_ORDER")); // 10
			vpd.put("var11", varOList.get(i).getString("INFO")); // 11
			vpd.put("var12", varOList.get(i).getString("ITEM1")); // 12
			vpd.put("var13", varOList.get(i).getString("ITEM2")); // 13
			vpd.put("var14", varOList.get(i).getString("ITEM3")); // 14
			vpd.put("var15", varOList.get(i).getString("IS_DEL")); // 15
			vpd.put("var16", varOList.get(i).getString("CREATE_TIME")); // 16
			vpd.put("var17", varOList.get(i).getString("MODIFY_TIME")); // 17
			vpd.put("var18", varOList.get(i).getString("CREATER")); // 18
			vpd.put("var19", varOList.get(i).getString("UPDATER")); // 19
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
