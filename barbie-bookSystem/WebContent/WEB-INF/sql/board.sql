-- 게시판 테이블
create table bls_board(
	boardNo number primary key,
	title varchar2(100) not null,
	memberId varchar2(50) not null,
	boardDate date not null,
	count number default 0,
	orgFileName varchar2(500),
	newFileName varchar2(500),
	cont varchar2(4000) not null,
	ref number not null,
	restep number not null,
	relevel number not null
)

-- 게시판 sequence
create sequence bls_board_seq nocache;

-- 게시판 insert test
insert into BLS_BOARD(boardNo, title, memberId, boardDate, cont, ref, restep, relevel)
values (bls_board_seq.nextval, '제목', '아이디', sysdate, '내용', 1, 0, 0)

drop table bls_board

drop sequence bls_board_seq

select * from BLS_BOARD order by ref desc, restep asc 


select * from
(
    select boardNo,
    lead(title,1,'다음 게시물이 존재하지 않습니다') over (order by boardNo) next_title,
    lead(boardNo,1,'0') over (order by boardNo) next_boardNo,
    lag(title,1,'이전 게시물이 존재하지 않습니다') over (order by boardNo) pre_title,
    lag(boardNo,1,'0') over (order by boardNo) pre_boardNo
    from bls_board where relevel='0'
) 
where boardNo='50'


