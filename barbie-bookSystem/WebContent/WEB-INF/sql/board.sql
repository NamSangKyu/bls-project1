-- 게시판 테이블
drop table bls_board
select * from bls_board

create table bls_board(
	boardNo number primary key,
	title varchar2(100) not null,
	memberId varchar2(50) not null,
	boardDate date not null,
	count number default 0,
	orgFileName varchar2(500),
	newFileName varchar2(500),
	cont varchar2(4000) not null,
	commentCount number default 0,
	ref number not null,
	restep number not null,
	relevel number not null
)

-- 게시판 댓글 테이블
drop table bls_board_comment
select * from bls_board_comment

create table bls_board_comment(
	commentNo number primary key,
	boardNo number not null,
	memberId varchar2(50) not null,
	commentDate date not null,
	cont varchar2(1000) not null,
	constraint boardNo_fk foreign key(boardNo) references bls_board(boardNo)
)

-- 게시판 sequence
drop sequence bls_board_seq
create sequence bls_board_seq nocache;

-- 게시판 댓글 sequence
drop sequence bls_board_comment_seq
create sequence bls_board_comment_seq nocache;