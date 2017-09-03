package com.weixin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.weixin.entity.MsgBase;
import com.weixin.mapper.MsgBaseDao;
import com.weixin.service.MsgBaseService;


@Service
public class MsgBaseServiceImpl implements MsgBaseService{

	@Autowired
	private MsgBaseDao entityDao;

	public MsgBase getById(String id){
		return entityDao.getById(id);
	}

	public List<MsgBase> listForPage(MsgBase searchEntity){
		return entityDao.listForPage(searchEntity);
	}

	public void add(MsgBase entity){
		entityDao.add(entity);
	}

	public void update(MsgBase entity){
		entityDao.update(entity);
	}

	public void delete(MsgBase entity){
		entityDao.delete(entity);
	}



}