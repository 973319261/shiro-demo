package com.koi.service;

import java.util.List;

import com.koi.pojo.URole;
import com.koi.utils.ResultInfo;
import com.koi.vo.ResuleVo;

public interface UserRoleService {
	/**
	 * 根据userId查询角色
	 * @param userId
	 * @return List<URole>
	 */
	List<URole> selectRoleByUserId(Long userId);
	/**
	 * 通过角色类型或者角色名称来查询
	 * @param userId
	 * @param info
	 * @return
	 */
	List<URole> selectRoleByInfo(String info);
	/**
	 * 新增角色列表
	 * @param uUserRole
	 * @return
	 */
	ResultInfo addRoleList(URole uRole) throws Exception;
    /**
     * 修改角色列表
     * @param uUserRole
     * @return
     */
	ResultInfo updateRoleList(URole uRole) throws Exception;
	/**
	 * 删除角色列表
	 * @param id
	 * @return
	 * @throws Exception
	 */
	ResultInfo deleteRoleListById(int[] ids) throws Exception;
	/**
	 * 批量添加角色列表
	 * @param list
	 * @return
	 * @throws Exception
	 */
	int addBatchRoleList(List<URole> list) throws Exception ;
	/**
	 * 查询角色分配列表
	 * @param info
	 * @return
	 */
	ResuleVo selectRoleAllocation(String info,Integer page,Integer limit);
	/**
	 * 通过userId查询角色分配列表
	 * @param uId
	 * @return
	 */
	List<Integer> selectRoleIdByUserId(Integer uId);
	/**
	 * 角色分配保存
	 * @param uId
	 * @param roleIds
	 * @return
	 * @throws Exception
	 */
	ResultInfo saveRoleAllocation(Integer uId,Integer[] roleIds) throws Exception;
	/**
	 * 角色分配清空
	 * @param roleIds
	 * @return
	 * @throws Exception
	 */
	ResultInfo deleteRoleAllocationByUserRId(int[] userIds) throws Exception;
}

