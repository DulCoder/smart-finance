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
        return null;
    }

    @Override
    public int pageQueryCount(Map<String, Object> map) {
        return 0;
    }

    @Override
    public int insertUser(SysUser user) {
        return 0;
    }

    @Override
    public SysUser queryById(Integer id) {
        return null;
    }

    @Override
    public int countUserByAcc(String userAcc) {
        return 0;
    }

    @Override
    public int updateUser(SysUser user) {
        return 0;
    }

    @Override
    public int deleteUserById(Integer id) {
        return 0;
    }

    @Override
    public int deleteUsers(Map<String, Object> map) {
        return 0;
    }

    @Override
    public int deleteUserRoles(Map<String, Object> map) {
        return 0;
    }

    @Override
    public int insertUserRoles(Map<String, Object> map) {
        return 0;
    }

    @Override
    public List<Integer> queryRoleidsByUserid(Integer id) {
        return null;
    }
}
