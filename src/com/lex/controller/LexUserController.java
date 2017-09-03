package com.lex.controller;


import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.information.pictures.PicturesManager;
import com.fh.util.*;
import com.lex.Service.LexUserService;
import com.lex.Service.company.CompanyManager;
import com.lex.Service.userlabel.UserLabelManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by chunye on 16/8/9.
 */
@Controller
@RequestMapping(value = "/app/user")
public class LexUserController extends BaseController {


    @Resource(name = "lexUserService")
    private LexUserService lexUserService;

    @Resource(name="picturesService")
    private PicturesManager picturesService;

    @Resource(name="companyService")
    private CompanyManager companyService;

    @Resource(name="userlabelService")
    private UserLabelManager userLabelService;

    /**
     * app登录接口
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Object appLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {

//        String phone = (String) request.getAttribute("phone");
//        String password = (String) request.getAttribute("password");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        if(Tools.isEmpty(phone) || Tools.isEmpty(password)){
            return  setResultMessage(null, Const.APP_RESULT_CODE_FAIL, "缺少参数");
        }
        PageData pd = new PageData();
        pd.put("phone", phone);
        pd.put("password", password);
        List<PageData> list = (List<PageData>) lexUserService.getUserInfoByPass(pd);
        if (list.isEmpty()) {
            //setResultMessage(Const.APP_RESULT_CODE_FAIL,"登录信息不正确");
            return setResultMessage(null, Const.APP_RESULT_CODE_FAIL, "登录信息不正确");
        } else {
            Map map = new HashMap();
            map.put("user", list.get(0));
            // map.put("returnCode","登录信息不正确");
            String token = phone + DateUtil.getDays();
            Const.APP_SESSION_TOKEN.put(token, list.get(0));
            response.addHeader("token", token);
            map = setResultMessage(map, Const.APP_RESULT_CODE_SUCCESS, "登录成功");
            return map;
        }

    }

    /**
     * 注册
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public Object appRegister(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        if(Tools.isEmpty(phone) && Tools.isEmpty(password)){
            return  setResultMessage(null, Const.APP_RESULT_CODE_FAIL, "缺少参数");
        }
        PageData pd = this.getPageData();
        pd.put("create_user", phone);
        List<PageData> list = lexUserService.isExist(pd);
        if (list.isEmpty()) {
            int rlt = lexUserService.register(pd);
            return setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "注册成功");
        } else {
            return setResultMessage(null, Const.APP_RESULT_CODE_FAIL, "用户已存在");
        }
    }

    /**
     * 忘记密码重置
     *
     * @param phone
     * @param validate_code_where
     * @param password
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/forgetPassReset", method = RequestMethod.POST)
    @ResponseBody
    public Object forgetPassReset(String phone, String validate_code_where, String password) throws Exception {
        PageData pd = this.getPageData();
        int reInt = lexUserService.edit(pd, phone);
        if (reInt == 1) {
            return setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "重置成功");
        }else{
            return setResultMessage(null, Const.APP_RESULT_CODE_FAIL, "重置失败");
        }
    }


    /**
     * 编辑用户基本信息
     * @param name
     * @param age
     * @param sex
     * @param signature
     * @param area_id
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/editUser", method = RequestMethod.POST)
    @ResponseBody
    public Object editUser(String phone, String name,String age,String sex,String signature,String area_id) throws  Exception{
        PageData pd = this.getPageData();
        int reInt = lexUserService.edit(pd, phone);
        if (reInt == 1) {
            return setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "编辑成功");
        }else{
            return setResultMessage(null, Const.APP_RESULT_CODE_FAIL, "编辑失败,记录数异常");
        }
    }

    /**
     * 编辑用户头像
     * @param file
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/editHeadPic", method = RequestMethod.POST)
    @ResponseBody
    public Object editHeadPic(@RequestParam(required=false) MultipartFile file,String phone) throws  Exception {
        String  ffile = DateUtil.getDays(), fileName = "",UUID = "";


        if (null != file && !file.isEmpty()) {
            String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;		//文件上传路径
            UUID = this.get32UUID();
            fileName = FileUpload.fileUp(file, filePath, UUID);				//执行上传
        }else{
            return setResultMessage(null, Const.APP_RESULT_CODE_FAIL, "上传文件为空");
        }
        //图片库插入
        PageData pd =new PageData();
        pd.put("PICTURES_ID", this.get32UUID());			//主键
        pd.put("TITLE", "头像图片");								//标题
        pd.put("NAME", fileName);							//文件名
        pd.put("PATH", ffile + "/" + fileName);				//路径
        pd.put("CREATETIME", Tools.date2Str(new Date()));	//创建时间
        pd.put("MASTER_ID", "1");							//附属与
        pd.put("BZ", "APP端上传");						//备注
        //Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);//加水印
        picturesService.save(pd);

        //用户表修改
        PageData pdUser = this.getPageData();
        pdUser.put("phone",phone);
        pdUser.put("head_pic",UUID);
        int reInt = lexUserService.edit(pdUser, phone);
        if (reInt == 1) {
            return setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "编辑成功");
        }else{
            return setResultMessage(null, Const.APP_RESULT_CODE_FAIL, "编辑失败,记录数异常");
        }

    }

    /**
     * 添加工作经历
     * @param company_name
     * @param start_time
     * @param end_time
     * @param company_id
     * @param phone
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addWork", method = RequestMethod.POST)
    @ResponseBody
    public Object addWork(String company_name, String start_time,String end_time,String company_id,String phone) throws  Exception{
        PageData pd = this.getPageData();
        pd.put("app_user_id","1");
        int reInt =lexUserService.saveWorkHistory(pd);
        if (reInt == 1) {
            return setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "添加成功");
        }else{
            return setResultMessage(null, Const.APP_RESULT_CODE_FAIL, "添加失败,记录数异常");
        }

    }

    /**
     * 编辑工作经历
     * @param company_name
     * @param start_time
     * @param end_time
     * @param company_id
     * @param phone
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/editWork", method = RequestMethod.POST)
    @ResponseBody
    public Object editWork(String company_name, String start_time,String end_time,String company_id,String phone) throws  Exception{
        PageData pd = this.getPageData();
        int reInt  = lexUserService.editWorkHistory(pd);
        if (reInt == 1) {
            return setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "编辑成功");
        }else{
            return setResultMessage(null, Const.APP_RESULT_CODE_FAIL, "编辑失败,记录数异常");
        }

    }

    /**
     * 工作经历
     * @param phone
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/workList", method = RequestMethod.POST)
    @ResponseBody
    public Object workList(String phone) throws  Exception{
        PageData pd = this.getPageData();
        Map map = setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "编辑成功");
        map.put("workList",lexUserService.workList(pd));
        return map;

    }

    /**
     * 标签列表
     * @param phone
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/labelList", method = RequestMethod.POST)
    @ResponseBody
    public Object labelList(String label_type,String data_type,String app_user_id) throws  Exception{
        PageData pd = this.getPageData();
        Page page =new Page();
        page.setPd(pd);
        Map map = new HashMap();
        map.put("labelList",userLabelService.appList(page));
        setResultMessage(map, Const.APP_RESULT_CODE_SUCCESS, "查询成功");

        return map;
    }

    /**
     * 编辑用户标签
     * @param label_id
     * @param label_type
     * @param label_name
     * @param data_type
     * @param app_user_id
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/editLabel", method = RequestMethod.POST)
    @ResponseBody
    public Object editLabel(String label_id,String label_type,String label_name,String data_type,String app_user_id) throws  Exception{
        if(Tools.isEmpty(label_id) || Tools.isEmpty(label_type) || Tools.isEmpty(data_type)){
            return  setResultMessage(null, Const.APP_RESULT_CODE_FAIL, "缺少参数");
        }
        PageData pd = this.getPageData();
        Page page =new Page();
        page.setPd(pd);
        pd.put("create_time",Tools.date2Str(new Date()));
        pd.put("user_label_id",this.get32UUID());
        pd.put("score",0);
        //删除该用户学生霍老师下的类型标签
        int dltCount = userLabelService.deleteByApp(pd);

        String[] label_id_array  = label_id.split(",");

        if(Const.LABEL_TYPE_JINENG.equals(label_type)){
            //技能可以进行5项保存
            for (int i = 0; i < label_id_array.length; i++) {
                String s = label_id_array[i];
                pd.put("label_id",s);
                userLabelService.save(pd);
                
            }
            return setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "标签成功:"+label_id_array.length);

        }else{
            userLabelService.save(pd);
            return setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "成功");
        }

       // map.put("labelList",userLabelService.appList(page));

    }
}
