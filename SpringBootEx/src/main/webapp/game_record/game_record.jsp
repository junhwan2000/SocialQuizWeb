<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>게임 전적 기록</title>
    <link rel="stylesheet" type="text/css" href="/rank/style_rank.css">
</head>
<body>

<!-- 필터/검색 영역 -->
<div class="filter-bar" style="margin: 20px;">
    <form method="get" action="game_record.jsp" style="display:inline;">
        <select name="game_id" onchange="this.form.submit()">
            <option value="1" <%= "1".equals(request.getParameter("game_id")) ? "selected" : "" %>>OX게임</option>
            <option value="2" <%= "2".equals(request.getParameter("game_id")) ? "selected" : "" %>>끝말잇기</option>
            <option value="3" <%= "3".equals(request.getParameter("game_id")) ? "selected" : "" %>>라이어 게임</option>
        </select>
        &nbsp;
        닉네임: <input type="text" name="nickname" value="<%= request.getParameter("nickname") != null ? request.getParameter("nickname") : "" %>">
        <button type="submit" class="action-btn">검색</button>
    </form>
    <button onclick="location.href='/logonmain'" class="action-btn" style="float: right; background-color: #4CAF50;">나가기</button>
</div>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String gameName = "게임";

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String dbid = "quiz";
        String dbpasswd = "quiz";
        con = DriverManager.getConnection(url, dbid, dbpasswd);

        String gameId = request.getParameter("game_id");
        String nickname = request.getParameter("nickname");

        if (gameId == null) gameId = "1";

        // 게임 이름
        Statement stmt = con.createStatement();
        ResultSet gameRs = stmt.executeQuery("SELECT game_name FROM Games WHERE game_id = " + gameId);
        if (gameRs.next()) {
            gameName = gameRs.getString("game_name");
        }
        gameRs.close();
        stmt.close();

        // 게임 기록 조회
        String sql = "SELECT m.nickname, gr.record_day, gr.record_time, gr.game_score " +
                     "FROM Members m JOIN game_records gr ON m.userId = gr.userId " +
                     "WHERE gr.game_id = ? ";

        if (nickname != null && !nickname.trim().equals("")) {
            sql += "AND m.nickname LIKE ? ";
        }

        sql += "ORDER BY gr.record_day DESC";

        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(gameId));
        if (nickname != null && !nickname.trim().equals("")) {
            pstmt.setString(2, "%" + nickname + "%");
        }

        rs = pstmt.executeQuery();
%>

<div class="ranking-container">
    <h1 class="ranking-title"><%= gameName %> 게임 기록</h1>
    <table class="ranking-table">
        <thead>
            <tr>
                <th>닉네임</th>
                <th>플레이 날짜</th>
                <th>소요 시간</th>
                <th>획득 점수</th>
            </tr>
        </thead>
        <tbody>
<%
    while (rs.next()) {
%>
        <tr>
            <td><%= rs.getString("nickname") %></td>
            <td><%= rs.getDate("record_day") %></td>
            <td><%= rs.getInt("record_time") %>초</td>
            <td><%= rs.getInt("game_score") %>점</td>
        </tr>
<%
    }
%>
        </tbody>
    </table>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (con != null) con.close();
    }
%>

</body>
</html>
