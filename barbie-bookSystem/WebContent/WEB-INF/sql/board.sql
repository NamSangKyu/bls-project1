create table bls_board(
	boardNo number() primary key,
	title varchar2(100) not null,
	memberId varchar2(20) not null,
	pass varchar2(40) ,
	boardDate date not null,
	count number not null,
	cont varchar2(4000) not null,
	ref number not null,
	restep number not null,
	relevel number not null 
	)
	
	create sequence bls_board_seq nocache;
	