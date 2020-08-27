package shop.main.model;

public class PCategoryDTO {
//	PARENT_SEQ          VARCHAR2(2)
//	PC_NAME             NVARCHAR2(15) 
	
	private String parent_seq;
	private String pc_name;
	
	public String getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(String parent_seq) {
		this.parent_seq = parent_seq;
	}
	public String getPc_name() {
		return pc_name;
	}
	public void setPc_name(String pc_name) {
		this.pc_name = pc_name;
	}
	
	
}
