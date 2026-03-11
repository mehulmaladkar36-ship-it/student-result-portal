<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SAP NetWeaver</title>
<style>
/* ---- YOUR SAME CSS (UNCHANGED DESIGN) ---- */
body{
    margin:0;
     background:#f2f2f2;
    font-family:Arial, Helvetica, sans-serif;

    user-select: none;
    -webkit-user-select: none;
    -ms-user-select: none;
    background:#f2f2f2;
    font-family:Arial, Helvetica, sans-serif;
}
.main-box{
    width:740px;
    height:400px;
    margin:80px auto;
    background:#fbfbfb;
    border:3.5px solid #c69214;
    border-radius:8px;
    position:relative;
    display:flex;
}
.left-panel{
    width:45%;
    display:flex;
    align-items:center;
    justify-content:center;
}
.left-panel img{ width:200px; }
.right-panel{
    width:55%;
    padding:20px 25px;
    padding-left:75px;
}
.title{
    font-size:34px;
    font-weight:bold;
    margin-bottom:30px;
    margin-left:35px;
    background:linear-gradient(to bottom,#fff3b0 0%,#ffd700 35%,#e6b800 60%,#b8860b 100%);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
}
.error-box{
    height:25px;
    color:#b00000;
    font-size:13px;
    margin-bottom:5px;
}

.error-icon{
    font-weight:bold;
    margin-right:5px;
}
.form-group{ margin-bottom:10px; }
label{
    display:inline-block;
    width:100px;
    font-size:16px;
    color:#000;
}
input[type=text], input[type=password]{
    width:210px;
    padding:4px;
    border:1px solid #999;
}
.login-btn{
    padding:6px 14px;
    font-size:12px;
    cursor:pointer;
    margin-left:0px;   
}
.button-group{
    margin-left:100px;   /* align with inputs */
    margin-top:10px;
}

.forgot-btn{
    margin-left:140px;
    color:#2f6fd6;
    text-decoration:none;
    font-size:14px;
}

.forgot-btn:hover{
    text-decoration:underline;
}
.captcha-group{
    display:flex;
    align-items:center;
    gap:8px;

}

.captcha-input{
    width:120px;
}

.refresh-btn{
    background:none;
    border:none;
    font-size:22px;
    cursor:pointer;
    color:black;
    padding:0;
    position: relative;
    top: -8px;
    left: 10px;
}
@keyframes spinRefresh {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

.refresh-btn.spin {
    animation: spinRefresh 0.6s linear;
}

.captcha-note{
    margin-left:0px;  
    font-size:12px;
    color:#b8a67a;      
}
.sap-bottom{
    position:absolute;
    bottom:-2px;
    left:50%;
    transform:translateX(-50%);
    width:320px;
    height:12px;
    background:linear-gradient(to bottom,#f8d877,#c69214);
    border-radius:60px 60px 0 0;
}
.footer{
    margin-top:20px;
    font-size:12px;
    text-align:center;
    color:#555;
    margin-left:-130px;
}

.sap-logo-space{
    margin-top:5px;
}
.sap-logo{
    height:30px;
    margin-left:-150px;
}
</style>
</head>
<body>

<div class="main-box">

<div class="left-panel">
    <img src="images/svkm.jpg">
</div>

<div class="right-panel">

<div class="title">SAP NetWeaver</div>

<div class="error-box">
<%
    String error = (String) request.getAttribute("error");
    if(error != null){
%>
   <%= error %>
<%
    }
%>
</div>

<form action="<%= request.getContextPath() %>/ResultServlet" method="post">

<div class="form-group">
<label>User <span class="required">*</span></label>
<input type="text" name="rollno" required>
</div>

<div class="form-group">
<label>Password <span class="required">*</span></label>
<input type="password" name="password" required>
</div>

<div class="form-group">
    <label>Captcha *</label>
    <input type="text" name="captcha">
</div>

<small class="captcha-note">Captcha letters are case sensitive</small>
<div class="captcha-display">
    <canvas id="captchaCanvas" width="120" height="35"></canvas>
    <button type="button" class="refresh-btn" onclick="rotateAndRefresh(this)">&#x21bb;</button>
</div>

<input type="hidden" name="generatedCaptcha" id="generatedCaptcha">

<input type="hidden" name="generatedCaptcha" id="generatedCaptcha">

<div>
<button type="submit" class="login-btn">Log On</button>
 <a href="#" class="forgot-btn">Forgot Password</a>
</div>

</form>
<div class="footer">
    Copyright © SVKM. All Rights Reserved

    <div class="sap-logo-space">
        <img src="images/sap.png" alt="SAP Logo" class="sap-logo">
    </div>
</div>
</div>

<div class="sap-bottom"></div>
</div>

<script>
    function rotateAndRefresh(btn){
    btn.classList.add("spin");
    generateCaptcha();

    setTimeout(function(){
        btn.classList.remove("spin");
    }, 600);
}
let generatedCaptcha="";

function generateCaptcha(){

    const chars="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    generatedCaptcha="";

    for(let i=0;i<6;i++){
        generatedCaptcha+=chars.charAt(Math.floor(Math.random()*chars.length));
    }

    document.getElementById("generatedCaptcha").value = generatedCaptcha;

    const canvas=document.getElementById("captchaCanvas");
    const ctx=canvas.getContext("2d");

    ctx.clearRect(0,0,canvas.width,canvas.height);

    ctx.fillStyle="#eeeeee";
    ctx.fillRect(0,0,canvas.width,canvas.height);

    ctx.font="bold 16px Arial";
    ctx.fillStyle="#000";
    ctx.textBaseline="middle";
    ctx.textAlign="center";

    ctx.fillText(generatedCaptcha, canvas.width/2, canvas.height/2);
}

generateCaptcha();
</script>

</body>
</html>