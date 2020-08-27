package shop.mypage.model;

import java.util.Date;

public class ReviewBeforeDTO {
	private String group_no;
	private String group_name;
	private String goods_no;
	private String goods_name;
	private String main_img;
	private int cnt;
	private long order_no;
	private Date delivered_date;
	private int remaining_days;
	private int list_cnt;
	
	public ReviewBeforeDTO() { }

	public ReviewBeforeDTO(String group_no, String group_name, String goods_no, String goods_name, String main_img,
			int cnt, long order_no, Date delivered_date, int remaining_days, int list_cnt) {
		this.group_no = group_no;
		this.group_name = group_name;
		this.goods_no = goods_no;
		this.goods_name = goods_name;
		this.main_img = main_img;
		this.cnt = cnt;
		this.order_no = order_no;
		this.delivered_date = delivered_date;
		this.remaining_days = remaining_days;
		this.list_cnt = list_cnt;
	}

	public String getGroup_no() {
		return group_no;
	}

	public void setGroup_no(String group_no) {
		this.group_no = group_no;
	}

	public String getGroup_name() {
		return group_name;
	}

	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}

	public String getGoods_no() {
		return goods_no;
	}

	public void setGoods_no(String goods_no) {
		this.goods_no = goods_no;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}

	public String getMain_img() {
		return main_img;
	}

	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public long getOrder_no() {
		return order_no;
	}

	public void setOrder_no(long order_no) {
		this.order_no = order_no;
	}

	public Date getDelivered_date() {
		return delivered_date;
	}

	public void setDelivered_date(Date delivered_date) {
		this.delivered_date = delivered_date;
	}

	public int getRemaining_days() {
		return remaining_days;
	}

	public void setRemaining_days(int remaining_days) {
		this.remaining_days = remaining_days;
	}

	public int getList_cnt() {
		return list_cnt;
	}

	public void setList_cnt(int list_cnt) {
		this.list_cnt = list_cnt;
	}
	
	
	
}
