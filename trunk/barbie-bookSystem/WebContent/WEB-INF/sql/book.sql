--도서 테이블
drop table bls_book;
select * from bls_book;
create sequence bls_book_seq nocache;
drop sequence bls_book_seq;

create table bls_book(
	bookNo number primary key,
	isbn number not null,
 	title varchar2(100) not null,
 	writer varchar2(50) not null,
 	cont varchar2(4000) not null,
 	loc varchar2(50) not null,
 	img varchar2(1000),
 	outputDate date not null,
 	bookState varchar2(50) default '대여가능',
 	subjectNo number not null,
 	publisherNo number not null,
 	constraint subjectNo_fk foreign key(subjectNo) references bls_book_sbj(subjectNo),
 	constraint publisherNo_fk foreign key(publisherNo) references bls_book_pbs(publisherNo)
)

--도서 Test 자료
insert into bls_book(bookNo, isbn, title, writer, cont, loc, outputDate, subjectNo, publisherNo)
values(bls_book_seq.nextval, '155123', '안철수의생각', '안철수', '대한민국 미래지도', '2013/01/02', '가1나1', '1', '1');

--도서분류 테이블
drop table bls_book_sbj;
select * from bls_book_sbj;
create sequence bls_book_sbj_seq nocache;
drop sequence bls_book_sbj_seq;

CREATE TABLE bls_book_sbj(
 	subjectNo number PRIMARY KEY,
 	subject varchar2(50)
)

--분류 Test
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'소설');

--출판사분류 테이블
drop table bls_book_pbs;
select * from bls_book_pbs;
create sequence bls_book_pbs_seq nocache;
drop sequence bls_book_pbs_seq;

CREATE TABLE bls_book_pbs(
 	publisherNo number PRIMARY KEY,
 	publisher varchar2(50)
)

--출판사 Test
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'창작과비평사');


--도서 서평 테이블
drop table bls_book_comment
select * from bls_book_comment
create sequence bls_book_comment_seq nocache;
drop sequence bls_book_comment_seq;

CREATE TABLE bls_book_comment(
 no number PRIMARY KEY,
 isbn number,
 writer varchar2(50),
 bookcomment varchar2(1000),
 score number
)


-- 도서 예약 테이블(사용자)
drop table bls_book_reserve;
select * from bls_book_reserve;

CREATE TABLE bls_book_reserve(
	bookNo number ,
	memberId varchar2(50) ,
	reserveDate date not null,
	PRIMARY KEY(bookNo, memberId),
	constraint bookNoReserve_fk foreign key(bookNo) references bls_book(bookNo),
	constraint memberIReserve_fk foreign key(memberId) references bls_member(memberId)
)

-- 도서 대여 테이블(관리가_대여중)
DROP table bls_book_rental
select * from bls_book_rental;
CREATE sequence bls_book_rental_seq nocache
DROP sequence bls_book_rental_seq

CREATE TABLE bls_book_rental(
	rentalNo number primary key,
	rentalDate date not null,
	returnDate date,
	count number default 0,
	memberId varchar2(50) not null,
	bookNo number not null,
	constraint bookNoRental_fk foreign key(bookNo) references bls_book(bookNo),
	constraint memberIdRental_fk foreign key(memberId) references bls_member(memberId)
)

-- 초기화 시켜줄때
update bls_book set bookState='대여가능'


SELECT MONTHS_BETWEEN(TO_DATE('2000/06/05') , TO_DATE('2000/09/23'))  "Date" FROM dual

-- 반납일이 없을때에
update /*+ bypass_ujvc */
(
   select b.bookState, b.bookNo
   from bls_book b, bls_book_rental r
   where (to_char(sysdate,'yyyymmdd')-to_char(r.rentalDate,'yyyymmdd') )  >1
   and r.bookNo = b.bookNo and r.returnDate is null
) set bookState='대여가능'

-- step1
select bookNo, title, publisher, loc, bookState, over1, (select '예약' as overData from dual where over1 >1) from(
		select b.bookNo, b.title, p.publisher, b.loc, b.bookState, ceil(rownum/5) as page, (
			select (to_char(sysdate,'yyyymmdd')-to_char(r.rentalDate,'yyyymmdd'))
			from bls_book_rental r
			where r.bookNo = b.bookNo and returnDate is null) as over1
		from bls_book b, bls_book_pbs p where b.publisherNo=p.publisherNo)
where page=1
	<![CDATA[     	]]>

---신간도서!! 
select outputDate,isbn, newbook, title, writer, subject, publisher from (
select outputDate, ceil(rownum/5) as page , isbn, newbook, title, writer, subject, publisher from (
select outputDate, isbn, newbook, title, writer, subject, publisher from (
select distinct(b.isbn), trunc (sysdate-outputDate) as newbook,  b.title, b.writer, s.subject, p.publisher, to_char(b.outputDate,'yyyy-mm-dd') as outputDate from bls_book b , BLS_BOOK_PBS p, BLS_BOOK_SBJ s
where s.subjectNo=b.subjectNo and p.publisherNo=b.publisherNo)where newbook<30 order by newbook asc)) where page='1';

--신간도서 전체 count구하기 
select count(*) from (
select distinct(b.isbn), trunc (sysdate-outputDate) as newbook,  b.title, b.writer, s.subject, p.publisher, to_char(b.outputDate,'yyyy-mm-dd') as outputDate from bls_book b , BLS_BOOK_PBS p, BLS_BOOK_SBJ s
where s.subjectNo=b.subjectNo and p.publisherNo=b.publisherNo)where newbook<30;











