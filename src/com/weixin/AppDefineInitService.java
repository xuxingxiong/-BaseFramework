package com.weixin;

import org.springframework.beans.factory.annotation.Autowired;

import com.common.spring.SpringBeanDefineService;
import com.weixin.interceptor.WxMemoryCacheClient;
import com.weixin.entity.Account;
import com.weixin.mapper.AccountDao;

/**
 * 系统启动时自动加载，把公众号信息加入到缓存中
 */
public class AppDefineInitService implements SpringBeanDefineService {

	@Autowired
	private AccountDao accountDao;
	
	public void initApplicationCacheData() {
		Account account = accountDao.getSingleAccount();
		WxMemoryCacheClient.addMpAccount(account);
	}
	
}
