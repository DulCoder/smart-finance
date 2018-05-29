package com.smart.manager.dao;

import com.smart.common.bean.SysPermission;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * Created by zhengxianyou on 2018/5/29 0029
 */
public interface PermissionMapper {

    @Select("SELECT * FROM sys_permission")
    List<SysPermission> queryAll();
}
