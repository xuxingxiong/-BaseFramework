package com.admin.controller.beautyorder;

import java.io.PrintWriter;
import java.math.BigDecimal;
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

import com.admin.service.beautygoods.BeautyGoodsManager;
import com.admin.service.beautyorder.impl.BeautyOrderService;
import com.admin.service.customer.CustomerManager;
import com.admin.service.customercard.CustomerCardManager;
import com.admin.service.orderdetails.OrderDetailsManager;
import com.common.util.PageDataUtil;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.system.user.UserManager;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.Tools;

/**
 * 说明：订单管理 创建人：FH Q313596790 创建时间：2017-03-14
 */
@Controller
@RequestMapping(value = "/beautyorder")
public class BeautyOrderController extends BaseController {

	String menuUrl = "beautyorder/list.do"; // 菜单地址(权限用)
	String menuUrl2 = "beautyorder/listTwo.do"; // 菜单地址(权限用)
	@Resource(name = "beautyOrderService")
	private BeautyOrderService beautyOrderService;
	@Resource(name = "customerService")
	private CustomerManager customerService;
	@Resource(name = "orderdetailsService")
	private OrderDetailsManager orderdetailsService;
	@Resource(name = "customercardService")
	private CustomerCardManager customercardService;
	@Resource(name = "beautygoodsService")
	private BeautyGoodsManager beautygoodsService;
	@Resource(name = "userService")
	private UserManager userService;

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
		BigDecimal profit = BigDecimal.ZERO;
		BigDecimal price = BigDecimal.ZERO;
		PageData retPd = new PageData();

