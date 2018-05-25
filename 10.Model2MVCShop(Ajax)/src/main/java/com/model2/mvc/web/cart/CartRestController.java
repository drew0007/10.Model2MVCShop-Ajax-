package com.model2.mvc.web.cart;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/cart/*")
public class CartRestController {
	
	///Field
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	//setter Method 구현 않음
		
	public CartRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/updateCart/{cartNo}/{cartCnt}", method=RequestMethod.GET )
	public Cart updateCart(@PathVariable String cartNo,
								@PathVariable String cartCnt) throws Exception{
		
		Cart cart = new Cart();
		cart.setCartNo(Integer.parseInt(cartNo));
		cart.setCartCnt(Integer.parseInt(cartCnt));
		
		return cart;
	}
}