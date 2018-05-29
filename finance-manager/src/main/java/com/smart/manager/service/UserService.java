package com.smart.manager.service;

import com.smart.common.bean.SysUser;

import java.util.List;
import java.util.Map;

/**
 * Created by zhengxianyou on 2018/5/23 0023
 */
public interface UserService {

    List<SysUser> queryAll();

    SysUser query4Login(SysUser user);

    List<SysUser> pageQueryData(Map<String, Object> map);

    int pageQueryCount(Map<String, Object> map);

    int insertUser(SysUser user);

    SysUser queryById(Long id);

    int countUserByAcc(String userAcc);

    int updateUser(SysUser user);

    int deleteUserById(Long id);

    int deleteUsers(Map<String, Object> map);

    int deleteUserRoles(Map<String, Object> map);

    int insertUserRoles(Map<String, Object> map);

    List<Long> queryRoleIdsByUserId(Long id);
}
