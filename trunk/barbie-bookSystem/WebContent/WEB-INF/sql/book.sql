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

insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '1111', '어린왕자', '이기인', '재밌는내용', '가1나2', '1', '1');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '1111', '어린왕자', '이기인', '재밌는내용', '가1나2', '1', '1');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '1111', '어린왕자', '이기인', '재밌는내용', '가1나2', '1', '1');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '1111', '어린왕자', '이기인', '재밌는내용', '가1나2', '1', '1');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '1111', '어린왕자', '이기인', '재밌는내용', '가1나2', '1', '1');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '2222', '어린왕자', '민전기', '재밌는내용', '가3나4', '1', '1');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '3333', '어린왕자', '최기웅', '재밌는내용', '다1나2', '1', '1');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '4444', '어린호희', '조호희', '재밌는내용', '라1나2', '1', '1');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '6666', '어린소년', '민정기', 'ㅎㅎ', '하1나2', '1', '1');
insert into bls_book(bookNo, isbn, title, writer, cont, loc, subjectNo, publisherNo)
values(bls_book_seq.nextval, '7777', '드래곤볼', '최정이', 'ㅎㅎㅎ', '뱌1나2', '1', '1');

update bls_book set bookState='예약중' where bookNo=19;
update bls_book set bookState='대여중' where bookNo=31

select * from bls_book
drop table bls_book

drop table bls_book_sbj;
--도서분류 테이블
CREATE TABLE bls_book_sbj(
 	subjectNo number PRIMARY KEY,
 	subject varchar2(50)
)


drop table bls_book_pbs;
--출판사분류 테이블
CREATE TABLE bls_book_pbs(
 	publisherNo number PRIMARY KEY,
 	publisher varchar2(50)
)

--도서 sequence
create sequence bls_book_seq nocache;

--도서분류 sequence
create sequence bls_book_sbj_seq nocache;

--출판사분류  sequence
create sequence bls_book_pbs_seq nocache;

insert into bls_book_pbs(publisherNo, publisher) values(bls_book_pbs_seq.nextval,'한샘');
insert into bls_book_pbs(publisherNo, publisher) values(bls_book_pbs_seq.nextval,'한국');
insert into bls_book_pbs(publisherNo, publisher) values(bls_book_pbs_seq.nextval,'서울');
insert into bls_book_pbs(publisherNo, publisher) values(bls_book_pbs_seq.nextval,'광주');
insert into bls_book_pbs(publisherNo, publisher) values(bls_book_pbs_seq.nextval,'호이');
insert into bls_book_pbs(publisherNo, publisher) values(bls_book_pbs_seq.nextval,'정');


select title, writer, cont, isbn ,loc, img, s.subject, p.publisher
from BLS_BOOK b, BLS_BOOK_PBS p, BLS_BOOK_SBJ s
where b.subjectno = s.subjectno and b.publisherno = p.publisherno and isbn=2222


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
select b.bookNo, b.title, p.publisher, b.loc, b.bookState from bls_book b, bls_book_pbs p where b.isbn='1234' and b.publisherNo=p.publisherNo

select * from BLS_BOOK_PBS

insert into bls_book_pbs values('1','창작과비평사');
insert into bls_book_pbs values('2','나무');
insert into bls_book_pbs values('3','한솔');
insert into bls_book_pbs values('4','푸른숲나무');
insert into bls_book_pbs values('5','맑은샘');
insert into bls_book_pbs values('6','책과나무');

select * from BLS_BOOK_SBJ;
insert into bls_book_sbj(subjectNo,subject) values('1','소설');
insert into bls_book_sbj(subjectNo,subject) values('2','인문');
insert into bls_book_sbj(subjectNo,subject) values('3','역사');
insert into bls_book_sbj(subjectNo,subject) values('4','정치');
insert into bls_book_sbj(subjectNo,subject) values('5','종교');
insert into bls_book_sbj(subjectNo,subject) values('6','철학');


--도서 서평 테이블
CREATE TABLE bls_book_comment(
	no number PRIMARY KEY,
	isbn number,
	writer varchar2(50),
	bookcomment varchar2(1000),
	score number
)
create sequence bls_book_comment_seq nocache;
--도서 서평 검색
select * from BLS_BOOK_COMMENT where isbn=123123
select * from BLS_BOOK
select  no, isbn, writer, bookcomment, score from (select rownum as cno, no, isbn, writer, bookcomment, score from BLS_BOOK_COMMENT where isbn=1919 order by no desc ) where cno <= 5
select cno, no, isbn, writer, bookcomment, score from (select  rownum as cno, no, isbn, writer, bookcomment, score from (select no, isbn, writer, bookcomment, score from BLS_BOOK_COMMENT where isbn=1919 order by no desc ))
--서평 입력
insert into BLS_BOOK_COMMENT values(bls_book_comment_seq.nextval,isbn,writer,bookcomment,score);
insert into BLS_BOOK_COMMENT values(bls_book_comment_seq.nextval,123123,'named1','comment',5);
--도서 서평 번호
select bls_book_comment_seq.nextval from dual
--해당 도서 평점
select round(avg(score),1) from BLS_BOOK_COMMENT where isbn=123123
select isbn, a_score from (select  isbn, avg(score) as a_score from BLS_BOOK_COMMENT group by isbn) order by a_score desc

select avg(score)

delete from bls_book_comment

--도서 평점으로 5개 출력
select rownum as num, isbn, average from (select rownum as num, isbn, average from(
select isbn, average from (
select isbn, avg(score) as average from BLS_BOOK_COMMENT group by isbn
) order by average desc))

--도서 평점을 가지고 도서 명 까지 출력
select num, r_isbn, average, title, writer, publisher, subject, loc from (
select rownum as num, r_isbn, average, title, writer, publisher, subject, loc from(
select r_isbn, average, title, writer, p.publisher, s.subject, loc from (
select distinct(r_isbn), average, title, writer, publisherNo, subjectNo, loc from bls_book b, (
select rownum as num, isbn as r_isbn, average from (select rownum as num, isbn, average from(
select isbn, average from (
select isbn, avg(score) as average from BLS_BOOK_COMMENT group by isbn
)))) where r_isbn = b.isbn) b, bls_book_sbj s, bls_book_pbs p where b.publisherNo = p.publisherNo and b.subjectNo = s.subjectNo and subject='수험서' order by average desc))
where num < 6
insert into BLS_BOOK_PBS values(bls_book_pbs_seq.nextval,)
select * from BLS_BOOK_PBS
select * from BLS_BOOK_SBJ
insert into BLS_BOOK_SBJ values(bls_book_sbj_seq.nextval,'asd')
