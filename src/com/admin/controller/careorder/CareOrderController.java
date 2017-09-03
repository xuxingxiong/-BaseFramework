package com.admin.controller.careorder;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import com.admin.service.beautygoods.BeautyGoodsManager;
import com.admin.service.care.CareManager;
import com.admin.service.carehistory.CareHistoryManager;
import com.admin.service.careorder.CareOrderManager;
import com.admin.service.customer.CustomerManager;
import com.fh.controller.base.BaseController;

/**
 * 说明：预约管理 创建人：FH Q313596790 创建时间：2017-03-14
 */
@Controller
@RequestMapping(value = "/careorder")
public class CareOrderController extends BaseController {

	String menuUrl = "carehistory/list.do"; // 菜单地址(权限用)
	// String menuUrl = "careorder/list.do"; // 菜单地址(权限用)
	@Resource(name = "careorderService")
	private CareOrderManager careorderService;

	@Resource(name = "carehistoryService")
	private CareHistoryManager carehistoryService;

	@Resource(name = "beautygoodsService")
	private BeautyGoodsManager beautygoodsService;

	@Resource(name = "careService")
	private CareManager careService;

	@Resource(name = "customerService")
	private CustomerManager customerService;
	private final SimpleDateFormat DATEFORMATSTR = new SimpleDateFormat("yyyy-MM-dd");
	private final SimpleDateFormat DATEFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
