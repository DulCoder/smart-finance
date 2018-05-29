package com.smart.manager.dao;

import com.smart.common.bean.SysRole;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map; /**
 * Created by zhengxianyou on 2018/5/28 0028
 */
public interface RoleMapper {

    List<SysRole> pageQueryData(Map<String, Object> map);

    int pageQueryCount(Map<String, Object> map);

    int insertRole(SysRole role);

    @Select("SELECT COUNT(*) FROM sys_role WHERE role_name = #{roleName}")
    int countRoleByName(String roleName);

    @Select("SELECT remark,available FROM sys_role WHERE ID = #{id}")
    SysRole queryById(Long id);

    int updateRole(SysRole role);

    @Select("SELECT COUNT(*) FROM sys_user_role WHERE sys_role_id = #{id}")
    int countUserByRoleId(Long id);

    @Delete("DELETE FROM sys_role WHERE id = #{id}")
    int deleteRole(Long id);

    int deleteRoles(Map<String, Object> map);
}
