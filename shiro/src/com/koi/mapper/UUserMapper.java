package com.koi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.koi.pojo.UUser;
import com.koi.pojo.UUserExample;

public interface UUserMapper {
    int countByExample(UUserExample example) throws Exception;

    int deleteByExample(UUserExample example)throws Exception;

    int deleteByPrimaryKey(Long id)throws Exception;

    int insert(UUser record)throws Exception;

    int insertSelective(UUser record)throws Exception;

    List<UUser> selectByExample(UUserExample example);

    UUser selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") UUser record, @Param("example") UUserExample example)throws Exception;

    int updateByExample(@Param("record") UUser record, @Param("example") UUserExample example)throws Exception;

    int updateByPrimaryKeySelective(UUser record)throws Exception;

    int updateByPrimaryKey(UUser record)throws Exception;
    
    int deleteUserByUserId(Integer[] userIds) throws Exception;
}