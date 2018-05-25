package com.smart.manager.controller;

import com.smart.manager.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
    public String index(@RequestParam(required = false,defaultValue = "1") Integer pageno, @RequestParam(required = false,defaultValue = "10")Integer pagesize, Model model){

        return "user/index";
    }


}
