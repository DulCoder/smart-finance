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

}
