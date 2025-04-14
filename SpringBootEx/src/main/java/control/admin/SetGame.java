package control.admin;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qna.QnaDBBean;
import qna.QnaDataBean;
import control.oxgame.StartOX;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;
@Controller
@RequestMapping( "/setoxgame" )
public class SetGame {

	@GetMapping
	public String setOXGame() {
		return "admin/setOXGame";
	}
	
	@PostMapping
	public String modifyOXGame() {
		return "admin/modifyOXGame";
	}
	
}
