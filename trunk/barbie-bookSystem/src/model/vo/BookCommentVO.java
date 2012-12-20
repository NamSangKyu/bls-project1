package model.vo;

public class BookCommentVO {
private int isbn;
private int no;
private String writer;
private String bookcomment;
private int score;
public BookCommentVO() {
	super();
	// TODO Auto-generated constructor stub
}
public int getIsbn() {
	return isbn;
}
public void setIsbn(int isbn) {
	this.isbn = isbn;
}
public int getNo() {
	return no;
}
public void setNo(int no) {
	this.no = no;
}
public String getWriter() {
	return writer;
}
public void setWriter(String writer) {
	this.writer = writer;
}
public String getBookcomment() {
	return bookcomment;
}
public void setBookcomment(String bookcomment) {
	this.bookcomment = bookcomment;
}
public int getScore() {
	return score;
}
public void setScore(int score) {
	this.score = score;
}
@Override
public String toString() {
	return "BookComentVO [isbn=" + isbn + ", no=" + no + ", writer=" + writer
			+ ", bookcomment=" + bookcomment + ", score=" + score + "]";
}


}