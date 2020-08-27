package shop.order.model;

import java.util.Date;

public class PaymentDTO {

	private String pay_code;
	private int pay_amount;
	private Date pay_date;
	private int del_fee;
	private int use_point;
	private int use_coupon;
	private int add_point;
	private int discount;
	private int payment_no;

	public PaymentDTO() {
		super();
	}

	public String getPay_code() {
		return pay_code;
	}

	public void setPay_code(String pay_code) {
		this.pay_code = pay_code;
	}

	public int getPay_amount() {
		return pay_amount;
	}

	public void setPay_amount(int pay_amount) {
		this.pay_amount = pay_amount;
	}

	public Date getPay_date() {
		return pay_date;
	}

	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}

	public int getDel_fee() {
		return del_fee;
	}

	public void setDel_fee(int del_fee) {
		this.del_fee = del_fee;
	}

	public int getUse_point() {
		return use_point;
	}

	public void setUse_point(int use_point) {
		this.use_point = use_point;
	}
	
	public int getUse_coupon() {
		return use_coupon;
	}

	public void setUse_coupon(int use_coupon) {
		this.use_coupon = use_coupon;
	}

	public int getAdd_point() {
		return add_point;
	}

	public void setAdd_point(int add_point) {
		this.add_point = add_point;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	public int getPayment_no() {
		return payment_no;
	}

	public void setPayment_no(int payment_no) {
		this.payment_no = payment_no;
	}
	
	
}
