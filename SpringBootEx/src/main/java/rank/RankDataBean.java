package rank;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RankDataBean {
    private String userId;      // 게임 기록 버튼 링크에 사용 (멤버의 userId)
    private String nickname;    // 닉네임
    private int game_id;
    private int rank_score;     // 누적 점수
    private int rank_time;      // 누적 시간 (초)
}