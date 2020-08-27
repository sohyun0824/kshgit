package shop.mypage.model;

import java.util.ArrayList;
import java.util.Date;

public class ReviewAfterDTO {
	private String reviewed_no;
	private String goods_no;
	private String title;
	private String content;
	private int helped;
	private int readed;
	private Date write_date;
	private long order_no;
	private String goods_name;
	private int cnt;
	private ArrayList<String> fileList;
	private String group_no;
	
	public ReviewAfterDTO() { }

	public ReviewAfterDTO(String reviewed_no, String goods_no, String title, String content, int helped, int readed,
			Date write_date, long order_no, String goods_name, String group_no) {
		this.reviewed_no = reviewed_no;
		this.goods_no = goods_no;
		this.title = title;
		this.content = content;
		this.helped = helped;
		this.readed = readed;
		this.write_date = write_date;
		this.order_no = order_no;
		this.goods_name = goods_name;
		this.group_no = group_no;
	}

	public String getReviewed_no() {
		return reviewed_no;
	}

	public void setReviewed_no(String reviewed_no) {
		this.reviewed_no = reviewed_no;
	}

	public String getGoods_no() {
		return goods_no;
	}

	public void setGoods_no(String goods_no) {
		this.goods_no = goods_no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getHelped() {
		return helped;
	}

	public void setHelped(int helped) {
		this.helped = helped;
	}

	public int getReaded() {
		return readed;
	}

	public void setReaded(int readed) {
		this.readed = readed;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}

	public long getOrder_no() {
		return order_no;
	}

	public void setOrder_no(long order_no) {
		this.order_no = order_no;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public ArrayList<String> getFileList() {
		return fileList;
	}

	public void setFileList(ArrayList<String> fileList) {
		this.fileList = fileList;
	}

	public String getGroup_no() {
		return group_no;
	}

	public void setGroup_no(String group_no) {
		this.group_no = group_no;
	}
	
	
	
}
