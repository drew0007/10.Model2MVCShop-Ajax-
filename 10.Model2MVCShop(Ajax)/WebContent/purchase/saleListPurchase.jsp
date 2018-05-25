<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">


<html>
<head>
<title>�Ǹ� �̷���ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	function fncListPage(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method","POST").attr("action","/purchase/historyPurchase").submit();
	}
	
	$(function(){
		$(".ct_list_pop td:nth-child(3)").on("click", function(){
			var index = $(".ct_list_pop td:nth-child(3)").index(this);
			var tranNo = $($("input[name='tranNoList']")[index]).val();
			self.location="/purchase/getPurchase?tranNo="+tranNo;
		});
		
		$(".ct_list_pop td:nth-child(25)").on("click", function(){
			var index = $(".ct_list_pop td:nth-child(25)").index(this);
			var prodNo = $($("input[name='prodNoList']")[index]).val();
			var tranNo = $($("input[name='tranNoList']")[index]).val();
			var tranCnt = $($("input[name='tranCntList']")[index]).val();
			var text = $($(".ct_list_pop td:nth-child(25)")[index]).text().trim();
			if(text == "����ϱ�"){
				self.location="/purchase/updateTranCode?tranNo="+tranNo+"&tranCnt="+tranCnt+"&tranCode=2&prodNo="+prodNo;
			}else if(text == "�������"){
				self.location="/purchase/updateTranCode?tranNo="+tranNo+"&tranCnt="+tranCnt+"&tranCode=5&prodNo="+prodNo;
			}
		});
	});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form>

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">�Ǹ� �̷���ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<input type="hidden" id="prodNo" name="prodNo" value="0"/>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="23">��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="50">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="70">�ֹ���ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="80">���̵�</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="70">�̸�</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="120">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="250">�ּ�</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="50">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">���Ź��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">�ֹ��Ͻ�</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">����������</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">���ſ�û����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="120">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="80"></td>
	</tr>
	<tr>
		<td colspan="25" bgcolor="808285" height="1"></td>
	</tr>

	
	<c:set var="i" value="0"/>
	<c:forEach var="purchase" items="${list }">
	<c:set var="i" value="${i+1 }"/>
	<tr class="ct_list_pop">
		<td align="center">${i}</td>
		<td></td>
		<td align="center">
			${purchase.tranNo}
			<input type="hidden" name="tranNoList" value="${purchase.tranNo}">
			<input type="hidden" name="prodNoList" value="${purchase.purchaseProd.prodNo}">
		</td>
		<td></td>
		<td align="center">${purchase.buyer.userId}</td>
		<td></td>
		<td align="center">${purchase.receiverName}</td>
		<td></td>
		<td align="center">${purchase.receiverPhone}</td>
		<td></td>
		<td align="left">(${purchase.divyPostcode}) ${purchase.divyAddress} ${purchase.divyAddress2}</td>
		<td></td>
		<td align="center">
			${purchase.tranCnt}
			<input type="hidden" name="tranCntList" value="${purchase.tranCnt}">
		</td>
		<td></td>
		<td align="center">${purchase.paymentOption.equals('1')?"���ݱ���":"�ſ뱸��"}</td>
		<td></td>
		<td align="center">${purchase.orderDate}</td>
		<td></td>
		<td align="center">${purchase.divyDate}</td>
		<td></td>
		<td align="center">${purchase.divyRequest}</td>
		<td></td>
		<td align="center">
		${purchase.tranCode.equals('1')?"���ſϷ�":purchase.tranCode.equals('2')?"�����":purchase.tranCode.equals('3')?"��ۿϷ�":purchase.tranCode.equals('4')?"������ҿ�û":purchase.tranCode.equals('5')?"�������":"" }
		 ����
		</td>
		<td></td>
		<td align="center">
			${purchase.tranCode.equals('1')?"����ϱ�":purchase.tranCode.equals('4')?"�������":"" }
		</td>
	</tr>
	<tr>
		<td colspan="25" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			
		<input type="hidden" id="currentPage" name="currentPage" value=""/>
			
			<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>