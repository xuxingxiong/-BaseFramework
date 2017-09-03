package com.lex.controller;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.lex.Service.company.CompanyManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by chunye on 16/8/16.
 */
@Controller
@RequestMapping(value="/app/company")
public class AppCompanyController extends BaseController {

    @Resource(name="companyService")
    private CompanyManager companyService;

    @RequestMapping(value="/list",method= RequestMethod.POST)
    @ResponseBody
    public Object list(String keywords) throws Exception{
        //logBefore(logger, Jurisdiction.getUsername()+"列表Company");
        PageData pd = new PageData();
        pd = this.getPageData();
        //String keywords = pd.getString("keywords");				//关键词检索条件
        if(null != keywords && !"".equals(keywords)){
            pd.put("keywords", keywords.trim());
        }
        Page page = new Page();
        page.setPd(pd);
        page.setShowCount(100);
        List<PageData> varList = companyService.list(page);	//列出Company列表
        Map returnMap = setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "查询成功");
        returnMap.put("companyList",varList);
        return returnMap;
    }
}
