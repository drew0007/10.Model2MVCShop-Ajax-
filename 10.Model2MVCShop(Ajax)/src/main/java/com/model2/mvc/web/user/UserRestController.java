package com.model2.mvc.web.user;

import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.List;
import java.util.Map;

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
	
	@RequestMapping( value="json/duplicationUser/{userId}", method=RequestMethod.GET )
	public boolean duplicationUser(@PathVariable String userId) throws Exception{
		
		System.out.println(userId);
		
		boolean check = false;
		if(!userId.equals("")) {
			check = userService.checkDuplication(userId);
		}
		
		return check;
	}
	
	@RequestMapping( value="json/autocompleteUser", method=RequestMethod.GET)
	public List<User> autocompleteUser() throws Exception{
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(100);
		
		Map<String, Object> map = userService.getUserList(search);
		List<User> list = (List<User>)map.get("list");
		
		return list;
	}
	
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
	
	@RequestMapping( value="json/updateUserId/{userId}/{userId2}/{type}", method=RequestMethod.GET)
	public User updateUserId(@PathVariable String userId,
							@PathVariable String userId2,
							@PathVariable String type) throws Exception{
		System.out.println("updateUserId => "+userId+" : "+userId2+" : "+type);

		userService.updateUserId(userId, userId2, type);
		User user = userService.getUser(userId);
		
		return user;
	}
	
	@RequestMapping( value="json/test", method=RequestMethod.GET)
	public JSONObject test() throws Exception{ 
		System.out.println("test 한다");
	    String clientId = "Tj5gWPI0ucoEYjJpkdWc";//애플리케이션 클라이언트 아이디값";
	    String redirectURI = URLEncoder.encode("http://localhost:8080/user/test2", "UTF-8");
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
	
}