<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	
	<title>회원가입</title>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		
		//=====기존Code 주석 처리 후  jQuery 변경 ======//
		function fncAddUser() {
			// Form 유효성 검증
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
				alert("아이디는 반드시 입력하셔야 합니다.");
				return;
			}
			if(chk=="false"){
				alert("이미 등록된 아이디 입니다.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("패스워드는  반드시 입력하셔야 합니다.");
				return;
			}
			if(pw_confirm == null || pw_confirm.length <1){
				alert("패스워드 확인은  반드시 입력하셔야 합니다.");
				return;
			}
			if(name == null || name.length <1){
				alert("이름은  반드시 입력하셔야 합니다.");
				return;
			}				 
			if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1 
		 			|| email.indexOf('.') == (email.length-1)) ){
		    	alert("이메일 형식이 아닙니다.");
				return;
		     }
			
			//if(document.detailForm.password.value != document.detailForm.password2.value) {
			if( pw != pw_confirm ) {				
				alert("비밀번호 확인이 일치하지 않습니다.");
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
		//==> 추가된부분 : "가입"  Event 연결
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			 $( "td.ct_btn01:contains('가입')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('가입')" ).html() );
				fncAddUser();
			});
		});	
		
		
		/*============= jQuery 변경 주석처리 =============
		function resetData() {
				document.detailForm.reset();
		}========================================	*/
		//==> 추가된부분 : "취소"  Event 처리 및  연결
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			 $( "td.ct_btn01:contains('취소')" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('취소')" ).html() );
					$("form")[0].reset();
			});
		});	
		 

		 /*============= jQuery 변경 주석처리 =============
		function check_email(frm) {
			var email=document.detailForm.email.value;
		    if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)){
		    	alert("이메일 형식이 아닙니다.");
				return false;
		    }
		    return true;
		}========================================	*/
		//==> 추가된부분 : "이메일" 유효성Check  Event 처리 및 연결
		 /* $(function() {
			 
			 $("input[name='email']").on("change" , function() {
				
				 var email=$("input[name='email']").val();
			    
				 console.log("1 : "+email.indexOf('.'));
				 console.log("2 : "+email.indexOf('@'));
				 console.log("3 : "+email.length);
				 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1 
						 			|| email.indexOf('.') == (email.length-1)) ){
			    	alert("이메일 형식이 아닙니다.");
			     }
			});
			 
		});	 */
		
	   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	   //==> 주민번호 유효성 check 는 이해정도로....
		function checkSsn() {
			var ssn1, ssn2; 
			var nByear, nTyear; 
			var today; 
	
			ssn = document.detailForm.ssn.value;
			// 유효한 주민번호 형식인 경우만 나이 계산 진행, PortalJuminCheck 함수는 CommonScript.js 의 공통 주민번호 체크 함수임 
			if(!PortalJuminCheck(ssn)) {
				alert("잘못된 주민번호입니다.");
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
	
		/*============= jQuery 변경 주석처리 =============
		function fncCheckDuplication() {
			popWin 
				= window.open("/user/checkDuplication.jsp",
											"popWin", 
											"left=300,top=200,width=300,height=200,marginwidth=0,marginheight=0,"+
											"scrollbars=no,scrolling=no,menubar=no,resizable=no");
		}========================================	*/
		//==> 추가된부분 : "ID중복확인" Event 처리 및 연결
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			 $("td.ct_btn:contains('ID중복확인')").on("click" , function() {
				//alert($("td.ct_btn:contains('ID중복확인')").html());
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
		
		$(function(){
			$("input[id='execPostcode']").on("click", function(){
				execDaumPostcode();
			});
		});

	</script>		
	
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- ////////////////// jQuery Event 처리로 변경됨 ///////////////////////// 
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
					<td width="93%" class="ct_ttl01">회원가입</td>
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
				아이디 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
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
				비밀번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
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
				비밀번호 확인 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
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
			이름 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
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
		<td width="104" class="ct_write">주민번호</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="ssn" class="ct_input_g" style="width:100px; height:19px" 
							onChange="javascript:checkSsn();"  maxLength="13" />
			-제외, 13자리 입력
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">주소</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<!-- <input		type="text" name="addr" class="ct_input_g" 
						 	style="width:370px; height:19px"  maxLength="100"/> -->
			<input type="text" id="postcode" name="postcode" placeholder="우편번호" class="ct_input_g" style="height:19px">
			<input type="button" id="execPostcode"  value="우편번호 찾기"><br>
			<input type="text" id="address" name="address" placeholder="주소" size="50" class="ct_input_g" style="height:19px">
			<input type="text" id="address2" name="address2" placeholder="상세주소" class="ct_input_g" style="height:19px">
		</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">휴대전화번호</td>
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
		<td width="104" class="ct_write">이메일 </td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="26">
						<!-- ////////////////// jQuery Event 처리로 변경됨 ///////////////////////// 
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
						<!-- ////////////////// jQuery Event 처리로 변경됨 ///////////////////////// 
						<a href="javascript:fncAddUser();">가입</a>
						 ////////////////////////////////////////////////////////////////////////////////////////////////// -->
						가입
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
					<td width="30"></td>					
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- ////////////////// jQuery Event 처리로 변경됨 ///////////////////////// 
						<a href="javascript:resetData();">취소</a>
						 ////////////////////////////////////////////////////////////////////////////////////////////////// -->
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