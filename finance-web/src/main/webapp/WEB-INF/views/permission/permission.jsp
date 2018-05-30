<%--
  Created by IntelliJ IDEA.
  User: zhengxianyou
  Date: 2018/5/29 0029
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="UTF-8" %>
<html>
<head>
    <title>许可管理</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${APP_PATH}/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/js/ztree/zTreeStyle.css">
</head>
<body>
<div>
    <div class="panel-heading">
        <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
    </div>
    <div class="panel-body">
        <ul id="permissionTree" class="ztree"></ul>
    </div>
</div>

<!-- 新增许可的模态框 -->
<div class="modal fade" id="permissionAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">许可添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <input type="hidden" name="parentId" value="">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-10">
                            <input name="perName" onchange="nameChange('#name_add_input','#permission_save_btn')"
                                   autocomplete="off"
                                   class="form-control" id="name_add_input" placeholder="permission Name">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">URL</label>
                        <div class="col-sm-10">
                            <input name="url" id="url_add_input" class="form-control" placeholder="URL"
                                   autocomplete="off"
                                   maxlength="60" onkeyup="this.value=this.value.replace(/[\u0391-\uFFE5]/gi,'')">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">图标</label>
                        <div class="col-sm-10">
                            <input name="icon" id="icon_add_input" class="form-control" placeholder="icon"
                                   maxlength="40" onkeyup="this.value=this.value.replace(/[\u0391-\uFFE5]/gi,'')">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">类型</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="style" value="1" checked> 菜单
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="style" value="2"> 按钮
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">状态</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="available" value="1" checked> 可用
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
                <button type="button" class="btn btn-primary" id="permission_save_btn" onClick="savePermission()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 编辑许可的模态框 -->
<div class="modal fade" id="permissionEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">许可修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <input type="hidden" name="id" value="">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-10">
                            <input name="perName" onchange="nameChange('#name_edit_input','#permission_edit_btn')"
                                   autocomplete="off"
                                   class="form-control" id="name_edit_input" placeholder="permission Name">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">URL</label>
                        <div class="col-sm-10">
                            <input name="url" id="url_edit_input" class="form-control" placeholder="URL"
                                   autocomplete="off"
                                   maxlength="60" onkeyup="this.value=this.value.replace(/[\u0391-\uFFE5]/gi,'')">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">图标</label>
                        <div class="col-sm-10">
                            <input name="icon" id="icon_edit_input" class="form-control" placeholder="icon"
                                   maxlength="40" onkeyup="this.value=this.value.replace(/[\u0391-\uFFE5]/gi,'')">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">状态</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="available" value="1" checked> 可用
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
                <button type="button" class="btn btn-primary" id="permission_edit_btn" onClick="saveUpdate()">修改</button>
            </div>
        </div>
    </div>
</div>

