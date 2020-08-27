package org.zerock.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;
import org.zerock.domain.Ticket;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/sample")
@Log4j
public class SampleController {
	
	@GetMapping(value="/getText", produces="text/plain; charset=UTF-8")
	public String getText() {
		return "안녕하세요";
	}
	
	@GetMapping(value="/getSample", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public SampleVO getSample() {
		return new SampleVO(112, "스타", "로드");
	}
	
	// 기본적으로는 xml데이터를 전송, 확장자를 .json으로 지정하면 json형태로 전송
	@GetMapping(value="/getSample2")
	public SampleVO getSample2() {
		return new SampleVO(113, "로켓", "라쿤");
	}
	
	@GetMapping(value="/getList")
	public List<SampleVO> getList(){
		// return IntStream.range(1, 10).mapToObj(i -> new SampleVO(i, i+"First", i+" Last")).collect(Collectors.toList());
		ArrayList<SampleVO> list = new ArrayList();
		for (int i = 1; i <=10; i++) {
			list.add(new SampleVO(i, i+"Fisrt", i+"Last"));
		}
		return list;
	}
	
	@GetMapping(value = "/getMap")
	public Map<String, SampleVO> getMap(){
		Map<String, SampleVO> map = new HashMap<>();
		map.put("First", new SampleVO(111, "그루트", "주니어"));
		
		return map;
	}
	
	@GetMapping(value="/check", params= {"height", "weight"})
	public ResponseEntity<SampleVO> check(Double height, Double weight){
		SampleVO vo = new SampleVO(0, "" + height, ""+weight);
		
		ResponseEntity<SampleVO> result = null;
		
		if(height < 150) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		}else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		return result;
	}
	
	// ?가아닌 url경로로 / 요청하면 경로 일부를 파라미터로 사용
	// /sample/product/bags/1234 -> bags와 1234를 파라미터로 사용하여 문자열배열로 반환 -> xml로 전송(기본)
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(@PathVariable("cat") String cat, @PathVariable Integer pid) {
		return new String[] {"category: " + cat, "productid: " + pid };
	}
	
	// 요청한 내용을 처리하기 때문에 일반적인 파라미터 전달방식 사용x
	// json 형태의 객체를 ajax매개변수로 전달하려면..
	// json형태의 데이터를 ticket객체로 변환
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		log.info(ticket);
		return ticket;  // Ticket(tno=123, owner=user00, grade=AAA)
	}
}
