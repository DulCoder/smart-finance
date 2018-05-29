<%--
  Created by IntelliJ IDEA.
  User: zhengxianyou
  Date: 2018/5/28 0028
  Time: 14:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>角色管理</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${APP_PATH}/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
</head>
<body>
<div>
    <div class="panel-heading">
        <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
    </div>
    <div class="panel-body">
        <form class="form-inline" role="form" style="float:left;">
            <div class="form-group has-feedback">
                <div class="input-group">
                    <div class="input-group-addon">名称</div>
                    <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
                </div>
            </div>
            <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询
            </button>
        </form>
        <button type="button" class="btn btn-danger" onclick="deleteRoles()" style="float:right;margin-left:10px;"><i
                class=" glyphicon glyphicon-remove"></i> 删除
        </button>
        <button type="button" class="btn btn-primary" style="float:right;" onclick="addRole()"><i
                class="glyphicon glyphicon-plus"></i> 新增
        </button>
        <br>
        <hr style="clear:both;">
        <div class="table-responsive">
            <form id="roleForm">
                <input type="hidden" name="_method" value="DELETE">
                <table class="table  table-bordered">
                    <thead>
                    <tr>
                        <th width="60">#</th>
                        <th width="40"><input type="checkbox" id="allSelBox"></th>
                        <th>名称</th>
                        <th>状态</th>
                        <th>备注</th>
                        <th width="120">操作</th>
                    </tr>
                    </thead>
                    <tbody id="roleData">

                    </tbody>
                    <tfoot>
                    <tr>
                        <td colspan="6" align="center">
                            <ul class="pagination">

                            </ul>
                        </td>
                    </tr>

                    </tfoot>
                </table>
            </form>
        </div>
    </div>
</div>

<!-- 角色添加的模态框 -->
<div class="modal fade" id="roleAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">新增角色</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-10">
                            <input type="text" name="roleName" onchange="roleChange('#role_add_input')"
                                   class="form-control" id="role_add_input" placeholder="roleName" autocomplete="off">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">备注</label>
                        <div class="col-sm-10">
                            <input type="text" name="remark" id="remark_add_input" class="form-control"
                                   placeholder="remark" autocomplete="off">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">状态</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="available" value="1" checked="checked"> 可用
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="available" value="0"> 禁用
                            </label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="role_save_btn" onClick="saveRole()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 角色修改的模态框 -->
<div class="modal fade" id="roleUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">修改角色</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">备注</label>
                        <div class="col-sm-10">
                            <input type="text" name="remark" id="remark_update_input" maxlength="35"
                                   class="form-control"
                                   placeholder="remark" autocomplete="off">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">状态</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="available" value="1" checked="checked"> 可用
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="available" value="0"> 禁用
                            </label>
                        </div>
                    </div>
                    <input type="hidden" name="id" id="roleID">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="role_update_btn" onClick="saveUpdate()">更新</button>
            </div>
        </div>
    </div>
</div>

