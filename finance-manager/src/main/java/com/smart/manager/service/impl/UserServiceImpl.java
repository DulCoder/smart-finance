package com.smart.manager.service.impl;

import com.smart.common.bean.SysUser;
import com.smart.manager.dao.UserMapper;
import com.smart.manager.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by zhengxianyou on 2018/5/23 0023
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserMapper userMapper;

    @Override
    public List<SysUser> queryAll() {
        return null;
    }

    @Override
    public SysUser query4Login(SysUser user) {
        return userMapper.query4Login(user);
    }

    @Override
    public List<SysUser> pageQueryData(Map<String, Object> map) {
        return userMapper.pageQueryData(map);
    }

    @Override
    public int pageQueryCount(Map<String, Object> map) {
        return userMapper.pageQueryCount(map);
    }

    @Override
    public int insertUser(SysUser user) {
        return userMapper.insertUser(user);
    }

    @Override
    public SysUser queryById(Long id) {
        return userMapper.queryById(id);
    }

    @Override
    public int countUserByAcc(String userAcc) {
        return userMapper.countUserByAcc(userAcc);
    }

    @Override
    public int updateUser(SysUser user) {
        return userMapper.updateUser(user);
    }

    @Override
    public int deleteUserById(Long id) {
        return userMapper.deleteUserById(id);
    }

    @Override
    public int deleteUsers(Map<String, Object> map) {
        return userMapper.deleteUsers(map);
    }

    @Override
    public int deleteUserRoles(Map<String, Object> map) {
        return userMapper.deleteUserRoles(map);
    }

    @Override
    public int insertUserRoles(Map<String, Object> map) {
        return userMapper.insertUserRoles(map);
    }

    @Override
    public List<Long> queryRoleIdsByUserId(Long id) {
        return userMapper.queryRoleIdsByUserId(id);
    }

}
