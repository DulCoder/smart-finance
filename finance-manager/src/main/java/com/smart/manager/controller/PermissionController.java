package com.smart.manager.controller;

import com.smart.common.bean.ResponseModel;
import com.smart.common.bean.SysPermission;
import com.smart.manager.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhengxianyou on 2018/5/29 0029
 */
@Controller
@RequestMapping("/permission/*")
@Scope("prototype")
public class PermissionController {
    @Autowired
    private PermissionService permissionService;


    @RequestMapping(value = "/index")
    public String index(){
        return "permission/permission";
    }

    @ResponseBody
    @RequestMapping(value = "/loadData", method = RequestMethod.GET)
    public Object loadData(){
        List<SysPermission> permissions = new ArrayList<>();

        List<SysPermission> ps = permissionService.queryAll();
        Map<Long, SysPermission> permissionMap = new HashMap<>();
        for (SysPermission p : ps) {
            permissionMap.put(p.getId(), p);
        }
        for ( SysPermission p : ps ) {
            if ( p.getParentId() == 0 ) {
                permissions.add(p);
            } else {
                SysPermission parent = permissionMap.get(p.getParentId());
                parent.getChildren().add(p);
            }
        }

        return permissions;
    }

    @ResponseBody
    @RequestMapping(value = "/loadAssignedData", method = RequestMethod.POST)
    public Object loadAssignedData(Long roleId){
        List<SysPermission> permissions = new ArrayList<>();
        List<SysPermission> ps = permissionService.queryAll();

        // 获取当前角色已经分配的许可信息
        List<Long> permissionIds = permissionService.queryPermissionIdsByRoleId(roleId);

        Map<Long, SysPermission> permissionMap = new HashMap<>();
        for (SysPermission p : ps) {
            if ( permissionIds.contains(p.getId()) ) {
                p.setChecked(true);
            } else {
                p.setChecked(false);
            }
            permissionMap.put(p.getId(), p);
        }
        for ( SysPermission p : ps ) {
            SysPermission child = p;
            if ( child.getParentId() == 0 ) {
                permissions.add(p);
            } else {
                SysPermission parent = permissionMap.get(child.getParentId());
                parent.getChildren().add(child);
            }
        }

        return permissions;
    }

    @ResponseBody
    @RequestMapping(value = "/checkPermission", method = RequestMethod.POST)
    public ResponseModel checkPermission(String name){
        int count  = permissionService.countByName(name);
        if (count == 0){
            return ResponseModel.success();
        }
        return ResponseModel.failed().add("va_msg","该许可已存在！");
    }

    @ResponseBody
    @RequestMapping(value = "/permission", method = RequestMethod.POST)
    public ResponseModel insert(SysPermission permission){
        try {
            int success = permissionService.insert(permission);
            if (success > 0){
                return ResponseModel.success().add("msg","新增许可成功！");
            }else {
                return ResponseModel.failed().add("msg","新增许可失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseModel.failed().add("msg","新增许可失败,"+e);
        }
    }

    @ResponseBody
    @RequestMapping(value = "/permission", method = RequestMethod.GET)
    public ResponseModel getPermissionById(Long id){
        SysPermission permission = permissionService.queryById(id);

        return ResponseModel.success().add("permission",permission);
    }

    @ResponseBody
    @RequestMapping(value = "/permission", method = RequestMethod.PUT)
    public ResponseModel update(SysPermission permission){
        int success = permissionService.update(permission);
        if (success > 0){
            return ResponseModel.success().add("msg","修改许可信息成功");
        }

        return ResponseModel.failed().add("msg","修改许可信息失败");
    }

    @ResponseBody
    @RequestMapping(value = "/permission", method = RequestMethod.DELETE)
    public ResponseModel delete(Long id){
        int success = permissionService.delete(id);
        if (success > 0){
            return ResponseModel.success().add("msg","许可删除成功");
        }

        return ResponseModel.failed().add("msg","删除许可失败");
    }

}
