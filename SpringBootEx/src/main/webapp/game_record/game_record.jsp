<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게임 전적 조회</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style_record.css">
</head>
<body>

<div class="record-container">
    <h2>게임 전적 조회</h2>

    <!-- 검색 필터 -->
    <form method="get" action="record">
        <div class="search-bar">
            <input type="text" name="nickname" placeholder="닉네임 검색" value="${param.nickname}" required />
            <select name="game_id">
                <option value="">전체 게임</option>
                <option value="1" <c:if test="${param.game_id eq '1'}">selected</c:if>>OX게임</option>
                <option value="2" <c:if test="${param.game_id eq '2'}">selected</c:if>>끝말잇기</option>
                <option value="3" <c:if test="${param.game_id eq '3'}">selected</c:if>>라이어 게임</option>
            </select>
            <button type="submit">검색</button>
        </div>
    </form>

    <c:if test="${not empty userRecord}">
        <!-- 전적 정보 테이블 -->
        <table class="record-table">
            <tr>
                <th>닉네임</th>
                <td>${userRecord.nickname}</td>
            </tr>
            <tr>
                <th>관리자 여부</th>
                <td><c:choose>
                        <c:when test="${userRecord.isAdmin}">✔ 관리자</c:when>
                        <c:otherwise>일반 사용자</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>가입일</th>
                <td>${userRecord.joinDate}</td>
            </tr>
            <tr>
                <th>누적 플레이 시간</th>
                <td>${userRecord.totalPlayTime}분</td>
            </tr>
            <tr>
                <th>누적 점수</th>
                <td>${userRecord.totalScore}점</td>
            </tr>
            <tr>
                <th>가장 많이 플레이한 게임</th>
                <td>${userRecord.mostPlayedGame}</td>
            </tr>
        </table>
    </c:if>

    <c:if test="${empty userRecord}">
        <p style="color: red; text-align: center;">조회된 전적이 없습니다.</p>
    </c:if>
</div>

</body>
</html>
