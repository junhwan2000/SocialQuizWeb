package rank;

import java.util.List;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RankDBBean {

    @Autowired
    private RankMapper mapper;

//    public List<RankDataBean> getRankList(int gameId) {
//        return mapper.getRankList(gameId);
//    }
    public List<RankDataBean> getRankList(int gameId) {
        List<RankDataBean> list = new ArrayList<>();
        RankDataBean dto = new RankDataBean();
        dto.setNickname("테스트");
        dto.setRank_score(100);
        dto.setRank_time(20);
        list.add(dto);
        return list;
    }

    public String getGameNameById(int gameId) {
        return mapper.getGameNameById(gameId);
    }
}
