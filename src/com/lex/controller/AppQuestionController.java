package com.lex.controller;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.lex.Service.question.QuestionManager;
import com.lex.entity.Question;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.tools.Tool;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by chunye on 16/9/7.
 */
@Controller
@RequestMapping(value = "/app/question")
public class AppQuestionController extends BaseController {

    @Resource(name = "questionService")
    private QuestionManager questionService;

    /**
     * 问答查询接口
     *
     * @param question_type  问题类型
     * @param question_state 问题状态
     * @param user_id        用户id
     * @param query_type     查询类型 0 学生 1老师
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public Object list(String question_type, String question_state, String user_id, String query_type) throws Exception {
        PageData pd = new PageData();
        pd = this.getPageData();
        //查询类型0代表的是学生,1代表的是老师
        if ("0".equals(query_type)) {
            pd.put("question_user_id", user_id);
        } else if ("1".equals(query_type)) {
            pd.put("answer_user_id", user_id);

        }
        Page page = new Page();
        page.setPd(pd);
        page.setShowCount(10);
        List<PageData> list = questionService.appList(page);
        Map returnMap = setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "查询成功");
        returnMap.put("companyList", list);
        return returnMap;
    }


    /**
     * @param user_id
     * @param question_type
     * @throws Exception
     */
    @RequestMapping(value = "/initQuestion", method = RequestMethod.POST)
    @ResponseBody
    public Object initQuestion(String user_id, String question_type) throws Exception {
        PageData pd = new PageData();
        String questionId = this.get32UUID();
        pd.put("question_id", questionId);
        pd.put("create_time", Tools.date2Str(new Date()));
        pd.put("question_state", Const.QUESTION_STATE_INIT);
        String s= null;
        questionService.save(pd);
        Map returnMap = setResultMessage(null, Const.APP_RESULT_CODE_SUCCESS, "成功");
        returnMap.put("question_id", questionId);
        return returnMap;
    }

    /**
     * 创建问答接口
     *
     * @param question
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/createQuestion", method = RequestMethod.POST)
    @ResponseBody
    public Object createQuestion(Question question) throws Exception {
        PageData pd = this.getPageData();

//        String user_id,String question_id,String question_title,String question_text,
//                String hy_label,String fx_label,String zn_label,String jn_label,String question_price,
//                String spread,String question_state, String question_type,String expire_text,
//                @RequestParam(required=false) MultipartFile photoFile,
//                @RequestParam(required=false) MultipartFile voiceFile,
//                String[] contacts
    return null;
        /**
         * 1,入问答主表,2上传附件,3入问答资源表,4入问答联系人表
         */
    }

}
