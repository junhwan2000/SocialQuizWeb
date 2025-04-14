package securitydb;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class User {
	private String userId;
	private String passwd;
	private String nickname;
	private String auth;
	private String email;
	private Timestamp createdAt;
	private Timestamp deletedAt;
	private char blockId;
}
