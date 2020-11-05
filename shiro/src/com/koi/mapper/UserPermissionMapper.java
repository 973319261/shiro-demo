package com.koi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.koi.pojo.UPermission;
import com.koi.pojo.URolePermission;

public interface UserPermissionMapper {
	/**
	 * 根据userId查询权限
	 * @param userId
	 * @return List<String>
	 */
	List<UPermission> selectPermissionByUserId(Long userId);
	/**
	 * 查询权限列表
	 * @param info
	 * @param page
	 * @param limit
	 * @return
	 */
	List<UPermission> selectPermissonList(@Param("info")String info);
	/**
	 * 新增权限列表
	 * @param uPermission
	 * @return
	 */
	int addPermissonList(UPermission uPermission) throws Exception;
	/**
	 * 通过PermissonId删除权限列表
	 * @param ids
	 * @return
	 */
	int deletePermissonListById(int[] ids) throws Exception;
	/**
	 * 查询权限分配列表
	 * @param info
	 * @return
	 */
	List<URolePermission> selectPerAllocation(@Param("info") String info);
	/**
	 *通过RoleId查询权限分配
	 * @param rId
	 * @return
	 */
	List<Integer> selectPermissionByRoleId(Integer rId);
	/**
	 * 勾选权限分配
	 * @param rId
	 * @param PerIds
	 * @return
	 * @throws Exception
	 */
	int addPerAllocation(@Param("rId")Integer rId,@Param("perIds")List<Integer> perIds) throws Exception;
	/**
	 * 去掉权限分配
	 * @param rId
	 * @param PerIds
	 * @return
	 * @throws Exception
	 */
	int deletePerAllocation(@Param("rId")Integer rId,@Param("perIds")List<Integer> perIds) throws Exception;
	
}