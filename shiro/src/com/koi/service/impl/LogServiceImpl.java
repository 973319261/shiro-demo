package com.koi.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koi.mapper.LogMapper;
import com.koi.pojo.Log;
import com.koi.service.LogService;
@Service
public class LogServiceImpl implements LogService{
	@Autowired 
	private LogMapper logMapper;
	@Override
	public int addLog(Log log) {
		return logMapper.addLog(log);
	}

}
