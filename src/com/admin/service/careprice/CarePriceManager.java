package com.admin.service.careprice;

import java.util.List;
import java.util.Map;

import com.fh.entity.Page;
import com.fh.util.PageData;

/**
 * 说明： 服务价格管理接口 创建人：FH Q313596790 创建时间：2017-03-11
 * 
 * @version
 */
public interface CarePriceManager {

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception;

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception;

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception;

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page) throws Exception;

	/**
	 * 列表(全部)
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd) throws Exception;

	/**
	 * SUB_ID最大值ByID
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public Integer queryMaxSubIdById(PageData pd) throws Exception;

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception;

	/**
	 * 通过Care获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findByCare(PageData pd) throws Exception;

	/**
	 * 批量删除
	 * 
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(List<Map<String, String>> ArrayDATA_IDS) throws Exception;

}
