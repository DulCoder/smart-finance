package com.smart.manager.service.impl;

import com.smart.common.bean.SysRole;
import com.smart.manager.dao.RoleMapper;
import com.smart.manager.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by zhengxianyou on 2018/5/28 0028
 */
@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    RoleMapper roleMapper;

    @Override
    public List<SysRole> pageQueryData(Map<String, Object> map) {
        return roleMapper.pageQueryData(map);
    }

    @Override
    public int pageQueryCount(Map<String, Object> map) {
        return roleMapper.pageQueryCount(map);
    }

    @Override
    public int insertRole(SysRole role) {
        return roleMapper.insertRole(role);
    }

    @Override
    public int countRoleByName(String roleName) {
        return roleMapper.countRoleByName(roleName);
    }

    @Override
    public SysRole queryById(Long id) {
        return roleMapper.queryById(id);
    }

    @Override
    public int updateRole(SysRole role) {
        return roleMapper.updateRole(role);
    }

    @Override
    public int countUserByRoleId(Long id) {
        return roleMapper.countUserByRoleId(id);
    }

    @Override
    public int deleteRole(Long id) {
        return roleMapper.deleteRole(id);
    }

    @Override
    public int deleteRoles(Map<String, Object> map) {
        return roleMapper.deleteRoles(map);
    }

    @Override
    public List<SysRole> queryAll() {
        return roleMapper.queryAll();
    }
}
