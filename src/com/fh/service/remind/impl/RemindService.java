package com.fh.service.remind.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.remind.RemindManager;
import com.fh.util.PageData;

@Service("remindService")
public class RemindService implements RemindManager {
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> list(Page pd) throws Exception {
		return (List<PageData>) dao.findForList("RemindMapper.getremind", pd);
	}

	@Override
	public void remove(PageData pd) throws Exception {
		 dao.update("RemindMapper.closeRemind", pd);
	}

}
