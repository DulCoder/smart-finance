package com.smart.manager.dao;

import com.smart.common.bean.SysUser;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * Created by zhengxianyou on 2018/5/23 0023
 */
public interface UserMapper {
    @Select("SELECT * FROM SYS_USER WHERE user_acc = #{userAcc} AND password = #{password}")
    SysUser query4Login(SysUser user);

    List<SysUser> pageQueryData(Map<String, Object> map);

    int pageQueryCount(Map<String, Object> map);

    @Select("SELECT COUNT(1) FROM sys_user WHERE user_acc = #{userAcc}")
    int countUserByAcc(String userAcc);

    int insertUser(SysUser user);

    @Select("SELECT username,locked FROM sys_user WHERE id = #{id}")
    SysUser queryById(Long id);

    int updateUser(SysUser user);

    @Delete("DELETE FROM sys_user WHERE id = #{id}")
    int deleteUserById(Long id);

    int deleteUsers(Map<String, Object> map);
}
