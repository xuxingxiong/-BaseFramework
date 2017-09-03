package com.common.util.timer;

import javax.annotation.Resource;

import com.common.util.TimerResetUtil;
import com.fh.dao.DaoSupport;
import com.fh.util.PageData;

public class RemindTimerUtil {
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	public void UpdateRemind() throws Exception {
		System.out.println("删除过期提醒：");
		System.out.println(dao.delete("RemindMapper.delete", new PageData()));
		System.out.println("添加生日提醒：");
		System.out.println(dao.save("RemindMapper.addbirthday", new PageData()));
		System.out.println("添加护肤提醒：");
		System.out.println(dao.save("RemindMapper.addcareday", new PageData()));
		System.out.println("添加来电提醒：");
		System.out.println(dao.save("RemindMapper.addorder", new PageData()));
		TimerResetUtil.reset();
	}
}
