package com.smart.web.system;

import com.smart.common.bean.SysUser;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by zhengxianyou on 2018/5/31 0031.
 */
public class LoginInterceptor implements HandlerInterceptor {
    /**
     * 在控制器执行之前完成业务逻辑操作
     * 方法的返回值决定逻辑是否继续执行， true，表示继续执行， false, 表示不再继续执行。
     */
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        // 判断当前用户是否已经登录
        HttpSession session = httpServletRequest.getSession();
        SysUser loginUser = (SysUser) session.getAttribute("loginUser");

        if (loginUser == null) {
            String path = session.getServletContext().getContextPath();
            String uri = httpServletRequest.getRequestURI();
            if ((path+"/main").equals(uri)){
                httpServletResponse.sendRedirect(path + "/login");
                return false;
            }
            httpServletResponse.sendRedirect(path + "/loginError");
            return false;
        } else {
            return true;
        }
    }

    /**
     * 在控制器执行完毕之后执行的逻辑操作
     */
    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    /**
     * 在完成视图渲染之后，执行此方法。
     */
    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
