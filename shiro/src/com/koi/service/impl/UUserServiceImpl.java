package com.koi.service.impl;

import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.koi.annotation.LogAnnotation;
import com.koi.exception.CustomException;
import com.koi.mapper.UUserMapper;
import com.koi.pojo.UUser;
import com.koi.pojo.UUserExample;
import com.koi.pojo.UUserExample.Criteria;
import com.koi.service.UUserService;
import com.koi.utils.ResultInfo;
import com.koi.vo.ResuleVo;

/*@Transactional(isolation = Isolation.REPEATABLE_READ,
propagation = Propagation.REQUIRED, rollbackFor = Exception.class)*/
@Service
public class UUserServiceImpl implements UUserService {
	@Autowired
	private UUserMapper userMapper;

	/*@Transactional(propagation = Propagation.NOT_SUPPORTED)*/
	@Override
	public ResultInfo register(UUser user) throws Exception {
		UUserExample example = new UUserExample();
		Criteria criteria = example.createCriteria();
		criteria.andNicknameEqualTo(user.getNickname());
		List<UUser> listUser = userMapper.selectByExample(example);
		// 如果存在就返回
		if (listUser.size() > 0) {
			return ResultInfo.setResultInfo(false, "该用户已存在");
		}
		// 加密密码
		// 生成盐（需要存入数据库中）
		String salt = new SecureRandomNumberGenerator().nextBytes().toHex();
		// 将原始密码加盐（上面生成的盐），并且用md5算法加密三次，将最后结果存入数据库中
		String password = new Md5Hash(user.getPswd(), salt, 3).toString();
		user.setPswd(password);
		user.setSalt(salt);
		// 设置创建时间和激活状态
		user.setCreateTime(new Date());
		user.setStatus(1L);
		try {
			userMapper.insert(user);
		} catch (Exception e) {
			throw new CustomException("注册失败");
		}
		return ResultInfo.setResultInfo(true, "注册成功");
	}

	@LogAnnotation(operateType="资料修改")
	@Override
	public ResultInfo updateInfo(UUser user) throws CustomException {
		try {
			UUserExample example = new UUserExample();
			Criteria criteria = example.createCriteria();
			criteria.andNicknameEqualTo(user.getNickname());
			criteria.andIdNotEqualTo(user.getId());
			List<UUser> listUser = userMapper.selectByExample(example);
			// 如果存在就返回
			if (listUser.size() > 0) {
				return ResultInfo.setResultInfo(false, "该用户已存在");
			}
			// 修改资料信息
			userMapper.updateByPrimaryKeySelective(user);
		} catch (Exception e) {
			// 自定义异常
			throw new CustomException("修改失败");
		}
		return ResultInfo.setResultInfo(true, "资料修改成功，是否重新登录...");
	}
	@LogAnnotation(operateType="修改密码")
	@Override
	public ResultInfo updatePassword(UUser user, String oldPassword)
			throws Exception {
		try {
			// 判断旧密码是否跟登录密码一致
			// 先获取用户的登陆身份通过shiro认证管理工具获得
			UUser uuser = (UUser) SecurityUtils.getSubject().getPrincipal();
			// MD5加密旧密码
			oldPassword = new SimpleHash("MD5", oldPassword, uuser.getSalt(), 3)
					.toHex();
			if (!uuser.getPswd().equals(oldPassword)) {
				return ResultInfo.setResultInfo(false, "旧密码错误");
			}
			// 生成盐（部分，需要存入数据库中）
			String salt = new SecureRandomNumberGenerator().nextBytes().toHex();
			// 将原始密码加盐（上面生成的盐），并且用md5算法加密三次，将最后结果存入数据库中
			String password = new Md5Hash(user.getPswd(), salt, 3).toString();
			user.setPswd(password);
			user.setSalt(salt);
			userMapper.updateByPrimaryKeySelective(user);
		} catch (Exception e) {
			throw new CustomException("修改失败");
		}
		return ResultInfo.setResultInfo(true, "密码修改成功，是否重新登录...");
	}

	@Override
	public ResuleVo selectUserList(String info, Integer page, Integer limit) {
		PageHelper.startPage(page, limit, true);
		UUserExample example = new UUserExample();
		if (info != "") {
			Criteria criteria = example.createCriteria();
			criteria.andNicknameLike('%' + info + '%');
		}
		List<UUser> list = userMapper.selectByExample(example);
		PageInfo<UUser> pageInfo = new PageInfo<UUser>(list);
		long count = pageInfo.getTotal();
		return ResuleVo.toLayui(count, list);
	}
	@LogAnnotation(operateType="删除用户信息")
	@Override
	public ResultInfo deleteUserByUserId(Integer[] userIds)
			throws CustomException {
		try {
			userMapper.deleteUserByUserId(userIds);
		} catch (Exception e) {
			throw new CustomException("删除失败");
		}
		return ResultInfo.setResultInfo(true, "删除成功");
	}
	@LogAnnotation(operateType="修改用户登录状态")
	@Override
	public ResultInfo updateUserStatuByUserId(UUser user)
			throws CustomException {
		try {
			userMapper.updateByPrimaryKeySelective(user);
		} catch (Exception e) {
			throw new CustomException("登录状态修改失败");
		}
		return ResultInfo.setResultInfo(true, "修改成功");
	}
}
