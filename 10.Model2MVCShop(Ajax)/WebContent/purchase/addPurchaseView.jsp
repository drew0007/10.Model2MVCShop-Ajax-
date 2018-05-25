<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>Insert title here</title>

<script type="text/javascript" src="../javascript/calendar.js">
</script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	function execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var fullAddr = ''; // 최종 주소 변수
	            var extraAddr = ''; // 조합형 주소 변수
	
	            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                fullAddr = data.roadAddress;
	
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                fullAddr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	            if(data.userSelectedType === 'R'){
	                //법정동명이 있을 경우 추가한다.
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있을 경우 추가한다.
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
	            document.getElementById('address').value = fullAddr;
	
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById('address2').focus();
	        }
	    }).open();
	}
	
	function fncAddPurchase() {
		var listSize = ${list.size()};
		var prodNoList = "";
		var tranCntList = "";	
		
		for(i=0; i<listSize; i++){
			prodNoList += $($("input[name=prodNo]")[i]).val() + ",";
			tranCntList += $($("input[name=tranCnt]")[i]).val() + ",";
		}
		
		$("#prodNoList").val(prodNoList);
		$("#tranCntList").val(tranCntList);
		
		$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
	}
	
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
		$("td.ct_btn01:contains('구매')").on("click", function(){
			fncAddPurchase();
		});
		
		$( "td.ct_btn01:contains('취소')" ).on("click" , function() {
			history.go(-1);
		});
	});
	
	$(function(){
		$(".ct_list_pop td:nth-child(3)").on("click", function(){
			var index = $(".ct_list_pop td:nth-child(3)").index(this);
			var val = $($("input[name='prodNo']")[index]).val();
			self.location = "/product/getProduct?prodNo="+val+"&menu=search";
		});
	});
	
	$(function(){
		$("img[name='divyDateImg']").on("click", function(){
			show_calendar('document.detailForm.divyDate', document.detailForm.divyDate.value);
		});
	});
	
	$(function(){
		$("input[id='execPostcode']").on("click", function(){
			execDaumPostcode();
		});
	});
</script>
</head>

<body>

<form name="detailForm">
	
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">상품구매</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="1000" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;" align="center">
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품이미지</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">구매수량</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">구매금액</td>
		</td>	
	</tr>
	<tr>
		<td colspan="9" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="sum" value="0"/>
	<c:set var="i" value="0"/>
	<c:forEach var="cart" items="${list }">
	<c:set var="i" value="${i+1 }"/>
	<c:set var="sum" value="${sum + cart.cartProd.price * cart.cartCnt}"/>
	<tr class="ct_list_pop">
		<td align="center">${i}
			
			<input type="hidden" name="prodNo" id="prodNo" value="${cart.cartProd.prodNo}" />
		</td>
		<td></td>
		<td align="left">
			<%-- <a href="/product/getProduct?prodNo=${cart.cartProd.prodNo}&menu=search">${cart.cartProd.prodName}</a> --%>
			${cart.cartProd.prodName}
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
			${cart.cartCnt}
			<input type="hidden" name="tranCnt" id="tranCnt" value="${cart.cartCnt}"/>
		</td>
		<td></td>
		<td align="right">${cart.cartProd.price * cart.cartCnt} 원</td>
	</tr>
	<tr>
		<td colspan="9" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	</c:forEach>
</table>
<br/>

<table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			구매자아이디 <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.userId}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매방법</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select 	name="paymentOption"		class="ct_input_g" 
							style="width: 100px; height: 23px" maxLength="20">
				<option value="1" selected="selected">현금구매</option>
				<option value="2">신용구매</option>
			</select>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자이름</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="receiverName" 	class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" value="${user.userName}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자연락처</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverPhone" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" value="${user.phone}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자주소</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
<%-- 			<input 	type="text" name="divyAddr" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" 	value="${user.addr}" /> --%>

			<input type="text" id="postcode" name="divyPostcode" placeholder="우편번호" class="ct_input_g" value="${user.postcode}">
			<input type="button" id="execPostcode"  value="우편번호 찾기"><br>
			<input type="text" id="address" name="divyAddress" placeholder="주소" size="50" class="ct_input_g" value="${user.address}">
			<input type="text" id="address2" name="divyAddress2" placeholder="상세주소" class="ct_input_g" value="${user.address2}">
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매요청사항</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input		type="text" name="divyRequest" 	class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">배송희망일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td width="200" class="ct_write01">
			<input 	type="text" readonly="readonly" name="divyDate" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20"/>
			<img name="divyDateImg" src="../images/ct_icon_date.gif" width="15" height="15"	/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			총 주문금액
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01" >${sum} 원</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>
<br/>

<input type="hidden" name="prodNoList" id="prodNoList" value="" />
<input type="hidden" name="tranCntList" id="tranCntList" value="" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<!-- <a href="javascript:fncAddPurchase()">구매</a> -->
						구매
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