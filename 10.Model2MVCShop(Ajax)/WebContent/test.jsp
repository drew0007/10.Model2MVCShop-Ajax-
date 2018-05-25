<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page contentType="text/html; charset=EUC-KR" %>

<html>
<head>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(function(){
		var userId2 = "na@"+${map.id};
		var type = "na";

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
							//$(opener.parent.frames["topFrame"].document.location).attr("href","/layout/top.jsp");
							//$(opener.parent.frames["leftFrame"].document.location).attr("href","/layout/left.jsp");
							//$(opener.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId="+JSONData.userId);
							
							login(JSONData.userId, JSONData.password);
							
						}else{
							$("form").attr("method","GET").attr("action","/user/addUser2").attr("target","rightFrame").submit();
							window.close();
						}
					}
			});
	});
	
	function login(id, password){
		
		$.ajax( 
				{
					url : "/user/json/login/"+id+"/"+password ,
					method : "GET" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData , status) {
						$(opener.parent.document.location).attr("href","/index.jsp");
						window.close();
					}
			});
	}
</script>

</head>
<form>
<body>
<input type="hidden" name="birthday" value="${map.birthday}"><br/>
<input type="hidden" name="gender" value="${map.gender}"><br/>
<input type="hidden" name="userName" value="${map.name}"><br/>
<input type="hidden" name="userId2" value="na@${map.id}"><br/>
<input type="hidden" name="age" value="${map.age}"><br/>
<input type="hidden" name="email" value="${map.email}"><br/>
<input type="hidden" name="type" value="na"><br/>
</body>
</form>
</html>