package com.admin.controller.customer;

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

import com.admin.service.beautycard.impl.BeautyCardService;
import com.admin.service.customer.CustomerManager;
import com.admin.service.customercard.impl.CustomerCardService;
import com.common.util.PageDataUtil;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;

/**
 * 说明：客户管理 创建人：FH Q313596790 创建时间：2017-03-07
 */
@Controller
@RequestMapping(value = "/customer")
public class CustomerController extends BaseController {

	String menuUrl = "customer/list.do"; // 菜单地址(权限用)
	String menuUrl2 = "customer/listTwo.do"; // 菜单地址(权限用)
	@Resource(name = "customerService")
	private CustomerManager customerService;
	@Resource(name = "customercardService")
	private CustomerCardService customercardService;
	@Resource(name = "beautyCardService")
	private BeautyCardService beautyCardService;

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
		logBefore(logger, Jurisdiction.getUsername() + "新增Customer");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "add") || Jurisdiction.buttonJurisdiction(menuUrl2, "add"))) {
			return null;
		} // 校验权限
		String uuid = this.get32UUID();

		PageData retPd = new PageData();
		try {
			PageData customerPd = handleParam(this.getPageData());
			PageData pd = (PageData) customerPd.get("customer");
			if (pd.get("ID") != null && !"".equals((String.valueOf(pd.get("ID")).trim()))) {
				uuid = pd.getString("ID");
			}
			if ("1".equals(flag)) {
				customercardService.delete(pd);
			}
			List<PageData> cardList = (List<PageData>) customerPd.get("cardList");
			for (PageData card : cardList) {
				card.put("CUSTOMER_ID", uuid); // 客户ID
				card.put("IS_DEL", "0"); // 逻辑删除标识
				card.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
				card.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
				card.put("CREATER", Jurisdiction.getUsername()); // 创建者
				card.put("UPDATER", Jurisdiction.getUsername()); // 修改者
				customercardService.save(PageDataUtil.removeEmpty(card));
			}
			if ("1".equals(flag)) {
				pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
				pd.put("UPDATER", Jurisdiction.getUsername()); // 修改者
				customerService.edit(PageDataUtil.removeEmpty(pd));
			} else {
				pd.put("ID", uuid); // 客户ID
				pd.put("SHOP_ID", "001"); // 登录的店ID
				pd.put("SHOP_NAME", "苏宁慧谷店"); // 登录的店名
				pd.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
				pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
				pd.put("CREATER", Jurisdiction.getUsername()); // 创建者
				pd.put("UPDATER", Jurisdiction.getUsername()); // 更新者
				customerService.save(PageDataUtil.removeEmpty(pd));
			}
			retPd.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			retPd.put("msg", "fail");
		}
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
		logBefore(logger, Jurisdiction.getUsername() + "删除Customer");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "del") || Jurisdiction.buttonJurisdiction(menuUrl2, "del"))) {
			return;
		} // 校验权限
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			customerService.delete(pd);
			customercardService.delete(pd);
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
		logBefore(logger, Jurisdiction.getUsername() + "修改Customer");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "edit") || Jurisdiction.buttonJurisdiction(menuUrl2, "edit"))) {
			return null;
		} // 校验权限
		return this.save("1");
	}

	/**
	 * 根据客户查询卡信息
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/findByCustomer")
	@ResponseBody
	public List<PageData> findByCustomer(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "根据客户查询卡信息");
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> custCardList = customercardService.findByCustomer(pd); // 根据客户查询卡信息
		List<PageData> cardList = new ArrayList<PageData>();
		for (PageData custCard : custCardList) {
			if (custCard.getString("END_TIME").compareTo(Tools.date2Str(new Date(), "yyyy-MM-dd")) >= 0) {
				PageData cardPd = new PageData();
				cardPd.put("ID", custCard.getString("CARD_ID"));
				cardPd = beautyCardService.findById(cardPd);
				custCard.put("DISCUT", cardPd.get("DISCUT"));
				cardList.add(custCard);
			}
		}

		return cardList;
	}

	/**
	 * 根据主键查询客户信息
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
		return customerService.findById(pd); // 根据主键查询客户信息
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) {
		logBefore(logger, Jurisdiction.getUsername() + "列表Customer");
		// if(!(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		try {
			List<PageData> varList = customerService.list(page); // 列出Customer列表

			List<PageData> custList = customerService.listAll(new PageData());
			List<PageData> cardList = beautyCardService.listAll(new PageData());
			mv.addObject("varList", varList);
			mv.addObject("custList", custList);
			mv.addObject("cardList", cardList);
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("admin/customer/customer_list");
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
		logBefore(logger, Jurisdiction.getUsername() + "列表Customer");
		// if(!(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		try {
			List<PageData> varList = customerService.list(page); // 列出Customer列表

			List<PageData> custList = customerService.listAll(new PageData());
			List<PageData> cardList = beautyCardService.listAll(new PageData());
			mv.addObject("varList", varList);
			mv.addObject("custList", custList);
			mv.addObject("cardList", cardList);
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("admin/customer/customer_list2");
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
		pd.put("PHOTO", this.get32UUID());
		mv.setViewName("admin/customer/customer");
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
		pd = customerService.findById(pd); // 根据ID读取
		mv.setViewName("admin/customer/customer");
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
		PageData customer = customerService.findById(pd); // 根据ID读取

		List<PageData> customercard = customercardService.findByCustomer(pd); // 列出careprice列表

		pd.put("customer", customer);
		pd.put("customercard", customercard);
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
		logBefore(logger, Jurisdiction.getUsername() + "批量删除Customer");
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
				customerService.deleteAll(ArrayDATA_IDS);
				customercardService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername() + "导出Customer到excel");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "cha") || Jurisdiction.buttonJurisdiction(menuUrl2, "cha"))) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("用户名称"); // 2
		titles.add("用户类型"); // 3
		titles.add("护肤卡号"); // 4
		titles.add("登录的店ID"); // 5
		titles.add("登录的店名"); // 6
		titles.add("微信号"); // 7
		titles.add("微信关注时间"); // 8
		titles.add("手机号"); // 9
		titles.add("电话座机"); // 10
		titles.add("年龄"); // 11
		titles.add("性别"); // 12
		titles.add("联系地址"); // 13
		titles.add("电子邮件"); // 14
		titles.add("QQ"); // 15
		titles.add("肤质情况"); // 16
		titles.add("头像"); // 17
		titles.add("护肤频率"); // 18
		titles.add("创建时间"); // 19
		titles.add("修改时间"); // 20
		titles.add("创建人"); // 21
		titles.add("修改人"); // 22
		dataMap.put("titles", titles);
		List<PageData> varOList = customerService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var2", varOList.get(i).getString("USER_NAME")); // 2
			vpd.put("var3", varOList.get(i).getString("TYPE")); // 3
			vpd.put("var4", varOList.get(i).getString("CARE_CARD_NO")); // 4
			vpd.put("var5", varOList.get(i).getString("SHOP_ID")); // 5
			vpd.put("var6", varOList.get(i).getString("SHOP_NAME")); // 6
			vpd.put("var7", varOList.get(i).getString("WECHAT_ID")); // 7
			vpd.put("var8", varOList.get(i).getString("WECHAT_FOCUS_TIME")); // 8
			vpd.put("var9", varOList.get(i).getString("MOBILE_PHONE")); // 9
			vpd.put("var10", varOList.get(i).getString("TEL")); // 10
			vpd.put("var11", varOList.get(i).get("AGE").toString()); // 11
			vpd.put("var12", varOList.get(i).get("SEX").toString()); // 12
			vpd.put("var13", varOList.get(i).getString("ADDRESS")); // 13
			vpd.put("var14", varOList.get(i).getString("EMAIL")); // 14
			vpd.put("var15", varOList.get(i).getString("QQ")); // 15
			vpd.put("var16", varOList.get(i).getString("SKIN_COMENT")); // 16
			vpd.put("var17", varOList.get(i).getString("PHOTO")); // 17
			vpd.put("var18", varOList.get(i).get("CARE_RATE").toString()); // 18
			vpd.put("var19", varOList.get(i).getString("CREATE_TIME")); // 19
			vpd.put("var20", varOList.get(i).getString("MODIFY_TIME")); // 20
			vpd.put("var21", varOList.get(i).getString("CREATER")); // 21
			vpd.put("var22", varOList.get(i).getString("UPDATER")); // 22
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv, dataMap);
		return mv;
	}

	@SuppressWarnings("unchecked")
	private static PageData handleParam(PageData pd) {
		PageData retPd = new PageData();
		PageData customer = new PageData();

		// 获取客户信息（master）
		for (String key : (Set<String>) pd.keySet()) {
			if (!key.startsWith("fieldarray")) {
				customer.put(key, pd.get(key));
				continue;
			}
		}

		int count = (pd.size() - 14) / 9;
		List<PageData> cardList = new ArrayList<>();
		// 获取客户持有卡明细（master）
		for (int i = 0; i < count; i++) {
			PageData card = new PageData();
			card.put("CARD_NO", pd.get("fieldarray[" + i + "][CARD_NO]"));
			card.put("CARD_ID", pd.get("fieldarray[" + i + "][CARD_ID]"));
			card.put("CHARGE", pd.get("fieldarray[" + i + "][CHARGE]"));
			card.put("SERVICE_CHAGE", pd.get("fieldarray[" + i + "][SERVICE_CHAGE]"));
			card.put("BALANCE", pd.get("fieldarray[" + i + "][BALANCE]"));
			card.put("SERVICE_BALANCE", pd.get("fieldarray[" + i + "][SERVICE_BALANCE]"));
			card.put("BUY_TIME", pd.get("fieldarray[" + i + "][BUY_TIME]"));
			card.put("END_TIME", pd.get("fieldarray[" + i + "][END_TIME]"));
			cardList.add(card);
		}
		retPd.put("customer", customer);
		retPd.put("cardList", cardList);
		return retPd;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
