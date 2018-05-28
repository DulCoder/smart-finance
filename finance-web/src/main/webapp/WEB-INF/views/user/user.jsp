<%--
  Created by IntelliJ IDEA.
  User: zhengxianyou
  Date: 2018/5/25 0025
  Time: 17:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <title>用户管理</title>
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
                                <div class="input-group-addon">账号</div>
                                <input id="queryText" class="form-control has-success" type="text"
                                       placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="queryBtn" type="button" class="btn btn-warning"><i
                                class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <button type="button" class="btn btn-danger" onclick="deleteUsers()"
                            style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="addUser()"><i
                            class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <form id="userForm">
                            <input type="hidden" name="_method" value="DELETE">
                            <table class="table  table-bordered">
                                <thead>
                                <tr>
                                    <th width="60">#</th>
                                    <th width="40"><input type="checkbox" id="allSelBox"></th>
                                    <th>账号</th>
                                    <th>名称</th>
                                    <th>锁定状态</th>
                                    <th width="120">操作</th>
                                </tr>
                                </thead>

                                <tbody id="userData">

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

<!-- 用户添加的模态框 -->
<div class="modal fade" id="userAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">用户添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">账号</label>
                        <div class="col-sm-10">
                            <input type="text" name="userAcc" onchange="accChange('#userAcc_add_input')"
                                   class="form-control" id="userAcc_add_input" placeholder="userAcc">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-10">
                            <input type="text" name="username" id="username_add_input" class="form-control" placeholder="username">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">锁定状态</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="locked" value="1" checked="checked"> 锁定
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="locked" value="0"> 不锁定
                            </label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="user_save_btn" onClick="saveUser()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 用户修改的模态框 -->
