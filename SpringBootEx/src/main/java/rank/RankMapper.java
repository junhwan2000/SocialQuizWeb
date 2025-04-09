package rank;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface RankMapper {
    List<RankDataBean> getRankList(@Param("gameId") int gameId);
    String getGameNameById(@Param("gameId") int gameId);
}
