<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="회원가입" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<div class="members-container" id="membersContainer">
    <c:forEach var="article" items="${articles}">
        <div class="member-card" data-sex="${member.sex}">
            <a href="/usr/article/detail?id=${article.id}">
                <c:choose>
                    <c:when test="${not empty article.pic}">
                        <img src="/usr/member/getImage?pic=${article.pic}" class="member-pic" />
                    </c:when>
                    <c:otherwise>
                        <div class="member-pic bg-gray-200"></div>
                    </c:otherwise>
                </c:choose>
                <div class="member-name">
                    <c:if test="${not empty article}">
                        <p>${article.title}</p>
                    </c:if>
                </div>
            </a>
        </div>
    </c:forEach>
</div>
<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>