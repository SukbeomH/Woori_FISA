// 무슨 메뉴를 고르실래요? 1. 가지튀김 2. 짜장면 3. 꿔바로우 4. 우롱차

var menu = prompt("1. 가지튀김 2. 짜장면 3. 꿔바로우. 아니면 기타 ");

switch (menu) {
	case "1":
		alert("가지튀김을 드시는군요 1");
		break;
	case "2":
		alert("짜장면을 드시는군요 2");
		break;
	case "3":
		alert("꿔바로우를 드시는군요 3");
		break;
	default:
		alert("우롱차 드릴게요");
}

// if 조건문으로 변경하되 1 또는 2를 입력하면 가지튀김 / 나머지 경우는 우롱차만 주는 걸로
var menu = Number(prompt("1. 가지튀김 2. 짜장면 3. 꿔바로우. 아니면 기타 "));

switch (menu) {
	case 1: // === 으로 조건 비교하고 있음
		alert("가지튀김을 드시는군요 1");
		break; // 해당 조건을 만족하면 코드 블록 밖으로 빠져나가게
	case 2:
		alert("짜장면을 드시는군요 2");
		break;
	case 3:
		alert("꿔바로우를 드시는군요 3");
		break;
	default: // else 의 역할
		alert("우롱차 드릴게요");
}
