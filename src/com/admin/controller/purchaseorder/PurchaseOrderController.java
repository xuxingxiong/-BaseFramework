package com.admin.controller.purchaseorder;

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

import com.admin.service.purchaseorder.PurchaseOrderManager;
import com.common.util.PageDataUtil;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;

/**
 * 说明：采购单信息管理
 */
@Controller
@RequestMapping(value = "/purchaseorder")
public class PurchaseOrderController extends BaseController {

	String menuUrl = "purchaseorder/list.do"; // 菜单地址(权限用)
	@Resource(name = "purchaseOrderService")
	private PurchaseOrderManager purchaseOrderService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增PurchaseOrder");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String uuid = this.get32UUID();
		pd.put("ID", uuid); // 主键
		pd.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
		pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
		pd.put("CREATER", Jurisdiction.getUsername()); // 创建者
		pd.put("UPDATER", Jurisdiction.getUsername()); // 修改者
		purchaseOrderService.save(pd);
		insertDetails(pd);
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
		logBefore(logger, Jurisdiction.getUsername() + "删除PurchaseOrder");
		PageData pd = new PageData();
		pd = this.getPageData();
		purchaseOrderService.delete(pd);
		purchaseOrderService.deleteDetails(pd);
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
		logBefore(logger, Jurisdiction.getUsername() + "修改PurchaseOrder");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
		pd.put("UPDATER", Jurisdiction.getUsername()); // 修改者
		purchaseOrderService.edit(pd);
		purchaseOrderService.deleteDetails(pd);
		insertDetails(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	private void insertDetails(PageData pd) throws Exception {
		PageData mate1 = new PageData();
		mate1.put("PUR_ID", pd.get("ID")); // 主键
		mate1.put("PUR_SUB_ID", 0); // 主键
		mate1.put("MATE_NAME", pd.get("MATE_NAME1"));
		mate1.put("MATE_NUM", pd.get("MATE_NUM1"));
		mate1.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
		mate1.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
		mate1.put("CREATER", Jurisdiction.getUsername()); // 创建者
		mate1.put("UPDATER", Jurisdiction.getUsername()); // 修改者
		purchaseOrderService.saveDetails(PageDataUtil.removeEmpty(mate1));
		PageData mate2 = new PageData();
		mate2.put("PUR_ID", pd.get("ID")); // 主键
		mate2.put("PUR_SUB_ID", 1); // 主键
		mate2.put("MATE_NAME", pd.get("MATE_NAME2"));
		mate2.put("MATE_NUM", pd.get("MATE_NUM2"));
		mate2.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
		mate2.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
		mate2.put("CREATER", Jurisdiction.getUsername()); // 创建者
		mate2.put("UPDATER", Jurisdiction.getUsername()); // 修改者
		purchaseOrderService.saveDetails(PageDataUtil.removeEmpty(mate2));
		PageData mate3 = new PageData();
		mate3.put("PUR_ID", pd.get("ID")); // 主键
		mate3.put("PUR_SUB_ID", 2); // 主键
		mate3.put("MATE_NAME", pd.get("MATE_NAME3"));
		mate3.put("MATE_NUM", pd.get("MATE_NUM3"));
		mate3.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
		mate3.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
		mate3.put("CREATER", Jurisdiction.getUsername()); // 创建者
		mate3.put("UPDATER", Jurisdiction.getUsername()); // 修改者
		purchaseOrderService.saveDetails(PageDataUtil.removeEmpty(mate3));
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表PurchaseOrder");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList = purchaseOrderService.list(page); // 列出PurchaseOrder列表
		mv.setViewName("/admin/purchaseorder/purchaseorder_list");
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
		mv.setViewName("/admin/purchaseorder/purchaseorder_edit");
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
		pd = purchaseOrderService.findById(pd); // 根据ID读取
		mv.setViewName("/admin/purchaseorder/purchaseorder_edit");
		List<PageData> details = purchaseOrderService.findByIdDetails(pd);
		for (PageData pageData : details) {
			if ("0".equals(String.valueOf(pageData.get("PUR_SUB_ID")))) {
				pd.put("MATE_NAME1", pageData.getString("MATE_NAME"));
				pd.put("MATE_NUM1", pageData.get("MATE_NUM"));
				continue;
			}
			if ("1".equals(String.valueOf(pageData.get("PUR_SUB_ID")))) {
				pd.put("MATE_NAME2", pageData.getString("MATE_NAME"));
				pd.put("MATE_NUM2", pageData.get("MATE_NUM"));
				continue;
			}
			if ("2".equals(String.valueOf(pageData.get("PUR_SUB_ID")))) {
				pd.put("MATE_NAME3", pageData.getString("MATE_NAME"));
				pd.put("MATE_NUM3", pageData.get("MATE_NUM"));
				continue;
			}
		}
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 去详情页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goDetail")
	public ModelAndView goDetail() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = purchaseOrderService.findById(pd); // 根据ID读取
		mv.setViewName("/admin/purchaseorder/purchaseorder_edit");
		List<PageData> details = purchaseOrderService.findByIdDetails(pd);
		for (PageData pageData : details) {
			if ("0".equals(String.valueOf(pageData.get("PUR_SUB_ID")))) {
				pd.put("MATE_NAME1", pageData.getString("MATE_NAME"));
				pd.put("MATE_NUM1", pageData.get("MATE_NUM"));
				continue;
			}
			if ("1".equals(String.valueOf(pageData.get("PUR_SUB_ID")))) {
				pd.put("MATE_NAME2", pageData.getString("MATE_NAME"));
				pd.put("MATE_NUM2", pageData.get("MATE_NUM"));
				continue;
			}
			if ("2".equals(String.valueOf(pageData.get("PUR_SUB_ID")))) {
				pd.put("MATE_NAME3", pageData.getString("MATE_NAME"));
				pd.put("MATE_NUM3", pageData.get("MATE_NUM"));
				continue;
			}
		}
		mv.addObject("msg", "detail");
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
		logBefore(logger, Jurisdiction.getUsername() + "批量删除PurchaseOrder");
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
			purchaseOrderService.deleteAll(ArrayDATA_IDS);
			purchaseOrderService.deleteAllDetails(ArrayDATA_IDS);
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
	public ModelAndView exportExcel() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "导出PurchaseOrder到excel");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("申请日期"); // 1
		titles.add("员工编号"); // 2
		titles.add("员工姓名"); // 3
		titles.add("所属部门"); // 4
		titles.add("职务"); // 5
		titles.add("预算金额"); // 8
		titles.add("期望交付日期"); // 9
		titles.add("预估金额"); // 13
		titles.add("预计交付时间"); // 14
		dataMap.put("titles", titles);
		List<PageData> varOList = purchaseOrderService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("APPLY_DATE")); // 1
			vpd.put("var2", varOList.get(i).getString("EMP_ID")); // 2
			vpd.put("var3", varOList.get(i).getString("EMP_NAME")); // 3
			vpd.put("var4", varOList.get(i).getString("DEPARTMENT")); // 4
			vpd.put("var5", varOList.get(i).getString("POST")); // 5
			vpd.put("var8", varOList.get(i).get("BUDGET_AMOUNT")); // 8
			vpd.put("var9", varOList.get(i).getString("EXPECT_DELI_DATE")); // 9
			vpd.put("var13", varOList.get(i).get("ESTI_AMOUNT")); // 13
			vpd.put("var14", varOList.get(i).getString("ESTI_DELI_DATE")); // 14
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
