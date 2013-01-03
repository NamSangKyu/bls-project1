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
values(bls_book_seq.nextval, '155123', 'UML 실전에서는 이것만 쓴다', '로버트',
'프로젝트를 진행하려면 UML을 사용해야 하지만, UML은 너무 복잡하고 난해하다. 현업 개발자에게 맞춰 실무 실제 프로젝트에 사용되는, 알아야 하는 UML을 다루었다. UML과 객체지향 설계를 동시에 배우고 싶은 독자들을 위해 실제 설계 예시를 단계별로 분석/설계/구현/검증까지 보여주며, 코드와 다이어그램이 매핑되어 다이어그램을 코드로 즉시 떠올릴 수 있게 소스코드 수준으로 설명해준다. 다양한 프로젝트를 진행해본 저자의 경험에서 우러나온 글이라서, 실제로 프로젝트에 UML을 적용하기로 마음먹은 개발자가 첫 발을 내딛기에 좋다. 각종 다이어그램의 단점과 주의할 점을 딱 집어서 설명해서, UML을 사용하면서 느끼는 궁금증이나 불명확한 부분에 대해 권위 있는 사람이 단정적으로 정리를 해주며, UML을 활용하기 위한 방법론과 리팩토링까지 보여준다.',
'가1나1', '2013/01/03', '2', '3');


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
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'문학');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'동화');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'추리');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'만화');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'잡지');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'여행');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'역사');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'전산');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'자연');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'과학');
insert into bls_book_sbj(subjectNo,subject) values(bls_book_sbj_seq.nextval,'대학');



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
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'한빛미디어');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'황금부엉이');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'위키북스');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'에이콘출판사');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'정보문화사');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'영진닷컴');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'문학사상사');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'이야기공작소');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'시나공');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'한겨레출판');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'서울문화사');
insert into bls_book_pbs values(bls_book_pbs_seq.nextval,'인사이트');

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











