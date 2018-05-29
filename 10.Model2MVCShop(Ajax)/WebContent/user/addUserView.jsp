<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	
	<title>ȸ������</title>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		
		//=====����Code �ּ� ó�� ��  jQuery ���� ======//
		function fncAddUser() {
			// Form ��ȿ�� ����
			//var id=document.detailForm.userId.value;
			//var pw=document.detailForm.password.value;
			//var pw_confirm=document.detailForm.password2.value;
			//var name=document.detailForm.userName.value;
			
			var id=$("input[name='userId']").val();
			var chk=$("input[name=CheckDuplication]").val();
			var pw=$("input[name='password']").val();
			var pw_confirm=$("input[name='password2']").val();
			var name=$("input[name='userName']").val();
			var email=$("input[name='email']").val();
			
			
			if(id == null || id.length <1){
				alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(chk=="false"){
				alert("�̹� ��ϵ� ���̵� �Դϴ�.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("�н������  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(pw_confirm == null || pw_confirm.length <1){
				alert("�н����� Ȯ����  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(name == null || name.length <1){
				alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}				 
			if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1 
		 			|| email.indexOf('.') == (email.length-1)) ){
		    	alert("�̸��� ������ �ƴմϴ�.");
				return;
		     }
			
			//if(document.detailForm.password.value != document.detailForm.password2.value) {
			if( pw != pw_confirm ) {				
				alert("��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
				//document.detailForm.password2.focus();
				$("input:text[name='password2']").focus();
				return;
			}
				
			//if(document.detailForm.phone2.value != "" && document.detailForm.phone2.value != "") {
			//	document.detailForm.phone.value = document.detailForm.phone1.value + "-" + document.detailForm.phone2.value + "-" + document.detailForm.phone3.value;
			//} else {
			//	document.detailForm.phone.value = "";
			//}
			
			var value = "";	
			if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
				var value = $("option:selected").val() + "-" 
									+ $("input[name='phone2']").val() + "-" 
									+ $("input[name='phone3']").val();
			}
			//Debug..
			//alert("phone : "+value)
			$("input:hidden[name='phone']").val( value );
			
			//document.detailForm.action='/user/addUser';
			//document.detailForm.submit();
			$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
		}
		//===========================================//
		//==> �߰��Ⱥκ� : "����"  Event ����
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			 $( "td.ct_btn01:contains('����')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('����')" ).html() );
				fncAddUser();
			});
		});	
		
		
		/*============= jQuery ���� �ּ�ó�� =============
		function resetData() {
				document.detailForm.reset();
		}========================================	*/
		//==> �߰��Ⱥκ� : "���"  Event ó�� ��  ����
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			 $( "td.ct_btn01:contains('���')" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('���')" ).html() );
					$("form")[0].reset();
			});
		});	
		 

		 /*============= jQuery ���� �ּ�ó�� =============
		function check_email(frm) {
			var email=document.detailForm.email.value;
		    if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)){
		    	alert("�̸��� ������ �ƴմϴ�.");
				return false;
		    }
		    return true;
		}========================================	*/
		//==> �߰��Ⱥκ� : "�̸���" ��ȿ��Check  Event ó�� �� ����
		 /* $(function() {
			 
			 $("input[name='email']").on("change" , function() {
				
				 var email=$("input[name='email']").val();
			    
				 console.log("1 : "+email.indexOf('.'));
				 console.log("2 : "+email.indexOf('@'));
				 console.log("3 : "+email.length);
				 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1 
						 			|| email.indexOf('.') == (email.length-1)) ){
			    	alert("�̸��� ������ �ƴմϴ�.");
			     }
			});
			 
		});	 */
		
	   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	   //==> �ֹι�ȣ ��ȿ�� check �� ����������....
		function checkSsn() {
			var ssn1, ssn2; 
			var nByear, nTyear; 
			var today; 
	
			ssn = document.detailForm.ssn.value;
			// ��ȿ�� �ֹι�ȣ ������ ��츸 ���� ��� ����, PortalJuminCheck �Լ��� CommonScript.js �� ���� �ֹι�ȣ üũ �Լ��� 
			if(!PortalJuminCheck(ssn)) {
				alert("�߸��� �ֹι�ȣ�Դϴ�.");
				return false;
			}
		}
	
		function PortalJuminCheck(fieldValue){
		    var pattern = /^([0-9]{6})-?([0-9]{7})$/; 
			var num = fieldValue;
		    if (!pattern.test(num)) return false; 
		    num = RegExp.$1 + RegExp.$2;
	
			var sum = 0;
			var last = num.charCodeAt(12) - 0x30;
			var bases = "234567892345";
			for (var i=0; i<12; i++) {
				if (isNaN(num.substring(i,i+1))) return false;
				sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
			}
			var mod = sum % 11;
			return ((11 - mod) % 10 == last) ? true : false;
		}
		 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		/*============= jQuery ���� �ּ�ó�� =============
		function fncCheckDuplication() {
			popWin 
				= window.open("/user/checkDuplication.jsp",
											"popWin", 
											"left=300,top=200,width=300,height=200,marginwidth=0,marginheight=0,"+
											"scrollbars=no,scrolling=no,menubar=no,resizable=no");
		}========================================	*/
		//==> �߰��Ⱥκ� : "ID�ߺ�Ȯ��" Event ó�� �� ����
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			 $("td.ct_btn:contains('ID�ߺ�Ȯ��')").on("click" , function() {
				//alert($("td.ct_btn:contains('ID�ߺ�Ȯ��')").html());
				popWin 
				= window.open("/user/checkDuplication.jsp",
											"popWin", 
											"left=300,top=200,width=300,height=200,marginwidth=0,marginheight=0,"+
											"scrollbars=no,scrolling=no,menubar=no,resizable=no");
			});
		});	
		
		$(function(){
			$("input[name=userId]").on("keyup", function(){
				var userId = $("input[name=userId]").val();
				if(userId == ""){
					$("img[name=CheckDuplicationImg]").attr("src", "");
					$("input[name=CheckDuplication]").val("false");
				}else{
					$.ajax(
							{
								url : "/user/json/duplicationUser/"+userId,
								method : "GET",
								dataType : "json",
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
							success : function(JSONData , status){
								var check = JSONData;
								
								if(check){
									$("img[name=CheckDuplicationImg]").attr("src", "/images/uploadFiles/duplication_o.png");
									$("input[name=CheckDuplication]").val("true");
								}else{
									$("img[name=CheckDuplicationImg]").attr("src", "/images/uploadFiles/duplication_x.png");
									$("input[name=CheckDuplication]").val("false");
								}
							}
						});
				}
			});
		});
		
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
			$("input[id='execPostcode']").on("click", function(){
				execDaumPostcode();
			});
		});

	</script>		
	
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- ////////////////// jQuery Event ó���� ����� ///////////////////////// 
<form name="detailForm"  method="post" >
////////////////////////////////////////////////////////////////////////////////////////////////// -->
<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">ȸ������</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<input 	type="hidden" name="type" class="ct_input_bg" value="${type}">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:13px;">
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<c:if test="${empty userId2}">
		<tr>
			<td width="104" class="ct_write">
				���̵� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="105">
							<input 	type="text" name="userId" class="ct_input_bg" 
											style="width:100px; height:19px"  maxLength="20" >
						</td>					
						<td style="padding-top:5px;">
							<img name="CheckDuplicationImg" src="" width="15">
							<input type="hidden" name="CheckDuplication" value="false">
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
				��й�ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">
				<input 	type="password" name="password" class="ct_input_g" 
								style="width:100px; height:19px"  maxLength="10" minLength="6"  />
			</td>
		</tr>
		
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		
		<tr>
			<td width="104" class="ct_write">
				��й�ȣ Ȯ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">
				<input 	type="password" name="password2" class="ct_input_g" 
								style="width:100px; height:19px"  maxLength="10" minLength="6" />
			</td>
		</tr>
		
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
	</c:if>
	<c:if test="${!empty userId2}">
		<input 	type="hidden" name="userId" class="ct_input_bg" value="${userId2}">
		<input 	type="hidden" name="password" class="ct_input_g" value="${userId2}"/>
		<input 	type="hidden" name="password2" class="ct_input_g" value="${userId2}"/>
	</c:if>
	
	<tr>
		<td width="104" class="ct_write">
			�̸� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="userName" class="ct_input_g" 
							style="width:100px; height:19px"  maxLength="50" 
							value="${user.userName}"/>
		</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">�ֹι�ȣ</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="ssn" class="ct_input_g" style="width:100px; height:19px" 
							onChange="javascript:checkSsn();"  maxLength="13" />
			-����, 13�ڸ� �Է�
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">�ּ�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<!-- <input		type="text" name="addr" class="ct_input_g" 
						 	style="width:370px; height:19px"  maxLength="100"/> -->
			<input type="text" id="postcode" name="postcode" placeholder="�����ȣ" class="ct_input_g" style="height:19px">
			<input type="button" id="execPostcode"  value="�����ȣ ã��"><br>
			<input type="text" id="address" name="address" placeholder="�ּ�" size="50" class="ct_input_g" style="height:19px">
			<input type="text" id="address2" name="address2" placeholder="���ּ�" class="ct_input_g" style="height:19px">
		</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">�޴���ȭ��ȣ</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select 	name="phone1" class="ct_input_g" style="width:50px; height:25px"
							onChange="document.detailForm.phone2.focus();">
				<option value="010" >010</option>
				<option value="011" >011</option>
				<option value="016" >016</option>
				<option value="018" >018</option>
				<option value="019" >019</option>
			</select>
			<input 	type="text" name="phone2" class="ct_input_g" 
							style="width:100px; height:19px"  maxLength="9" />
			- 
			<input 	type="text" name="phone3" class="ct_input_g" 
							style="width:100px; height:19px"  maxLength="9" />
			<input type="hidden" name="phone" class="ct_input_g"  />
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">�̸��� </td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="26">
						<!-- ////////////////// jQuery Event ó���� ����� ///////////////////////// 
						<input 	type="text" name="email" class="ct_input_g" 
										style="width:100px; height:19px" onChange="check_email(this.form);" />
						 ////////////////////////////////////////////////////////////////////////////////////////////////// -->
 						<input 	type="text" name="email" class="ct_input_g" 
										style="width:200px; height:19px" 
										value="${user.email }"/>										
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td width="53%">	</td>

		<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- ////////////////// jQuery Event ó���� ����� ///////////////////////// 
						<a href="javascript:fncAddUser();">����</a>
						 ////////////////////////////////////////////////////////////////////////////////////////////////// -->
						����
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
					<td width="30"></td>					
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- ////////////////// jQuery Event ó���� ����� ///////////////////////// 
						<a href="javascript:resetData();">���</a>
						 ////////////////////////////////////////////////////////////////////////////////////////////////// -->
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