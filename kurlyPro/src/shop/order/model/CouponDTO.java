package shop.order.model;

import java.util.Date;

public class CouponDTO {
	private String coupon_code;
	private String name;
	private String type;
	private int advantage;
	private int limited_price;
	private Date expire_date;

	public CouponDTO() {
		super();
	}

	public String getCoupon_code() {
		return coupon_code;
	}

	public void setCoupon_code(String coupon_code) {
		this.coupon_code = coupon_code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getAdvantage() {
		return advantage;
	}

	public void setAdvantage(int advantage) {
		this.advantage = advantage;
	}

	public int getLimited_price() {
		return limited_price;
	}

	public void setLimited_price(int limited_price) {
		this.limited_price = limited_price;
	}

	public Date getExpire_date() {
		return expire_date;
	}

	public void setExpire_date(Date expire_date) {
		this.expire_date = expire_date;
	}
	
	
}
