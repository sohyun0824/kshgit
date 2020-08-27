package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {
	
	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
	public List<BoardVO> getList();
	
	// 현재 페이지 번호와 한 페이지에 뿌릴 레코드 수가 저장된 객체를 넘겨서 해당 페이지의 레코드 목록 조회
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
}
