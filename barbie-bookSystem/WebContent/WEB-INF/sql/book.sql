--도서 테이블
drop table bls_book;
select * from BLS_BOOK;

create table bls_book(
	bookNo number primary key,
	isbn number not null,
 	title varchar2(100) not null,
 	writer varchar2(50) not null,
 	cont varchar2(4000) not null,
 	loc varchar2(50) not null,
 	img varchar2(1000),
 	bookState varchar2(50) default '대여가능',
 	subjectNo number not null,
 	publisherNo number not null,
 	constraint subjectNo_fk foreign key(subjectNo) references bls_book_sbj(subjectNo),
 	constraint publisherNo_fk foreign key(publisherNo) references bls_book_pbs(publisherNo)
)

--도서 Test 자료
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '155123', '안철수의생각', '안철수', '대한민국 미래지도', '가1나1', '1', '1');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '155123', '안철수의생각', '안철수', '대한민국 미래지도', '가1나1', '1', '1');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '155123', '안철수의생각', '안철수', '대한민국 미래지도', '가1나1', '1', '1');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '155123', '안철수의생각', '안철수', '대한민국 미래지도', '가1나1', '1', '1');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '155123', '안철수의생각', '안철수', '대한민국 미래지도', '가1나1', '1', '1');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '152334', '어린왕자', '생텍쥐페리', '희망하는 삶', '가1나2', '2', '2');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '152334', '어린왕자', '생텍쥐페리', '희망하는 삶', '가1나2', '2', '2');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '152336', '아프니까 청춘이다', '김난도', '20대 멘토링 편지', '가1나3', '3', '3');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '152336', '아프니까 청춘이다', '김난도', '20대 멘토링 편지', '가1나3', '3', '3');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '152336', '아프니까 청춘이다', '김난도', '20대 멘토링 편지', '가1나3', '3', '3');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '152336', '아프니까 청춘이다', '김난도', '20대 멘토링 편지', '가1나3', '3', '3');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '152336', '아프니까 청춘이다', '김난도', '20대 멘토링 편지', '가1나3', '3', '3');

--도서분류 테이블
drop table bls_book_sbj;

CREATE TABLE bls_book_sbj(
 	subjectNo number PRIMARY KEY,
 	subject varchar2(50)
)

--출판사분류 테이블
drop table bls_book_pbs;

CREATE TABLE bls_book_pbs(
 	publisherNo number PRIMARY KEY,
 	publisher varchar2(50)
)

--도서 sequence
create sequence bls_book_seq nocache;
drop sequence bls_book_seq;
--도서분류 sequence
create sequence bls_book_sbj_seq nocache;
drop sequence bls_book_sbj_seq;
--출판사분류  sequence
create sequence bls_book_pbs_seq nocache;
drop sequence bls_book_pbs_seq;

--도서대여 테이블
create table bls_book_mgt(
 bookMgtNo number primary key,
 rentalDate date,
 returnDate date,
 count number default 0,
 memberId varchar2(50) not null,
 bookNo number not null,
 constraint memberId_fk foreign key(memberId) references bls_member(memberId),
 constraint bookNo_fk foreign key(bookNo) references bls_book(bookNo)
)

--출판사 등록
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'창작과비평사');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'나무');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'한솔');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'푸른숲나무');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'맑은샘');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'책과나무');
--분류 등록
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'소설');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'인문');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'역사');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'정치');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'종교');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'철학');

--도서 서평 테이블
CREATE TABLE bls_book_comment(
 no number PRIMARY KEY,
 isbn number,
 writer varchar2(50),
 bookcomment varchar2(1000),
 score number
)
create sequence bls_book_comment_seq nocache;
