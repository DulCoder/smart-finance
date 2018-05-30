package com.smart.manager.service;

import com.smart.common.bean.SysPermission;

import java.util.List;

/**
 * Created by zhengxianyou on 2018/5/29 0029
 */
public interface PermissionService {

    List<SysPermission> queryAll();

    int countByName(String name);

    int insert(SysPermission permission);

    SysPermission queryById(Long id);

    int update(SysPermission permission);

    int delete(Long id);
}
