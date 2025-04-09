let quizData = [];

let count = 0; 				// 푼 문제수 체크하는거
let num = 0;   				// 맞춘 문제수
let time = 10;  			// 시간
let interval;  				// 타이머 
let gameOver = false; 		// 이게 게임 끝났는지 확인하는 변수 true면 게임오버 false면 게임중

const tspan = document.querySelector("#timeout");	// 마지막문제를 풀어서 게임이 끝나는거랑 
const qdiv = document.querySelector(".question");	// 마지막문제를 시간초과해서 게임 끝나는거 구현하려고 변수 밖으로 뺌

// OX 점수 랭크 연동
function submitScore( userId, game_id, rank_score, rank_time ) {
	fetch( "/quiz/startox", {
		method: "POST",
		headers: {
			"Content-Type": "application/json"
		},
		body:  JSON.stringify({
			userId: userId,
			game_id: game_id,
			rank_score: rank_score,
			rank_time: rank_time
		})
		
	})
	.then( response => {
		if (!response.ok) {
			throw new Error( "서버 전송 실패" );
		}
	})
	.then( data => {
		console.log( "서버 응답", data );
	})
	.catch( error => {
		console.error( "에러:", error );
	});
}

//    
function showQuestion(index) {		// 문제보여주는거
    if (index < quizData.length) {
        qdiv.innerText = quizData[index].question;
    } else {
        alert("퀴즈 종료! 맞힌 개수: " + num);
        qdiv.innerText = "문제가 끝났습니다.";
        clearInterval(interval);
        gameOver = true;
    }
}

function startTimer() {
    clearInterval(interval);
    time = 10;
    tspan.innerText = time;

    interval = setInterval(() => {
        tspan.innerText = time--;
        if (time < 0) {
            clearInterval(interval);
            count++;
            alert("시간초과!");
            if (count < quizData.length) {
                showQuestion(count);
                startTimer();
            } else {
                alert("퀴즈 종료! 맞힌 개수 : " + num);
                tspan.innerText = 0;					// 마지막 문제 안풀고 시간 초과시
                qdiv.innerText = "퀴즈가 종료되었습니다.";   
                gameOver = true;
				
			// num 값을 서버에 넘겨야 함
			const userId = document.querySelector( "#userId" )?.value;
			const game_id = 1;		// OX : 1 / 끝말잇기 : 2 / 라이어 : 3 이라는 가정하에
			const rank_score = num;
			const rank_time = 100; // 총 플레이 시간을 넣어야 함.
			submitScore(userId, game_id, rank_score, rank_time);
				
            }
        }
    }, 1000);	
}

function resetGame() {		// 겜 다시할때
    count = 0;
    num = 0;
    gameOver = false;
    showQuestion(0);
    startTimer();
}

function checkAnswer(userInput) {		// 정답체크

    if (quizData[count].answer === userInput) {
        alert("정답!");
        num++;
    } else {
        alert("땡!");
    }
    count++;
    if (count < quizData.length) {
        showQuestion(count);
        startTimer();
    } else {
        alert("퀴즈 종료! 맞힌 개수: " + num);	// 마지막 문제를 풀었을시
        tspan.innerText = 0;
        qdiv.innerText = "퀴즈가 종료되었습니다.";	
        clearInterval(interval);
        gameOver = true;
		
		// num 값을 서버에 넘겨야 함
		const userId = document.querySelector( "#userId" )?.value;
		const game_id = 1;		// OX : 1 / 끝말잇기 : 2 / 라이어 : 3 이라는 가정하에
		const rank_score = num;
		const rank_time = 100; // 총 플레이 시간을 넣어야 함.
		submitScore(userId, game_id, rank_score, rank_time);
    }
}

window.addEventListener( "DOMContentLoaded", () => {
	
	fetch( "/quiz/startox" )
		.then( response => response.json() )
		.then( data => {
			quizData = data.map( quiz => ({
				question: quiz.question,
				answer: quiz.answer
			}));
			showQuestion(0);
			startTimer();
		})
		.catch( error => {
			console.error( "퀴즈 데이터 불러오기 실패: ", error );
		});
		
	document.querySelector(".btn_O").addEventListener("click", () => checkAnswer("O"));
	document.querySelector(".btn_X").addEventListener("click", () => checkAnswer("X"));

	document.getElementById("restartBtn").addEventListener("click", 
			() => {
	    if (gameOver) {	// 게임끝났을때 다시하기 누르면 
	        if (confirm("게임이 종료되었습니다. 다시 시작하시겠습니까?")) {
	            resetGame();
	        }
	    } else {	// 게임도중에 다시하기 누르면 이건 나중에 빼도 될듯함
	        if (confirm("게임 도중입니다. 다시 시작하시겠습니까?")) {
	            resetGame();
	        }
	    }
	});

	document.getElementById("exitBtn").addEventListener("click", // 나가는 거 컨펌
			() => {
	    if (confirm("정말로 나가시겠습니까?")) {
	
	        window.location.href = "selectquiz";	// 아직 연결은 안했는데 메인으로 갈예정
	    }
	});

	showQuestion(0);
	startTimer();
	
});