<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%@ page import="java.net.URLEncoder"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<html>
<head>
<title>장바구니 조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
function fncSumPrice(){
	var listSize = ${list.size()};
	var sumPrice = 0;

	for(i=0; i<listSize; i++){
		if($($("input[name='cartChk']")[i]).prop("checked")){
			sumPrice += parseInt($($("input[name='price']")[i]).val());
		}
	}
	
	$("#sumPrice").val(sumPrice);
}

$(function(){
	$("#cartChkAll").on("click",function(){
		if($("#cartChkAll").prop("checked")){
			$("input[name='cartChk']:checkbox").each(function(){
				$(this).prop('checked', true);
			});
		}else{
			$("input[name='cartChk']:checkbox").each(function(){
				$(this).prop('checked', false);
			});
		}
		fncSumPrice();
	});
	
	$("input[name='cartChk']").on("click", function(){
		fncSumPrice();
	});
});

$(function(){
	$(".ct_list_pop td:nth-child(3)").on("click", function(){
		var index = $(".ct_list_pop td:nth-child(3)").index(this);
		var prodNo = $($("input[name='prodNo']")[index]).val();
		location.href="/product/getProduct?prodNo="+prodNo+"&menu=search";
	});
	
	$("input[name='cartCnt']").on("change", function(){
		var index = $("input[name='cartCnt']").index(this);
		$($("input[name='cntChange']")[index]).attr("type", "button");
	});
	
	$("input[name='cntChange']").on("click", function(){
		var index = $("input[name='cntChange']").index(this);
		var cartNo = $($("input[name='cartNo']")[index]).val();
		var cartCnt = $($("input[name='cartCnt']")[index]).val();
		var prodCnt = $($("input[name='prodCnt']")[index]).val();

		if(cartCnt == null || cartCnt.length<1){
			alert("수량은 반드시 입력하셔야 합니다.");
			return;
		}
		if(parseInt(cartCnt) > parseInt(prodCnt)){
			alert("재고 수량을 초과할 수 없습니다.");
			return;
		}

		location.href="/cart/updateCart?cartNo="+cartNo+"&cartCnt="+cartCnt;
		/* 
		$.ajax(
				{
					url : "/cart/json/updateCart/"+cartNo+"/"+cartCnt,
					method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
				success : function(JSONData , status){
					//alert(index);
					$($("input[name='cntChange']")[index]).attr("type", "hidden");
					alert("확인");
				}
			}); */
	});
});

$(function(){
	$("p.state1").on("click",function(){
		if($(this).text().trim() == '재고없음'){
			return;
		}
		var index = $("p.state1").index(this);
		var prodNo = $($("input[name='prodNo']")[index]).val();
		var cartCnt = $($("input[name='cartCnt']")[index]).val();
		var cartNo = $($("input[name='cartNo']")[index]).val();
		location.href="/purchase/addPurchaseView?cartList=" + cartNo;
	});
	
	$("p.state2").on("click",function(){
		var index = $("p.state2").index(this);
		var cartNo = $($("input[name='cartNo']")[index]).val();
		location.href="/cart/deleteCart?cartNo="+cartNo;
	});
	
	$("td.ct_btn01:contains('구매하기')").on("click", function(){
		var cartList = "";
		var listSize = ${list.size()};
		
		for(i=0; i<listSize; i++){
			if($($("input[name='cartChk']")[i]).prop("checked")){
				cartList += ($($("input[name='cartNo']")[i]).val()) + ",";
			}
		}

		if(cartList == ""){
			alert("1개 이상의 상품을 선택해주세요.");
			return;
		}
		
		location.href="/purchase/addPurchaseView?cartList=" + cartList;
	});
});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form>

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					
						장바구니
					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="4" >
			전체 ${resultPage.totalCount} 건수
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">
			<input type="checkbox" id="cartChkAll" name="cartChkAll"">
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품이미지</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">재고수량</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">구매수량</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">구매금액</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100"></td>
		<td class="ct_line02"></td>
		</td>	
	</tr>
	<tr>
		<td colspan="16" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0"/>
	<c:forEach var="cart" items="${list }">
	<c:set var="i" value="${i+1 }"/>
	<tr class="ct_list_pop">
		<td align="center">
			<input type=${cart.cartCnt <= cart.cartProd.prodCnt ? "checkbox" : "hidden"} id="cartChk" name="cartChk">
			<input type="hidden" id="cartNo" name="cartNo" value="${cart.cartNo}">
		</td>
		<td></td>
		<td align="left">
			${cart.cartProd.prodName}
			<input type="hidden" id="prodNo" name="prodNo" value="${cart.cartProd.prodNo}">
		</td>
		<td></td>
		<td align="center">
			<c:if test="${!empty cart.cartProd.fileNameList[0]}">
				<img src = "/images/uploadFiles/${cart.cartProd.fileNameList[0]}" width="150"/>
			</c:if>
			<c:if test="${empty cart.cartProd.fileNameList[0]}">
				<img src = "/images/uploadFiles/1298310238.png" width="150"/>
			</c:if>
		</td>
		<td></td>
		<td align="center">
			${cart.cartProd.prodCnt}
			<input type="hidden" name="prodCnt" id="prodCnt" value="${cart.cartProd.prodCnt }"/>
		</td>
		<td></td>
		<td align="right">
			${cart.cartProd.price} 원
		</td>
		<td></td>
		<td align="center">
			<input type="text" name="cartCnt" id="cartCnt" 	class="ct_input_g"" 
							style="width: 50px; height: 15px" maxLength="5" value="${cart.cartCnt}" /><br/><br/>
			<input type="hidden" name="cntChange" id="cntChange" value="수량변경"
							style="width: 80px; height: 25px"/>
		</td>
		<td></td>
		<td align="right">
			${cart.cartProd.price * cart.cartCnt} 원
			<input type="hidden" id="price" name="price" value="${cart.cartProd.price * cart.cartCnt}"/>
		</td>
		<td></td>
		<td align="center" height="70">
			<p class="state1">${cart.cartCnt <= cart.cartProd.prodCnt?"구매":"재고없음"}</p>
			<p class="state2">삭제</p>
		</td>
		<td></td>
	</tr>
	<tr>
		<td colspan="16" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	</c:forEach>
</table>


<input type="hidden" id="cartList" >

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td >
						총 구매금액 : 
						<input style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px; text-align:right" 
								type="text" id="sumPrice" size="10" value="0" readonly="readonly">
						 원
						<td width="30"></td>
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
							구매하기
						</td>
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
						</td>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>

</div>
</body>
</html>
