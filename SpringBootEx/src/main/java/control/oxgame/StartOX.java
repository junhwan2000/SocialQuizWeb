package control.oxgame;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import game.OxDBBean;
import game.OxDataBean;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("quiz/startox")
public class StartOX {
	@Resource
	private OxDBBean oxDao;

	@GetMapping
	public String oxForm() {
		return "quiz/oxGame/oxForm";
	}
	
	@PostMapping
	public String oxPro( @RequestBody OxDataBean oxDto, Model model, HttpSession session ) throws Exception {
//		String memId = (String) session.getAttribute( "memId" );
//		if ( memId != null ) {
//			oxDto.setUserId(memId);
//		}
		int result =  oxDao.submitScore(oxDto);
		if( result == 1 )
			session.setAttribute( "memId", oxDto.getUserId() );
		model.addAttribute( "result", result );
		return "quiz/oxGame/oxPro";
	}
}
