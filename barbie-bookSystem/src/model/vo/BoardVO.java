package model.vo;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {
	private int boardNo;
	private String title;
	private String memberId;
	private String boardDate;
	private int count;
	private MultipartFile uploadFile; // 업로드 파일
	private String orgFileName; // 업로드한 원본 파일명
	private String newFileName; // 시간_파일명 변경 파일명
	private String cont;
	private int ref;
	private int restep;
	private int relevel;

	public BoardVO() {
		super();
	}

	public BoardVO(int boardNo, String title, String memberId,
			String boardDate, int count, MultipartFile uploadFile,
			String orgFileName, String newFileName, String cont, int ref,
			int restep, int relevel) {
		super();
		this.boardNo = boardNo;
		this.title = title;
		this.memberId = memberId;
		this.boardDate = boardDate;
		this.count = count;
		this.uploadFile = uploadFile;
		this.orgFileName = orgFileName;
		this.newFileName = newFileName;
		this.cont = cont;
		this.ref = ref;
		this.restep = restep;
		this.relevel = relevel;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	public String getOrgFileName() {
		return orgFileName;
	}

	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}

	public String getNewFileName() {
		return newFileName;
	}

	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}

	public String getCont() {
		return cont;
	}

	public void setCont(String cont) {
		this.cont = cont;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getRestep() {
		return restep;
	}

	public void setRestep(int restep) {
		this.restep = restep;
	}

	public int getRelevel() {
		return relevel;
	}

	public void setRelevel(int relevel) {
		this.relevel = relevel;
	}

	public String toString() {
		return "BoardVO [boardNo=" + boardNo + ", title=" + title
				+ ", memberId=" + memberId + ", boardDate=" + boardDate
				+ ", count=" + count + ", uploadFile=" + uploadFile
				+ ", orgFileName=" + orgFileName + ", newFileName="
				+ newFileName + ", cont=" + cont + ", ref=" + ref + ", restep="
				+ restep + ", relevel=" + relevel + "]";
	}
}
