package shop.main.model;

public class CCategoryDTO {
//	CHILD_SEQ  NOT NULL VARCHAR2(4)   
//	CC_NAME             NVARCHAR2(15) 
//	PARENT_SEQ          VARCHAR2(2)
	
	private String child_seq;
	private String cc_name;
	private String parent_seq;
	
	public String getChild_seq() {
		return child_seq;
	}
	public void setChild_seq(String child_seq) {
		this.child_seq = child_seq;
	}
	public String getCc_name() {
		return cc_name;
	}
	public void setCc_name(String cc_name) {
		this.cc_name = cc_name;
	}
	public String getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(String parent_seq) {
		this.parent_seq = parent_seq;
	}
	
}
