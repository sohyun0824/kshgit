package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum;  // 현재 페이지 번호
	private int amount;  // 한 페이지 출력할 게시글 수
	
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	// 동적 SQL   foreach문 돌릴때 collection="map"
	// TWC를 배열로 만들어서 동적쿼리의 값(collection)으로 활용하기 위해
	public String[] getTypeArr() {
		return type == null? new String[] {} : type.split("");
	}
}