<div class="modal fade" id="userUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">用户编辑</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="username" id="username_update_input" maxlength="35" class="form-control"
                                   placeholder="userName" autocomplete="off">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">锁定状态</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="locked" value="1" checked="checked"> 锁定
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="locked" value="0"> 不锁定
                            </label>
                        </div>
                    </div>
                    <input type="hidden" name="id" id="userID">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="user_update_btn" onClick="saveUpdate()">更新</button>
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

        //按钮点击事件
        $("#queryBtn").click(function () {  //条件查询按钮
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

            $("#userData :checkbox").each(function () {
                this.checked = flg;
            });
        });

        $(document).on("click",".check_item",function(){ //复选框点击事件
            //判断当前选择中的元素是否等于总数
            var flag = $(".check_item:checked").length==$(".check_item").length;
            $("#allSelBox").prop("checked",flag);
        });
    });

    var pageTotal = 1;
    /**
     * 分页查询
     */
    function pageQuery(pageNo) {
        var loadingIndex = null;

        var jsonData = {"pageNo": pageNo, "pageSize": 10};
        if (hasLike == true) {
            jsonData.queryText = $("#queryText").val();
        }

        $.ajax({
            type: "POST",
            url: "${APP_PATH}/user/pageQuery",
            data: jsonData,
            dataType: 'json',
            beforeSend: function () {
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.code == '200') {
                    // 局部刷新页面数据
                    var tableContent = "";
                    var pageContent = "";

                    var userPage = result.extend.data;
                    var users = userPage.datas;

                    $.each(users, function (i, user) {
                        tableContent += '<tr>';
                        tableContent += '  <td>' + (i + 1) + '</td>';
                        tableContent += '  <td><input type="checkbox" name="id" class="check_item" value="' + user.id + '"></td>';
                        tableContent += '  <td>' + user.userAcc + '</td>';
                        tableContent += '  <td>' + user.username + '</td>';
                        tableContent += '  <td>' + (user.locked == 0 ? "<span style='color: green'>未锁定</span>" : "<span style='color: red'>已锁定</span>") + '</td>';
                        tableContent += '  <td>';
                        tableContent += '      <button type="button" onclick="goAssignPage(' + user.id + ')" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
                        tableContent += '      <button type="button" onclick="updateUser(' + user.id + ')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        tableContent += '	  <button type="button" onclick="deleteUser(' + user.id + ', \'' + user.userAcc + '\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                        tableContent += '  </td>';
                        tableContent += '</tr>';
                    });

                    if (pageNo > 1) {
                        pageContent += '<li><a href="#" onclick="pageQuery(' + (pageNo - 1) + ')">上一页</a></li>';
                    }

                    pageTotal = userPage.total;
                    for (var i = 1; i <= pageTotal; i++) {
                        if (i == pageNo) {
                            pageContent += '<li class="active"><a  href="#">' + i + '</a></li>';
                        } else {
                            pageContent += '<li ><a href="#" onclick="pageQuery(' + i + ')">' + i + '</a></li>';
                        }
                    }

                    if (pageNo < pageTotal) {
                        pageContent += '<li><a href="#" onclick="pageQuery(' + (pageNo + 1) + ')">下一页</a></li>';
                    }

                    $("#userData").html(tableContent);
                    $(".pagination").html(pageContent);
                } else {
                    layer.msg("用户信息分页查询失败", {time: 2000, icon: 5, shift: 6}, function () {});
                }
            }
        });
    }

    /**
     * 添加用户
     */
    function addUser() {
        // 清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#userAddModal form");

        // 弹出模态框
        $("#userAddModal").modal({
            backdrop: "static"
        });
    }

    /**
     * 保存新用户
     */
    function saveUser() {
        if (validate_add_form()==0) {
            return false;
        }

        $.ajax({
            url: "${APP_PATH}/user/user",
            type: "POST",
            data: $("#userAddModal form").serialize(),
            success: function (result) {
                if (result.code == 200) {
                    // 保存成功；
                    // 1、关闭模态框
                    $("#userAddModal").modal('hide');

                    // 2、来到最后一页，显示刚才保存的数据
                    pageQuery(pageTotal);
                    layer.msg("修改用户信息成功", {time:2000, icon:6, shift:0}, function(){});
                } else {
                    // 有哪个字段的错误信息就显示哪个字段的；
                    if (undefined != result.extend.errorFields.userAcc) {
                        // 显示账号的错误信息
                        show_validate_msg("#userAcc_add_input", "error",
                            result.extend.errorFields.userAcc);
                    }
                }
            },error:function () {
                // 1、关闭模态框
                $("#userAddModal").modal('hide');
            }
        });
    }

    /**
     * 删除用户
     */
    function deleteUser(id, userAcc) {
        layer.confirm("删除用户信息【" +id+"=="+ userAcc + "】, 是否继续", {icon: 3, title: '提示'}, function (cindex) {

            // 删除用户信息
            $.ajax({
                url: "${APP_PATH}/user/user",
                type: "POST",
                data:{_method:"DELETE","id":id},
                success: function (result) {
                    if (result.code=='200') {
                        pageQuery(1);
                        layer.msg("删除用户成功", {time:2000, icon:6, shift:0}, function(){});
                    } else {
                        layer.msg("用户信息删除失败", {time: 2000, icon: 5, shift: 6}, function () {});
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
    function deleteUsers() {
        var boxes = $("#userData :checkbox");
        if (boxes.length == 0) {
            layer.msg("请选择需要删除的用户信息", {time: 2000, icon: 5, shift: 6}, function () {});
        } else {
            layer.confirm("删除选择的用户信息, 是否继续", {icon: 3, title: '提示'}, function (cindex) {
                // 删除选择的用户信息
                $.ajax({
                    type: "POST",
                    url: "${APP_PATH}/user/deletes",
                    data: $("#userForm").serialize(),
                    success: function (result) {
                        if (result.code == '200') {
                            pageQuery(1);
                        } else {
                            layer.msg("用户信息删除失败", {time: 2000, icon: 5, shift: 6}, function () {
                            });
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
     * 修改用户信息
     */
    function updateUser(id) {
        $("#userID").val(id)
        // 清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#userUpdateModal form");

        $.ajax({
            url:"${APP_PATH}/user/user",
            type:"GET",
            data:{"id":id},
            success:function (result) {
                if (result.code=='200'){
                    $("#username_update_input").val(result.extend.user.username);
                    $("#userUpdateModal input[name=locked]").val([result.extend.user.locked]);
                }
            }
        });

        // 弹出模态框
        $("#userUpdateModal").modal({
            backdrop: "static"
        });
    }

    /**
     * 保存修改后的信息
     */
    function saveUpdate() {
        var username = $("#username_update_input").val();
        if (username.trim().length==0) {
            show_validate_msg("#username_update_input", "error",
                "用户名不能为空！");
            return false;
        } else {
            show_validate_msg("#username_update_input", "success", "");
        }

        $.ajax({
            url: "${APP_PATH}/user/user",
            type: "PUT",
            data: $("#userUpdateModal form").serialize(),
            success: function (result) {
                if (result.code == 200) {
                    // 1、关闭模态框
                    $("#userUpdateModal").modal('hide');
                    // 2、来到最后一页，显示刚才保存的数据
                    pageQuery(pageTotal);
                } else {
                    // 有哪个字段的错误信息就显示哪个字段的；
                    if (undefined != result.extend.errorFields.username) {
                        // 显示账号的错误信息
                        show_validate_msg("#username_update_input", "error",
                            result.extend.errorFields.username);
                    }
                }
            },error:function () {
                // 1、关闭模态框
                $("#userUpdateModal").modal('hide');
            }
        });
    }

    /**
     * 给用户信分配角色
     */
    function goAssignPage(id) {
        window.location.href = "${APP_PATH}/user/assign?id=" + id;
    }

    /**
     * 校验输入框信息
     */
    function validate_add_form() {
        // 1、拿到要校验的数据，使用正则表达式
        var userAcc = $("#userAcc_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(userAcc)) {
            show_validate_msg("#userAcc_add_input", "error",
                "用户名可以是2-5位中文或者3-16位英文和数字的组合");
            return 0;
        } else {
            show_validate_msg("#userAcc_add_input", "success", "");
        }

        var username = $("#username_add_input").val();
        if (username.trim().length==0) {
            show_validate_msg("#username_add_input", "error",
                "用户名不能为空");
            return 0;
        } else {
            show_validate_msg("#username_add_input", "success", "");
        }
    }

    /**
     * 输入账号过程中的变化事件
     *
     * @returns
     */
    function accChange(id) {
        // 发送ajax请求校验用户名是否可用
        var userAcc = $(id).val();
        $.ajax({
            url: "${APP_PATH}/user/checkUser",
            data: "userAcc=" + userAcc,
            type: "GET",
            success: function (result) {
                if (result.code == 200) {
                    show_validate_msg(id, "success", "用户名可用");
                    $("#user_save_btn").removeAttr("disabled")
                } else {
                    show_validate_msg(id, "error", result.extend.va_msg);
                    $("#user_save_btn").attr("disabled", "disabled");
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
