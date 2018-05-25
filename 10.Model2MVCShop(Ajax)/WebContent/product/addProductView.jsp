<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>��ǰ���</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<script type="text/javascript" src="../javascript/calendar.js">
</script>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	
	function fncAddProduct(){
		//Form ��ȿ�� ����
		var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
		var cnt = $("input[name='prodCnt']").val();
	
		if(name == null || name.length<1){
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(detail == null || detail.length<1){
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(price == null || price.length<1){
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(cnt == null || cnt.length<1){
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}

		$("form").attr("method" , "POST").attr("action" , "/product/addProduct").submit();
	}
	
	$(function() {
		$( "td.ct_btn01:contains('Ȯ��')" ).on("click" , function() {
			$("form").attr("method" , "GET").attr("action" , "/product/listProduct?menu=manage").submit();
		});

		$( "td.ct_btn01:contains('�߰����')" ).on("click" , function() {
			$("form").attr("method" , "GET").attr("action" , "/product/addProductView.jsp").submit();
		});
		
		$( "td.ct_btn01:contains('���')" ).on("click" , function() {
			fncAddProduct();
		});
		 
		$( "td.ct_btn01:contains('���')" ).on("click" , function() {
			$("form")[0].reset();
		});
	});	
	
	$(function(){
		$("img[name='manuDateImg']").on("click", function(){
			show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value);
		});
	});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="detailForm" enctype="multipart/form-data">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">��ǰ���</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif"	width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ�� <imgsrc="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">
					<c:if test="${!empty product }">
						${product.prodName}
					</c:if>
					<c:if test="${empty product }">
						<input type="text" name="prodName" class="ct_input_g" 
									style="width: 100px; height: 19px" maxLength="20">
					</c:if>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ������ <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<c:if test="${!empty product }">
				${product.prodDetail}
			</c:if>
			<c:if test="${empty product }">
				<input type="text" name="prodDetail" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
			</c:if>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			�������� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<c:if test="${!empty product }">
				${product.manuDate}
			</c:if>
			<c:if test="${empty product }">
				<input type="text" name="manuDate" readonly="readonly" class="ct_input_g"  
							style="width: 100px; height: 19px"	maxLength="10" minLength="6"/>
					&nbsp;<img name="manuDateImg" src="../images/ct_icon_date.gif" width="15" height="15"/>
			</c:if>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			���� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<c:if test="${!empty product }">
				${product.price}&nbsp;��
			</c:if>
			<c:if test="${empty product }">
				<input type="text" name="price" 	class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="10">&nbsp;��
			</c:if>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			���� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<c:if test="${!empty product }">
				${product.prodCnt}
			</c:if>
			<c:if test="${empty product }">
				<input type="text" name="prodCnt" 	class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="5">
			</c:if>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">��ǰ�̹���</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<c:if test="${!empty product }">
				<c:forEach var="file" items="${product.fileNameList}">
					<c:if test="${!empty file}">
						<img src = "/images/uploadFiles/${file}" width="300"/>
					</c:if>
				</c:forEach>
			</c:if>
			<c:if test="${empty product }">
				<input		type="file" name="file" class="ct_input_g" multiple="multiple"
								style="width: 200px; height: 19px"/>
			</c:if>
		</td>
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
			<c:if test="${!empty product }">
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"  style="padding-top: 3px;">
					<!-- <a href="/product/listProduct?menu=manage">Ȯ��</a> -->
					Ȯ��
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
				<td width="30"></td>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"	 style="padding-top: 3px;">
					<!-- <a href="/product/addProductView.jsp">�߰����</a> -->
					�߰����
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
			</c:if>
			<c:if test="${empty product }">
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"  style="padding-top: 3px;">
					<!-- <a href="javascript:fncAddProduct();">���</a> -->
					���
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
				<td width="30"></td>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"	 style="padding-top: 3px;">
					<!-- <a href="javascript:resetData();">���</a> -->
					���
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
			</c:if>			
			</tr>
		</table>
		</td>
	</tr>
</table>

</form>
</body>
</html>