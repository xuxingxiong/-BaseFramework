package com.fh.service.remind;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

public interface RemindManager {
	/**
	 * 获取所有提醒消息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> list(Page pd) throws Exception;/**
	 * 不再提醒消息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void remove(PageData pd) throws Exception;
}
