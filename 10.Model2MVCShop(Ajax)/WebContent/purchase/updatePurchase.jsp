<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>�������� ����</title>

<script type="text/javascript" src="../javascript/calendar.js">
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script>
	function execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.
	
	            // �� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
	            // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
	            var fullAddr = ''; // ���� �ּ� ����
	            var extraAddr = ''; // ������ �ּ� ����
	
	            // ����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
	            if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
	                fullAddr = data.roadAddress;
	
	            } else { // ����ڰ� ���� �ּҸ� �������� ���(J)
	                fullAddr = data.jibunAddress;
	            }
	
	            // ����ڰ� ������ �ּҰ� ���θ� Ÿ���϶� �����Ѵ�.
	            if(data.userSelectedType === 'R'){
	                //���������� ���� ��� �߰��Ѵ�.
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                // �ǹ����� ���� ��� �߰��Ѵ�.
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // �������ּ��� ������ ���� ���ʿ� ��ȣ�� �߰��Ͽ� ���� �ּҸ� �����.
	                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	            }
	
	            // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
	            document.getElementById('postcode').value = data.zonecode; //5�ڸ� �������ȣ ���
	            document.getElementById('address').value = fullAddr;
	
	            // Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
	            document.getElementById('address2').focus();
	        }
	    }).open();
	}
	
	$(function(){
		$(".ct_list_pop td:nth-child(3)").on("click", function(){
			var index = $(".ct_list_pop td:nth-child(3)").index(this);
			var prodNo = $($("input[name='prodNoList']")[index]).val();
			self.location="/product/getProduct?prodNo="+prodNo+"&menu=search";
		});
		
		${purchase.purchaseProd.prodNo}
		$("td:contains('����')").on("click", function(){
			$("form").attr("method","POST").attr("action","/purchase/updatePurchase?tranNo=${list[0].tranNo}").submit();
		});
		
		$("td:contains('���')").on("click", function(){
			history.go(-1);
		});
	});
	
	$(function(){
		$("img[name='divyDateImg']").on("click", function(){
			show_calendar('document.updatePurchase.divyDate', document.updatePurchase.divyDate.value);
		});
	});
	
	$(function(){
		$("input[id='execPostcode']").on("click", function(){
			execDaumPostcode();
		});
	});
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<form name="updatePurchase">

<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif"  width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">������������</td>
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
		</td>
		<td></td>
		<td align="left">
			${purchase.purchaseProd.prodName}
			<input type="hidden" name="prodNoList" value="${purchase.purchaseProd.prodNo}">
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
		<td width="104" class="ct_write">�����ھ��̵�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			${list[0].buyer.userId}
			<input type="hidden" name="buyerId" value="${list[0].buyer.userId}">
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">���Ź��</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select name="paymentOption" class="ct_input_g" style="width: 100px; height: 23px" maxLength="20">
				<option value="1" ${list[0].paymentOption.equals("1")?"selected":""}>���ݱ���</option>
				<option value="2" ${list[0].paymentOption.equals("2")?"selected":""}>�ſ뱸��</option>
			</select>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������̸�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverName" 	class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${list[0].receiverName}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">������ ����ó</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverPhone" class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${list[0].receiverPhone}" />
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������ּ�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
<%-- 			<input 	type="text" name="divyAddr" class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${list[0].divyAddr}" /> --%>
							
			<input type="text" id="postcode" name="divyPostcode" placeholder="�����ȣ" class="ct_input_g" value="${list[0].divyPostcode}">
			<input type="button" id="execPostcode"  value="�����ȣ ã��"><br>
			<input type="text" id="address" name="divyAddress" placeholder="�ּ�" size="50" class="ct_input_g" value="${list[0].divyAddress}">
			<input type="text" id="address2" name="divyAddress2" placeholder="���ּ�" class="ct_input_g" value="${list[0].divyAddress2}">
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">���ſ�û����</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="divyRequest" 	class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${list[0].divyRequest}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">����������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td width="200" class="ct_write01">
			<input type="text" readonly="readonly" name="divyDate" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20"/>
				<img 	src="../images/ct_icon_date.gif" width="15" height="15"	name="divyDateImg"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
					����
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
				<td width="30"></td>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					���
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