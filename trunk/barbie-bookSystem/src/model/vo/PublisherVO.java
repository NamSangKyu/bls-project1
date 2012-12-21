package model.vo;

/**
 * @author user
 *
 */
public class PublisherVO {
	private int publisherNo;
	private String publisher;
	public int getPublisherNo() {
		return publisherNo;
	}
	public void setPublisherNo(int publisherNo) {
		this.publisherNo = publisherNo;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public PublisherVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "PublisherVO [publisherNo=" + publisherNo + ", publisher="
				+ publisher + "]";
	}
	
}
