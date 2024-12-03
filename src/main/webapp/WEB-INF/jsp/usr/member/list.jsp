<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>   

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
 <c:set var="pageTitle" value="친구 찾기" />

<div class="table-box">
    <table class="table table-striped w-full border">
        <thead>
            <tr class="bg-blue-500 text-white">
                <th>회원 번호</th>
                <th>지역</th>
                <th>성별</th>
                <th>이름</th>
                <th>조회수</th>
                <th>하트</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="member" items="${members}">
                <tr class="hover:bg-blue-100">
                    <td>${member.getId()}</td>
                    <td>${member.getAreaId()}</td>
                    <td>${member.getSex()}</td>
                    <td>
                        <a href="/usr/member/detail?id=${member.getId()}" class="text-blue-500 hover:underline">
                            ${member.getName()}
                        </a>
                    </td>
                    <td>${member.getViews()}</td>
                    <td>${member.getHearts()}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>


<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>