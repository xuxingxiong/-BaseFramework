package com.weixin.service;

import java.util.List;
import com.common.page.Pagination;
import com.weixin.entity.AccountMenuGroup;


public interface AccountMenuGroupService {

	public AccountMenuGroup getById(String id);

	public List<AccountMenuGroup> list(AccountMenuGroup searchEntity);

	public Pagination<AccountMenuGroup> paginationEntity(AccountMenuGroup searchEntity ,Pagination<AccountMenuGroup> pagination);

	public void add(AccountMenuGroup entity);

	public void update(AccountMenuGroup entity);

	public void delete(AccountMenuGroup entity);



}

