package com.smart.common.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by zhengxianyou on 2018/5/28 0028
 */
public class Page<T> implements Serializable {

    private List<T> datas;
    private Integer pageNo;
    private Integer pageSize;
    private Integer total;

    public List<T> getDatas() {
        return datas;
    }

    public void setDatas(List<T> datas) {
        this.datas = datas;
    }

    public Integer getPageNo() {
        return pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }
}
