package com.koi.service;

import com.koi.exception.CustomException;
import com.koi.pojo.UUser;
import com.koi.utils.ResultInfo;
import com.koi.vo.ResuleVo;

public interface UUserService {
	/**
	 * 注册用户
	 * @param user
	 * @return
	 * @throws CustomException 
	 */
	ResultInfo register(UUser user) throws Exception;
	/**
	 * 资料修改
	 * @param user
	 * @return
	 * @throws CustomException
	 */
	ResultInfo updateInfo(UUser user) throws Exception;
	/**
	 * 密码修改
	 * @param user
	 * @param oldPassword
	 * @return
	 */
	ResultInfo updatePassword(UUser user,String oldPassword) throws Exception;
	/**
	 * 查询用户列表
	 * @param info
	 * @param page
	 * @param limit
	 * @return
	 */
	ResuleVo selectUserList(String info,Integer page,Integer limit);
	/**
	 * 修改用户登录状态
	 * @param uId
	 * @param status
	 * @return
	 * @throws CustomException
	 */
	ResultInfo updateUserStatuByUserId(UUser user) throws CustomException;
	/**
	 * 批量删除用户
	 * @param userIds
	 * @return
	 * @throws CustomException
	 */
	ResultInfo deleteUserByUserId(Integer[] userIds)throws CustomException;
	
}

