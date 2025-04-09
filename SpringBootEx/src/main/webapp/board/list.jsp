<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="${project}style_board.css">
<script type="text/javascript" src="${project}script_board.js"></script>

<h2>실시간 순위</h2>
<br>

<!-- 랭킹 테이블 -->
<table class="table" style="margin: 0 auto; width: 80%;">
    <thead>
        <tr>
            <th colspan="6" class="text-center">OX게임 랭킹</th>
        </tr>
        <tr class="table-dark">
            <th class="text-center" style="width:7%;">순위</th>
            <th class="text-center" style="width:20%;">닉네임</th>
            <th class="text-center" style="width:15%;">점수</th>
            <th class="text-center" style="width:15%;">시간</th>
            <th class="text-center" style="width:15%;">상태</th>
            <th class="text-center" style="width:15%;">게임기록</th>
        </tr>
    </thead>
    <tbody>
        <c:if test="${count eq 0}">
            <tr>
                <td colspan="6" class="text-center">${msg_list_x}</td>
            </tr>
        </c:if>
        <c:if test="${count ne 0}">
            <c:set var="number" value="${number}" />
            <c:forEach var="dto" items="${rankList}">
                <tr>
                    <td class="text-center">
                        ${number}
                        <c:set var="number" value="${number - 1}" />
                    </td>
                    <td class="text-center">${dto.nickname}</td>
                    <td class="text-center">${dto.rank_score}</td>
                    <td class="text-center">${dto.rank_time}초</td>
                    <td class="text-center">
                        <!-- 현재 세션 미적용: 모두 오프라인 → 빨간 동그라미 -->
                        <div style="width:12px; height:12px; border-radius:50%; background-color:red; margin: 0 auto;"></div>
                    </td>
                    <td class="text-center">
                        <button type="button" class="btn-res" onclick="location.href='gameRecord?userId=${dto.userId}&amp;game_id=${dto.game_id}'">
                            게임기록
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </tbody>
</table>
<br>

<!-- 페이징 영역 -->
<center>
    <c:if test="${count gt 0}">
        <c:if test="${startPage gt pageBlock}">
            <a href="rank?pageNum=1">[◀◀]</a>
            <a href="rank?pageNum=${startPage - pageBlock}">[◀]</a>
        </c:if>
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <c:choose>
                <c:when test="${i eq currentPage}">
                    <b>[${i}]</b>
                </c:when>
                <c:otherwise>
                    <a href="rank?pageNum=${i}">[${i}]</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${pageCount gt endPage}">
            <a href="rank?pageNum=${startPage + pageBlock}">[▶]</a>
            <a href="rank?pageNum=${pageCount}">[▶▶]</a>
        </c:if>
    </c:if>
</center>
