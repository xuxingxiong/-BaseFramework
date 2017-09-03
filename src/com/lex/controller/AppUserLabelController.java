package com.lex.controller;

import com.fh.controller.base.BaseController;
import com.lex.Service.userlabel.UserLabelManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * Created by chunye on 16/8/17.
 */
@Controller
@RequestMapping(value="/app/userlabel")
public class AppUserLabelController extends BaseController {

    @Resource(name="userlabelService")
    private UserLabelManager userlabelService;

    /**保存
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/list",method= RequestMethod.POST)
    @ResponseBody
    public Object list(String l) throws Exception{
            return null;
    }





}
