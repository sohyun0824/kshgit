package shop.order.model;

import java.util.Date;

public class OrderListDTO {
	private int order_no;
	private String status;
	private Date order_date;
	private Date delivered_date;
	private String no_goods;
	private String user_no;
	private String delivery_code;
	private String pay_code;
	
	public OrderListDTO() {
		super();
	}

	public int getOrder_no() {
		return order_no;
	}

	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}

	public Date getDelivered_date() {
		return delivered_date;
	}

	public void setDelivered_date(Date delivered_date) {
		this.delivered_date = delivered_date;
	}

	public String getNo_goods() {
		return no_goods;
	}

	public void setNo_goods(String no_goods) {
		this.no_goods = no_goods;
	}

	public String getUser_no() {
		return user_no;
	}

	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}

	public String getDelivery_code() {
		return delivery_code;
	}

	public void setDelivery_code(String delivery_code) {
		this.delivery_code = delivery_code;
	}

	public String getPay_code() {
		return pay_code;
	}

	public void setPay_code(String pay_code) {
		this.pay_code = pay_code;
	}
	
	
}
