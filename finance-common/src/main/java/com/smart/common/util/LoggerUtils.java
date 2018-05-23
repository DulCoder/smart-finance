package com.smart.common.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by zhengxianyou on 2018/5/23 0023
 */
public class LoggerUtils {

    public static Logger logger(Class<? extends Object> clazz){
        return LoggerFactory.getLogger(clazz);
    }

}
