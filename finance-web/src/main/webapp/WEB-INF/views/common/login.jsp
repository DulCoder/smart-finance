<%--
  Created by IntelliJ IDEA.
  User: zhengxianyou
  Date: 2018/5/22 0022
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <title>登录</title>

    <link rel="stylesheet" href="${APP_PATH}/js/bootstrap/3.3.7/css/bootstrap.css" />
    <link rel="stylesheet" href="${APP_PATH}/js/bootstrap/3.3.7/css/bootstrap-theme.css" />
    <style>
        .input-group span{
            width: 120px;
        }
        #frm input{
            height: 60px;
            width: 380px;
        }

        #frm div{
            text-align: center;
            margin-top: 8px;
        }

        .frm{
            position: absolute;
            text-align: center;
        }
        body{
            width: 100%;
            height: 100%;
            background:url("${APP_PATH}/images/login.jpg");
        }
    </style>

</head>
<body>

<form id="frm" class="frm" onsubmit="return false" action="##" method="post">
    <h1>Smart-Finance Login</h1>
    <div class="input-group input-group-lg">
        <span class="input-group-addon" >用户名：</span>
        <input id="username" maxlength="35" class="form-control" placeholder="Username" aria-describedby="sizing-addon1" autocomplete="off">
    </div>

    <div class="input-group input-group-lg">
        <span class="input-group-addon" id="sizing-addon2">密码：</span>
        <input type="password" maxlength="28" id="pswd" class="form-control" placeholder="password" aria-describedby="sizing-addon1" autocomplete="off">
    </div>

    <div class="input-group input-group-lg">
        <span class="input-group-addon" id="sizing-addon3">验证码：</span>
        <input onkeyup="value=value.replace(/[\W]/g,'')" maxlength="4"  id="vCode" class="form-control" style="width: 230px" placeholder="Verification code" aria-describedby="sizing-addon1" autocomplete="off">
        <img style="margin-left: 15px;border-radius: 3px" id="imgCode" onclick="getVCode()" src=""/>
    </div>

    <div style="text-align: left; margin-left: 10px;">
        <label><input type="checkbox" checked="checked" id="rememberMe"
                      style="width: 15px; height: 15px;">记住我</label></b>
    </div>

    <button class="btn btn-success" onclick="login()" style="width: 245px;height: 55px " type="submit">Sign in</button>
    <button class="btn btn-warning" onclick="register()" style="width: 245px;height: 55px " type="submit">Register</button>

</form>

<script src="${APP_PATH}/js/jquery/jquery-2.1.1.min.js"></script>
<script  src="${APP_PATH}/js/layer/layer.js"></script>
<script src="${APP_PATH}/js/MD5.js"></script>
<script>
    $(function () {
        onresize();
        getVCode();
    });

    /**
     * 获取验证码
     */
    function getVCode() {
        $("#imgCode").attr("src","sys/getVCode?"+ Math.random());
    }

    /**
     * 登录操作
     */
    function login() {
        var username = $("#username").val();
        var pswd = $("#password").val();
        var vCode = $("#vCode").val();

        if (username=='') {
            layer.msg("用户登录账号不能为空，请输入", {time: 2000, icon: 5, shift: 6}, function () {
            });
            return;
        }

        if (pswd==''){
            layer.msg("用户登录密码不能为空，请输入", {time:2000, icon:5, shift:6}, function(){});
            return;
        }
        if (vCode==''){
            layer.msg("验证码不能为空，请输入", {time:2000, icon:5, shift:6}, function(){});
            return;
        }

        var password = MD5(username+'#'+pswd);
        var data = {'userAcc':username,'password':password,'vCode':vCode};
         console.log(password)
        $.ajax({
            url:"sys/submitLogin",
            data:data,
            async:false,
            type:'POST',
            dataType:'json',
            success:function (callBack) {
                console.log(callBack)
                if (callBack.code=='200'){
                    layer.msg(callBack.extend.message, {time:2000, icon:6, shift:3}, function(){});
                    window.location.href = "sys/main";
                }else {
                    layer.msg(callBack.extend.message, {time:2000, icon:5, shift:6}, function(){});
                    getVCode();
                }
            },error:function (e) {
                layer.msg(e, {time:2000, icon:5, shift:6}, function(){});
            }
        })
    }

    /**
     * 注册页面
     */
    function register() {
        layer.msg("运营平台用户注册接口不对外开放！", {time:2000, icon:0, shift:5}, function(){});
    }

    /**
     * 监听窗口大小变化
     */
    window.onresize = function(){
        $("#frm").css('left',($('body').width()-$("#frm").width())/2);
        $("#frm").css('top',($(window).height()-$("#frm").height())/3);
    }
</script>
</body>
</html>

