package com.smart.manager.service.impl;

import com.smart.common.bean.SysPermission;
import com.smart.manager.dao.PermissionMapper;
import com.smart.manager.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhengxianyou on 2018/5/29 0029
 */
@Service
public class PermissionServiceImpl implements PermissionService {
    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    public List<SysPermission> queryAll() {
        return permissionMapper.queryAll();
    }

    @Override
    public int countByName(String name) {
        return permissionMapper.countByName(name);
    }

    @Override
    public int insert(SysPermission permission) {
        return permissionMapper.insert(permission);
    }

    @Override
    public SysPermission queryById(Long id) {
        return permissionMapper.queryById(id);
    }

    @Override
    public int update(SysPermission permission) {
        return permissionMapper.update(permission);
    }

    @Override
    public int delete(Long id) {
        return permissionMapper.delete(id);
    }
}
