package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.mapper.Sample1Mapper;
import org.zerock.mapper.Sample2Mapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

// @Transactional : 이클래스에 있는 모든 메서드 트랜잭션 처리하고자 할때
@Service
@Log4j
public class SampleTxServiceImpl implements SampleTxService {
	
	@Setter(onMethod_= {@Autowired})
	private Sample1Mapper mapper1;
	
	@Setter(onMethod_= {@Autowired})
	private Sample2Mapper mapper2;
	
	
	// insert하는 두 작업이 트랜잭션 처리되도록 어노테이션 설정 (메서드 -> 클래스 -> 인터페이스 순으로 우선순위 적용)
	@Transactional
	@Override
	public void addData(String value) {
		log.info("mapper1.......................");
		mapper1.insertCol1(value);
		
		log.info("mapper2........................");
		mapper2.insertCol2(value);
		
		log.info("end!!!");
	}
}
