package com.weixin.service;

import java.util.List;

import com.common.page.Pagination;
import com.weixin.entity.AccountFans;


public interface AccountFansService {

	public AccountFans getById(String id);
	
	public AccountFans getByOpenId(String openId);

	public List<AccountFans> list(AccountFans searchEntity);

	public Pagination<AccountFans> paginationEntity(AccountFans searchEntity,Pagination<AccountFans> pagination);

	public AccountFans getLastOpenId();
	
	public void sync(AccountFans searchEntity);
	
	public void add(AccountFans entity);

	public void update(AccountFans entity);

	public void delete(AccountFans entity);

	public void deleteByOpenId(String openId);


}