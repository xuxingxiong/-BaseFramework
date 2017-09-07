package com.common.util;

import com.fh.util.PageData;

/**
 * PageData处理
 * 
 * @author Administrator
 *
 */
public class PageDataUtil {
	/**
	 * 移除PageData空白项
	 * 
	 * @param pd
	 * @return
	 */
	public static PageData removeEmpty(PageData pd) {
		PageData pageData = new PageData();
		for (Object key : pd.keySet()) {
			Object value = pd.get(key);
			if (value != null && !"".equals(String.valueOf(value).trim())) {
				pageData.put(key, value);
			}
		}
		return pageData;
	}
}
