package com.smart.manager.service;

import com.smart.common.bean.SysRole;

import java.util.List;
import java.util.Map; /**
 * Created by zhengxianyou on 2018/5/28 0028
 */
public interface RoleService {

    List<SysRole> pageQueryData(Map<String, Object> map);

    int pageQueryCount(Map<String, Object> map);

    int insertRole(SysRole role);

    int countRoleByName(String roleName);

    SysRole queryById(Long id);

    int updateRole(SysRole role);

    int countUserByRoleId(Long id);

    int deleteRole(Long id);

    int deleteRoles(Map<String, Object> map);
}
