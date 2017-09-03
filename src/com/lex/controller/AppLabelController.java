package com.lex.controller;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.lex.Service.label.LabelManager;
import com.sun.corba.se.pept.transport.ReaderThread;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by chunye on 16/8/16.
 */

@Controller
@RequestMapping(value="/app/label")
public class AppLabelController  extends BaseController {


    @Resource(name="labelService")
    private LabelManager labelService;

    /**查询列表
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/list",method = RequestMethod.POST)
    @ResponseBody
    public Object list(String label_type,String label_name,String parent_label_id) throws Exception{
        //logBefore(logger, Jurisdiction.getUsername()+"列表Label");
        //if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
        PageData pd = new PageData();
        pd = this.getPageData();
        Page page = new Page();
        page.setPd(pd);
        List<PageData> varList = labelService.appList(page);	//列出Label列表
        Map returnMap = setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "查询成功");
        returnMap.put("companyList",varList);
        return returnMap;
    }

    /**
     * 新增标签库
     * @param label_type
     * @param label_name
     * @param parent_label_id
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/addLabel",method = RequestMethod.POST)
    @ResponseBody
    public Object addLabel(String label_type,String label_name,String parent_label_id) throws Exception{
        PageData pd = new PageData();
        pd = this.getPageData();
        String UUID = this.get32UUID();
        pd.put("label_id",UUID);
        labelService.save(pd);
        Map returnMap = setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "查询成功");
        returnMap.put("label_id",UUID);
        return returnMap;
    }


}
