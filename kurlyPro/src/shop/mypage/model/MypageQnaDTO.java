package shop.mypage.model;

import java.util.ArrayList;
import java.util.Date;

public class MypageQnaDTO {
	// 1:1문의 사항 컬럼
	private String pq_code	;
	private String title	 ;
	private String pq_type;
	private String name	;
	private long order_no	;
	private String content	;
	private Date write_date	;
	private int is_answer	;
	private int step	;
	private String ref;
	private String m_id	;
	//
	private ArrayList<String> file_list;
	//
	private String seq;
	private String pq_file;
	
	// member 테이블 컬럼들
	//private String email;
	//private String tel;
			
	//
	public String getPq_code() {
		return pq_code;
	}
	public void setPq_code(String pq_code) {
		this.pq_code = pq_code;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getPq_type() {
		return pq_type;
	}
	public void setPq_type(String pq_type) {
		this.pq_type = pq_type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public long getOrder_no() {
		return order_no;
	}
	public void setOrder_no(long order_no) {
		this.order_no = order_no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	public int getIs_answer() {
		return is_answer;
	}
	public void setIs_answer(int is_answer) {
		this.is_answer = is_answer;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public String getRef() {
		return ref;
	}
	public void setRef(String ref) {
		this.ref = ref;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public ArrayList<String> getFile_list() {
		return file_list;
	}
	public void setFile_list(ArrayList<String> file_list) {
		this.file_list = file_list;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getPq_file() {
		return pq_file;
	}
	public void setPq_file(String pq_file) {
		this.pq_file = pq_file;
	}


}//class
