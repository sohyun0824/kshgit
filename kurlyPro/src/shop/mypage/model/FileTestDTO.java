package shop.mypage.model;

import java.util.ArrayList;

public class FileTestDTO {
	private String goods_no;
	private Long order_no;
	private String m_name;
	private String m_id;
	private String mode;
	private String subject;
	private String contents;
	private ArrayList<String> file_list;
	
	public FileTestDTO() { }

	public FileTestDTO(String goods_no, Long order_no, String m_name, String m_id, String mode, String subject,
			String contents, ArrayList<String> file_list) {
		this.goods_no = goods_no;
		this.order_no = order_no;
		this.m_name = m_name;
		this.m_id = m_id;
		this.mode = mode;
		this.subject = subject;
		this.contents = contents;
		this.file_list = file_list;
	}

	public String getGoods_no() {
		return goods_no;
	}

	public void setGoods_no(String goods_no) {
		this.goods_no = goods_no;
	}

	public Long getOrder_no() {
		return order_no;
	}

	public void setOrder_no(Long order_no) {
		this.order_no = order_no;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public ArrayList<String> getFile_list() {
		return file_list;
	}

	public void setFile_list(ArrayList<String> file_list) {
		this.file_list = file_list;
	}
	
}
