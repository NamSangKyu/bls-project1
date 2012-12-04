create table bls_board(
	boardNo number primary key,
	title varchar2(100) not null,
	memberId varchar2(50) not null,
	pass varchar2(50) ,
	boardDate date not null,
	count number default 0,
	cont varchar2(4000) not null,
	ref number not null,
	restep number not null,
	relevel number not null 
)

create sequence bls_board_seq nocache;

insert into BLS_BOARD(boardNo, title, memberId, pass, boardDate, cont, ref, restep, relevel)
values (bls_board_seq.nextval, '하하', 'bls1004', 'gg', sysdate, '으하하하', 1, 0, 0)

select * from BLS_BOARD