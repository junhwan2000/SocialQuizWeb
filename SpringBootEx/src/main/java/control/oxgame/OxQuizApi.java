package control.oxgame;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import game.OxDBBean;
import game.OxDataBean;
import jakarta.annotation.Resource;

@RestController
@RequestMapping("quiz/oxquiz")
public class OxQuizApi {
	@Resource
	private OxDBBean oxDao;
	
	@GetMapping
	public List<OxDataBean> getOxQuiz() {
		return oxDao.getOxQuiz();
	}

}
