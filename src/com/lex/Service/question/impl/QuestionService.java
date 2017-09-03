package com.lex.Service.question.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import javax.annotation.Resource;

import com.fh.util.*;
import com.lex.Service.question.QuestionManager;
import com.lex.Service.questionlogs.impl.QuestionLogsService;
import com.lex.Service.questionmessage.impl.QuestionMessageService;
import com.lex.entity.Question;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;


/**
 * 说明： 主问答模块
 * 创建人：FH Q313596790
 * 创建时间：2016-09-05
 */
@Service("questionService")
public class QuestionService implements QuestionManager {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    @Resource(name = "questionlogsService")
    private QuestionLogsService questionLogsService;

    @Resource(name = "questionmessageService")
    private QuestionMessageService questionMessageService;

    /**
     * 新增
     *
     * @param pd
     * @throws Exception
     */
    public void save(PageData pd) throws Exception {
        dao.save("QuestionMapper.save", pd);
    }

    /**
     * 删除
     *
     * @param pd
     * @throws Exception
     */
    public void delete(PageData pd) throws Exception {
        dao.delete("QuestionMapper.delete", pd);
    }

    /**
     * 修改
     *
     * @param pd
     * @throws Exception
     */
    public void edit(PageData pd) throws Exception {
        dao.update("QuestionMapper.edit", pd);
    }

