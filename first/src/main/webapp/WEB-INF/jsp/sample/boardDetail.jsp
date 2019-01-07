<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<title>Insert title here</title>
</head>
<body>
	<table class="board_view">
		<colgroup>
			<col width="15%"/>
			<col width="35%"/>
			<col width="15%"/>
			<col width="35%"/>
		</colgroup>
		<caption>게시글 상세</caption>
		<tbody>
			<tr>
				<th scope="row">글번호</th>
				<td>${map.IDX }
				<input type="hidden" id="IDX" name="IDX" value="${map.IDX }"></td>
				<th scope="row">조회수</th>
				<td>${map.HIT_CNT }</td>
			</tr>
			<tr>
				<th scope="row">작성자</th>
				<td>${map.CREA_ID }</td>
				<th scope="row">작성시간</th>
				<td>${map.CREA_DTM }</td>
			</tr>
			<tr>
				<th scope="row">제목</th>
				<td colspan="3">${map.TITLE }</td>
			</tr>
			<tr>
				<td colspan="4">${map.CONTENTS }</td>
			</tr>
			<tr><!-- jstl태그를 이용하여 mv객체에 addObject()로 추가한 list를 ${list}를 통해 접근하여 사용.
			forEach를 이용해서 var를 "row"로 지정하고 list를 Map으로 정의하여 Map의 key값을 통해  value를 가져옴.-->
				<th scope="row">첨부파일</th>
				<td colspan="3">
					<c:forEach var="row" items="${list }">
						<input type="hidden" id="IDX" value="${row.IDX }">
						<a href="#this" name="file">${row.ORIGINAL_FILE_NAME }</a>
						(${row.FILE_SIZE }kb)<br/>
					</c:forEach>
				</td>
			</tr>
		</tbody>
	</table>
	<a href="#this" class="btn" id="list">목록으로</a>
	<a href="#this" class="btn" id="update">수정하기</a>
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#list").on("click",function(e){
				e.preventDefault();
				fn_openBoardList();
			});
			$("#update").on("click",function(e){
				/* e.stopPropagation(); */ //preventDefault()와 동작은 동일하지만 stopPropagation()은 url이동이 있음.
				e.preventDefault();
				fn_openBoardUpdate();
			});
			
			//a 태그의 이름이 file인 것을 클릭했을 때 기능을 설정함.
			$("a[name='file']").on("click",function(e){
				e.preventDefault(); //이벤트를 전파하지 않고 취소함. 가장 내부에 있는 event만 실행이 되고 바깥에 있는 이벤트는 실행이 되지 않도록 할 때 사용함.
				//(url에 #this요청을 무시하고 원래의 주소로 넘겨줌. url 변화가 없도록 함.)
				fn_downloadFile($(this));
			});
		});
		
		function fn_openBoardList(){
			var comSubmit=new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardList.do'/>");
			comSubmit.submit();
		}
		function fn_openBoardUpdate(){
			var idx="${map.IDX}";
			var comSubmit=new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardUpdate.do'/>");
			comSubmit.addParam("IDX",idx);
			comSubmit.submit();
		}
		function fn_downloadFile(obj){ //다운로드를 할 수 있도록 요청이 가도록 함.
			var idx=obj.parent().find("#IDX").val();
			var comSubmit=new ComSubmit();
			/* $("#commonForm").children().remove(); */
			comSubmit.setUrl("<c:url value='/common/downloadFile.do'/>"); 
			comSubmit.addParam("IDX",idx);
			comSubmit.submit();
		}
	</script>
</body>
</html>