<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../setting.jsp"%>
<link rel="stylesheet" type="text/css" href="${project}main.css">
<script type="text/javascript" src="${project}script_member.js"></script>    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
<%@ include file="/home/header.jsp" %>
	
	<div class="container">
		<div class="div1">  Social Quiz 배너 </div>
		<div class="div2">
		<a href="quiz/selectquiz" >추천게임 </a> 
		
		</div>
		
		<div class="div3">
		    <a href="rank">
			<span > 실시간 순위 </span>
			</a>
		</div>
		<div class="div4" name="loginSession">
		<c:if test="${memId eq null}">
			<p class="d-inline-flex gap-1">
			  <button type="button" class="btn btn-primary" data-bs-toggle="button" onclick="location='logonlogin'">
			  	로그인
				  	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-in-right" viewBox="0 0 16 16">
					  <path fill-rule="evenodd" d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0z"/>
					  <path fill-rule="evenodd" d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708z"/>
					</svg>
				</button>
			</p>	
		</c:if>
		<c:if test="${memId ne null}">		
		</c:if>
		
		</div>
		<div class="div5">
		<a href="boardlist">
			<span > 공지사항 </span>
		</a>
			<!-- 공지사항 목록 JSP 삽입 -->
		</div>
		<div class="div6">
			<a href="qnalist">
				<span > 1대1 게시판 </span>
			</a>
		</div>
		
	</div>
	
<%@ include file="/home/footer.jsp" %>











