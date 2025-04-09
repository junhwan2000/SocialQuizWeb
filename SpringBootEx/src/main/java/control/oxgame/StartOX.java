package control.oxgame;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import rank.RankDBBean;
import rank.RankDataBean;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("quiz/startox")
public class StartOX {
	@Resource
	private RankDBBean rankDao;

	@GetMapping
	public String oxForm() {
		return "quiz/oxGame/oxForm";
	}
	
	@PostMapping
	public String oxPro( @RequestBody RankDataBean rankDto, Model model, HttpSession session ) throws Exception {
		int result = rankDao.insertRank(rankDto);
		if( result == 1 )
			session.setAttribute( "memId", rankDto.getUserId() );
		model.addAttribute( "result", result );
		return "quiz/oxGame/oxPro";
	}
}
