<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	function fncCheck(){
		var tranCnt=$("input[name='tranCnt']").val();
		var prodCnt=$("input[name='prodCnt']").val();
	
		if(tranCnt == null || tranCnt.length<1){
			alert("수량은 반드시 입력하셔야 합니다.");
			return;
		}
		if(parseInt(tranCnt) > parseInt(prodCnt)){
			alert("재고 수량을 초과할 수 없습니다.");
			return;
		}
	}
	
	$(function(){
		$("td.ct_btn01:contains('장바구니')").on("click", function(){
			fncCheck();
			$("form").attr("method" , "POST").attr("action" , "/cart/addCart").submit();
		});
		
		$("td.ct_btn01:contains('바로구매')").on("click", function(){
			fncCheck();
			$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchaseView").submit();
		});
		
		$("td.ct_btn01:contains('이전')" ).on("click" , function() {
			history.go(-1);
		});
		
		$("td.ct_btn01:contains('확인')" ).on("click" , function() {
			$("form").attr("method" , "GET").attr("action" , "/product/listProduct?menu=manage").submit();
		});
	});
</script>

<title>Insert title here</title>
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"	width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">상품상세조회</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif"  width="12" height="37"/>
		</td>
	</tr>
</table>

<input type="hidden" name="prodNo" id="prodNo" value="${product.prodNo}"/>
<input type="hidden" name="prodCnt" id="prodCnt" value="${product.prodCnt}"/>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">${product.prodNo}</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		${product.prodName}
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품이미지 <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<c:forEach var="file" items="${product.fileNameList}">
				<c:if test="${!empty file}">
					<img src = "/images/uploadFiles/${file}" width="300"/>
				</c:if>
			</c:forEach>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품상세정보 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		${product.prodDetail}
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">제조일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		${product.manuDate}
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">가격</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		${product.price} 원
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">재고수량</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		${product.prodCnt}
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">등록일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.regDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">평점</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.scoreAvg}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">

		<table border="0" cellspacing="0" cellpadding="0">
			<tr>		
			<c:if test="${param.menu.equals('search') }">
				<c:if test="${user.role.equals('user') && product.prodCnt > 0 }">
					<td width="70">
						구매 수량 : 
					</td>
					
					<td >
						<input	type="text" name="tranCnt" id="tranCnt" class="ct_input_g" value="1"
								style="width: 50px;" maxLength="5"/>
					</td>
					<td width="30"></td>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<%-- <a href="javascript:fncAddCart(${product.prodNo })">장바구니 담기</a> --%>
						장바구니 담기
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
					<td width="30"></td>
					
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<!-- <a href="javascript:fncAddPurchase()">바로구매</a> -->
						바로구매
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
					<td width="30"></td>
				</c:if>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					<!-- <a href="javascript:history.go(-1)">이전</a> -->
					이전
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23">
				</td>
			</c:if>
			<c:if test="${param.menu.equals('manage') }">
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					<!-- <a href="/product/listProduct?menu=manage" >확인</a> -->
					확인
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23">
				</td>
			</c:if>
			</tr>
		</table>

		</td>
	</tr>
</table>
</form>

<br/>

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"	width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">상품평</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif"  width="12" height="37"/>
		</td>
	</tr>
</table>

<table>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<c:forEach var="purchase" items="${list}">
	<tr>
		<td>${purchase.receiverName}</td>
		<td>${purchase.commentDate}</td>
	</tr>
	<tr>
		<td>
		<c:forEach var="i" begin="1" end="5">
			<c:if test="${i <= purchase.score}">
				<img src="/images/uploadFiles/roundstar_01.png" width="15"/>
			</c:if>
			<c:if test="${i > purchase.score}">
				<img src="/images/uploadFiles/roundstar_02.png" width="15"/>
			</c:if>
		</c:forEach>
		</td>
		<td colspan="2">${product.prodName} ${purchase.tranCnt} EA</td>
	</tr>
	<tr>
		<td>
			<c:forEach var="file" items="${purchase.commentImageList}">
				<c:if test="${!empty file}">
					<img src = "/images/uploadFiles/${file}" width="100"/>
				</c:if>
			</c:forEach>
		</td>
	</tr>
	<tr>
		<td>${purchase.commentText}</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	</c:forEach>
</table>

</body>
</html>