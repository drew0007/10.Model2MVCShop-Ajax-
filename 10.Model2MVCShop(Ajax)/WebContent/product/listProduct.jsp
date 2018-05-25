<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%@ page import="java.net.URLEncoder"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<style>
		.ui-autocomplete {
			max-height: 100px;
			overflow-y: auto;
			/* prevent horizontal scrollbar */
			overflow-x: hidden;
		}
		
		/* IE 6 doesn't support max-height
		 * we use height instead, but this forces the menu to always be this tall
		 */
		
		* html .ui-autocomplete {
			height: 100px;
		}
	</style>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	function fncGetProductList(currentPage){
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${param.menu}").submit();
	}
	function fncListPage(currentPage){
		$("#searchCondition").val("${search.searchCondition}");
		$("#searchKeyword").val("${search.searchKeyword}");
		fncGetProductList(currentPage);
	}
	function fncSort(currentPage, sort){
		$("#sort").val(sort);
		fncListPage(currentPage);
	}
	
	$(function(){
		$( "td.ct_btn01:contains('검색')" ).on("click" , function() {
			fncGetProductList(1);
		});
		
		$(".ct_list_pop td:nth-child(3)").on("click", function(){
			var menu = "${param.menu}";
			var index = $(".ct_list_pop td:nth-child(3)").index(this);
			var val = $($("input[name='prodNo']")[index]).val();
			
			if(menu == 'manage'){
				self.location = "/product/updateProductView?prodNo="+val+"&menu="+menu;
			}else{
				self.location = "/product/getProduct?prodNo="+val+"&menu="+menu;
			}
		});
		
		$("td:contains('확인')").on("click", function(){
			var index = $("td:contains('확인')").index(this);
			var val = $($("input[name='prodNo']")[index]).val();
			
			self.location ="/purchase/historyPurchase?prodNo="+val;
		});
	});
	
	$( function() {
	    var autocompleNo = [];
	    var autocompleName = [];
	    var autocomplePrice = [];
	    
	    $.ajax( 
				{
					url : "/product/json/autocompleteProduct" ,
					method : "GET" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData , status) {
						for(i=0; i<JSONData.length; i++){
							autocompleNo.push(JSON.stringify(JSONData[i].prodNo));
							autocompleName.push(JSONData[i].prodName);
							autocomplePrice.push(JSON.stringify(JSONData[i].price));
						}
					}
			});

	    $( "input[name=searchKeyword]" ).autocomplete({
	      source: autocompleNo
	    });
	    
	    $("select[name=searchCondition]").on("change", function(){
	    	var value = $(this).val();
	    	if(value == "0"){
	    		alert("1");
	    		$( "input[name=searchKeyword]" ).autocomplete({
	  		      source: autocompleNo
	  		    });	    		
	    	} else if(value == "1"){
	    		alert("2");
	    		$( "input[name=searchKeyword]" ).autocomplete({
	  		      source: autocompleName
	  		    });
	    	} else{
	    		alert("3");
	    		$( "input[name=searchKeyword]" ).autocomplete({
		  		      source: autocomplePrice
		  		    });
	    	}
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
					
						${param.menu.equals('manage')?"판매상품관리":"상품 목록조회"}
					
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
		<td align="right">
			<select id = "searchCondition" name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${! empty search.searchCondition && search.searchCondition.equals("0")?"selected":""}>상품번호</option>
				<option value="1" ${! empty search.searchCondition && search.searchCondition.equals("1")?"selected":""}>상품명</option>
				<option value="2" ${! empty search.searchCondition && search.searchCondition.equals("2")?"selected":""}>상품가격</option>
			</select>
			<input type="text" id="searchKeyword" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" 
					value="${! empty search.searchKeyword ? search.searchKeyword : ''}" />
		</td>
	
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:fncGetProductList('1');">검색</a> -->
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="4" >
			전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지
		</td>
		<td colspan="12" align="right">
			<c:if test="${search.sort.equals('asc')}">
				<img src="/images/ct_icon_red.gif" width="5" height="5" align="middle"/> 
				<a href="javascript:fncSort('1', 'default');">
				<b>낮은 가격 순</b>
				</a>
			</c:if>
			<c:if test="${!search.sort.equals('asc')}">
				<img src="/images/empty.gif" width="5" height="5" align="middle"/> 
				<a href="javascript:fncSort('1', 'asc');">
				낮은 가격 순
				</a>
			</c:if>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<c:if test="${search.sort.equals('dsc')}">
				<img src="/images/ct_icon_red.gif" width="5" height="5" align="middle"/> 
				<a href="javascript:fncSort('1', 'default');">
				<b>높은 가격 순</b>
				</a>
			</c:if>
			<c:if test="${!search.sort.equals('dsc')}">
				<img src="/images/empty.gif" width="5" height="5" align="middle"/> 
				<a href="javascript:fncSort('1', 'dsc');">
				높은 가격 순
				</a>
			</c:if>
		</td>
		<input type="hidden" id="sort" name="sort" value="${search.sort }"/>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품이미지</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">재고수량</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">평점</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">
		<c:if test="${param.menu.equals('manage') }">
			판매내역
		</c:if>
		</td>	
	</tr>
	<tr>
		<td colspan="17" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0"/>
	<c:forEach var="product" items="${list }">
	<c:set var="i" value="${i+1 }"/>
	<tr class="ct_list_pop">
		<td align="center">${i}</td>
		<td></td>
			<td align="left">
				<input type="hidden" name="prodNo" value="${product.prodNo }">
				<%-- <a href="/product/updateProductView?prodNo=${product.prodNo}&menu=manage">${product.prodName}</a> --%>
				${product.prodName}
			</td>
		<td></td>
		<td align="center">
			<c:if test="${!empty product.fileNameList[0]}">
				<img src = "/images/uploadFiles/${product.fileNameList[0]}" width="150"/>
			</c:if>
			<c:if test="${empty product.fileNameList[0]}">
				<img src = "/images/uploadFiles/1298310238.png" width="150"/>
			</c:if>
		</td>
		<td></td>
		<td align="right">${product.price} 원</td>
		<td></td>
		<td align="center">${product.prodCnt}</td>
		<td></td>
		<td align="center">${product.regDate}</td>
		<td></td>
		<td align="center">${product.scoreAvg}</td>
		<td></td>
		<td align="center">
			${product.prodCnt != 0?"판매중":"재고없음" }
		</td>	
		<td></td>
		<td align="center">
		<c:if test="${param.menu.equals('manage') }">
			<%-- <a href="/purchase/historyPurchase?prodNo=${product.prodNo}">확인</a> --%>
			확인
		</c:if>
		</td>
	</tr>
	<tr>
		<td colspan="17" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			
		<input type="hidden" id="currentPage" name="currentPage" value="0"/>
			
			<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
