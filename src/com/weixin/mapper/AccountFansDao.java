package com.weixin.mapper;

import java.util.List;

import com.common.page.Pagination;
import com.weixin.entity.AccountFans;


public interface AccountFansDao {

	public AccountFans getById(String id);

	public AccountFans getByOpenId(String openId);
	
	public List<AccountFans> list(AccountFans searchEntity);

	public Integer getTotalItemsCount(AccountFans searchEntity);
	
	public List<AccountFans> paginationEntity(AccountFans searchEntity ,Pagination<AccountFans> pagination);

	public AccountFans getLastOpenId();
	
	public void add(AccountFans entity);
	
	public void addList(List<AccountFans> list);

	public void update(AccountFans entity);

	public void delete(AccountFans entity);

	public void deleteByOpenId(String openId);

}