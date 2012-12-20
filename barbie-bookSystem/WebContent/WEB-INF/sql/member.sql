create table bls_member(
	memberId varchar2(50) primary key,
	pass varchar2(50) not null,
	name varchar2(50) not null,
	gender varchar2(20) not null,
	email varchar2(100) not null,
	subject1 varchar2(50) not null,
	subject2 varchar2(50) not null,
	subject3 varchar2(50) not null,
	orgfilename varchar2(70) ,
	newfilename varchar2(70)
)
drop table bls_member;

create table bls_book_sbj(
	subjectNo varchar2(50)
	subject varchar2(50)
)

select * from bls_member
insert into bls_member(memberId,pass,name,gender,email,subject1,subject2,subject3)
values('1','2','민전기','0','naver','역사','미술','음악');

update member set

--도서분류 테이블
CREATE TABLE bls_book_sbj(
 	subjectNo number PRIMARY KEY,
 	subject varchar2(50)
)

--도서분류 sequence
create sequence bls_book_sbj_seq nocache;

insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'소설');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'인문');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'역사');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'정치');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'종교');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'철학');





select * from bls_member
delete from bls_member where id='java'








