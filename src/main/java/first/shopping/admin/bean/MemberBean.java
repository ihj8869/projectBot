package first.shopping.admin.bean;

public class MemberBean {
	private int mem_no;
	private String name;
	private String password;
	private String address;
	private String phone;
	private String email;
	private String gender;
	private String birthday;
	private String mod_ip;
	
	public MemberBean() {
		super();
	}

	public MemberBean(int mem_no, String name, String password, String address, String phone, String email,
			String gender, String birthday, String mod_ip) {
		super();
		this.mem_no = mem_no;
		this.name = name;
		this.password = password;
		this.address = address;
		this.phone = phone;
		this.email = email;
		this.gender = gender;
		this.birthday = birthday;
		this.mod_ip = mod_ip;
	}

	public int getMem_no() {
		return mem_no;
	}

	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getMod_ip() {
		return mod_ip;
	}

	public void setMod_ip(String mod_ip) {
		this.mod_ip = mod_ip;
	}

	@Override
	public String toString() {
		return "MemberBean [mem_no=" + mem_no + ", name=" + name + ", password=" + password + ", address=" + address
				+ ", phone=" + phone + ", email=" + email + ", gender=" + gender + ", birthday=" + birthday
				+ ", mod_ip=" + mod_ip + "]";
	}
	
	
}
