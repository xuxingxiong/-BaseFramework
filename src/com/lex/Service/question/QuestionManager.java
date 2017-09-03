package com.lex.Service.question;

import java.util.List;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.lex.entity.Question;

/** 
 * 说明： 主问答模块接口
 * 创建人：FH Q313596790
 * 创建时间：2016-09-05
 * @version
 */
public interface QuestionManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;

	/**
	 * APP查询列表
	 * @param page
	 * @return
	 * @throws Exception
     */
	public List<PageData> appList(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;

	public void createQuestion(PageData pd, Question question) throws  Exception;
	
}

