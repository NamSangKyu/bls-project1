package config;
/**
 * 페이징 처리시 사용할 공통 상수를 정의한 인터페이스
 * @author admin
 *
 */
public interface CommonConstants {
	/** 			Board
	 *  한 페이지에서 보여질 게시물 수 , 한페이지에 보여질 페이지 그룹의 페이지수
	 */
	int BOARD_CONTENT_NUMBER_PER_PAGE=10;
	int BOARD_COMMENT_NUMBER_PER_PAGE=5;
	int BOARD_PAGEGROUP_NUMBER_PER_PAGE=4;

	/**			Book
	 *  한 페이지에서 보여질 게시물 수 , 한페이지에 보여질 페이지 그룹의 페이지수
	 */
	int BOOK_CONTENT_NUMBER_PER_PAGE=10;
	int BOOK_PAGEGROUP_NUMBER_PER_PAGE=4;

	/**			Member
	 *  한 페이지에서 보여질 게시물 수 , 한 페이지에 보여질 페이지 그룹의 페이지수
	 */
	int MEMBER_CONTENT_NUMBER_PER_PAGE=8;
	int MEMBER_PAGEGROUP_NUMBER_PER_PAGE=4;
}













