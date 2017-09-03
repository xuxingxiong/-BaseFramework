package com.weixin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.weixin.entity.Account;
import com.weixin.mapper.AccountDao;
import com.weixin.service.AccountService;


@Service
public class AccountServiceImpl implements AccountService{

	@Autowired
	private AccountDao entityDao;

	public Account getById(String id){
		return entityDao.getById(id);
	}
	
	public Account getByAccount(String account){
		return entityDao.getByAccount(account);
	}

	public List<Account> listForPage(Account searchEntity){
		return entityDao.listForPage(searchEntity);
	}

	public void add(Account entity){
		entityDao.add(entity);
	}

	public void update(Account entity){
		entityDao.update(entity);
	}

	public void delete(Account entity){
		entityDao.delete(entity);
	}

}