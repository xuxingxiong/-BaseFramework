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
		PageData temp = new PageData();
		for (Object key : pd.keySet()) {
			if (pd.get(key) != null && !"".equals((String.valueOf(pd.get(key)).trim()))) {
				temp.put(key, pd.get(key));
			}
		}
		return temp;
	}

}
