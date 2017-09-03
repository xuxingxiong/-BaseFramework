package com.admin.controller.carehistory;

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
import com.admin.service.care.CareManager;
import com.admin.service.carehistory.CareHistoryManager;
import com.admin.service.careorder.CareOrderManager;
import com.admin.service.customer.CustomerManager;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;

import net.sf.json.JSONArray;

/**
 * 说明：护肤记录
 */
@Controller
@RequestMapping(value = "/carehistory")
public class CareHistoryController extends BaseController {

	String menuUrl = "carehistory/list.do"; // 菜单地址(权限用)
	String menuUrl2 = "carehistory/list2.do"; // 菜单地址(权限用)
	@Resource(name = "carehistoryService")
	private CareHistoryManager carehistoryService;

	@Resource(name = "careorderService")
	private CareOrderManager careorderService;

	@Resource(name = "beautygoodsService")
	private BeautyGoodsManager beautygoodsService;

	@Resource(name = "careService")
	private CareManager careService;

	@Resource(name = "customerService")
	private CustomerManager customerService;

	private final SimpleDateFormat DATEFORMATSTR = new SimpleDateFormat("yyyy-MM-dd");
	private final SimpleDateFormat DATEFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save_order")
	public ModelAndView save_order() {
		logBefore(logger, Jurisdiction.getUsername() + "新增CareOrder");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "add")||Jurisdiction.buttonJurisdiction(menuUrl2, "add"))) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();

			if (null == pd.get("CUSTOMER_ID") || ("").equals(pd.getString("CUSTOMER_ID"))) {
				PageData user = new PageData();
				user.put("ID", this.get32UUID());
				user.put("USER_NAME", pd.get("CUSTOMER_NAME"));
				user.put("TYPE", "4");
				customerService.save(user);
				pd.put("CUSTOMER_ID", user.get("ID"));
			}
			String startTime = pd.getString("CARE_DATE_START");
			String endTime = pd.getString("CATE_DATE_END");
			String startDate = pd.getString("lastStart");
			String endDate = pd.getString("lastEnd");
			pd.put("CARE_DATE_START", DATEFORMAT.parse(startDate + " " + startTime + ":00")); // 主键
			pd.put("CATE_DATE_END", DATEFORMAT.parse(endDate + " " + endTime + ":00")); // 主键
			pd.remove("lastStart");
			pd.remove("lastEnd");
			pd.put("ID", this.get32UUID()); // 主键
			pd.put("SHOP_ID", "001"); // 护理店ID
			pd.put("SHOP_NAME", "苏宁慧谷店"); // 护理店店名
			pd.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
			pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
			pd.put("CREATER", Jurisdiction.getUsername()); // 创建者
			pd.put("UPDATER", Jurisdiction.getUsername()); // 更新者
			careorderService.save(pd);
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
	@RequestMapping(value = "/delete_order")
	public ModelAndView delete_order(PrintWriter out) {
		logBefore(logger, Jurisdiction.getUsername() + "删除CareOrder");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "del")||Jurisdiction.buttonJurisdiction(menuUrl2, "del"))) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			careorderService.delete(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit_order")
	public ModelAndView edit_order() {
		logBefore(logger, Jurisdiction.getUsername() + "修改CareOrder");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "edit")||Jurisdiction.buttonJurisdiction(menuUrl2, "edit"))) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			String startTime = pd.getString("CARE_DATE_START");
			String endTime = pd.getString("CATE_DATE_END");
			String startDate = pd.getString("lastStart");
			String endDate = pd.getString("lastEnd");
			pd.put("CARE_DATE_START", DATEFORMAT.parse(startDate + " " + startTime + ":00")); // 主键
			pd.put("CATE_DATE_END", DATEFORMAT.parse(endDate + " " + endTime + ":00")); // 主键
			pd.remove("lastStart");
			pd.remove("lastEnd");
			pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
			pd.put("UPDATER", Jurisdiction.getUsername()); // 更新者
			careorderService.edit(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 保存到护肤记录
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/addtohis")
	public ModelAndView addtohis() {
		logBefore(logger, Jurisdiction.getUsername() + "保存到护肤记录");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "add")||Jurisdiction.buttonJurisdiction(menuUrl2, "add"))) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd = careorderService.findById(pd);

			String ori = pd.getString("PRICE_ORI");
			String discut = pd.getString("PRICE_DISCUT");
			String type = pd.getString("SETTLE_TYPE");
			if (null != ori && ("").equals(ori))
				pd.put("PRICE_ORI", ori);
			if (null != discut && ("").equals(discut))
				pd.put("PRICE_DISCUT", discut);
			if (null != type && ("").equals(type))
				pd.put("SETTLE_TYPE", type);
			careorderService.delete(pd);
			pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
			pd.put("UPDATER", Jurisdiction.getUsername()); // 更新者
			pd.put("ID", this.get32UUID()); // 主键
			carehistoryService.save(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 去新增页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAdd_order")
	public ModelAndView goAdd_order() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("IMAGE_ID", this.get32UUID());
		mv.setViewName("/admin/careorder/careorder_edit");
		List<PageData> presentList = new ArrayList<PageData>();
		for (PageData present : careorderService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("PRESENT_ID", present.get("ID"));
			temp.put("PRESENT_NAME", present.get("NAME"));
			presentList.add(temp);
		}
		List<PageData> careItemList = new ArrayList<PageData>();
		for (PageData care : careService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("CARE_ITEM_ID", care.get("ID"));
			temp.put("CARE_ITEM_NAME", care.get("NAME"));
			careItemList.add(temp);
		}
		List<PageData> customerList = new ArrayList<PageData>();
		for (PageData customer : customerService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("CUSTOMER_ID", customer.get("ID"));
			temp.put("CUSTOMER_NAME", customer.get("USER_NAME"));
			customerList.add(temp);
		}
		mv.addObject("customerList", customerList);
		mv.addObject("careItemList", careItemList);
		mv.addObject("presentList1", presentList);
		mv.addObject("presentList2", presentList);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
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
	@RequestMapping(value = "/goEdit_order")
	public ModelAndView goEdit_order() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = careorderService.findById(pd); // 根据ID读取
		mv.setViewName("/admin/careorder/careorder_edit");
		List<PageData> presentList = new ArrayList<PageData>();
		for (PageData present : beautygoodsService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("PRESENT_ID", present.get("ID"));
			temp.put("PRESENT_NAME", present.get("NAME"));
			presentList.add(temp);
		}
		List<PageData> careItemList = new ArrayList<PageData>();
		for (PageData care : careService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("CARE_ITEM_ID", care.get("ID"));
			temp.put("CARE_ITEM_NAME", care.get("NAME"));
			careItemList.add(temp);
		}
		List<PageData> customerList = new ArrayList<PageData>();
		for (PageData customer : customerService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("CUSTOMER_ID", customer.get("ID"));
			temp.put("CUSTOMER_NAME", customer.get("USER_NAME"));
			customerList.add(temp);
		}

		String startTime = DATEFORMAT.format((Date) pd.get("CARE_DATE_START"));
		String endTime = DATEFORMAT.format((Date) pd.get("CATE_DATE_END"));
		pd.put("CARE_DATE_START", startTime.substring(11));
		pd.put("lastStart", startTime.substring(0, 10));

		pd.put("CATE_DATE_END", endTime.substring(11));
		pd.put("lastEnd", endTime.substring(0, 10));
		mv.addObject("customerList", customerList);
		mv.addObject("careItemList", careItemList);
		mv.addObject("presentList1", presentList);
		mv.addObject("presentList2", presentList);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() {
		logBefore(logger, Jurisdiction.getUsername() + "新增CareHistory");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "add")||Jurisdiction.buttonJurisdiction(menuUrl2, "add"))) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			if (null == pd.get("CUSTOMER_ID") || ("").equals(pd.getString("CUSTOMER_ID"))) {
				PageData user = new PageData();
				user.put("ID", this.get32UUID());
				user.put("USER_NAME", pd.get("CUSTOMER_NAME"));
				user.put("TYPE", "4");
				customerService.save(user);
				pd.put("CUSTOMER_ID", user.get("ID"));
			}
			String startTime = pd.getString("CARE_DATE_START");
			String endTime = pd.getString("CATE_DATE_END");
			String startDate = pd.getString("lastStart");
			String endDate = pd.getString("lastEnd");
			pd.put("CARE_DATE_START", DATEFORMAT.parse(startDate + " " + startTime + ":00")); // 主键
			pd.put("CATE_DATE_END", DATEFORMAT.parse(endDate + " " + endTime + ":00")); // 主键
			pd.remove("lastStart");
			pd.remove("lastEnd");
			pd.put("ID", this.get32UUID()); // 主键
			pd.put("SHOP_ID", "001"); // 护理店ID
			pd.put("SHOP_NAME", "苏宁慧谷店"); // 护理店店名
			pd.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
			pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
			pd.put("CREATER", Jurisdiction.getUsername()); // 创建者
			pd.put("UPDATER", Jurisdiction.getUsername()); // 更新者
			pd.put("IMAGE_ID", this.get32UUID()); // 其他图片
			carehistoryService.save(pd);
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
	public ModelAndView delete(PrintWriter out) {
		logBefore(logger, Jurisdiction.getUsername() + "删除CareHistory");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "del")||Jurisdiction.buttonJurisdiction(menuUrl2, "del"))) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			carehistoryService.delete(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() {
		logBefore(logger, Jurisdiction.getUsername() + "修改CareHistory");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "edit")||Jurisdiction.buttonJurisdiction(menuUrl2, "edit"))) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			String startTime = pd.getString("CARE_DATE_START");
			String endTime = pd.getString("CATE_DATE_END");
			String startDate = pd.getString("lastStart");
			String endDate = pd.getString("lastEnd");
			pd.put("CARE_DATE_START", DATEFORMAT.parse(startDate + " " + startTime + ":00")); // 主键
			pd.put("CATE_DATE_END", DATEFORMAT.parse(endDate + " " + endTime + ":00")); // 主键
			pd.remove("lastStart");
			pd.remove("lastEnd");
			pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
			pd.put("UPDATER", Jurisdiction.getUsername()); // 更新者
			carehistoryService.edit(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
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
		logBefore(logger, Jurisdiction.getUsername() + "列表CareHistory");
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
			List<PageData> varList = carehistoryService.list(page); // 列出CareHistory列表
			mv.addObject("varList", varList);
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("/admin/carehistory/carehistory_list");
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
	@RequestMapping(value = "/list2")
	public ModelAndView list2(Page page) {
		logBefore(logger, Jurisdiction.getUsername() + "列表CareHistory");
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
			List<PageData> varList = carehistoryService.list2(page); // 列出CareHistory列表
			mv.addObject("varList", varList);
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("/admin/carehistory/carehistory");
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
	@RequestMapping(value = "/timelist")
	@ResponseBody
	public String timelist(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表CareHistory_timelist");
		// if(!(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		// ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String strstartdate = pd.getString("start"); // 关键词检索条件
		Date startdate = DATEFORMATSTR.parse(strstartdate);
		String strenddate = pd.getString("end"); // 关键词检索条件
		Date enddate = DATEFORMATSTR.parse(strenddate);

		pd.put("start", startdate);
		pd.put("end", enddate);
		page.setPd(pd);
		List<PageData> varList = carehistoryService.timelist(page); // 列出CareHistory列表
		varList.addAll(careorderService.timelist(page));
		return JSONArray.fromObject(varList).toString();
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
		mv.setViewName("/admin/carehistory/carehistory_edit");
		List<PageData> presentList = new ArrayList<PageData>();
		for (PageData present : beautygoodsService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("PRESENT_ID", present.get("ID"));
			temp.put("PRESENT_NAME", present.get("NAME"));
			presentList.add(temp);
		}
		List<PageData> careItemList = new ArrayList<PageData>();
		for (PageData care : careService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("CARE_ITEM_ID", care.get("ID"));
			temp.put("CARE_ITEM_NAME", care.get("NAME"));
			careItemList.add(temp);
		}
		List<PageData> customerList = new ArrayList<PageData>();
		for (PageData customer : customerService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("CUSTOMER_ID", customer.get("ID"));
			temp.put("CUSTOMER_NAME", customer.get("USER_NAME"));
			customerList.add(temp);
		}
		mv.addObject("customerList", customerList);
		mv.addObject("careItemList", careItemList);
		mv.addObject("presentList1", presentList);
		mv.addObject("presentList2", presentList);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 从客户去新增页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAddCare")
	public ModelAndView goAddCare() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("IMAGE_ID", this.get32UUID());
		mv.setViewName("/admin/carehistory/carehistory_edit");
		List<PageData> presentList = new ArrayList<PageData>();
		for (PageData present : beautygoodsService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("PRESENT_ID", present.get("ID"));
			temp.put("PRESENT_NAME", present.get("NAME"));
			presentList.add(temp);
		}
		List<PageData> careItemList = new ArrayList<PageData>();
		for (PageData care : careService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("CARE_ITEM_ID", care.get("ID"));
			temp.put("CARE_ITEM_NAME", care.get("NAME"));
			careItemList.add(temp);
		}
		List<PageData> customerList = new ArrayList<PageData>();
		for (PageData customer : customerService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("CUSTOMER_ID", customer.get("ID"));
			temp.put("CUSTOMER_NAME", customer.get("USER_NAME"));
			if(pd.getString("CUSTOMER_ID").equals(customer.get("ID"))){
				pd.put("CUSTOMER_NAME",customer.get("USER_NAME"));
			}
			customerList.add(temp);
		}
		mv.addObject("customerList", customerList);
		mv.addObject("careItemList", careItemList);
		mv.addObject("presentList1", presentList);
		mv.addObject("presentList2", presentList);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
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
		pd = carehistoryService.findById(pd); // 根据ID读取
		mv.setViewName("/admin/carehistory/carehistory_edit");
		List<PageData> presentList = new ArrayList<PageData>();
		for (PageData present : beautygoodsService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("PRESENT_ID", present.get("ID"));
			temp.put("PRESENT_NAME", present.get("NAME"));
			presentList.add(temp);
		}
		List<PageData> careItemList = new ArrayList<PageData>();
		for (PageData care : careService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("CARE_ITEM_ID", care.get("ID"));
			temp.put("CARE_ITEM_NAME", care.get("NAME"));
			careItemList.add(temp);
		}
		List<PageData> customerList = new ArrayList<PageData>();
		for (PageData customer : customerService.listAll(new PageData())) {
			PageData temp = new PageData();
			temp.put("CUSTOMER_ID", customer.get("ID"));
			temp.put("CUSTOMER_NAME", customer.get("USER_NAME"));
			customerList.add(temp);
		}

		String startTime = DATEFORMAT.format((Date) pd.get("CARE_DATE_START"));
		String endTime = DATEFORMAT.format((Date) pd.get("CATE_DATE_END"));
		pd.put("CARE_DATE_START", startTime.substring(11));
		pd.put("lastStart", startTime.substring(0, 10));

		pd.put("CATE_DATE_END", endTime.substring(11));
		pd.put("lastEnd", endTime.substring(0, 10));
		mv.addObject("customerList", customerList);
		mv.addObject("careItemList", careItemList);
		mv.addObject("presentList1", presentList);
		mv.addObject("presentList2", presentList);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
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
		logBefore(logger, Jurisdiction.getUsername() + "批量删除CareHistory");
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
				carehistoryService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername() + "导出CareHistory到excel");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "cha")||Jurisdiction.buttonJurisdiction(menuUrl2, "cha"))) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("ID"); // 1
		titles.add("客户编号"); // 2
		titles.add("客户名称"); // 2
		titles.add("护理时间开始"); // 3
		titles.add("护理时间结束"); // 4
		titles.add("技师名称"); // 5
		titles.add("护理项目编号"); // 6
		titles.add("护理项目名称"); // 7
		titles.add("护理店编号"); // 8
		titles.add("护理店店名"); // 9
		titles.add("单次护理费用(原价)"); // 10
		titles.add("单次护理费用(折后价)"); // 11
		titles.add("结算类型"); // 12
		titles.add("本次赠送产品或CARE1"); // 13
		titles.add("本次赠送产品或CARE2"); // 14
		titles.add("本次赠送产品或CARE自由填写"); // 15
		dataMap.put("titles", titles);
		List<PageData> varOList = carehistoryService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("ID")); // 1
			vpd.put("var2", varOList.get(i).getString("CUSTOMER_ID")); // 2
			vpd.put("var3", varOList.get(i).getString("CUSTOMER_NAME")); // 2
			vpd.put("var3", varOList.get(i).getString("CARE_DATE")); // 3
			vpd.put("var4", varOList.get(i).getString("CATE_TIME")); // 4
			vpd.put("var5", varOList.get(i).getString("STAFF_NAME")); // 5
			vpd.put("var6", varOList.get(i).getString("CARE_ITEM_ID")); // 6
			vpd.put("var7", varOList.get(i).getString("CATE_ITEM_NAME")); // 7
			vpd.put("var8", varOList.get(i).getString("SHOP_ID")); // 8
			vpd.put("var9", varOList.get(i).getString("SHOP_NAME")); // 9
			vpd.put("var10", varOList.get(i).get("PRICE_ORI").toString()); // 10
			vpd.put("var11", varOList.get(i).get("PRICE_DISCUT").toString()); // 11
			vpd.put("var12", varOList.get(i).getString("SETTLE_TYPE")); // 12
			vpd.put("var13", varOList.get(i).getString("PRESENT1")); // 13
			vpd.put("var14", varOList.get(i).getString("PRESENT2")); // 14
			vpd.put("var15", varOList.get(i).getString("PRESENTFREE")); // 15
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
