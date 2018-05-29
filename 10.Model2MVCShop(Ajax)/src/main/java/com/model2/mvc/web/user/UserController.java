package com.model2.mvc.web.user;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 Controller
@Controller
@RequestMapping("/user/*")
public class UserController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
		
	public UserController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	//@RequestMapping("/addUserView.do")
	//public String addUserView() throws Exception {
	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUser() throws Exception{
	
		System.out.println("/user/addUser : GET");
		
		return "redirect:/user/addUserView.jsp";
	}
	
	//@RequestMapping("/addUser.do")
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("user") User user,
							@RequestParam("type") String type) throws Exception {

		System.out.println("/user/addUser : POST");
		//Business Logic
		System.out.println("type : "+type);
		
		Random random = new Random();
		StringBuffer sb = new StringBuffer();
		int num = 0;
		int size = 20;
		
		do {
			num = random.nextInt(75)+48;
			
			//숫자 , 대문자 , 소문자
			if((num>=48 && num<=57) || (num>=65 && num<=90) || (num>=97 && num<=122)) {
				sb.append((char)num);
			}else {
				continue;
			}
		}while(sb.length() < size);
		
		if(type.equals("ka")) {
			user.setUserIdKakao(user.getUserId());
			user.setUserStatusCode("1");
		}else if(type.equals("na")) {
			user.setUserIdNaver(user.getUserId());
			user.setUserStatusCode("1");
		}else {
			user.setUserStatusCode("3");
			user.setEmailCode(sb.toString());
		}
		
		userService.addUser(user);
		
		return "redirect:/user/loginView.jsp";
	}
	
	//@RequestMapping("/getUser.do")
	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {
		
		System.out.println("/user/getUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model 과 View 연결
		model.addAttribute("user", user);
		
		return "forward:/user/getUser.jsp";
	}
	
	//@RequestMapping("/updateUserView.do")
	//public String updateUserView( @RequestParam("userId") String userId , Model model ) throws Exception{
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/updateUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model 과 View 연결
		model.addAttribute("user", user);
		
		return "forward:/user/updateUser.jsp";
	}
	
	//@RequestMapping("/updateUser.do")
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user , Model model , HttpSession session) throws Exception{

		System.out.println("/user/updateUser : POST");
		//Business Logic
		userService.updateUser(user);
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
		
		//return "redirect:/getUser.do?userId="+user.getUserId();
		return "redirect:/user/getUser?userId="+user.getUserId();
	}
	
	//@RequestMapping("/loginView.do")
	//public String loginView() throws Exception{
	@RequestMapping( value="login", method=RequestMethod.GET )
	public String login() throws Exception{
		
		System.out.println("/user/logon : GET");

		return "redirect:/user/loginView.jsp";
	}
	
	//@RequestMapping("/login.do")
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user , HttpSession session ) throws Exception{
		
		System.out.println("/user/login : POST");
		//Business Logic
		System.out.println("userId : "+user.getUserId());
		System.out.println("getPassword : "+user.getPassword());
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return "redirect:/index.jsp";
	}
	
	//@RequestMapping("/logout.do")
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{
		
		System.out.println("/user/logout : POST");
		
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
	/*
	//@RequestMapping("/checkDuplication.do")
	@RequestMapping( value="checkDuplication", method=RequestMethod.POST )
	public String checkDuplication( @RequestParam("userId") String userId , Model model ) throws Exception{
		
		System.out.println("/user/checkDuplication : POST");
		//Business Logic
		boolean result=userService.checkDuplication(userId);
		// Model 과 View 연결
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);

		return "forward:/user/checkDuplication.jsp";
	}*/
	
	//@RequestMapping("/listUser.do")
	@RequestMapping( value="listUser" )
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/user/listUser.jsp";
	}
	
	@RequestMapping( value="duplicationUser" )
	public String duplicationUser(@ModelAttribute("user") User user, Model model) throws Exception{
		
		System.out.println(user);
		
		boolean check = false;
		if(!user.getUserId().equals("")) {
			check = userService.checkDuplication(user.getUserId());
		}
		model.addAttribute("check", check);
		
		return "/user/addUserView.jsp";
	}
	
	//카카오, 네이버 로그인시 가입 안되어있으면 회원가입으로 이동
	@RequestMapping( value="addUser2", method=RequestMethod.GET )
	public String addUser2( @RequestParam("userId2") String userId2 , 
							@RequestParam("type") String type,
							@ModelAttribute("user") User user, Model model ) throws Exception{

		System.out.println("/user/addUser : GET");
		System.out.println("userId2 : "+userId2);
		System.out.println("type : "+type);
		System.out.println("user : "+user);
		
		model.addAttribute("userId2", userId2);
		model.addAttribute("type", type);
		model.addAttribute("user", user);
		
		return "forward:/user/addUserView.jsp";
	}

	//네이버 로그인 정보 가져오기
	@RequestMapping( value="loginWithNaver", method=RequestMethod.GET)
	public String loginWithNaver(HttpServletRequest request, Model model) throws Exception{ 
	    String clientId = "Tj5gWPI0ucoEYjJpkdWc";//애플리케이션 클라이언트 아이디값";
	    String clientSecret = "jdQ9HN0JTn";//애플리케이션 클라이언트 시크릿값";
	    String code = request.getParameter("code");
	    String state = request.getParameter("state");
	    String redirectURI = URLEncoder.encode("http://localhost:8080/user/loginWithNaver", "UTF-8");
	    String apiURL;
	    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&;";
	    apiURL += "client_id=" + clientId;
	    apiURL += "&client_secret=" + clientSecret;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&code=" + code;
	    apiURL += "&state=" + state;
	    String access_token = "";
	    String refresh_token = "";
	    System.out.println("apiURL="+apiURL);
	    try {
	      URL url = new URL(apiURL);
	      HttpURLConnection con = (HttpURLConnection)url.openConnection();
	      con.setRequestMethod("GET");
	      int responseCode = con.getResponseCode();
	      BufferedReader br;
	      System.out.print("responseCode="+responseCode);
	      if(responseCode==200) { // 정상 호출
	        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	      } else {  // 에러 발생
	        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	      }
	      String inputLine;
	      StringBuffer res = new StringBuffer();
	      while ((inputLine = br.readLine()) != null) {
	        res.append(inputLine);
	      }
	      br.close();
	      if(responseCode==200) {
	        System.out.println(res.toString());
	        JSONObject jsonobj = (JSONObject)JSONValue.parse(res.toString());
	        access_token = jsonobj.get("access_token").toString();
	      }
	    } catch (Exception e) {
	      System.out.println(e);
	    }
	    
	    Map<String, Object> map = new HashMap<>();
	    String data = "";
        String token = access_token;// 네이버 로그인 접근 토큰; 여기에 복사한 토큰값을 넣어줍니다.
        String header = "Bearer " + token; // Bearer 다음에 공백 추가
        try {
            apiURL = "https://openapi.naver.com/v1/nid/me";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", header);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());
	        JSONObject jsonobj = (JSONObject)JSONValue.parse(response.toString());
            System.out.println(jsonobj);
            ObjectMapper objectMapper = new ObjectMapper();
            map = objectMapper.readValue(jsonobj.get("response").toString(), new TypeReference<Map<String, Object>>() {});
            System.out.println(map);
        } catch (Exception e) {
            System.out.println(e);
        }
        
		model.addAttribute("map", map);
	    
		return "/loginWithNaver.jsp";
	}
	
	@RequestMapping( value="checkUserMail", method=RequestMethod.GET )
	public String checkMail(@RequestParam("user") String userId,
							@RequestParam("code") String emailCode) throws Exception{
		System.out.println(userId + "/" + emailCode);
		User user = new User();
		user = userService.getUser(userId);
		
		if(user != null && user.getEmailCode() != null) {
			if(user.getEmailCode().equals(emailCode) && user.getUserStatusCode().equals("3")) {
				user.setUserStatusCode("1");
				userService.updateStatusCode(user);
			}
		}
		
		return "redirect:/index.jsp";
	}
	
	
}