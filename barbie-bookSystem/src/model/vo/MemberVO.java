package model.vo;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {
	private String memberId;
	private String pass;
	private String name;
	private String gender;
	private String email;
	private String subject1;
	private String subject2;
	private String subject3;
	private MultipartFile uploadFile;
	private String orgfilename;// 업로드한 원본 파일명
	private String newfilename;// 시간_파일명 변경 파일명

	public MemberVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemberVO(String memberId, String pass, String name, String gender,
			String email, String subject1, String subject2, String subject3,
			MultipartFile uploadFile, String orgfilename, String newfilename) {
		super();
		this.memberId = memberId;
		this.pass = pass;
		this.name = name;
		this.gender = gender;
		this.email = email;
		this.subject1 = subject1;
		this.subject2 = subject2;
		this.subject3 = subject3;
		this.uploadFile = uploadFile;
		this.orgfilename = orgfilename;
		this.newfilename = newfilename;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSubject1() {
		return subject1;
	}

	public void setSubject1(String subject1) {
		this.subject1 = subject1;
	}

	public String getSubject2() {
		return subject2;
	}

	public void setSubject2(String subject2) {
		this.subject2 = subject2;
	}

	public String getSubject3() {
		return subject3;
	}

	public void setSubject3(String subject3) {
		this.subject3 = subject3;
	}

	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	public String getOrgfilename() {
		return orgfilename;
	}

	public void setOrgfilename(String orgfilename) {
		this.orgfilename = orgfilename;
	}

	public String getNewfilename() {
		return newfilename;
	}

	public void setNewfilename(String newfilename) {
		this.newfilename = newfilename;
	}

	@Override
	public String toString() {
		return "MemberVO [memberId=" + memberId + ", pass=" + pass + ", name="
				+ name + ", gender=" + gender + ", email=" + email
				+ ", subject1=" + subject1 + ", subject2=" + subject2
				+ ", subject3=" + subject3 + ", uploadFile=" + uploadFile
				+ ", orgfilename=" + orgfilename + ", newfilename="
				+ newfilename + "]";
	}

}
