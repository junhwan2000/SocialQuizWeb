package control.rank;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import rank.RankDataBean;
import rank.RankDBBean;

@Controller
public class RankController {

    @Autowired
    private RankDBBean rankService;

    @GetMapping("/rank")
    public String showRank(@RequestParam(value = "game_id", required = false, defaultValue = "1") int gameId, Model model) {
        List<RankDataBean> rankList = rankService.getRankList(gameId);
        String gameName = rankService.getGameNameById(gameId);

        model.addAttribute("rankList", rankList);
        model.addAttribute("gameName", gameName);
        model.addAttribute("gameId", gameId);
        model.addAttribute("count", rankList.size());

        return "rank/rank";  // 실제로는 /webapp/rank/rank.jsp
    }

}

