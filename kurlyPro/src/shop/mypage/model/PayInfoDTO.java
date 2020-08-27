package shop.mypage.model;

public class PayInfoDTO {
	private long order_no;
	private int discount;
	private int coupon;
	private int point;
	private int del_fee;
	private int pay_amount;
	private int add_point;
	private int order_amount;
	private String pay_name;
	
	public PayInfoDTO() {
	}
	
	public PayInfoDTO(long order_no, int discount, int coupon, int point, int del_fee, int pay_amount, int add_point,
			int order_amount, String pay_name) {
		this.order_no = order_no;
		this.discount = discount;
		this.coupon = coupon;
		this.point = point;
		this.del_fee = del_fee;
		this.pay_amount = pay_amount;
		this.add_point = add_point;
		this.order_amount = order_amount;
		this.pay_name = pay_name;
	}

	public long getOrder_no() {
		return order_no;
	}

	public void setOrder_no(long order_no) {
		this.order_no = order_no;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	public int getCoupon() {
		return coupon;
	}

	public void setCoupon(int coupon) {
		this.coupon = coupon;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getDel_fee() {
		return del_fee;
	}

	public void setDel_fee(int del_fee) {
		this.del_fee = del_fee;
	}

	public int getPay_amount() {
		return pay_amount;
	}

	public void setPay_amount(int pay_amount) {
		this.pay_amount = pay_amount;
	}

	public int getAdd_point() {
		return add_point;
	}

	public void setAdd_point(int add_point) {
		this.add_point = add_point;
	}

	public int getOrder_amount() {
		return order_amount;
	}

	public void setOrder_amount(int order_amount) {
		this.order_amount = order_amount;
	}

	public String getPay_name() {
		return pay_name;
	}

	public void setPay_name(String pay_name) {
		this.pay_name = pay_name;
	}
	
	
}
