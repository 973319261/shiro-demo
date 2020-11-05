package com.koi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.koi.pojo.URole;
import com.koi.pojo.UUserRole;

public interface UserRoleMapper {
	/**
	 * 根据userId查询角色
	 * @param userId
	 * @return List<String>
	 */
	List<URole> selectRoleByUserId(Long userId);
	/**
	 * 通过角色类型或者角色名称来查询
	 * @param info
	 * @return
	 */
	List<URole> selectRoleByInfo(@Param("info") String info);
	/**
	 * 新增角色列表
	 * @param uUserRole
	 * @return
	 * @throws Exception
	 */
	int addRoleList(URole uRole) throws Exception;
	/**
	 * 修改角色列表
	 * @param uUserRole
	 * @return
	 * @throws Exception
	 */
	int updateRoleList(URole uRole) throws Exception;
	/**
	 * 删除角色列表
	 * @param id
	 * @return
	 * @throws Exception
	 */
	int deleteRoleListById(int[] ids) throws Exception;
	/**
	 * 批量添加角色列表
	 * @param list
	 * @return
	 * @throws Exception
	 */
	int addBatchRoleList(List<URole> list) throws Exception;
	/**
	 * 查询角色分配列表
	 * @param info
	 * @return
	 */
	List<UUserRole> selectRoleAllocation(@Param("info") String info);
	/**
	 * 通过userId查询角色分配列表
	 * @param uId
	 * @return
	 */
	List<Integer> selectRoleIdByUserId(Integer uId);
	/**
	 * 角色分配添加
	 * @param uId
	 * @param roleIds
	 * @return
	 * @throws Exception
	 */
	int addRoleAllocation(@Param("uId")Integer uId,@Param("roleIds")List<Integer> roleIds) throws Exception;
	/**
	 * 角色分配清空
	 * @param roleIds
	 * @return
	 * @throws Exception
	 */
	int deleteRoleAllocation(@Param("uId")Integer uId,@Param("roleIds")List<Integer> roleIds) throws Exception;
	/**
	 * 通过userId清空角色分配
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	int deleteRoleAllocationByUseRId(int[] userIds) throws Exception;
}

