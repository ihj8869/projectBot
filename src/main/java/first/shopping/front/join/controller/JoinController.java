package first.shopping.front.join.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class JoinController {
	
	@RequestMapping(value="/join.do")
	public String moveJoinPage() {
		System.out.println("dd");
		return "/join/join";
	}
}
