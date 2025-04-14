let quizData = [];			// 여기서 길이가 없으니까 시작할때 퀴즈종료가 뜨고 그 이후에 문제를 받아오니까 그런거얌

let count = 0; 				// 푼 문제수 체크하는거
let num = 0;   				// 맞춘 문제수
let time = 10;  			// 시간
let interval;  				// 타이머 
let gameOver = false; 		// 이게 게임 끝났는지 확인하는 변수 true면 게임오버 false면 게임중

let tspan; 	// 마지막문제를 풀어서 게임이 끝나는거랑 
let qdiv;	// 마지막문제를 시간초과해서 게임 끝나는거 구현하려고 변수 밖으로 뺌

let game_id;		// OX : 1 / 끝말잇기 : 2 / 라이어 : 3 이라는 가정하에
let userId;
let record_time;
let game_score;

// 문제보여주는거 
function showQuestion(index) {		
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
			game_id = 1;		// OX : 1 / 끝말잇기 : 2 / 라이어 : 3 이라는 가정하에
			userId = document.querySelector("#userId")?.value;
			console.log("세션에서 넘어온 유저 ID:", userId);
			record_time = Date.now();
			game_score = num;
			console.log(game_id, userId, record_time, game_score);
			submitScore( game_id, userId, record_time, game_score );
            }
        }
    }, 1000);	
}


// OX 점수 랭크 연동
function submitScore( game_id, userId, record_time, game_score ) {
	fetch( "/quiz/startox", {
		method: "POST",
		headers: {
			"Content-Type": "application/json"
		},
		body: JSON.stringify({
			game_id: game_id,
			userId: userId,
			record_time: record_time,
			game_score: game_score
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
		game_id = 1;		// OX : 1 / 끝말잇기 : 2 / 라이어 : 3 이라는 가정하에
		userId = document.querySelector("#userId")?.value;
		console.log("세션에서 넘어온 유저 ID:", userId);
		record_time = Date.now();
		game_score = num;
		console.log(game_id, userId, record_time, game_score);
		submitScore( game_id, userId, record_time, game_score);
    }
}

window.addEventListener( "DOMContentLoaded", () => {
	qdiv = document.querySelector(".question");
	tspan = document.querySelector("#timeout");
	fetch( "/quiz/oxquiz",{
		method: "GET"
	 	})
		.then( response => response.json() )
		.then( data => {
			console.log("받은퀴즈데이터:", data);
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