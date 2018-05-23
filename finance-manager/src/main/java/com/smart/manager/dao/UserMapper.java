package com.smart.manager.dao;

import com.smart.common.bean.SysUser;
import org.apache.ibatis.annotations.Select;

/**
 * Created by zhengxianyou on 2018/5/23 0023
 */
public interface UserMapper {
    @Select("select * from sys_user where user_acc = #{userAcc} and password = #{password}")
    SysUser query4Login(SysUser user);
}
