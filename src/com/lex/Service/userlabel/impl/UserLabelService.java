package com.lex.Service.userlabel.impl;

import java.util.List;
import javax.annotation.Resource;

import com.lex.Service.userlabel.UserLabelManager;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


/** 
 * 说明： app用户标签
 * 创建人：FH Q313596790
 * 创建时间：2016-08-17
 * @version
 */
@Service("userlabelService")
public class UserLabelService implements UserLabelManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("UserLabelMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("UserLabelMapper.delete", pd);
	}

	@Override
	public int deleteByApp(PageData pd) throws Exception {
		return  (int)dao.delete("UserLabelMapper.deleteByApp", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("UserLabelMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("UserLabelMapper.datalistPage", page);
	}

	/**列表
	* @param page
	* @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public List<PageData> appList(Page page)throws Exception{
		return (List<PageData>)dao.findForList("UserLabelMapper.appDataListPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("UserLabelMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("UserLabelMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("UserLabelMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

