package com.koi.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.koi.pojo.UPermission;
import com.koi.utils.ResultInfo;
import com.koi.vo.ResuleVo;

public interface UserPermissonService {
	/**
	 * 根据userId查询权限
	 * 
	 * @param userId
	 * @return List<UPermission>
	 */
	List<UPermission> selectPermissionByUserId(Long userId);

	/**
	 * 查询权限列表
	 * 
	 * @param info
	 * @param page
	 * @param limit
	 * @return
	 */
	List<UPermission> selectPermissonList(String info);

	/**
	 * 新增权限列表
	 * 
	 * @param uPermission
	 * @return
	 */
	ResultInfo addPermissonList(UPermission uPermission) throws Exception;

	/**
	 * 通过PermissonId删除权限列表
	 * 
	 * @param ids
	 * @return
	 */
	ResultInfo deletePermissonListById(@Param("ids") int[] ids) throws Exception;

	/**
	 * 查询权限分配列表
	 * 
	 * @param info
	 * @return
	 */
	ResuleVo selectPerAllocation(String info, Integer page,
			Integer limit);

	/**
	 * 权限分配保存
	 * 
	 * @param rId
	 * @param perIds
	 */
	ResultInfo savePerAllocation(Integer rId, Integer[] perIds) throws Exception;
}
