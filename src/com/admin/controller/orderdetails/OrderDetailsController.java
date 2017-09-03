package com.admin.controller.orderdetails;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.admin.service.orderdetails.OrderDetailsManager;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.Tools;

/**
 * 说明：订单明细管理 创建人：FH Q313596790 创建时间：2017-03-19
 */
@Controller
@RequestMapping(value = "/orderdetails")
public class OrderDetailsController extends BaseController {

	String menuUrl = "orderdetails/list.do"; // 菜单地址(权限用)
	@Resource(name = "orderdetailsService")
	private OrderDetailsManager orderdetailsService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增OrderDetails");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ORDERDETAILS_ID", this.get32UUID()); // 主键
		pd.put("ORDER_ID", ""); // 订单编号
		pd.put("ORDER_SUB_ID", "0"); // 订单编号枝番
		pd.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
		pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
		pd.put("CREATER", Jurisdiction.getUsername()); // 创建者
		pd.put("UPDATER", Jurisdiction.getUsername()); // 修改者
		orderdetailsService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername() + "删除OrderDetails");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		} // 校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		orderdetailsService.delete(pd);
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
		logBefore(logger, Jurisdiction.getUsername() + "修改OrderDetails");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
		pd.put("UPDATER", Jurisdiction.getUsername()); // 修改者
		orderdetailsService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername() + "列表OrderDetails");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		page.setPd(pd);
		List<PageData> varList = orderdetailsService.list(page); // 列出OrderDetails列表
		mv.setViewName("orderdetails/orderdetails/orderdetails_list");
		mv.addObject("varList", varList);
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
