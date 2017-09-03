package com.lex.controller;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.lex.Service.LexUserService;
import com.lex.Service.contacts.ContactsManager;
import com.lex.Service.contactsmessage.ContactsMessageManager;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by chunye on 16/8/24.
 *
 */
@Controller
@RequestMapping(value="/app/contacts")
public class AppContactsController extends BaseController {


    @Resource(name="contactsService")
    private ContactsManager contactsService;

    @Resource(name="lexUserService")
    private LexUserService lexUserService;

    @Resource(name="contactsmessageService")
    private ContactsMessageManager  contactsMessageManager;

    /**
     * 查询用户师友录
     * @param user_id
     * @param contacts_type
     * @param contacts_group_id
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/list",method = RequestMethod.POST)
    @ResponseBody
    public Object list(String user_id,String contacts_type,String contacts_group_id) throws Exception{
       //判断该用户是否具有这个user_id的访问权限,这个需要后期加入
        if(Tools.isEmpty(user_id) || Tools.isEmpty(contacts_type)){
           return  setResultMessage(null, Const.APP_RESULT_CODE_FAIL, "缺少参数");
        }
        PageData pd = new PageData();
        Page page = new Page();
        pd.put("user_id",user_id);
        pd.put("contacts_type",user_id);
        pd.put("contacts_group_id",contacts_group_id);
        page.setShowCount(100);
        page.setPd(pd);
        List<PageData> varList = contactsService.appList(page);	//列出Label列表
        Map returnMap = setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "查询成功");
        returnMap.put("contactsList",varList);
        return returnMap;
    }


    /**查询本地通讯录用户列表
     * @param phone
     * @throws Exception
     */
    @RequestMapping(value="/getLocalUser",method = RequestMethod.POST)
    @ResponseBody
    public Object getLocalPhoneUserList(String[] phone) throws Exception{
        PageData pd = new PageData();
        pd = this.getPageData();
        List<PageData> list = lexUserService.queryListByPhone(pd);
        Map returnMap = setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "查询成功");
        returnMap.put("userList",list);
        return  returnMap;
    }


    /**
     * 拜师接口
     * @param launch_user_id
     * @param receive_user_id
     * @param message_note
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/apprentice",method = RequestMethod.POST)
    @ResponseBody
    public Object apprentice(String launch_user_id,String receive_user_id,String message_note) throws Exception{
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("contacts_message_id",this.get32UUID());
        pd.put("message_type",Const.CONTACTS_MESSAGE_TYPE_INVITE);
        pd.put("message_state",Const.CONTACTS_MESSAGE_STATE_INIT);
        pd.put("create_time",Tools.date2Str(new Date()));
        contactsMessageManager.save(pd);
        /**
         * 这里需要加入调用推送的接口
         */
        Map returnMap = setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "拜师信息已经发布");
        return  returnMap;
    }

    /**
     * 获取消息列表
     * @param receive_user_id
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/getContactsMessage",method = RequestMethod.POST)
    @ResponseBody
    public Object getContactsMessage(String receive_user_id) throws Exception{
        PageData pd = this.getPageData();
        pd.put("message_type","1,3,4");
        Page page = new Page();
        page.setPd(pd);
        List<PageData> list = contactsMessageManager.appList(page);
        Map returnMap = setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "查询成功");
        returnMap.put("contactsMessageList",list);
        return returnMap;
    }


    /**
     * 读取消息改变消息状态
     * @param contacts_message_id
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/readContactsMessage",method = RequestMethod.POST)
    @ResponseBody
    public Object readContactsMessage(String contacts_message_id) throws Exception{
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("message_state",Const.CONTACTS_MESSAGE_STATE_READ);
        pd.put("update_time",Tools.date2Str(new Date()));
        Map returnMap = setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "已读状态修改成功");
        return returnMap;

    }

    /**
     * 老师接受拜师接口
     * @param contacts_message_id
     * @param user_id
     * @param student_user_id
     * @param name_note
     * @param description
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/agreeApprentice",method = RequestMethod.POST)
    @ResponseBody
    public Object agreeApprentice(String contacts_message_id,String user_id,String student_user_id,String name_note,String description
    ) throws Exception{
        //新增通讯录消息记录
        PageData pd = new PageData();
        pd.put("contacts_message_id",this.get32UUID());
        pd.put("launch_user_id",user_id);
        pd.put("receive_user_id",student_user_id);
        //同意拜师消息
        pd.put("message_type",Const.CONTACTS_MESSAGE_TYPE_AGREE);
        pd.put("message_state",Const.CONTACTS_MESSAGE_STATE_INIT);
        pd.put("create_time",Tools.date2Str(new Date()));
        contactsMessageManager.save(pd);



        //插入老师通讯录
        PageData pdTeacher = new PageData();
        pdTeacher.put("contacts_id",this.get32UUID());
        pdTeacher.put("user_id",user_id);
        pdTeacher.put("friend_user_id",student_user_id);
        pdTeacher.put("contacts_type",Const.USER_LABEL_DATA_STUDENT);

        pdTeacher.put("name_note",name_note);
        pdTeacher.put("description",description);
        pdTeacher.put("contacts_group_id",null);
        pdTeacher.put("picture_id",null);
        pdTeacher.put("create_time",Tools.date2Str(new Date()));

        contactsService.save(pdTeacher);

        //插入学生通讯录
        PageData pdStudent = new PageData();
        pdStudent.put("contacts_id",this.get32UUID());
        pdStudent.put("user_id",student_user_id);
        pdStudent.put("friend_user_id",user_id);
        pdStudent.put("contacts_type",Const.USER_LABEL_DATA_TEACHER);
        pdStudent.put("name_note",null);
        pdStudent.put("description",null);
        pdStudent.put("contacts_group_id",null);
        pdStudent.put("picture_id",null);
        pdStudent.put("create_time",Tools.date2Str(new Date()));
        contactsService.save(pdStudent);

        /**
         * 这里需要加入调用推送的接口,通知学生老师同意拜师
         */

        Map returnMap = setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "老师接受拜师");
        return  returnMap;
    }


}
