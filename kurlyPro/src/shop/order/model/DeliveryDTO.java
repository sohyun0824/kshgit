package shop.order.model;

public class DeliveryDTO {

	private String delivery_code;
	private String address;
	private String delivery_type;
	private String receiver;
	private String receiver_tel;
	private String loc;
	private String loc_detail;
	private String front_door;
	private String entering_detail;
	private String delivered_msg;
	private String m_id;
	private int is_basic;

	public DeliveryDTO() {
		super();
	}
	
	
	
	public int getIs_basic() {
		return is_basic;
	}

	public void setIs_basic(int is_basic) {
		this.is_basic = is_basic;
	}
	
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getDelivery_code() {
		return delivery_code;
	}

	public void setDelivery_code(String delivery_code) {
		this.delivery_code = delivery_code;
	}

	public String getDelivery_type() {
		return delivery_type;
	}

	public void setDelivery_type(String delivery_type) {
		this.delivery_type = delivery_type;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getReceiver_tel() {
		return receiver_tel;
	}

	public void setReceiver_tel(String receiver_tel) {
		this.receiver_tel = receiver_tel;
	}

	public String getLoc() {
		return loc;
	}

	public void setLoc(String loc) {
		this.loc = loc;
	}

	public String getLoc_detail() {
		return loc_detail;
	}

	public void setLoc_detail(String loc_detail) {
		this.loc_detail = loc_detail;
	}

	public String getFront_door() {
		return front_door;
	}

	public void setFront_door(String front_door) {
		this.front_door = front_door;
	}

	public String getEntering_detail() {
		return entering_detail;
	}

	public void setEntering_detail(String entering_detail) {
		this.entering_detail = entering_detail;
	}

	public String getDelivered_msg() {
		return delivered_msg;
	}

	public void setDelivered_msg(String delivered_msg) {
		this.delivered_msg = delivered_msg;
	}
	
	
}
