package com.model2.mvc.web.user;

import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}

	@RequestMapping( value="json/login/{userId}/{password}", method=RequestMethod.GET )
	public User login2(	@PathVariable String userId,
						@PathVariable String password,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+userId);
		User dbUser=userService.getUser(userId);
		
		if( password.equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}

	//회원가입시 id 중복체크
	@RequestMapping( value="json/duplicationUser/{userId}", method=RequestMethod.GET )
	public boolean duplicationUser(@PathVariable String userId) throws Exception{
		
		System.out.println(userId);
		
		boolean check = false;
		if(!userId.equals("")) {
			check = userService.checkDuplication(userId);
		}
		
		return check;
	}
	
	//유저 리스트에서 검색창 Autocomplete
	@RequestMapping( value="json/autocompleteUser", method=RequestMethod.GET)
	public List<User> autocompleteUser() throws Exception{
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(100);
		
		Map<String, Object> map = userService.getUserList(search);
		List<User> list = (List<User>)map.get("list");
		
		return list;
	}
	
	//카카오, 네이버 아이디 가입 체크
	@RequestMapping( value="json/checkUser/{userId2}/{type}", method=RequestMethod.GET)
	public User checkUser(@PathVariable String userId2,
							@PathVariable String type,
							HttpSession session) throws Exception{
		System.out.println("checkUser => "+userId2+" : "+type);
		User user = userService.checkUser(userId2, type);
		if(user == null) {
			user = new User();
		}
		
		return user;
	}
	
	//카카오 계정 연동
	@RequestMapping( value="json/updateUserId/{userId}/{userId2}/{type}", method=RequestMethod.GET)
	public User updateUserId(@PathVariable String userId,
							@PathVariable String userId2,
							@PathVariable String type) throws Exception{
		System.out.println("updateUserId => "+userId+" : "+userId2+" : "+type);

		userService.updateUserId(userId, userId2, type);
		User user = userService.getUser(userId);
		
		return user;
	}
	
	//네이버 로그인창 호출
	@RequestMapping( value="json/loginWithNaver", method=RequestMethod.GET)
	public JSONObject loginWithNaver() throws Exception{ 
	    String clientId = "Tj5gWPI0ucoEYjJpkdWc";//애플리케이션 클라이언트 아이디값";
	    String redirectURI = URLEncoder.encode("http://localhost:8080/user/loginWithNaver", "UTF-8");
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&state=" + state;
	    //session.setAttribute("state", state);
	    JSONObject jsonobj = new JSONObject();
	    jsonobj.put("apiURL", apiURL);
	    System.out.println("jsonobj : "+jsonobj);
	    
		return jsonobj;
	}
	
	//메일
	@RequestMapping( value="json/sendMail/{userId}/{email}/{emailCode}", method=RequestMethod.GET)
	public boolean mailTest(@PathVariable String userId,
							@PathVariable String email,
							@PathVariable String emailCode) throws Exception{
		boolean check = false;
		String host = "smtp.naver.com";
		String user = "drew00077@naver.com";
		String password = "apdlfxptmxm";	
		String receiveMail = email;
		String code = emailCode;
		String nextUrl="http://localhost:8080/user/checkUserMail?user="+userId+
						"&code="+emailCode;
		
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.auth", true);
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() { 
			protected PasswordAuthentication getPasswordAuthentication() { 
				return new PasswordAuthentication(user, password); 
			} 
		});
		
		try { 
			MimeMessage message = new MimeMessage(session); 
			message.setFrom(new InternetAddress(user)); 
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiveMail));
			message.setSubject("가입 인증 메일입니다."); // 메일 제목 
			//message.setText("갔냐?"); // send the message 
			
			//////////////////////////////////////////////////////////////////
			Multipart mp = new MimeMultipart();
			MimeBodyPart mbp0 = new MimeBodyPart();

			//mbp0.setText("http://localhost:8080/user/checkUserMail?user=user01&code="+code); // send the message 
			mbp0.setContent("회원가입을 축하합니다.<br>이메일 인증을 위해 아래 링크를 클릭해 주세요.<br><br><a href="+nextUrl+
					" target=\"_self\" style=\"cursor: pointer; white-space: pre;\">인증확인</a>", "text/html;charset=euc-kr");
			
			mp.addBodyPart(mbp0);
			
			/*
			String fileName = "C:\\Users\\leesunghee\\Desktop\\image\\f123gdf1df5g1.jpg";
			
			if(fileName != null) {
				MimeBodyPart mbp2 = new MimeBodyPart();
				FileDataSource fds = new FileDataSource(fileName);
				
				mbp2.setDataHandler(new DataHandler(fds));
				mbp2.setFileName(MimeUtility.encodeText(fds.getName(), "UTF-8", "B"));
				mp.addBodyPart(mbp2);
			}
			*/
			
			message.setContent(mp, "text/html;charset=euc-kr");
			///////////////////////////////////////////////////////////////////
			
			Transport.send(message); 
			System.out.println("Success Message Send"); 
			check = true;
		} catch (MessagingException e) { 
			e.printStackTrace();
		}


		return check;
	}
	
	@RequestMapping( value="json/checkUserStatus/{userId}", method=RequestMethod.GET)
	public String checkUserStatus(@PathVariable String userId) throws Exception{
		String status = "";
		User user = userService.getUser(userId);
		status = user.getUserStatusCode();		
		
		return status;
	}
	
}