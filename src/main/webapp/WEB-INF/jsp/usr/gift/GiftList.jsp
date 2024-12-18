<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:set var="pageTitle" value="게시글 목록" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f4f9;
}

.articles-container {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
	gap: 20px;
	padding: 20px;
}

.article-card {
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	text-decoration: none;
	color: inherit;
}

.article-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
	border: 2px solid #808080;
}

.article-image {
	width: 100%;
	height: 180px;
	object-fit: cover;
}

.article-details {
	padding: 15px;
}

.article-title {
	font-size: 1.2em;
	font-weight: bold;
	margin: 10px 0;
	color: #333;
}

.article-writer {
	font-size: 0.9em;
	color: #666;
}

.write-button {
	display: inline-block;
	margin: 20px;
	padding: 10px 20px;
	background-color: #007BFF;
	color: white;
	text-decoration: none;
	border-radius: 4px;
	transition: background-color 0.3s ease;
	font-weight: bold;
}

.write-button:hover {
	background-color: #0056b3;
}
</style>
<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>

<div class="articles-container" id="articleContainer">
	<c:forEach var="gift" items="${gifts}">
		<a href="#" class="article-card">
			<c:choose>
				<c:when test="${not empty gift.giftPic}">
					<img src="/usr/pic/getImage?pic=${gift.giftPic.pic}"
						class="article-image" />
				</c:when>
				<c:otherwise>
					<img src="/static/default-pic.jpg" class="article-image"
						alt="No Image" />
				</c:otherwise>
			</c:choose>
			<div class="article-details">
				<p class="article-title">${gift.giftName}</p>
				<p class="article-writer">${gift.price}</p>
			</div>
		</a>
	</c:forEach>
</div>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>
