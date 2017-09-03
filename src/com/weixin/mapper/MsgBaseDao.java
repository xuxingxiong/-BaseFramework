package com.weixin.mapper;

import java.util.List;

import com.weixin.entity.MsgBase;
import com.weixin.entity.MsgNews;
import com.weixin.entity.MsgText;


public interface MsgBaseDao {

	public MsgBase getById(String id);

	public List<MsgBase> listForPage(MsgBase searchEntity);

	public List<MsgNews> listMsgNewsByBaseId(String[] ids);
	
	public MsgText getMsgTextByBaseId(String id);
	
	public MsgText getMsgTextBySubscribe();
	
	public MsgText getMsgTextByInputCode(String inputcode);
	
	public void add(MsgBase entity);

	public void update(MsgBase entity);
	
	public void updateInputcode(MsgBase entity);

	public void delete(MsgBase entity);

}