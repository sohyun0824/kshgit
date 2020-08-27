package shop.goods.model;

public class ReviewBoardDTO {
	//fields
	private String reviewed_no;
	private String title;
	private String content;
	private int readed;
	private int helped;
	private String name;
	private String write_date;
	private int isnotice;
	private String goods_no;
	private String group_no;
	
	public String getReviewed_no() {
		return reviewed_no;
	}
	public void setReviewed_no(String reviewed_no) {
		this.reviewed_no = reviewed_no;
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
	public int getReaded() {
		return readed;
	}
	public void setReaded(int readed) {
		this.readed = readed;
	}
	public int getHelped() {
		return helped;
	}
	public void setHelped(int helped) {
		this.helped = helped;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public int getIsnotice() {
		return isnotice;
	}
	public void setIsnotice(int isnotice) {
		this.isnotice = isnotice;
	}
	public String getGoods_no() {
		return goods_no;
	}
	public void setGoods_no(String goods_no) {
		this.goods_no = goods_no;
	}
	public String getGroup_no() {
		return group_no;
	}
	public void setGroup_no(String group_no) {
		this.group_no = group_no;
	}
	
}
