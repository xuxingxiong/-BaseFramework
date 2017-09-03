package com.lex.Service.contacts.impl;

import java.util.List;
import javax.annotation.Resource;

import com.lex.Service.contacts.ContactsManager;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 用户通讯录
 * 创建人：FH Q313596790
 * 创建时间：2016-08-24
 * @version
 */
@Service("contactsService")
public class ContactsService implements ContactsManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ContactsMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ContactsMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ContactsMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ContactsMapper.datalistPage", page);
	}

	@Override
	public List<PageData> appList(Page page) throws Exception {
		return (List<PageData>)dao.findForList("ContactsMapper.datalistPage", page);
	}

	/**
	 *
	 * @param page
	 * @param identity 学生或者老师 0学生 1老师
	 * @return
	 * @throws Exception
     */
	public List<PageData> appList(Page page,int identity) throws Exception {

		return (List<PageData>)appList(page);
	}

	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContactsMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ContactsMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ContactsMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

