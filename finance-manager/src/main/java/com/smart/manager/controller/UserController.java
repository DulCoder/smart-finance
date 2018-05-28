package com.smart.manager.controller;

import com.smart.common.bean.Page;
import com.smart.common.bean.ResponseModel;
import com.smart.common.bean.SysUser;
import com.smart.common.util.MD5Utils;
import com.smart.manager.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhengxianyou on 2018/5/25 0025
 */
@Controller
@RequestMapping("/user/*")
@Scope("prototype")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public String index(){
        return "user/index";
    }

    @ResponseBody
    @RequestMapping(value = "/pageQuery",method = RequestMethod.GET)
    public ResponseModel pageQuery(String queryText, Integer pageNo, Integer pageSize){
        // 分页查询
        Map<String, Object> map = new HashMap<>();
        map.put("start", (pageNo-1)*pageSize);
        map.put("size", pageSize);
        map.put("queryText",queryText);
        List<SysUser> users = userService.pageQueryData(map);
        // 总的数据条数
        int count = userService.pageQueryCount(map);
        // 最大页码（总页码）
        int total = 0;
        if ( count % pageSize == 0 ) {
            total = count / pageSize;
        } else {
            total = count / pageSize + 1;
        }

        Page<SysUser> userPage = new Page<>();
        userPage.setDatas(users);
        userPage.setPageNo(pageNo);
        userPage.setPageSize(pageSize);
        userPage.setTotal(total);

        return ResponseModel.success().add("data",userPage);
    }

    @ResponseBody
    @RequestMapping(value = "/checkUser",method = RequestMethod.GET)
    public ResponseModel checkUser(String userAcc){
        int count = userService.countUserByAcc(userAcc);
        if (count==0){
            return ResponseModel.success();
        }
        return ResponseModel.failed().add("va_msg","该用户已存在！");
    }

    @ResponseBody
    @RequestMapping(value = "/user",method = RequestMethod.POST)
    public ResponseModel insert(SysUser user){
        user.setCreateTime(new Date());
        user.setPassword(MD5Utils.getMD5(user.getUserAcc()+"#123456"));
        int success = userService.insertUser(user);
        if (success > 0){
            return ResponseModel.success();
        }

        return ResponseModel.failed();
    }

    @ResponseBody
    @RequestMapping(value = "/user",method = RequestMethod.GET)
    public ResponseModel getUserById(Long id){
        SysUser user = userService.queryById(id);
        return ResponseModel.success().add("user",user);
    }

    @ResponseBody
    @RequestMapping(value = "/user", method = RequestMethod.PUT)
    public ResponseModel updateUser(SysUser user){
        int success = userService.updateUser(user);
        if (success > 0){
            return ResponseModel.success();
        }

        return ResponseModel.failed();
    }

    @ResponseBody
    @RequestMapping(value = "/user", method = RequestMethod.DELETE)
    public ResponseModel deleteUser(Long id){
        int success = userService.deleteUserById(id);
        if (success > 0){
            return ResponseModel.success();
        }

        return ResponseModel.failed();
    }

    @ResponseBody
    @RequestMapping(value = "/deletes", method = RequestMethod.DELETE)
    public ResponseModel deleteUsers(Long[] id){
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("userIds", id);
            int success = userService.deleteUsers(map);
            if (success > 0){
                return ResponseModel.success();
            }else {
                return ResponseModel.failed();
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return ResponseModel.failed();
        }
    }

}