<script src="${APP_PATH}/js/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/js/other/docs.min.js"></script>
<script src="${APP_PATH}/js/layer/layer.js"></script>
<script type="text/javascript">
    var hasLike = false;
    $(function () {
        pageQuery(1);

        $("#queryBtn").click(function () {
            var queryText = $("#queryText").val();
            if (queryText == "") {
                hasLike = false;
            } else {
                hasLike = true;
            }

            pageQuery(1);
        });

        $("#allSelBox").click(function () {   //全选框按钮点击事件
            var flg = this.checked;

            $("#roleData :checkbox").each(function () {
                this.checked = flg;
            });
        });

        $(document).on("click", ".check_item", function () { //复选框点击事件
            //判断当前选择中的元素是否等于总数
            var flag = $(".check_item:checked").length == $(".check_item").length;
            $("#allSelBox").prop("checked", flag);
        });
    });

    var pageTotal = 1;

    /**
     *  分页查询
     */
    function pageQuery(pageNo) {
        var loadingIndex = null;

        var jsonData = {"pageNo": pageNo, "pageSize": 10};
        if (hasLike == true) {
            jsonData.queryText = $("#queryText").val();
        }

        $.ajax({
            type: "POST",
            url: "${APP_PATH}/role/pageQuery",
            data: jsonData,
            beforeSend: function () {
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.code == '200') {
                    // 局部刷新页面数据
                    var tableContent = "";
                    var pageContent = "";

                    var rolePage = result.extend.data;
                    var roles = rolePage.datas;

                    $.each(roles, function (i, role) {
                        tableContent += '<tr>';
                        tableContent += '  <td>' + (i + 1) + '</td>';
                        tableContent += '  <td><input type="checkbox" class="check_item" name="roleId" value="' + role.id + '"></td>';
                        tableContent += '  <td>' + role.roleName + '</td>';
                        tableContent += '  <td>' + (role.available == 1 ? "<span style='color: #00CC00'>可用</span>" : "<span style='color: red'>禁用</span>") + '</td>';
                        tableContent += '  <td>' + role.remark + '</td>';
                        tableContent += '  <td>';
                        tableContent += '      <button type="button" onclick="goAssignPage(' + role.id + ')" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
                        tableContent += '      <button type="button" onclick="updateRole(' + role.id + ')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        tableContent += '	  <button type="button" onclick="deleteRole(' + role.id + ', \'' + role.roleName + '\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                        tableContent += '  </td>';
                        tableContent += '</tr>';
                    });

                    if (pageNo > 1) {
                        pageContent += '<li><a href="#" onclick="pageQuery(' + (pageNo - 1) + ')">上一页</a></li>';
                    }
                    pageTotal = rolePage.total;
                    for (var i = 1; i <= rolePage.total; i++) {
                        if (i == pageNo) {
                            pageContent += '<li class="active"><a  href="#">' + i + '</a></li>';
                        } else {
                            pageContent += '<li ><a href="#" onclick="pageQuery(' + i + ')">' + i + '</a></li>';
                        }
                    }

                    if (pageNo < rolePage.total) {
                        pageContent += '<li><a href="#" onclick="pageQuery(' + (pageNo + 1) + ')">下一页</a></li>';
                    }

                    $("#roleData").html(tableContent);
                    $(".pagination").html(pageContent);
                } else {
                    layer.msg("角色信息分页查询失败", {time: 2000, icon: 5, shift: 6}, function () {});
                }
            }
        });
    }

    /**
     * 新增角色
     */
    function addRole() {
        // 清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#roleAddModal form");

        // 弹出模态框
        $("#roleAddModal").modal({
            backdrop: "static"
        });
    }

    /**
     * 保存新角色
     */
    function saveRole() {
        if (validate_add_form() == 0) {
            return false;
        }

        $.ajax({
            url: "${APP_PATH}/role/role",
            type: "POST",
            data: $("#roleAddModal form").serialize(),
            success: function (result) {
                if (result.code == 200) {
                    // 1、关闭模态框
                    $("#roleAddModal").modal('hide');
                    // 2、来到最后一页，显示刚才保存的数据
                    pageQuery(pageTotal);
                    layer.msg(result.extend.msg, {time: 2000, icon: 6, shift: 0}, function () {
                    });
                } else {
                    // 有哪个字段的错误信息就显示哪个字段的；
                    if (undefined != result.extend.errorFields.roleName) {
                        // 显示账号的错误信息
                        show_validate_msg("#role_add_input", "error",
                            result.extend.errorFields.roleName);
                    }
                }
            }, error: function () {
                // 1、关闭模态框
                $("#roleAddModal").modal('hide');
            }
        });
    }

    /**
     * 删除角色
     */
    function deleteRole(id, roleName) {
        layer.confirm("删除角色信息【" + id + "】" + roleName + " , 是否继续", {icon: 3, title: '提示'}, function (cindex) {

            // 删除角色信息
            $.ajax({
                url: "${APP_PATH}/role/role",
                type: "POST",
                data: {_method: "DELETE", "id": id},
                success: function (result) {
                    if (result.code == '200') {
                        pageQuery(1);
                        layer.msg(result.extend.msg, {time: 2000, icon: 6, shift: 0}, function () {
                        });
                    } else {
                        layer.msg(result.extend.msg, {time: 2000, icon: 5, shift: 6}, function () {
                        });
                    }
                }
            });

            layer.close(cindex);
        }, function (cindex) {
            layer.close(cindex);
        });
    }

    /**
     *批量删除
     */
    function deleteRoles() {
        var boxes = $("#roleData :checkbox");
        if (boxes.length == 0) {
            layer.msg("请选择需要删除的角色信息", {time: 2000, icon: 5, shift: 6}, function () {
            });
        } else {
            layer.confirm("删除选择的角色信息, 是否继续", {icon: 3, title: '提示'}, function (cindex) {
                // 删除选择的角色信息
                $.ajax({
                    type: "POST",
                    url: "${APP_PATH}/role/roles",
                    data: $("#roleForm").serialize(),
                    success: function (result) {
                        if (result.code == '200') {
                            pageQuery(1);
                            layer.msg(result.extend.msg, {time:2000, icon:6, shift:0}, function(){});
                        } else {
                            layer.msg(result.extend.msg, {time: 2000, icon: 5, shift: 6}, function () {});
                        }
                    }
                });

                layer.close(cindex);
            }, function (cindex) {
                layer.close(cindex);
            });
        }
    }

    /**
     * 修改角色信息
     */
    function updateRole(id) {
        $("#roleID").val(id)
        // 清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#roleUpdateModal form");

        $.ajax({
            url: "${APP_PATH}/role/role",
            type: "GET",
            data: {"id": id},
            success: function (result) {
                if (result.code == '200') {
                    $("#remark_update_input").val(result.extend.role.remark);
                    $("#roleUpdateModal input[name=available]").val([result.extend.role.available]);
                }
            }
        });

        // 弹出模态框
        $("#roleUpdateModal").modal({
            backdrop: "static"
        });
    }

    /**
     * 保存修改后的信息
     */
    function saveUpdate() {
        var remark = $("#remark_update_input").val();
        if (remark.trim().length == 0) {
            show_validate_msg("#remark_update_input", "error", "角色名不能为空！");
            return false;
        } else {
            show_validate_msg("#remark_update_input", "success", "");
        }

        $.ajax({
            url: "${APP_PATH}/role/role",
            type: "PUT",
            data: $("#roleUpdateModal form").serialize(),
            success: function (result) {
                if (result.code == 200) {
                    // 1、关闭模态框
                    $("#roleUpdateModal").modal('hide');
                    // 2、来到最后一页，显示刚才保存的数据
                    pageQuery(pageTotal);
                    layer.msg(result.extend.msg, {time:2000, icon:6, shift:0}, function(){});
                } else {
                    // 有哪个字段的错误信息就显示哪个字段的；
                    if (undefined != result.extend.errorFields.remark) {
                        // 显示账号的错误信息
                        show_validate_msg("#remark_update_input", "error",
                            result.extend.errorFields.remark);
                    }
                }
            }, error: function () {
                // 1、关闭模态框
                $("#roleUpdateModal").modal('hide');
            }
        });
    }

    /**
     * 校验输入框信息
     */
    function validate_add_form() {
        // 1、拿到要校验的数据，使用正则表达式
        var role = $("#role_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)/;
        if (!regName.test(role)) {
            show_validate_msg("#role_add_input", "error",
                "角色名只能是3-16位英文和数字的组合");
            return 0;
        } else {
            show_validate_msg("#role_add_input", "success", "");
        }

        var remark = $("#remark_add_input").val();
        if (remark.trim().length == 0) {
            show_validate_msg("#remark_add_input", "error",
                "角色名不能为空");
            return 0;
        } else {
            show_validate_msg("#remark_add_input", "success", "");
        }
    }

    /**
     * 输入账号过程中的变化事件
     *
     * @returns
     */
    function roleChange(id) {
        // 发送ajax请求校验角色名是否可用
        var roleName = $(id).val();
        $.ajax({
            url: "${APP_PATH}/role/checkRole",
            data: "roleName=" + roleName,
            type: "GET",
            success: function (result) {
                if (result.code == 200) {
                    show_validate_msg(id, "success", "角色名可用");
                    $("#role_save_btn").removeAttr("disabled")
                } else {
                    show_validate_msg(id, "error", result.extend.va_msg);
                    $("#role_save_btn").attr("disabled", "disabled");
                }
            }
        });
    }

    /**
     * 显示校验结果的提示信息
     *
     * @param ele
     *            输入框id
     * @param status
     *            校验状态
     * @param msg
     *            提示信息
     * @returns
     */
    function show_validate_msg(ele, status, msg) {
        // 清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    /**
     * 清空表格数据
     *
     * @param item
     */
    function reset_form(item) {
        $(item)[0].reset();
        // 清空表单样式
        $(item).find("*").removeClass("has-error has-success");
        $(item).find(".help-block").text("");
    }
</script>
</body>
</html>
