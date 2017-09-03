package com.lex.Service;


import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.UuidUtil;
import com.lex.Service.company.CompanyManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Iterator;
import java.util.List;

/**
 * Created by chunye on 16/8/9.
 */
@Service("lexUserService")
public class LexUserService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    @Resource(name = "companyService")
    private CompanyManager companyService;


    public List<PageData> getUserInfoByPass(PageData page) throws Exception {
        List pageData = (List<PageData>) dao.findForList("LexUserMapper.getUserInfoByPass", page);
        for (Iterator iterator = pageData.iterator(); iterator.hasNext(); ) {
            PageData next = (PageData) iterator.next();
            if (Tools.notEmpty(next.getString("head_pic_path"))) {
                String picPath = next.getString("head_pic_path");
                picPath = Const.FILEPATHIMG + picPath;
                next.put("head_pic_path", picPath);
            }


        }
        return pageData;
    }

    /*
    * 注册
	*/
    public int register(PageData pd) throws Exception {
        return (int) (dao.save("LexUserMapper.register", pd));
    }

    /*
    * 是否存在
     */
    public List<PageData> isExist(PageData page) throws Exception {
        return (List<PageData>) dao.findForList("LexUserMapper.isExist", page);
    }


    /*
    * 编辑
	*/
    public int edit(PageData pd, String phone) throws Exception {
        return (int) (dao.update("LexUserMapper.edit", pd));
    }

    /**
     * 新增工作
     *
     * @param pd
     * @throws Exception
     */
    public int saveWorkHistory(PageData pd) throws Exception {
        String company_id = (String) pd.get("company_id");
        if (Tools.isEmpty(company_id)) {
            //PageData pd = new PageData();
            String UUID = UuidUtil.get32UUID();
            pd.put("company_id", UUID);    //主键
            pd.put("use_count", 1);
            companyService.save(pd);
        }
        return (int) (dao.save("LexUserMapper.insertWork", pd));

    }

    /**
     * 编辑工作历史
     *
     * @param pd
     * @throws Exception
     */
    public int editWorkHistory(PageData pd) throws Exception {
        String company_id = (String) pd.get("company_id");
        if (Tools.isEmpty(company_id)) {
            //PageData pd = new PageData();
            String UUID = UuidUtil.get32UUID();
            pd.put("COMPANY_ID", UUID);    //主键
            pd.put("USE_COUNT", 1);
            companyService.save(pd);
        }
        return (int) (dao.update("LexUserMapper.editWork", pd));
    }

    public List<PageData> workList(PageData page) throws Exception {
        return (List<PageData>) dao.findForList("LexUserMapper.workList", page);
    }


    /**
     * 列表
     *
     * @param page
     * @throws Exception
     */
    public List<PageData> queryListByPhone(PageData page) throws Exception {
        return (List<PageData>) dao.findForList("LexUserMapper.queryListByPhone", page);
    }

}
