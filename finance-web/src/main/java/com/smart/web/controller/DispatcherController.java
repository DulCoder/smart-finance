package com.smart.web.controller;

import com.smart.common.bean.ResponseModel;
import com.smart.common.bean.SysPermission;
import com.smart.common.bean.SysUser;
import com.smart.common.util.LoggerUtils;
import com.smart.common.util.vcode.Captcha;
import com.smart.common.util.vcode.SpecCaptcha;
import com.smart.manager.service.PermissionService;
import com.smart.manager.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * Created by zhengxianyou on 2018/5/23 0023
 */
@Controller
@RequestMapping("/*")
@Scope("prototype")
public class DispatcherController {
    @Autowired
    private UserService userService;
    @Autowired
    private PermissionService permissionService;

    /**
     * 获取验证码（jpg版本）
     * @param response
     */
    @RequestMapping(value="getVCode",method= RequestMethod.GET)
    public void getJPGCode(HttpServletResponse response, HttpServletRequest request){
        try {
            response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            response.setContentType("image/jpg");
            /**
             * jpg格式验证码
             * 宽，高，位数。
             */
            Captcha captcha = new SpecCaptcha(135,58,4);
            //输出
            captcha.out(response.getOutputStream());
            HttpSession session = request.getSession(true);
            //存入Session
            session.setAttribute("_code",captcha.text().toLowerCase());
            LoggerUtils.logger(getClass()).debug("验证码: "+captcha.text());
        } catch (Exception e) {
            LoggerUtils.logger(getClass()).error(String.format("获取验证码异常：%s",e.getMessage()),e);
        }
    }

    /**
     * 用户登录
     *
     * @param entity
     * @param vCode
     * @param request
     * @return
     */
    @RequestMapping(value = "/submitLogin", method = RequestMethod.POST)
    @ResponseBody
    public ResponseModel submitLogin(SysUser entity, String vCode, HttpServletRequest request) {
        HttpSession session = request.getSession(false);//true：如果存在session取出，没有则创建;false：没有返回null
        if (null != session) {
            if (!session.getAttribute("_code").toString().equalsIgnoreCase(vCode)) {
                return ResponseModel.failed().add("message", "验证码错误！");
            }
        } else {
            return ResponseModel.failed().add("message", "验证码未填写！");
        }

        SysUser user = userService.query4Login(entity);
        if (null != user) {
            if (entity.getPassword().equals(user.getPassword())) {
                session.setAttribute("loginUser",user);

                return ResponseModel.success().add("message", "登录成功！");
            } else {
                return ResponseModel.failed().add("message", "密码错误！");
            }
        }

        return ResponseModel.failed().add("message", "该用户不存在！");
    }

    @ResponseBody
    @RequestMapping(value = "/userPermissions",method = RequestMethod.GET)
    public Object getPermissions(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        SysUser user = (SysUser) session.getAttribute("loginUser");

        // 获取用户权限信息
        List<SysPermission> permissions = permissionService.queryPermissionsByUser(user);
        Map<Long, SysPermission> permissionMap = new HashMap<>();
        Set<String> uriSet = new HashSet<>();
        for ( SysPermission permission : permissions ) {
            permissionMap.put(permission.getId(), permission);
            if ( permission.getUrl() != null && !"".equals(permission.getUrl()) ) {
                uriSet.add(session.getServletContext().getContextPath() + "/"+ permission.getUrl());
            }
        }
        session.setAttribute("authUriSet", uriSet);

        return permissions;
    }

    /**
     * 注册新用户
     *
     * @param entity
     * @param vCode
     * @param request
     * @return
     */
    @RequestMapping(value = "/submitRegister", method = RequestMethod.POST)
    public ResponseModel submitRegister(SysUser entity, String vCode, HttpServletRequest request) {
        HttpSession session = request.getSession(false);//true：如果存在session取出，没有则创建;false：没有返回null
        if (null != session) {
            if (null != session) {
                if (session.getAttribute("_code").toString().equalsIgnoreCase(vCode)) {
                    if (userService.countUserByAcc(entity.getUsername()) == 0) {
                        entity.setCreateTime(new Date());
                        entity.setLocked("1");
                        if (userService.insertUser(entity) > 0) {
                            return ResponseModel.success().add("message", "注册成功");
                        }
                    } else {
                        return ResponseModel.failed().add("message", "该用户已存在！");
                    }
                } else {
                    return ResponseModel.failed().add("message", "验证码错误！");
                }
            }
        }
        return ResponseModel.failed().add("message", "非法访问！");
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "common/login";
    }

    @RequestMapping(value = "/error", method = RequestMethod.GET)
    public String error() {
        return "open/error";
    }

    @RequestMapping(value = "/loginError", method = RequestMethod.GET)
    public String loginError(){
        return "open/loginError";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:login";
    }

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main() {
        return "index/index";
    }

}
