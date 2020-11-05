package com.koi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.hutool.core.collection.CollUtil;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.koi.annotation.LogAnnotation;
import com.koi.exception.CustomException;
import com.koi.mapper.UserRoleMapper;
import com.koi.pojo.URole;
import com.koi.pojo.UUserRole;
import com.koi.service.UserRoleService;
import com.koi.utils.ResultInfo;
import com.koi.vo.ResuleVo;
@Service
public class UserRoleServiceImpl implements UserRoleService {
	@Autowired UserRoleMapper userRoleMapper;
	@Override
	public List<URole> selectRoleByUserId(Long userId) {
		return userRoleMapper.selectRoleByUserId(userId);
	}
	@Override
	public List<URole> selectRoleByInfo(String info) {
		 return userRoleMapper.selectRoleByInfo(info);
	}
	@LogAnnotation(operateType="添加角色")
	@Override
	public ResultInfo addRoleList(URole uRole) throws CustomException {
		try {
			userRoleMapper.addRoleList(uRole);
		} catch (Exception e) {
			throw new CustomException("新增失败");
		}
	return ResultInfo.setResultInfo(true, "新增成功");
	}
	@LogAnnotation(operateType="修改角色")
	@Override
	public ResultInfo updateRoleList(URole uRole) throws CustomException {
		try {
			 userRoleMapper.updateRoleList(uRole);
		} catch (Exception e) {
			throw new CustomException("修改失败");
		}
	return ResultInfo.setResultInfo(true, "修改成功");
	}
	@LogAnnotation(operateType="删除角色")
	@Override
	public ResultInfo deleteRoleListById(int[] ids) throws CustomException {
		try {
			userRoleMapper.deleteRoleListById(ids);// 批量或者单个删除
		} catch (Exception e) {
			throw new CustomException("删除失败");
		}
		return ResultInfo.setResultInfo(true, "成功删除" + ids.length + "条数据");
	}
	@LogAnnotation(operateType="导入角色")
	@Override
	public int addBatchRoleList(List<URole> list) throws Exception {
		return userRoleMapper.addBatchRoleList(list);
	}
	@Override
	public ResuleVo selectRoleAllocation(String info,Integer page,Integer limit) {
		PageHelper.startPage(page, limit, true);
		List<UUserRole> list = userRoleMapper.selectRoleAllocation(info);
		PageInfo<UUserRole> pageInfo=new PageInfo<UUserRole>(list);
		long count=pageInfo.getTotal();
		return ResuleVo.toLayui(count, list);
	}
	@LogAnnotation(operateType="角色分配保存")
	@Override
	public ResultInfo saveRoleAllocation(Integer uId, Integer[] roleIds) throws CustomException {
		try {
			List<Integer> oneRIds = CollUtil.toList(roleIds);
			List<Integer> towRIds = CollUtil.toList(roleIds);
			List<Integer> oldRIds = userRoleMapper.selectRoleIdByUserId(uId);//查询原来的角色分配列表
			oneRIds.removeAll(oldRIds);//oneRIds返回的是要新增的集合
			oldRIds.removeAll(towRIds);//oldRIds返回的是要删除的集合
			if(oneRIds.size()>0){
				userRoleMapper.addRoleAllocation(uId, oneRIds);
			}
			if(oldRIds.size()>0){
				userRoleMapper.deleteRoleAllocation(uId, oldRIds);
			}
		} catch (Exception e) {
			throw new CustomException("保存失败");
		}
		return ResultInfo.setResultInfo(true, "保存成功");
	}
	@LogAnnotation(operateType="清空角色")
	@Override
	public ResultInfo deleteRoleAllocationByUserRId(int[] userIds) throws CustomException {
		try {
			if (userIds != null) {
				userRoleMapper.deleteRoleAllocationByUseRId(userIds);
			} else {
				return ResultInfo.setResultInfo(false, "选择的数据没有可清空的角色");
			}
		} catch (Exception e) {
			throw new CustomException("清空清空失败");
		}
		return ResultInfo.setResultInfo(true, "清空角色成功");
	}
	@Override
	public List<Integer> selectRoleIdByUserId(Integer uId) {
		return userRoleMapper.selectRoleIdByUserId(uId);
	}
}
