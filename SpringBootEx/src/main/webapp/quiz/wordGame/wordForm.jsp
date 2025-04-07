<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp" %>
<style>
  .top-right-btn {
    position: absolute;
    top: 20px;
    right: 30px;
  }
</style>
<!DOCTYPE html>
<html>
  <head>
     <meta charset="UTF-8">
     <title>끝말잇기 게임</title>
  </head>
  <body>
     <div class="top-right-btn">
       <a href="selectquiz" class="btn btn-outline-primary">퀴즈 선택으로 이동</a>
     </div>
     
     <div style="position:absolute; top:25%; left:10%;">
        <input type="text" name="show_word" readonly style="width:500px;height:300px;font-size:100px;text-align:center;">
     </div>
     <div style="position:absolute; top:25%; left:50%;">
        <input type="text" name="user_input" style="width:500px;height:300px;font-size:100px;text-align:center;">
     </div>
     <br>
     <div name="definition" border="1" style="position:absolute; top:60%; left:25%; width:600px; height:200px; font-size:20px; border-style:solid">
     </div>
     <jsp:include page="wordCheck.jsp"/>
  </body>
 </html>