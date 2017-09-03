package com.lex.controller;

import com.fh.controller.base.BaseController;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.lex.Service.LexUserService;
import com.lex.util.AliyunSmsUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by chunye on 16/8/11.
 */
@Controller
@RequestMapping(value = "/app/sms")
public class SmsController extends BaseController {

    @Resource(name = "lexUserService")
    private LexUserService lexUserService;

    /**
     * 基本发送短信
     * @param phone
     * @param vCode
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/send", method = RequestMethod.POST)
    @ResponseBody
    public Object sentSms(String phone, String vCode) throws Exception {
        Map map = new HashMap();
        String code = AliyunSmsUtil.randomNum(4);
        map.put("code",code);
        return setResultMessage(map, Const.APP_RESULT_CODE_SUCCESS,"发送成功");
    }

    /**
     * 找回密码短信发送
     * @param phone
     * @param vCode
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/forgetPass", method = RequestMethod.POST)
    @ResponseBody
    public Object forgetPass(String phone, String vCode) throws Exception {
        String code = AliyunSmsUtil.randomNum(4);
        PageData pd = new PageData();
        pd.put("phone",phone);
        pd.put("validate_code",code);

        Map map = new HashMap();
        map.put("code",code);
        int reInt = lexUserService.edit(pd,phone);
        if(reInt==1){
            return setResultMessage(map, Const.APP_RESULT_CODE_SUCCESS,"发送成功");
        }else{
            return setResultMessage(map, Const.APP_RESULT_CODE_FAIL,"系统异常");
        }
    }



}