    /**
     * 列表
     *
     * @param page
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<PageData> list(Page page) throws Exception {
        return (List<PageData>) dao.findForList("QuestionMapper.datalistPage", page);
    }


    public List<PageData> appList(Page page) throws Exception {
        return (List<PageData>) dao.findForList("QuestionMapper.appDatalistPage", page);
    }

    /**
     * 列表(全部)
     *
     * @param pd
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<PageData> listAll(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("QuestionMapper.listAll", pd);
    }

    /**
     * 通过id获取数据
     *
     * @param pd
     * @throws Exception
     */
    public PageData findById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("QuestionMapper.findById", pd);
    }

    /**
     * 批量删除
     *
     * @param ArrayDATA_IDS
     * @throws Exception
     */
    public void deleteAll(String[] ArrayDATA_IDS) throws Exception {
        dao.delete("QuestionMapper.deleteAll", ArrayDATA_IDS);
    }

    /**
     * 创建问题
     *
     * @param pd
     * @param question
     * @throws Exception
     */
    @Transactional
    public void createQuestion(PageData pd, Question question) throws Exception {
        /**
         * 1,入问答主表,2上传附件,3入问答资源表,4入问答联系人表,5入通知表,6推送数据
         */
        //处理主表操作
        Calendar cal = Calendar.getInstance();
        if (Tools.notEmpty(question.getExpire_text())) {
            int expireInt = Integer.parseInt(question.getExpire_text());
            cal.add(Calendar.HOUR, expireInt);
        }
        pd.put("expire_time", Tools.date2Str(cal.getTime()));
        pd.put("create_time", Tools.date2Str(new Date()));
        pd.put("question_state", Const.QUESTION_STATE_PUBLISH);
        dao.update("QuestionMapper", pd);
        //处理文字资源操作
        PageData pdResText = new PageData();
        String pdResTextId = UuidUtil.get32UUID();
        pdResText.put("question_id", question.getQuestion_id());
        pdResText.put("res_type", Const.QUESTION_RES_TYPE_TEXT);
        pdResText.put("res_text", pdResText);
        pdResText.put("create_time", Tools.date2Str(new Date()));
        pdResText.put("question_resource_id", pdResTextId);

        dao.save("QuestionResourceMapper.save", pdResText);

        //处理图片资源操作
        for (MultipartFile file : question.getPhotoFile()) {
            String ffile = DateUtil.getDays(), fileName = "", UUID = "";
            if (null != file && !file.isEmpty()) {
                String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;        //文件上传路径
                UUID = UuidUtil.get32UUID();
                fileName = FileUpload.fileUp(file, filePath, UUID);                //执行上传
            } else {
                //return setResultMessage(null, Const.APP_RESULT_CODE_FAIL, "上传文件为空");
            }
            //图片库插入
            PageData pdPictures = new PageData();
            String pictures_id = UuidUtil.get32UUID();
            pdPictures.put("PICTURES_ID", pictures_id);            //主键
            pdPictures.put("TITLE", "头像图片");                                //标题
            pdPictures.put("NAME", fileName);                            //文件名
            pdPictures.put("PATH", ffile + "/" + fileName);                //路径
            pdPictures.put("CREATETIME", Tools.date2Str(new Date()));    //创建时间
            pdPictures.put("MASTER_ID", "1");                            //附属与
            pdPictures.put("BZ", "APP端上传");                        //备注
            pdPictures.put("FILE_TYPE", Const.QUESTION_RES_TYPE_PHOTO);
            String extName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            pd.put("SUFFIX_NAME", extName);
            //Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);//加水印
            //picturesService.save(pd);
            dao.save("PicturesMapper.save", pd);
            //处理图片资源入库
            PageData pdResTextPhoto = new PageData();
            //String pdResTextId = UuidUtil.get32UUID();
            pdResTextPhoto.put("question_id", question.getQuestion_id());
            pdResTextPhoto.put("res_type", Const.QUESTION_RES_TYPE_PHOTO);
            pdResTextPhoto.put("res_text", pdResText);
            pdResTextPhoto.put("create_time", Tools.date2Str(new Date()));
            pdResTextPhoto.put("question_resource_id", UuidUtil.get32UUID());
            pdResTextPhoto.put("pictures_id", pictures_id);
            dao.save("QuestionResourceMapper.save", pdResTextPhoto);
        }
        //处理语音资源操作
        for (MultipartFile file : question.getVoiceFile()) {
            String ffile = DateUtil.getDays(), fileName = "", UUID = "";
            if (null != file && !file.isEmpty()) {
                String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;        //文件上传路径
                UUID = UuidUtil.get32UUID();
                fileName = FileUpload.fileUp(file, filePath, UUID);                //执行上传
            } else {
                //return setResultMessage(null, Const.APP_RESULT_CODE_FAIL, "上传文件为空");
            }
            //语音库插入
            PageData pdPictures = new PageData();
            String pictures_id = UuidUtil.get32UUID();
            pdPictures.put("PICTURES_ID", pictures_id);            //主键
            pdPictures.put("TITLE", "头像图片");                                //标题
            pdPictures.put("NAME", fileName);                            //文件名
            pdPictures.put("PATH", ffile + "/" + fileName);                //路径
            pdPictures.put("CREATETIME", Tools.date2Str(new Date()));    //创建时间
            pdPictures.put("MASTER_ID", "1");                            //附属与
            pdPictures.put("BZ", "APP端上传");                        //备注
            pdPictures.put("FILE_TYPE", Const.PICTURES_FILE_TYPE_VOICE);
            String extName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            pd.put("SUFFIX_NAME", extName);
            //Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);//加水印
            //picturesService.save(pd);
            dao.save("PicturesMapper.save", pd);
            //处理语音资源入库
            PageData pdResTextVoice = new PageData();
            //String pdResTextId = UuidUtil.get32UUID();
            pdResTextVoice.put("question_id", question.getQuestion_id());
            pdResTextVoice.put("res_type", Const.QUESTION_RES_TYPE_VOICE);
            pdResTextVoice.put("res_text", pdResText);
            pdResTextVoice.put("create_time", Tools.date2Str(new Date()));
            pdResTextVoice.put("question_resource_id", UuidUtil.get32UUID());
            pdResTextVoice.put("pictures_id", pictures_id);
            dao.save("QuestionResourceMapper.save", pdResTextVoice);
        }
        //入库指定老师
        for (String teacher : question.getContacts()) {
            PageData pdTeacher = new PageData();
            pdTeacher.put("question_contacts_id", UuidUtil.get32UUID());
            pdTeacher.put("question_id", question.getQuestion_id());
            pdTeacher.put("user_id", teacher);
            pdTeacher.put("create_time", Tools.date2Str(new Date()));
            dao.save("QuestionContactsMapper.save", pdTeacher);
        }

        //入库log
        PageData pdQuestionLog = new PageData();
        pdQuestionLog.put("question_logs_id", UuidUtil.get32UUID());
        pdQuestionLog.put("user_id", question.getUser_id());
        pdQuestionLog.put("log_type", Const.QUESTION_STATE_PUBLISH);
        pdQuestionLog.put("log_text", "问题发布");
        pdQuestionLog.put("question_id", question.getQuestion_id());
        pdQuestionLog.put("create_time", Tools.date2Str(new Date()));
        questionLogsService.save(pdQuestionLog);

        //推送功能   推送成功0 失败为1

        //入库问题消息表 指定问题
        if (Const.QUESTION_TYPE_SPECIFY.equals(question.getQuestion_type()))
            for (String receive_user_id : question.getContacts()) {
                PageData pdQuestionMessage = new PageData();
                pdQuestionMessage.put("question_message_id", UuidUtil.get32UUID());
                pdQuestionMessage.put("launch_user_id", question.getUser_id());
                pdQuestionMessage.put("receive_user_id", receive_user_id);
                pdQuestionMessage.put("question_id", question.getQuestion_id());
                pdQuestionMessage.put("message_type", Const.QUESTION_STATE_PUBLISH);
                pdQuestionMessage.put("message_state", Const.CONTACTS_MESSAGE_STATE_INIT);
                pdQuestionMessage.put("message_note", "新问题:" + question.getQuestion_title());
                pdQuestionMessage.put("create_time", Tools.date2Str(new Date()));
                pdQuestionMessage.put("update_time", Tools.date2Str(new Date()));
                pdQuestionMessage.put("push_state", 0);
                questionMessageService.save(pdQuestionMessage);
            }
        if (Const.QUESTION_TYPE_DIFFUSE.equals(question.getQuestion_type())){
            //悬赏思路  按照技能逐层进行查找
        }


    }

}

