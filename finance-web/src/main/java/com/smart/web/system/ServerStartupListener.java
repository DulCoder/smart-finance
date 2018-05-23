package com.smart.web.system;

import com.smart.common.util.LoggerUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Created by zhengxianyou on 2018/5/23 0023
 */
public class ServerStartupListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // 将web应用名称（路径）保存到application范围中
        ServletContext application = sce.getServletContext();
        String path = application.getContextPath();
        application.setAttribute("APP_PATH", path);
        LoggerUtils.logger(getClass()).debug("应用上下文路径："+path);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