		try {
			PageData orderPd = handleParam(this.getPageData());

			PageData pd = (PageData) orderPd.get("order");
			if (pd.get("ID") != null && !"".equals((String.valueOf(pd.get("ID")).trim()))) {
				uuid = pd.getString("ID");
			}
			int i = 0;
			List<PageData> orderDtlList = (List<PageData>) orderPd.get("orderDtlList");
			for (PageData orderDtl : orderDtlList) {
				price = price.add((new BigDecimal(orderDtl.getString("PRICE")))
						.multiply(new BigDecimal(orderDtl.getString("GOODS_NUM"))));
				profit = profit.add((new BigDecimal(orderDtl.getString("PRICE"))
						.subtract(new BigDecimal(orderDtl.getString("PURCHACE_PRICE"))))
								.multiply(new BigDecimal(orderDtl.getString("GOODS_NUM"))));
			}

			for (PageData orderDtl : orderDtlList) {
				// 判断商品库存
				if ("2".equals(orderDtl.get("TYPE"))) {
					PageData goods = new PageData();
					goods.put("ID", orderDtl.get("GOODS_ID"));
					goods = beautygoodsService.findById(goods);
					if (goods.get("STOCK") == "" || goods.get("STOCK") == null
							|| (Integer) goods.get("STOCK") < Integer.parseInt(orderDtl.getString("GOODS_NUM"))) {
						retPd.put("msg", "商品\"" + goods.getString("NAME") + "\"库存不足！！！");
						return retPd;
					}
				}
			}

			// 会员卡支付
			if ("10".equals(pd.get("PAY_TYPE")) && "0".equals(pd.get("STATUS"))) {
				PageData customerCard = new PageData();
				customerCard.put("CARD_NO", pd.get("PAY_CARD_NO"));
				customerCard = customercardService.findById(customerCard);
				String balanceStr = String.valueOf(customerCard.get("BALANCE"));
				String serviceBalanceStr = String.valueOf(customerCard.get("SERVICE_BALANCE"));
				BigDecimal balance = BigDecimal.ZERO;
				BigDecimal serviceBalance = BigDecimal.ZERO;
				if (null != balanceStr && "" != balanceStr) {
					balance = balance.add(new BigDecimal(balanceStr));
				}
				if (null != serviceBalanceStr && "" != serviceBalanceStr) {
					serviceBalance = serviceBalance.add(new BigDecimal(serviceBalanceStr));
				}
				balance = balance.subtract(price);
				if (balance.compareTo(BigDecimal.ZERO) < 0) {
					serviceBalance = serviceBalance.add(balance);
					balance = BigDecimal.ZERO;
				}
				if (serviceBalance.compareTo(BigDecimal.ZERO) < 0) {
					retPd.put("msg", "会员卡余额不足,请选其他支付方式！！！");
					return retPd;
				}

				PageData custCard = new PageData();
				custCard.put("CARD_NO", pd.get("PAY_CARD_NO"));
				custCard.put("BALANCE", balance);
				custCard.put("SERVICE_BALANCE", serviceBalance);
				custCard.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
				custCard.put("UPDATER", Jurisdiction.getUsername()); // 修改者
				customercardService.edit(PageDataUtil.removeEmpty(custCard));
			}

			if ("1".equals(flag)) {
				orderdetailsService.delete(pd);
			}

			profit = profit.subtract(new BigDecimal(pd.getString("TAKYUBIN_FEE")));
			for (PageData orderDtl : orderDtlList) {
				orderDtl.put("ORDER_ID", uuid); // 订单编号
				orderDtl.put("ORDER_SUB_ID", i++); // 订单编号枝番
				orderDtl.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
				orderDtl.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
				orderDtl.put("CREATER", Jurisdiction.getUsername()); // 创建者
				orderDtl.put("UPDATER", Jurisdiction.getUsername()); // 修改者
				orderdetailsService.save(PageDataUtil.removeEmpty(orderDtl));

				if ("0".equals(pd.get("STATUS")) && "2".equals(orderDtl.get("TYPE"))) {
					// 修改商品库存
					PageData goods = new PageData();
					goods.put("ID", orderDtl.get("GOODS_ID"));
					goods = beautygoodsService.findById(goods);
					goods.put("STOCK",
							(Integer) goods.get("STOCK") - Integer.parseInt(orderDtl.getString("GOODS_NUM")));
					goods.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
					goods.put("UPDATER", Jurisdiction.getUsername()); // 修改者
					beautygoodsService.edit(PageDataUtil.removeEmpty(goods));
				}
			}

			pd.put("PROFIT", profit.toPlainString()); // 本单利润
			pd.put("SALE_TIME", Tools.date2Str(new Date())); //
			pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
			pd.put("UPDATER", Jurisdiction.getUsername()); // 修改者
			if ("1".equals(flag)) {
				beautyOrderService.edit(PageDataUtil.removeEmpty(pd));
			} else {
				pd.put("ID", uuid); // 订单编号
				pd.put("SHOP_ID", "001"); // 登录的店ID
				pd.put("SHOP_NAME", "苏宁慧谷店"); // 登录的店名
				pd.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
				pd.put("CREATER", Jurisdiction.getUsername()); // 创建者
				beautyOrderService.save(PageDataUtil.removeEmpty(pd));
			}
			retPd.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			retPd.put("msg", "fail");
		}
		return retPd;
	}

	/**
	 * 参数转换
	 * 
	 * @param pd
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private static PageData handleParam(PageData pd) {
		PageData retPd = new PageData();
		PageData order = new PageData();

		// 获取订单信息（master）
		for (String key : (Set<String>) pd.keySet()) {
			if (!key.startsWith("fieldarray")) {
				order.put(key, pd.get(key));
				continue;
			}
		}

		int count = (pd.size() - 11) / 6;
		List<PageData> orderDtlList = new ArrayList<>();
		// 获取订单信息明细（master）
		for (int i = 0; i < count; i++) {
			PageData orderDetails = new PageData();
			orderDetails.put("TYPE", pd.get("fieldarray[" + i + "][TYPE]"));
			orderDetails.put("GOODS_ID", pd.get("fieldarray[" + i + "][GOODS_ID]"));
			orderDetails.put("GOODS_NAME", pd.get("fieldarray[" + i + "][GOODS_NAME]"));
			orderDetails.put("PURCHACE_PRICE", pd.get("fieldarray[" + i + "][PURCHACE_PRICE]"));
			orderDetails.put("PRICE", pd.get("fieldarray[" + i + "][PRICE]"));
			orderDetails.put("GOODS_NUM", pd.get("fieldarray[" + i + "][GOODS_NUM]"));
			if ("true".equals(pd.get("fieldarray[" + i + "][IS_DISCUT]"))) {
				orderDetails.put("IS_DISCUT", "1");
			} else {
				orderDetails.put("IS_DISCUT", "0");
			}
			orderDtlList.add(orderDetails);
		}
		retPd.put("order", order);
		retPd.put("orderDtlList", orderDtlList);
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
		logBefore(logger, Jurisdiction.getUsername() + "删除Order");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "del")||Jurisdiction.buttonJurisdiction(menuUrl2, "del"))) {
			return;
		} // 校验权限
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			beautyOrderService.delete(pd);
			orderdetailsService.delete(pd);
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
	public ModelAndView list(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表Order");
		// if(!(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		if ("on".equals(pd.getString("checkbox1"))) {
			pd.put("checkbox1", "2");
		} else {
			pd.put("checkbox1", "");
		}
		if ("on".equals(pd.getString("checkbox2"))) {
			pd.put("checkbox2", "3");
		} else {
			pd.put("checkbox2", "");
		}
		if ("on".equals(pd.getString("checkbox3"))) {
			pd.put("checkbox3", "4");
		} else {
			pd.put("checkbox3", "");
		}
		page.setPd(pd);
		try {
			List<PageData> varList = beautyOrderService.list(page); // 列出Order列表
			PageData countPd = beautyOrderService.listCount(page); // 汇总列表
			mv.addObject("countPd", countPd);
			mv.addObject("varList", varList);
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("admin/beautyorder/beautyorder_list");
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
		logBefore(logger, Jurisdiction.getUsername() + "列表Order");
		// if(!(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		if ("on".equals(pd.getString("checkbox1"))) {
			pd.put("checkbox1", "2");
		} else {
			pd.put("checkbox1", "");
		}
		if ("on".equals(pd.getString("checkbox2"))) {
			pd.put("checkbox2", "3");
		} else {
			pd.put("checkbox2", "");
		}
		if ("on".equals(pd.getString("checkbox3"))) {
			pd.put("checkbox3", "4");
		} else {
			pd.put("checkbox3", "");
		}
		page.setPd(pd);
		try {
			List<PageData> varList = beautyOrderService.list(page); // 列出Order列表
			PageData countPd = beautyOrderService.listCount(page); // 汇总列表
			mv.addObject("countPd", countPd);
			mv.addObject("varList", varList);
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("admin/beautyorder/beautyorder_list2");
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
		String flag = pd.getString("flag");
		// 订单明细
		if (pd.get("DATA") != null && (String) pd.get("DATA") != "") {
			String[] datas = ((String) pd.get("DATA")).split(",,");
			// 销售种类
			mv.addObject("type", datas[0]);
			flag = datas[1];
			// 销售产品
			mv.addObject("orderDetails", datas[2]);
		}
		// FIXME 查询客户信息
		PageData custData = new PageData();
		if (pd.get("custId") != null && (String) pd.get("custId") != "") {
			custData.put("ID", pd.get("custId"));
			custData = customerService.findById(custData);
		}

		List<PageData> custList = customerService.listAll(new PageData());
		if ("1".equals(flag)) {
			mv.setViewName("admin/beautyorder/beautyorder2");
		} else {
			mv.setViewName("admin/beautyorder/beautyorder");
		}
		mv.addObject("custData", custData);
		mv.addObject("custList", custList);
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

		List<PageData> custList = customerService.listAll(new PageData());
		if ("1".equals(flag)) {
			mv.setViewName("admin/beautyorder/beautyorder2");
		} else {
			mv.setViewName("admin/beautyorder/beautyorder");
		}
		mv.addObject("custList", custList);
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
	@RequestMapping(value = "/goInfo")
	public ModelAndView goInfo() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();

		List<PageData> custList = customerService.listAll(new PageData());

		mv.setViewName("admin/beautyorder/orderinfo");
		mv.addObject("custList", custList);
		mv.addObject("msg", "info");
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

		PageData order = beautyOrderService.findById(pd); // 根据ID读取

		List<PageData> orderDetails = orderdetailsService.findById(pd); // 列出OrderDetails列表

		pd.put("order", order);
		pd.put("orderDetails", orderDetails);
		return pd;
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
		logBefore(logger, Jurisdiction.getUsername() + "批量删除Order");
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
				beautyOrderService.deleteAll(ArrayDATA_IDS);
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
	 * 重置密码
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/reset")
	@ResponseBody
	public PageData resetPwd() {
		logBefore(logger, Jurisdiction.getUsername() + "重置密码");
		PageData retPd = new PageData();
		try {
			userService.resetPwd(retPd);
			retPd.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			retPd.put("msg", "fail");
		}
		return retPd;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
