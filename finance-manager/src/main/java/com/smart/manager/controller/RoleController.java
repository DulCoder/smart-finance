package com.smart.manager.controller;

import com.smart.common.bean.Page;
import com.smart.common.bean.ResponseModel;
import com.smart.common.bean.SysRole;
import com.smart.manager.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhengxianyou on 2018/5/28 0028
 */
@Controller
@RequestMapping("/role/*")
@Scope("prototype")
public class RoleController {
    @Autowired
    private RoleService roleService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "role/role";
    }

    @ResponseBody
    @RequestMapping(value = "/pageQuery", method = RequestMethod.POST)
    public ResponseModel pageQuery(String queryText, Integer pageNo, Integer pageSize) {
        // 分页查询
        Map<String, Object> map = new HashMap<>();
        map.put("start", (pageNo - 1) * pageSize);
        map.put("size", pageSize);
        map.put("queryText", queryText);
        List<SysRole> roles = roleService.pageQueryData(map);
        // 总的数据条数
        int count = roleService.pageQueryCount(map);
        // 最大页码（总页码）
        int total = 0;
        if (count % pageSize == 0) {
            total = count / pageSize;
        } else {
            total = count / pageSize + 1;
        }

        Page<SysRole> rolePage = new Page<>();
        rolePage.setDatas(roles);
        rolePage.setPageNo(pageNo);
        rolePage.setPageSize(pageSize);
        rolePage.setTotal(total);

        return ResponseModel.success().add("data", rolePage);
    }

    @ResponseBody
    @RequestMapping(value = "/checkRole", method = RequestMethod.POST)
    public ResponseModel checkRole(String roleName) {
        int count = roleService.countRoleByName(roleName);
        if (count > 0) {
            return ResponseModel.failed().add("va_msg", "该角色已存在！");
        }

        return ResponseModel.success();
    }

    @ResponseBody
    @RequestMapping(value = "/role", method = RequestMethod.POST)
    public ResponseModel insert(SysRole role) {
        int success = roleService.insertRole(role);
        if (success > 0) {
            return ResponseModel.success().add("msg", "新增角色成功！");
        }

        return ResponseModel.failed().add("msg", "新增角色失败！");
    }

    @ResponseBody
    @RequestMapping(value = "/role", method = RequestMethod.GET)
    public ResponseModel getRoleById(Long id) {
        SysRole role = roleService.queryById(id);

        return ResponseModel.success().add("role", role);
    }

    @ResponseBody
    @RequestMapping(value = "/role", method = RequestMethod.PUT)
    public ResponseModel updateRole(SysRole role) {
        int success = roleService.updateRole(role);
        if (success > 0) {
            return ResponseModel.success().add("msg", "修改角色成功！");
        }

        return ResponseModel.failed().add("msg", "修改角色失败！");
    }

    @ResponseBody
    @RequestMapping(value = "/role", method = RequestMethod.DELETE)
    public ResponseModel deleteRole(Long id) {
        int count = roleService.countUserByRoleId(id);
        if (count > 0) {
            return ResponseModel.failed().add("msg", "删除失败，该角色已被分配给用户！");
        }

        int success = roleService.deleteRole(id);
        if (success > 0) {
            return ResponseModel.success().add("msg", "删除角色成功！");
        }

        return ResponseModel.failed().add("msg", "删除失败，未知错误！");
    }

    @ResponseBody
    @RequestMapping(value = "/roles", method = RequestMethod.DELETE)
    public ResponseModel deleteRoles(Long[] roleId) {
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("roleIds", roleId);
            int success = roleService.deleteRoles(map);
            if (success > 0) {
                return ResponseModel.success().add("msg", "删除成功！");
            } else {
                return ResponseModel.failed().add("msg", "删除失败！");
            }
        } catch (Exception e) {
            return ResponseModel.failed().add("msg", "删除失败！" + e);
        }
    }


    @ResponseBody
    @RequestMapping(value = "/saveAssign", method = RequestMethod.POST)
    public ResponseModel saveAssign(Long roleId, Long[] permissionIds) {
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("roleId", roleId);
            paramMap.put("permissionIds", permissionIds);
            int success = roleService.insertRolePermission(paramMap);
            if (success > 0) {
                return ResponseModel.success().add("msg", "权限分配成功");
            } else {
                return ResponseModel.failed().add("msg", "权限分配失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseModel.failed().add("msg", "权限分配失败，" + e);
        }
    }

}
