--게시판 테이블
create table bls_board(
	boardNo number primary key,
	title varchar2(100) not null,
	memberId varchar2(50) not null,
	boardDate date not null,
	count number default 0,
	cont varchar2(4000) not null,
	ref number not null,
	restep number not null,
	relevel number not null 
)

--게시판 sequence
create sequence bls_board_seq nocache;

--게시판 insert test
insert into BLS_BOARD(boardNo, title, memberId, pass, boardDate, cont, ref, restep, relevel)
values (bls_board_seq.nextval, '하하', 'bls1004', sysdate, '으하하하', 1, 0, 0)

select * from BLS_BOARD

drop table bls_board