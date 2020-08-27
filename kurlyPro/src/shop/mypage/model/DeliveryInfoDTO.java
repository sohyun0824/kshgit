package shop.mypage.model;

public class DeliveryInfoDTO {
	private String receiver;
	private String tel;
	private String address;
	private String type;
	private String loc;
	private String front_door;
	private String msg;

	public DeliveryInfoDTO() {
		super();
	}

	public DeliveryInfoDTO(String receiver, String tel, String address, String type, String loc, String front_door,
			String msg) {
		super();
		this.receiver = receiver;
		this.tel = tel;
		this.address = address;
		this.type = type;
		this.loc = loc;
		this.front_door = front_door;
		this.msg = msg;
	}

	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getLoc() {
		return loc;
	}

	public void setLoc(String loc) {
		this.loc = loc;
	}

	public String getFront_door() {
		return front_door;
	}

	public void setFront_door(String front_door) {
		this.front_door = front_door;
	}


	public String getMsg() {
		return msg;
	}


	public void setMsg(String msg) {
		this.msg = msg;
	}
}
