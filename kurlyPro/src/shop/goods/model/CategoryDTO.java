package shop.goods.model;

public class CategoryDTO {
	private String parent_seq;
	private String pc_name;
	private String child_seq;
	private String cc_name;
	
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
	
}
