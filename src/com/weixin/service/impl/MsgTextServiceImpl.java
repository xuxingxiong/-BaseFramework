package com.weixin.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.weixin.interceptor.MsgType;
import com.weixin.entity.MsgBase;
import com.weixin.entity.MsgText;
import com.weixin.mapper.MsgBaseDao;
import com.weixin.mapper.MsgTextDao;
import com.weixin.service.MsgTextService;


@Service
public class MsgTextServiceImpl implements MsgTextService{

	@Autowired
	private MsgTextDao entityDao;
	
	@Autowired
	private MsgBaseDao baseDao;

	public MsgText getById(String id){
		return entityDao.getById(id);
	}

	public List<MsgText> listForPage(MsgText searchEntity){
		return entityDao.listForPage(searchEntity);
	}

	public void add(MsgText entity){
		
		MsgBase base = new MsgBase();
		base.setInputcode(entity.getInputcode());
		base.setCreatetime(new Date());
		base.setMsgtype(MsgType.Text.toString());
		baseDao.add(base);
		
		entity.setBaseId(base.getId());
		entityDao.add(entity);
	}

	public void update(MsgText entity){
		MsgBase base = baseDao.getById(entity.getBaseId().toString());
		base.setInputcode(entity.getInputcode());
		baseDao.updateInputcode(base);
		entityDao.update(entity);
	}

	public void delete(MsgText entity){
		MsgBase base = new MsgBase();
		base.setId(entity.getBaseId());
		entityDao.delete(entity);
		baseDao.delete(entity);
	}

	//根据用户发送的文本消息，随机获取一条文本消息
	public MsgText getRandomMsg(String inputCode){
		return entityDao.getRandomMsg(inputCode);
	}
	public MsgText getRandomMsg2(){
		return entityDao.getRandomMsg2();
	}
}

