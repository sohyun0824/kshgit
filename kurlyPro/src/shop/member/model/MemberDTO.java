package shop.member.model;

import java.sql.Date;

public class MemberDTO {
//	M_ID         NOT NULL VARCHAR2(16)  
//	PWD          NOT NULL VARCHAR2(16)  
//	NAME         NOT NULL VARCHAR2(30)  
//	EMAIL        NOT NULL VARCHAR2(30)  
//	TEL          NOT NULL VARCHAR2(14)  
//	GENDER                CHAR(1)       
//	BIRTHDAY              DATE          
//	RECOMMEND_ID          VARCHAR2(16)  
//	EVENT_NAME            NVARCHAR2(30) 
//	SMS_AGR               NUMBER(1)     
//	EMAIL_AGR             NUMBER(1)     
//	GRADE                 VARCHAR2(15)  
//	TOTAL_POINT           NUMBER        
//	JOIN_DATE             DATE          
//	EXPIRE_DATE           DATE          
	
	// field
	private String m_id;
	private String pwd;
	private String name;
	private String email;
	private String tel;
	private String gender;
	private Date birthday;
	private String recommend_id;
	private String event_name;
	private int sms_agr;
	private int email_agr;
	private String grade;
	private int total_point;
	private Date join_date;
	private Date expire_date;
	
	// getter, setter
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getRecommend_id() {
		return recommend_id;
	}
	public void setRecommend_id(String recommend_id) {
		this.recommend_id = recommend_id;
	}
	public String getEvent_name() {
		return event_name;
	}
	public void setEvent_name(String event_name) {
		this.event_name = event_name;
	}
	public int getSms_agr() {
		return sms_agr;
	}
	public void setSms_agr(int sms_agr) {
		this.sms_agr = sms_agr;
	}
	public int getEmail_agr() {
		return email_agr;
	}
	public void setEmail_agr(int email_agr) {
		this.email_agr = email_agr;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public int getTotal_point() {
		return total_point;
	}
	public void setTotal_point(int total_point) {
		this.total_point = total_point;
	}
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	public Date getExpire_date() {
		return expire_date;
	}
	public void setExpire_date(Date expire_date) {
		this.expire_date = expire_date;
	}
	
	
}
