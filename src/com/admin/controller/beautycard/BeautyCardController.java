package com.admin.controller.beautycard;

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

import com.admin.service.beautycard.BeautyCardManager;
import com.common.util.PageDataUtil;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;

/**
 * 说明：会员卡管理
 */
@Controller
@RequestMapping(value = "/beautycard")
public class BeautyCardController extends BaseController {

	String menuUrl = "beautycard/list.do"; // 菜单地址(权限用)
	String menuUrl2 = "beautycard/listTwo.do"; // 菜单地址(权限用)
	@Resource(name = "beautyCardService")
	private BeautyCardManager beautyCardService;

	/**
	 * 保存
	 * 
	 * @param @
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() {
		logBefore(logger, Jurisdiction.getUsername() + "新增Card");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "add")||Jurisdiction.buttonJurisdiction(menuUrl2, "add"))) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("ID", this.get32UUID()); // 主键
			pd.put("IS_DEL", "0"); // 逻辑删除标识
			pd.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
			pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
			pd.put("CREATER", Jurisdiction.getUsername()); // 创建者
			pd.put("UPDATER", Jurisdiction.getUsername()); // 修改者
			beautyCardService.save(PageDataUtil.removeEmpty(pd));
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
	 * @
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) {
		logBefore(logger, Jurisdiction.getUsername() + "删除Card");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "del")||Jurisdiction.buttonJurisdiction(menuUrl2, "del"))) {
			return;
		} // 校验权限
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			beautyCardService.delete(pd);
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
	 * @param @
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() {
		logBefore(logger, Jurisdiction.getUsername() + "修改Card");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "edit")||Jurisdiction.buttonJurisdiction(menuUrl2, "edit"))) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
			pd.put("UPDATER", Jurisdiction.getUsername()); // 修改者
			beautyCardService.edit(PageDataUtil.removeEmpty(pd));
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
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) {
		logBefore(logger, Jurisdiction.getUsername() + "列表Card");
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
			List<PageData> varList = beautyCardService.list(page); // 列出Card列表
			mv.addObject("varList", varList);
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("admin/beautycard/beautycard_list");
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 列表
	 * 
	 * @param page
	 */
	@RequestMapping(value = "/listTwo")
	public ModelAndView listTwo(Page page) {
		logBefore(logger, Jurisdiction.getUsername() + "列表Card");
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
			List<PageData> varList = beautyCardService.list(page); // 列出Card列表
			mv.addObject("varList", varList);
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("admin/beautycard/beautycard_list2");
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 所有会员卡
	 * 
	 * @param page
	 * @throws Exception
	 * @
	 */
	@RequestMapping(value = "/listAll")
	@ResponseBody
	public List<PageData> listAll(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表Card");

		List<PageData> retList = new ArrayList<PageData>();
		List<PageData> cardList = beautyCardService.listAll(new PageData());
		for (PageData pageData : cardList) {
			PageData pd = new PageData();
			pd.put("CARD_ID", pageData.get("ID"));
			pd.put("CARD_NAME", pageData.get("CADR_NAME"));
			// 订单处用
			pd.put("GOODS_ID", pageData.get("ID"));
			pd.put("GOODS_NAME", pageData.get("CADR_NAME"));
			retList.add(pd);
		}

		return retList;
	}

	/**
	 * 去新增页面
	 * 
	 * @param @
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("IMAGE_ID", this.get32UUID());
		mv.setViewName("admin/beautycard/beautycard_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 去修改页面
	 * 
	 * @param @
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = beautyCardService.findById(pd); // 根据ID读取
		mv.setViewName("admin/beautycard/beautycard_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 批量删除
	 * 
	 * @param @
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, Jurisdiction.getUsername() + "批量删除Card");
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
				beautyCardService.deleteAll(ArrayDATA_IDS);
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
	 * @param @
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "导出Card到excel");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "cha")||Jurisdiction.buttonJurisdiction(menuUrl2, "cha"))) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("卡编号"); // 1
		titles.add("卡名"); // 2
		titles.add("最低预充值"); // 3
		titles.add("赠送"); // 4
		titles.add("折扣"); // 5
		titles.add("护理次数	"); // 6
		titles.add("护理周期"); // 7
		titles.add("使用限制"); // 8
		titles.add("备注"); // 9
		titles.add("贩卖开始时间"); // 10
		titles.add("贩卖截止时间"); // 11
		titles.add("图片"); // 12
		dataMap.put("titles", titles);
		List<PageData> varOList = beautyCardService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("ID")); // 1
			vpd.put("var2", varOList.get(i).getString("CADR_NAME")); // 2
			vpd.put("var3", varOList.get(i).get("MIN_CHARGE").toString()); // 3
			vpd.put("var4", varOList.get(i).get("SERVICE_CHARGE").toString()); // 4
			vpd.put("var5", varOList.get(i).get("DISCUT").toString()); // 5
			vpd.put("var6", varOList.get(i).get("CARE_TIMES").toString()); // 6
			vpd.put("var7", varOList.get(i).get("CARE_PERIOD").toString()); // 7
			vpd.put("var8", varOList.get(i).getString("LIMIT")); // 8
			vpd.put("var9", varOList.get(i).getString("COMMENT")); // 9
			vpd.put("var10", varOList.get(i).getString("SALE_STARTTIME")); // 10
			vpd.put("var11", varOList.get(i).getString("SALE_ENDTIME")); // 11
			vpd.put("var12", varOList.get(i).getString("IMAGE_ID")); // 12
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
