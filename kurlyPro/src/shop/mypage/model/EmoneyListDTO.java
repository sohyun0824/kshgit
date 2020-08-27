package shop.mypage.model;

import java.sql.Date;

public class EmoneyListDTO {
	private String seq;
	private Date balance_date;
	private String content;
	private Date expire_date;
	private int balance_point;
	private int res;
	private String m_id;
	private int sum;
	
	
	public EmoneyListDTO(String seq, Date balance_date, String content, Date expire_date, int balance_point, int res,
			String m_id, int sum) {
		super();
		this.seq = seq;
		this.balance_date = balance_date;
		this.content = content;
		this.expire_date = expire_date;
		this.balance_point = balance_point;
		this.res = res;
		this.m_id = m_id;
		this.sum = sum;
	}
	public EmoneyListDTO() {
		super();
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public Date getBalance_date() {
		return balance_date;
	}
	public void setBalance_date(Date balance_date) {
		this.balance_date = balance_date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getExpire_date() {
		return expire_date;
	}
	public void setExpire_date(Date expire_date) {
		this.expire_date = expire_date;
	}
	public int getBalance_point() {
		return balance_point;
	}
	public void setBalance_point(int balance_point) {
		this.balance_point = balance_point;
	}
	public int getRes() {
		return res;
	}
	public void setRes(int res) {
		this.res = res;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	
	
}
