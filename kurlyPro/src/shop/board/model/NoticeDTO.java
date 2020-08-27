package shop.board.model;

import java.util.Date;

public class NoticeDTO {

	private String seq;
	private String title;
	private Date write_date;
	private int readed;
	private String content;
	// 공지사항 상세보기에 필요한 DTO
	private String preSeq; // 이전글
	private String nextSeq; // 다음글
	private String maxSeq; // 최신 글번호
	private String minSeq; // 처음 글번호
	private String preTitle; // 이전글 제목
	private String nextTitle; // 다음글 제목
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	public int getReaded() {
		return readed;
	}
	public void setReaded(int readed) {
		this.readed = readed;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPreSeq() {
		return preSeq;
	}
	public void setPreSeq(String preSeq) {
		this.preSeq = preSeq;
	}
	public String getNextSeq() {
		return nextSeq;
	}
	public void setNextSeq(String nextSeq) {
		this.nextSeq = nextSeq;
	}
	public String getMaxSeq() {
		return maxSeq;
	}
	public void setMaxSeq(String maxSeq) {
		this.maxSeq = maxSeq;
	}
	public String getMinSeq() {
		return minSeq;
	}
	public void setMinSeq(String minSeq) {
		this.minSeq = minSeq;
	}
	public String getPreTitle() {
		return preTitle;
	}
	public void setPreTitle(String preTitle) {
		this.preTitle = preTitle;
	}
	public String getNextTitle() {
		return nextTitle;
	}
	public void setNextTitle(String nextTitle) {
		this.nextTitle = nextTitle;
	}
	
}