<script src="${APP_PATH}/js/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/js/other/docs.min.js"></script>
<script src="${APP_PATH}/js/layer/layer.js"></script>
<script src="${APP_PATH}/js/ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">
    $(function () {
        var setting = {
            data: {
                simpleData: {
                    enable: true
                },
                key: {
                    name: "perName",
                    pId: "parentId"
                }
            },
            async: {
                type: 'GET',
                enable: true,
                url: "${APP_PATH}/permission/loadData",
                autoParam: ["id", "name=n", "level=lv"]
            },
            view: {
                selectedMulti: false,
                addDiyDom: function (treeId, treeNode) {
                    var icoObj = $("#" + treeNode.tId + "_ico");
                    if (treeNode.icon) {
                        icoObj.removeClass("button ico_docu ico_open").addClass("glyphicon " + treeNode.icon).css("background", "");
                    }
                },
                addHoverDom: function (treeId, treeNode) {
                    var aObj = $("#" + treeNode.tId + "_a");
                    aObj.attr("href", "javascript:;");
                    if (treeNode.editNameFlag || $("#btnGroup" + treeNode.tId).length > 0) return;
                    var s = '<span id="btnGroup' + treeNode.tId + '">';
                    if (treeNode.level == 0) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addNode(' + treeNode.id + ')" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                    } else if (treeNode.level == 1) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="editNode(' + treeNode.id + ')" href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                        if (treeNode.children.length == 0) {
                            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteNode(' + treeNode.id + ')" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                        }
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addNode(' + treeNode.id + ')" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                    } else if (treeNode.level == 2) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="editNode(' + treeNode.id + ')" href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteNode(' + treeNode.id + ')" href="#">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                    }

                    s += '</span>';
                    aObj.after(s);
                },
                removeHoverDom: function (treeId, treeNode) {
                    $("#btnGroup" + treeNode.tId).remove();
                }
            }
        };
        // 异步获取树形结构数据
        $.fn.zTree.init($("#permissionTree"), setting);
    });


    /**
     * 打开新增模态框
     */
    function addNode(id) {
        $("#permissionAddModal input[name=parentId]").val(id);
        // 清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#permissionAddModal form");

        // 弹出模态框
        $("#permissionAddModal").modal({
            backdrop: "static"
        });
    }

    /**
     * 执行新增操作
     */
    function savePermission() {
        if (validate_form('#name_add_input', '#url_add_input') == 0) {
            return false;
        }

        $.ajax({
            url: "${APP_PATH}/permission/permission",
            type: "POST",
            data: $("#permissionAddModal form").serialize(),
            success: function (result) {
                if (result.code == 200) {
                    // 1、关闭模态框
                    $("#permissionAddModal").modal('hide');
                    layer.msg(result.extend.msg, {time: 1500, icon: 6, shift: 0}, function () {
                        refreshTree();
                    });
                } else {
                    // 有哪个字段的错误信息就显示哪个字段的；
                    if (undefined != result.extend.errorFields.perName) {
                        // 显示名称的错误信息
                        show_validate_msg("#name_add_input", "error",
                            result.extend.errorFields.perName);
                    }
                }
            }, error: function () {
                // 1、关闭模态框
                $("#permissionAddModal").modal('hide');
            }
        });
    }

    /**
     * 编辑许可内容
     */
    function editNode(id) {
        $("#permissionEditModal input[name=id]").val(id);
        // 清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#permissionEditModal form");

        $.ajax({
            url: "${APP_PATH}/permission/permission",
            type: "GET",
            data: {"id": id},
            success: function (result) {
                if (result.code == '200') {
                    $("#name_edit_input").val(result.extend.permission.perName);
                    $("#url_edit_input").val(result.extend.permission.url);
                    $("#icon_edit_input").val(result.extend.permission.icon);
                    $("#permissionEditModal input[name=available]").val([result.extend.permission.available]);
                }
            }
        });

        // 弹出模态框
        $("#permissionEditModal").modal({
            backdrop: "static"
        });
    }

    /**
     * 保存编辑后的内容、更新
     */
    function saveUpdate() {
        if (validate_form('#name_edit_input', '#url_edit_input') == 0) {
            return false;
        }

        $.ajax({
            url: "${APP_PATH}/permission/permission",
            type: "PUT",
            data: $("#permissionEditModal form").serialize(),
            success: function (result) {
                if (result.code == 200) {
                    // 1、关闭模态框
                    $("#permissionEditModal").modal('hide');
                    layer.msg(result.extend.msg, {time: 1500, icon: 6, shift: 0}, function () {
                        refreshTree();
                    });
                } else {
                    // 有哪个字段的错误信息就显示哪个字段的；
                    if (undefined != result.extend.errorFields.perName) {
                        // 显示名称的错误信息
                        show_validate_msg("#name_edit_input", "error",
                            result.extend.errorFields.perName);
                    }
                }
            }, error: function () {
                // 1、关闭模态框
                $("#permissionEditModal").modal('hide');
            }
        });
    }

    function deleteNode(id) {
        layer.confirm("删除许可信息, 是否继续", {icon: 3, title: '提示'}, function (cindex) {
            // 删除选择的用户信息
            $.ajax({
                type: "POST",
                url: "${APP_PATH}/permission/permission",
                data: {_method:'DELETE','id': id},
                success: function (result) {
                    if (result.code = '200') {
                        // 刷新数据
                        refreshTree();
                    } else {
                        layer.msg("许可信息删除失败", {time: 2000, icon: 5, shift: 6}, function () {});
                    }
                }
            });

            layer.close(cindex);
        }, function (cindex) {
            layer.close(cindex);
        });
    }

    /**
     * 校验输入框信息
     */
    function validate_form(nameId, urlId) {
        // 1、拿到要校验的数据，使用正则表达式
        var name = $(nameId).val();
        if (name.trim().length == 0) {
            show_validate_msg(nameId, "error",
                "许可名称不能为空");
            return 0;
        } else {
            show_validate_msg(nameId, "success", "");
        }

        var url = $(urlId).val();
        if (url.trim().length == 0) {
            show_validate_msg(urlId, "error",
                "URL不能为空");
            return 0;
        } else {
            show_validate_msg(urlId, "success", "");
        }
    }

    /**
     * 输入账号过程中的变化事件
     *
     * @returns
     */
    function nameChange(inputId, btnId) {
        // 发送ajax请求校验角色名是否可用
        var name = $(inputId).val();
        $.ajax({
            url: "${APP_PATH}/permission/checkPermission",
            data: {"name": name},
            type: "POST",
            success: function (result) {
                if (result.code == 200) {
                    show_validate_msg(inputId, "success", "角色名可用");
                    $(btnId).removeAttr("disabled")
                } else {
                    show_validate_msg(inputId, "error", result.extend.va_msg);
                    $(btnId).attr("disabled", "disabled");
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

    /**
     * 刷新树
     */
    function refreshTree() {
        var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
        treeObj.reAsyncChildNodes(null, "refresh");
    }
</script>
</body>
</html>
