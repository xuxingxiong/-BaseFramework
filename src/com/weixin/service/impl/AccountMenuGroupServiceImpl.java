package com.weixin.service.impl;

import java.util.List;
import com.common.page.Pagination;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.weixin.entity.AccountMenuGroup;
import com.weixin.service.AccountMenuGroupService;
import com.weixin.mapper.AccountMenuGroupDao;


@Service
public class AccountMenuGroupServiceImpl implements AccountMenuGroupService{

	@Autowired
	private AccountMenuGroupDao entityDao;

	public AccountMenuGroup getById(String id){
		return entityDao.getById(id);
	}

	public List<AccountMenuGroup> list(AccountMenuGroup searchEntity){
		return entityDao.list(searchEntity);
	}

	public Pagination<AccountMenuGroup> paginationEntity(AccountMenuGroup searchEntity ,Pagination<AccountMenuGroup> pagination){
		Integer totalItemsCount = entityDao.getTotalItemsCount(searchEntity);
		List<AccountMenuGroup> items = entityDao.paginationEntity(searchEntity,pagination);
		pagination.setTotalItemsCount(totalItemsCount);
		pagination.setItems(items);
		return pagination;
	}

	public void add(AccountMenuGroup entity){
		entityDao.add(entity);
	}

	public void update(AccountMenuGroup entity){
		entityDao.update(entity);
	}

	public void delete(AccountMenuGroup entity){
		entityDao.deleteAllMenu(entity);
		entityDao.delete(entity);
	}



}

