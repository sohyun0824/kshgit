
console.log("Reply Module..........");

// 객체를 담는 변수
// var replyService = {};

// 모듈 구성하기
// 함수를()로 묶고 선언과 동시에 즉시 실행시켜서 replyService라는 변수에 name:"AAAA"값을 가진 객체 할당
/*
var replyService = (function(){
	alert("즉시 실행 함수");
	return {name:"AAAA"};
})();

console.log("> replyService = " + replyService);
console.log("> replyService.name = " + replyService.name);
*/
// 즉시 실행하는 함수 내부에서 메서드를 구성해서 객체를 구성
var replyService = (function(){
	function add(reply, callback){
		console.log("reply.............");
	}
	return {plus:add}; // 객체에 속성값으로 함수 등록
})();

replyService.plus();