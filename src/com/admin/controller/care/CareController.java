package com.admin.controller.care;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.admin.service.care.CareManager;
import com.admin.service.careprice.CarePriceManager;
import com.common.util.PageDataUtil;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;

/**
 * 说明：服务管理 创建人：FH Q313596790 创建时间：2017-03-11
 */
@Controller
@RequestMapping(value = "/care")
public class CareController extends BaseController {

	String menuUrl = "care/list.do"; // 菜单地址(权限用)
	String menuUrl2 = "care/listTwo.do"; // 菜单地址(权限用)
	@Resource(name = "careService")
	private CareManager careService;
	@Resource(name = "carepriceService")
	private CarePriceManager carepriceService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/save")
	@ResponseBody
	public PageData save(String flag) {
		logBefore(logger, Jurisdiction.getUsername() + "新增Order");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "add")||Jurisdiction.buttonJurisdiction(menuUrl2, "add"))) {
			return null;
		}
		String uuid = this.get32UUID();

		PageData retPd = new PageData();
		try {
			PageData carePd = handleParam(this.getPageData());

			PageData pd = (PageData) carePd.get("care");
			if (pd.get("ID") != null && !"".equals((String.valueOf(pd.get("ID")).trim()))) {
				uuid = pd.getString("ID");
			}
			if ("1".equals(flag)) {
				carepriceService.delete(pd);
			}
			int i = 0;
			List<PageData> carePriceList = (List<PageData>) carePd.get("carePriceList");
			for (PageData carePrice : carePriceList) {
				carePrice.put("ID", uuid); // 订单编号
				carePrice.put("SUB_ID", i++); // 订单编号枝番
				carePrice.put("IS_DEL", "0"); // 逻辑删除标识
				carePrice.put("DISPLAY_ORDER", "0");
				carePrice.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
				carePrice.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
				carePrice.put("CREATER", Jurisdiction.getUsername()); // 创建者
				carePrice.put("UPDATER", Jurisdiction.getUsername()); // 修改者
				carepriceService.save(PageDataUtil.removeEmpty(carePrice));
			}

			if ("1".equals(flag)) {
				pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
				pd.put("UPDATER", Jurisdiction.getUsername()); // 更新者
				careService.edit(PageDataUtil.removeEmpty(pd));
			} else {
				pd.put("ID", uuid); // 订单编号
				pd.put("IS_DEL", "0"); // 逻辑删除标识
				pd.put("DISPLAY_ORDER", "0");
				pd.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
				pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
				pd.put("CREATER", Jurisdiction.getUsername()); // 创建者
				pd.put("UPDATER", Jurisdiction.getUsername()); // 更新者
				careService.save(PageDataUtil.removeEmpty(pd));
			}
			retPd.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			retPd.put("msg", "fail");
		}
		return retPd;
	}

	@SuppressWarnings("unchecked")
	private static PageData handleParam(PageData pd) {
		PageData retPd = new PageData();
		PageData care = new PageData();

		// 获取服务信息（master）
		for (String key : (Set<String>) pd.keySet()) {
			if (!key.startsWith("fieldarray")) {
				care.put(key, pd.get(key));
				continue;
			}
		}

		int count = (pd.size() - 5) / 4;
		List<PageData> carePriceList = new ArrayList<>();
		// 获取订单信息明细（master）
		for (int i = 0; i < count; i++) {
			PageData carePrice = new PageData();
			carePrice.put("NAME", pd.get("fieldarray[" + i + "][NAME]"));
			carePrice.put("NAME_EN", pd.get("fieldarray[" + i + "][NAME_EN]"));
			carePrice.put("PRICE", pd.get("fieldarray[" + i + "][PRICE]"));
			carePrice.put("PURCHACE_PRICE", pd.get("fieldarray[" + i + "][PURCHACE_PRICE]"));
			carePriceList.add(carePrice);
		}
		retPd.put("care", care);
		retPd.put("carePriceList", carePriceList);
		return retPd;
	}

	/**
	 * 删除
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) {
		logBefore(logger, Jurisdiction.getUsername() + "删除Care");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "del")||Jurisdiction.buttonJurisdiction(menuUrl2, "del"))) {
			return;
		} // 校验权限
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			careService.delete(pd);
			carepriceService.delete(pd);
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
	@ResponseBody
	public PageData edit() {
		logBefore(logger, Jurisdiction.getUsername() + "修改Order");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "edit")||Jurisdiction.buttonJurisdiction(menuUrl2, "edit"))) {
			return null;
		}
		return this.save("1");
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) {
		logBefore(logger, Jurisdiction.getUsername() + "列表Care");
		// if(!(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			String keywords = pd.getString("keywords"); // 关键词检索条件
			if (null != keywords && !"".equals(keywords)) {
				pd.put("keywords", keywords.trim());
			}
			page.setPd(pd);
			List<PageData> varList = careService.list(page); // 列出Care列表
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("admin/care/care_list");
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
		logBefore(logger, Jurisdiction.getUsername() + "列表Care");
		// if(!(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			String keywords = pd.getString("keywords"); // 关键词检索条件
			if (null != keywords && !"".equals(keywords)) {
				pd.put("keywords", keywords.trim());
			}
			page.setPd(pd);
			List<PageData> varList = careService.list(page); // 列出Care列表
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("admin/care/care_list2");
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
		mv.setViewName("admin/care/care");
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
		mv.setViewName("admin/care/care");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 修改数据获取
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/editInfo")
	@ResponseBody
	public PageData editInfo() throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData care = careService.findById(pd); // 根据ID读取

		List<PageData> careprice = carepriceService.findByCare(pd); // 列出careprice列表

		pd.put("care", care);
		pd.put("careprice", careprice);
		return pd;
	}

	/**
	 * 所有服务
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/listAll")
	@ResponseBody
	public List<PageData> listAll(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表Care");

		List<PageData> retList = new ArrayList<PageData>();
		List<PageData> goodsList = careService.listAll(new PageData());
		for (PageData pageData : goodsList) {
			PageData pd = new PageData();
			pd.put("GOODS_ID", pageData.get("ID"));
			pd.put("GOODS_NAME", pageData.get("NAME"));
			retList.add(pd);
		}

		return retList;
	}

	/**
	 * 根据主键查询服务价格信息
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/byId")
	@ResponseBody
	public List<PageData> byId() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "根据主键查询服务价格信息");
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> careprice = carepriceService.findByCare(pd); // 根据主键查询服务价格信息
		return careprice;
	}

	/**
	 * 去下单
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAddOrder")
	public ModelAndView goAddOrder() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "去下单");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String ids = pd.getString("Ids");
		if (null != ids && !"".equals(ids)) {
			String[] idsArray = ids.split(",");
			int i = 0;
			for (String id : idsArray) {
				PageData condition = new PageData();
				condition.put("ID", id);
				PageData care = careService.findById(condition);
				List<PageData> careprice = carepriceService.findByCare(condition);
				care.put("i", i++);
				care.put("careprice", careprice);
				pdList.add(care);
			}
		}
		mv.setViewName("admin/care/care_order");
		mv.addObject("pdList", pdList);
		mv.addObject("count", pdList.size());
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
		logBefore(logger, Jurisdiction.getUsername() + "批量删除Care");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "del")||Jurisdiction.buttonJurisdiction(menuUrl2, "del"))) {
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
				careService.deleteAll(ArrayDATA_IDS);
				for (String id : ArrayDATA_IDS) {
					pd.put("ID", id);
					carepriceService.delete(pd);
				}
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
		logBefore(logger, Jurisdiction.getUsername() + "导出Care到excel");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "cha")||Jurisdiction.buttonJurisdiction(menuUrl2, "cha"))) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("服务编号"); // 1
		titles.add("服务名称"); // 2
		titles.add("服务英文名称"); // 3
		titles.add("功效"); // 4
		titles.add("流程"); // 5
		titles.add("时长"); // 6
		titles.add("商品显示顺序"); // 7
		titles.add("逻辑删除标识"); // 8
		titles.add("创建时间"); // 9
		titles.add("修改时间"); // 10
		titles.add("创建者"); // 11
		titles.add("修改者"); // 12
		dataMap.put("titles", titles);
		List<PageData> varOList = careService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("ID")); // 1
			vpd.put("var2", varOList.get(i).getString("NAME")); // 2
			vpd.put("var3", varOList.get(i).getString("NAME_EN")); // 3
			vpd.put("var4", varOList.get(i).getString("DETAILS")); // 4
			vpd.put("var5", varOList.get(i).getString("FLOWS")); // 5
			vpd.put("var6", varOList.get(i).get("TIMER").toString()); // 6
			vpd.put("var7", varOList.get(i).getString("DISPLAY_ORDER")); // 7
			vpd.put("var8", varOList.get(i).getString("IS_DEL")); // 8
			vpd.put("var9", varOList.get(i).getString("CREATE_TIME")); // 9
			vpd.put("var10", varOList.get(i).getString("MODIFY_TIME")); // 10
			vpd.put("var11", varOList.get(i).getString("CREATER")); // 11
			vpd.put("var12", varOList.get(i).getString("UPDATER")); // 12
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
