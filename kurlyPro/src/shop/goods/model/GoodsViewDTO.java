package shop.goods.model;

import java.util.ArrayList;

public class GoodsViewDTO {
	//fields
	private String group_no;
	private String group_name; 
	private String main_img;
	private String line_discript;
	private int price;
	private int discount;
	private int moomin;
	private String content;
	private String img;
	private ArrayList<GoodsDTO> goodsList;
	private int reviewCnt;
	private int qnaCnt;
	
	// getter, setter
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
	public String getMain_img() {
		return main_img;
	}
	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}
	public String getLine_discript() {
		return line_discript;
	}
	public void setLine_discript(String line_discript) {
		this.line_discript = line_discript;
	}
	public int getMoomin() {
		return moomin;
	}
	public void setMoomin(int moomin) {
		this.moomin = moomin;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public ArrayList<GoodsDTO> getGoodsList() {
		return goodsList;
	}
	public void setGoodsList(ArrayList<GoodsDTO> goodsList) {
		this.goodsList = goodsList;
	}
	public int getReviewCnt() {
		return reviewCnt;
	}
	public void setReviewCnt(int reviewCnt) {
		this.reviewCnt = reviewCnt;
	}
	public int getQnaCnt() {
		return qnaCnt;
	}
	public void setQnaCnt(int qnaCnt) {
		this.qnaCnt = qnaCnt;
	}
	
	
}
