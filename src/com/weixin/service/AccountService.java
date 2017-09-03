package com.weixin.service;

import java.util.List;

import com.weixin.entity.Account;


public interface AccountService {

	public Account getById(String id);
	
	public Account getByAccount(String account);
	
	public List<Account> listForPage(Account searchEntity);

	public void add(Account entity);

	public void update(Account entity);

	public void delete(Account entity);



}