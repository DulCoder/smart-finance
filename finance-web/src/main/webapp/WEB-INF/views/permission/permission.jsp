<%--
  Created by IntelliJ IDEA.
  User: zhengxianyou
  Date: 2018/5/29 0029
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                type:'GET',
                enable: true,
                url:"${APP_PATH}/permission/loadData",
                autoParam:["id", "name=n", "level=lv"]
            },
            view: {
                selectedMulti: false,
                addDiyDom: function(treeId, treeNode){
                    var icoObj = $("#" + treeNode.tId + "_ico");
                    if ( treeNode.icon ) {
                        icoObj.removeClass("button ico_docu ico_open").addClass("glyphicon "+treeNode.icon).css("background","");
                    }
                },
                addHoverDom: function(treeId, treeNode){
                    var aObj = $("#" + treeNode.tId + "_a");
                    aObj.attr("href", "javascript:;");
                    if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                    var s = '<span id="btnGroup'+treeNode.tId+'">';
                    if ( treeNode.level == 0 ) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addNode('+treeNode.id+')" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                    } else if ( treeNode.level == 1 ) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="editNode('+treeNode.id+')" href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                        if (treeNode.children.length == 0) {
                            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteNode('+treeNode.id+')" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                        }
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addNode('+treeNode.id+')" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                    } else if ( treeNode.level == 2 ) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="editNode('+treeNode.id+')" href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteNode('+treeNode.id+')" href="#">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                    }

                    s += '</span>';
                    aObj.after(s);
                },
                removeHoverDom: function(treeId, treeNode){
                    $("#btnGroup"+treeNode.tId).remove();
                }
            }
        };
        // 异步获取树形结构数据
        $.fn.zTree.init($("#permissionTree"), setting);
    });

    function addNode(id) {
        window.location.href = "${APP_PATH}/permission/add?id="+id;
    }

    function editNode(id) {
        window.location.href = "${APP_PATH}/permission/edit?id="+id;
    }

    function deleteNode(id) {
        layer.confirm("删除许可信息, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
            // 删除选择的用户信息
            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/permission/delete",
                data : {
                    id : id
                },
                success : function(result) {
                    if ( result.success ) {
                        // 刷新数据
                        var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
                        treeObj.reAsyncChildNodes(null, "refresh");
                    } else {
                        layer.msg("许可信息删除失败", {time:2000, icon:5, shift:6}, function(){

                        });
                    }
                }
            });

            layer.close(cindex);
        }, function(cindex){
            layer.close(cindex);
        });
    }
</script>
</body>
</html>
