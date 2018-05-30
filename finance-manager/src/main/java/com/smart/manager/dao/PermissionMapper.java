package com.smart.manager.dao;

import com.smart.common.bean.SysPermission;
import com.smart.common.bean.SysUser;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * Created by zhengxianyou on 2018/5/29 0029
 */
public interface PermissionMapper {

    @Select("SELECT * FROM sys_permission")
    List<SysPermission> queryAll();

    @Select("SELECT COUNT(*) FROM sys_permission WHERE per_name = #{name}")
    int countByName(String name);

    int insert(SysPermission permission);

    @Select("SELECT per_name,url,icon,available FROM sys_permission WHERE id = #{id}")
    SysPermission queryById(Long id);

    int update(SysPermission permission);

    @Delete("DELETE FROM sys_permission WHERE id = #{id}")
    int delete(Long id);

    @Select("SELECT sys_permission_id FROM sys_role_permission WHERE sys_role_id = #{roleId}")
    List<Long> queryPermissionIdsByRoleId(Long roleId);

    List<SysPermission> queryPermissionsByUser(SysUser user);
}
