package model.vo;

import org.springframework.web.multipart.MultipartFile;

public class BookVO {
	private int no;
	private String title;
	private int subjectNo;
	private int publisherNo;
	private int isbn;
	private String loc;
	private String outputDate;
	private String writer;
	private String cont;
	private MultipartFile file;
	
	public BookVO() {
		super();
	}

	public BookVO(int no, String title, int subjectNo, int publisherNo,
			int isbn, String loc, String outputDate, String writer,
			String cont, MultipartFile file) {
		super();
		this.no = no;
		this.title = title;
		this.subjectNo = subjectNo;
		this.publisherNo = publisherNo;
		this.isbn = isbn;
		this.loc = loc;
		this.outputDate = outputDate;
		this.writer = writer;
		this.cont = cont;
		this.file = file;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title){
		this.title = title;
	}

	public int getSubjectNo(){
		return subjectNo;
	}

	public void setSubjectNo(int subjectNo) {
		this.subjectNo = subjectNo;
	}

	public int getPublisherNo() {
		return publisherNo;
	}

	public void setPublisherNo(int publisherNo) {
		this.publisherNo = publisherNo;
	}

	public int getIsbn() {
		return isbn;
	}

	public void setIsbn(int isbn) {
		this.isbn = isbn;
	}

	public String getLoc() {
		return loc;
	}

	public void setLoc(String loc) {
		this.loc = loc;
	}

	public String getOutputDate() {
		return outputDate;
	}

	public void setOutputDate(String outputDate) {
		this.outputDate = outputDate;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getCont() {
		return cont;
	}

	public void setCont(String cont) {
		this.cont = cont;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	@Override
	public String toString() {
		return "BookVO [no=" + no + ", title=" + title + ", subjectNo="
				+ subjectNo + ", publisherNo=" + publisherNo + ", isbn=" + isbn
				+ ", loc=" + loc + ", outputDate=" + outputDate + ", writer="
				+ writer + ", cont=" + cont + ", file=" + file + "]";
	}
	
	

	
	
}
