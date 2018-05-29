<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>ȸ��������ȸ</title>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script type="text/javascript">
		
		//==> �߰��Ⱥκ� : "����" "Ȯ��"  Event ���� �� ó��
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			 $( "td.ct_btn01:contains('Ȯ��')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('Ȯ��')" ).html() );
				history.go(-1);
			});
			
			 $( "td.ct_btn01:contains('����')" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('����')" ).html() );
					self.location = "/user/updateUser?userId=${user.userId}"
				});
		});
		
		$(function(){
			$("td.ct_btn01:contains('īī�� ���� ����')").on("click" , function() {
				loginWithKakao();
			});
		});

		$(function(){
			$("td.ct_btn01:contains('���̹� ���� ����')").on("click" , function() {
				loginWithNaver();
			});
		});
		
		Kakao.init('1d3fddc61b788ab458254eb1f4ea00ae');
	    function loginWithKakao() {
	      // �α��� â�� ���ϴ�.
	      Kakao.Auth.login({
	        success: function(authObj) {
	            // �α��� ������, API�� ȣ���մϴ�.
	            Kakao.API.request({
	              url: '/v1/user/me',
	              success: function(res) {
	                //alert(JSON.stringify(res));
	                //alert(res.properties.nickname);
	                //alert(res.id+"_kakao");
	                checkUser("ka@"+res.id, "ka");
	              },
	              fail: function(error) {
	                alert(JSON.stringify(error));
	              }
	            });
	          },
	          fail: function(err) {
	            alert(JSON.stringify(err));
	          }
	      });
	    };
	    
	    function loginWithNaver(){
	    	alert("���̹� ���� ���� ��� ���� ��");
	    }
	    
	    function checkUser(userId2, type){
			
	    	$.ajax( 
					{
						url : "/user/json/checkUser/"+userId2+"/"+type ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							if(JSONData.userId != null){
								alert("�̹� ���Ե� �����Դϴ�.");
							}else{
								updateUserId(userId2,type);
							}
						}
				});
	    }
	    
	    function updateUserId(userId2,type){
	    	$.ajax( 
					{
						url : "/user/json/updateUserId/${user.userId}/"+userId2+"/"+type ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							alert("��������");
							console.log(JSONData);
							$("td.ct_btn01:contains('īī�� ���� ����')").attr("hidden","hidden");
						}
				});
	    }
	    
	    $(function(){
	    	$("#sendMail").on("click", function(){
	    		var userId = "${user.userId}";
	    		var email = "${user.email}";
	    		var emailCode = "${user.emailCode}";
	    		
	    		$.ajax( 
						{
							url : "/user/json/checkUserStatus/"+userId ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								var status = JSONData;
								console.log(status);
								if(status == "3"){
									sendMail(userId, email, emailCode);
								}else{
									alert("�̹� ������ �Ϸ�Ǿ����ϴ�.");
									self.location = "/user/getUser?userId=${user.userId}";
								}
							}
					});
	    	});
	    });
	    
	    function sendMail(userId, email, emailCode){
	    	$.ajax( 
					{
						url : "/user/json/sendMail/"+userId+"/"+email+"/"+emailCode ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							var check = JSONData;
							if(check){
					    		alert("���� ���� �Ϸ�");
							}else{
					    		alert("���� ���� ����");
							}
						}
				});
	    }
		
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif" width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">ȸ��������ȸ</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:13px;">
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">
			���̵� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.userId}</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">
			�̸� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.userName}</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">�ּ�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">(${user.postcode}) ${user.address} ${user.address2}</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">�޴���ȭ��ȣ</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${ !empty user.phone ? user.phone : ''}	</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">
			�̸��� 
			<span style="color:red">${user.userStatusCode.equals('3')?'(������)':'' }</span>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			${user.email} 
			<input type="${user.userStatusCode.equals('3')?'button':'hidden' }" id="sendMail" value="�������� ��߼�">
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">��������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.regDate}</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<c:if test="${empty user.userIdKakao }">
						<td width="120" class="ct_btn01">
							 īī�� ���� ����
						</td>
					</c:if>
					<c:if test="${empty user.userIdNaver }">
						<td width="120" class="ct_btn01">
							 ���̹� ���� ����
						</td>
					</c:if>
					<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- ////////////////// jQuery Event ó���� ����� ///////////////////////// 
						<a href="/user/updateUser?userId=${user.userId}">����</a>
						 ////////////////////////////////////////////////////////////////////////////////////////////////// -->
						 ����
					</td>
					<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
					<td width="30"></td>					
					<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- ////////////////// jQuery Event ó���� ����� ///////////////////////// 
						<a href="javascript:history.go(-1);">Ȯ��</a>
						 ////////////////////////////////////////////////////////////////////////////////////////////////// -->
						Ȯ��
					</td>
					<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</body>

</html>