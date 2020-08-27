package org.zerock.service;

import org.springframework.transaction.annotation.Transactional;

// @Transactional : 인터페이스에 설정하는 것도 가능
public interface SampleTxService {
	public void addData(String value);
}
