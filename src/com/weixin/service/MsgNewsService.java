package com.weixin.service;

import java.util.List;

import com.common.page.Pagination;
import com.weixin.entity.MsgNews;
import com.weixin.entity.MsgNewsVO;


public interface MsgNewsService {

	public MsgNews getById(String id);

	public List<MsgNews> listForPage(MsgNews searchEntity);
	
	public List<MsgNewsVO> pageWebNewsList(MsgNews searchEntity,Pagination<MsgNews> page);

	public void add(MsgNews entity);

	public void update(MsgNews entity);

	public void delete(MsgNews entity);

	//根据用户发送的文本消息，随机获取 num 条文本消息
	public List<MsgNews> getRandomMsg(String inputcode,Integer num);

}