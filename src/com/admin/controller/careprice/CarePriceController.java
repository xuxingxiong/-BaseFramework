package com.admin.controller.careprice;

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

import com.admin.service.careprice.CarePriceManager;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.Tools;

/**
 * 说明：服务价格管理 创建人：FH Q313596790 创建时间：2017-03-11
 */
@Controller
@RequestMapping(value = "/careprice")
public class CarePriceController extends BaseController {

	String menuUrl = "careprice/list.do"; // 菜单地址(权限用)
	String menuUrl2 = "careprice/listTwo.do"; // 菜单地址(权限用)
	@Resource(name = "carepriceService")
	private CarePriceManager carepriceService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() {
		logBefore(logger, Jurisdiction.getUsername() + "新增CarePrice");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "add") || Jurisdiction.buttonJurisdiction(menuUrl2, "add"))) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();

			Integer subId = carepriceService.queryMaxSubIdById(pd);
			if (subId == null) {
				pd.put("SUB_ID", "1"); // 服务编号枝番
			} else {
				pd.put("SUB_ID", subId + 1 + ""); // 服务编号枝番
			}
			pd.put("IS_DEL", "0"); // 逻辑删除标识
			pd.put("CREATE_TIME", Tools.date2Str(new Date())); // 创建时间
			pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
			pd.put("CREATER", Jurisdiction.getUsername()); // 创建者
			pd.put("UPDATER", Jurisdiction.getUsername()); // 更新者
			carepriceService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername() + "删除CarePrice");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "del") || Jurisdiction.buttonJurisdiction(menuUrl2, "del"))) {
			return;
		} // 校验权限
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
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
	public ModelAndView edit() {
		logBefore(logger, Jurisdiction.getUsername() + "修改CarePrice");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "edit") || Jurisdiction.buttonJurisdiction(menuUrl2, "edit"))) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("MODIFY_TIME", Tools.date2Str(new Date())); // 修改时间
			pd.put("UPDATER", Jurisdiction.getUsername()); // 更新者
			carepriceService.edit(pd);
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
	public ModelAndView list(Page page) {
		logBefore(logger, Jurisdiction.getUsername() + "列表CarePrice");
		// if(!(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		try {
			List<PageData> varList = carepriceService.list(page); // 列出CarePrice列表
			mv.addObject("varList", varList);
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("admin/careprice/careprice_list");
		mv.addObject("pd", pd);
		mv.addObject("ID", pd.getString("ID"));
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
		logBefore(logger, Jurisdiction.getUsername() + "列表CarePrice");
		// if(!(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		try {
			List<PageData> varList = carepriceService.list(page); // 列出CarePrice列表
			mv.addObject("varList", varList);
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "fail");
		}
		mv.setViewName("admin/careprice/careprice_list2");
		mv.addObject("pd", pd);
		mv.addObject("ID", pd.getString("ID"));
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
		mv.setViewName("admin/careprice/careprice_edit");
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
		pd = carepriceService.findById(pd); // 根据ID读取
		mv.setViewName("admin/careprice/careprice_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 根据ID读取
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/findById")
	@ResponseBody
	public PageData findById() throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = carepriceService.findById(pd); // 根据ID读取
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
		logBefore(logger, Jurisdiction.getUsername() + "批量删除CarePrice");
		if (!(Jurisdiction.buttonJurisdiction(menuUrl, "del") || Jurisdiction.buttonJurisdiction(menuUrl2, "del"))) {
			return null;
		} // 校验权限
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String SUB_ID = pd.getString("SUB_ID");
			if (null != SUB_ID && !"".equals(SUB_ID)) {
				String ArrayDATA_IDS[] = SUB_ID.split(",");
				List<Map<String, String>> itemList = new ArrayList<Map<String, String>>();
				for (String subId : ArrayDATA_IDS) {
					Map<String, String> item = new HashMap<String, String>();
					item.put("SUB_ID", subId);
					item.put("ID", pd.getString("ID"));
					itemList.add(item);
				}
				carepriceService.deleteAll(itemList);
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

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
