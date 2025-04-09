package game;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OxDataBean {
	private int quiz_id;
	private int game_id;
	private int category_id;
	private String question;
	private String answer;
	private int quiz_score;
}
