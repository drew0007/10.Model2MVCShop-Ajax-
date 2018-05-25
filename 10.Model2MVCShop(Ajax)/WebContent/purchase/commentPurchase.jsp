<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">	
	$(function(){
		$("img[name='star']").on("click", function(){
			var index = $("img[name='star']").index(this);
			
			for(i=0; i<5; i++){
				if(i<=index){
					$($("img[name='star']")[i]).attr('src','/images/uploadFiles/roundstar_01.png');
				}else{
					$($("img[name='star']")[i]).attr('src','/images/uploadFiles/roundstar_02.png');
				}
			}
			
			$("#score").val(index+1);
		});
	});
	
	$(function(){
		$("td.ct_btn01:contains('등록')").on("click", function(){
			$("form").attr("method", "POST").attr("action", "/purchase/commentPurchase").submit();
		});
		
		$("td.ct_btn01:contains('취소')").on("click", function(){
			history.go(-1)
		});
	});
</script>

<title>Insert title here</title>
</head>
<body>

<form enctype="multipart/form-data">
<table  border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px; margin-left: 10px;" align="center">
	<tr>
		<td rowspan="2">
			<c:if test="${!empty purchase.purchaseProd.fileNameList[0]}">
				<img src = "/images/uploadFiles/${purchase.purchaseProd.fileNameList[0]}" width="150"/>
			</c:if>
			<c:if test="${empty purchase.purchaseProd.fileNameList[0]}">
				<img src = "/images/uploadFiles/1298310238.png" width="150"/>
			</c:if>
		</td>
		<td rowspan="2" width="15"></td>
		<td colspan="10"><b><font size="5">${purchase.purchaseProd.prodName}</font></b></td>
	</tr>
	<tr>
		<td colspan="10">주문일시 : ${purchase.orderDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="10" bgcolor="D6D6D6"></td>
	</tr>
	<tr height="50">
		<td><b><font size="5">별점</font></b></td>
		<td rowspan="2" width="15"></td>
		<td><img name="star" src="/images/uploadFiles/roundstar_01.png" width="30" /></td>
		<td><img name="star" src="/images/uploadFiles/roundstar_02.png" width="30" /></td>
		<td><img name="star" src="/images/uploadFiles/roundstar_02.png" width="30" /></td>
		<td><img name="star" src="/images/uploadFiles/roundstar_02.png" width="30" /></td>
		<td><img name="star" src="/images/uploadFiles/roundstar_02.png" width="30" /></td>

		<td><input type="hidden" id="score" name="score" value="1"></td>
	</tr>
	<tr>
		<td height="1" colspan="10" bgcolor="D6D6D6"></td>
	</tr>
	<tr height="50">
		<td><b><font size="5">상품평</font></b></td>
		<td rowspan="2" width="15"></td>
		<td colspan="10"><input type="text" name="commentText" style="width: 200px; height: 19px" maxLength="20"></td>
	</tr>
	<tr>
		<td height="1" colspan="10" bgcolor="D6D6D6"></td>
	</tr>
	<tr height="50">
		<td><b><font size="5">파일첨부</font></b></td>
		<td rowspan="2" width="15"></td>
		<td colspan="10"><input		type="file" name="file" class="ct_input_g" multiple="multiple"
					style="width: 200px; height: 19px"/></td>
	</tr>
</table>

<br/>
<input type="hidden" name="tranNo" value="${purchase.tranNo }">
<input type="hidden" name="prodNo" value="${purchase.purchaseProd.prodNo }">

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<!-- <a href="javascript:fncComment()">등록</a> -->
						등록
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
					<td width="30"></td>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<!-- <a href="javascript:history.go(-1)">취소</a> -->
						취소
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>

</body>
</html>