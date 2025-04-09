package mb;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {
    "mb", "logon", "board", "qna", "control.quiz", "control.oxgame", "control.wordgame",
    "control.logon", "control.board", "control.qna", "websocket", "control.rank", "rank"
})
@MapperScan(basePackages = {
    "logon", "board", "qna", "quiz.oxgame", "quiz.wordGame", "rank"
})
public class MBApplication {
    public static void main(String[] args) {
        SpringApplication.run(MBApplication.class);
    }
}
