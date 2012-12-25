package model.vo;

public class BoardCommentVO {
	private int commentNo;
	private int boardNo;
	private String memberId;
	private String commentDate;
	private String cont;

	public BoardCommentVO() {
		super();
	}

	public BoardCommentVO(int commentNo, int boardNo, String memberId,
			String commentDate, String cont) {
		super();
		this.commentNo = commentNo;
		this.boardNo = boardNo;
		this.memberId = memberId;
		this.commentDate = commentDate;
		this.cont = cont;
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(String commentDate) {
		this.commentDate = commentDate;
	}

	public String getCont() {
		return cont;
	}

	public void setCont(String cont) {
		this.cont = cont;
	}

	public String toString() {
		return "BoardCommentVO [commentNo=" + commentNo + ", boardNo="
				+ boardNo + ", memberId=" + memberId + ", commentDate="
				+ commentDate + ", cont=" + cont + "]";
	}
}
