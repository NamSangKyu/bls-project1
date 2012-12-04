--도서 테이블
create table book(
 bookno number primary key,
 title varchar2(100) not null,
 writer varchar2(50) not null,
 isbn number not null,
 loc varchar2(50) not null,
 cont varchar2(4000) not null,
 publisherno number not null,
 subjectno number not null,
 img varchar2(1000),
 constraint publisherno_fk foreign key(publisherno) references publisher(publisherno),
 constraint subjectno_fk foreign key(subjectno) references booksubject(subjectno)
)
--도서분류 테이블
CREATE TABLE booksubject(
 subjectno number PRIMARY KEY,
 subjectname varchar2(50)
)
--출판사 테이블
CREATE TABLE publisher(
 publisherno number PRIMARY KEY,
 publishername varchar2(50)
)
--Book table sequence
create sequence bookno nocache;
--도서분류 sequence
create sequence subjectno nocache;
--출판사 sequence
create sequence publisherno nocache;
