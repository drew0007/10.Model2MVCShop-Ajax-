<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="/css/admin.css" type="text/css">
</head>


<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(".ct_list_pop td:nth-child(3)").on("click", function(){
			var index = $(".ct_list_pop td:nth-child(3)").index(this);
			var val = $($("input[name='prodNo']")[index]).val();
			self.location = "/product/getProduct?prodNo="+val+"&menu=search";
		});
	});
</script>

<body>

<form name="addPurchase" method="post">

������ ���� ���Ű� �Ǿ����ϴ�.

<table width="1000" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;" align="center">
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ�̹���</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">���ż���</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">���űݾ�</td>
		</td>	
	</tr>
	<tr>
		<td colspan="9" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="sum" value="0"/>
	<c:set var="i" value="0"/>
	<c:forEach var="purchase" items="${list}">
	<c:set var="i" value="${i+1 }"/>
	<c:set var="sum" value="${sum + purchase.purchaseProd.price * purchase.tranCnt}"/>
	<tr class="ct_list_pop">
		<td align="center">${i}
			<input type="hidden" name="prodNo" id="prodNo" value="${purchase.purchaseProd.prodNo}" />
		</td>
		<td></td>
		<td align="left">
			<%-- <a href="/product/getProduct?prodNo=${purchase.purchaseProd.prodNo}&menu=search"></a> --%>
			${purchase.purchaseProd.prodName}
		</td>
		<td></td>
		<td align="center">
			<c:if test="${!empty purchase.purchaseProd.fileNameList[0]}">
				<img src = "/images/uploadFiles/${purchase.purchaseProd.fileNameList[0]}" width="150"/>
			</c:if>
			<c:if test="${empty purchase.purchaseProd.fileNameList[0]}">
				<img src = "/images/uploadFiles/1298310238.png" width="150"/>
			</c:if>
		</td>
		<td></td>
		<td align="center">
			${purchase.tranCnt}
		</td>
		<td></td>
		<td align="right">${purchase.purchaseProd.price * purchase.tranCnt} ��</td>
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
			�����ھ��̵� <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.userId}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">���Ź��</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			${list[0].paymentOption.equals('1')?"���ݱ���":"�ſ뱸��" }
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������̸�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			${list[0].receiverName}
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�����ڿ���ó</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			${list[0].receiverPhone}
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������ּ�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			(${list[0].divyPostcode}) ${list[0].divyAddress} ${list[0].divyAddress2}
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">���ſ�û����</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			${list[0].divyRequest}
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">����������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td width="200" class="ct_write01">
			${list[0].divyDate}
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			�� �ֹ��ݾ�
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01" >${sum} ��</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>
</form>

</body>
</html>