package model.vo;

public class SubjectVO {
	private int subjectNo;
	private String subject;
	@Override
	public String toString() {
		return "SubjectVO [subjectNo=" + subjectNo + ", subject=" + subject
				+ "]";
	}
	public int getSubjectNo() {
		return subjectNo;
	}
	public void setSubjectNo(int subjectNo) {
		this.subjectNo = subjectNo;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public SubjectVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
