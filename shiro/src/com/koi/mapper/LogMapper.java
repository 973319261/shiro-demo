package com.koi.mapper;

import com.koi.pojo.Log;

public interface LogMapper {
	/**
	 * 添加日志记录
	 * @param log
	 * @return
	 */
	int addLog(Log log);
}
