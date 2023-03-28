<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Read Page</div>

			<div class="panel-body">
				<div class="form-group">
					<label>Bno</label> <input class="form-control" name="bno"
						value='<c:out value="${board.bno}" />' readonly="readonly" />
				</div>
				<div class="form-group">
					<label>Title</label> <input class="form-control" name="title"
						value='<c:out value="${board.title}" />' readonly="readonly" />
				</div>
				<div class="form-group">
					<label>Content</label>
					<textarea class="form-control" rows="3" name="content"><c:out
							value="${board.content}" /></textarea>
				</div>
				<div class="form-group">
					<label>Writer</label> <input class="form-control" name="writer"
						value='<c:out value="${board.writer}" />' readonly="readonly" />
				</div>
				<button data-oper='modify' class="btn btn-default"
					onClick="location.href='/board/modify?bno=<c:out value="${board.bno}" />'">Modify</button>
				<button data-oper='list' class="btn btn-info"
					onClick="location.href='/board/list'">List</button>
			</div>
			
			<form id="actionForm" action="/board/list" method='get'>
				<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}" />' />
				<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}" />' />
				<input type="hidden" name="amount" value='<c:out value="${cri.amount}" />' />
			</form>

		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
$(document).ready(function() {
	var actionForm = $("#actionForm");
	$(".btn-info").on("click", function(e) {
		e.preventDefault();
		actionForm.attr("action", "/board/list");
		actionForm.submit();
	})
	$(".btn-default").on("click", function(e) {
		e.preventDefault();
		actionForm.attr("action", "/board/modify");
		actionForm.submit();
	})
	
})
</script>
