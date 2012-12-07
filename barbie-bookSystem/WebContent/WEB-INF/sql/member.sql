create table bls_member(
memberId varchar2 (50) primary key,
pass varchar2 (50) not null,
name varchar2 (50) not null,
gender varchar2 (20) not null,
email varchar2 (100) not null,
subject1 varchar2 (50) not null,
subject2 varchar2 (50) not null,
subject3 varchar2 (50) not null
)

drop table bls_member

insert into BLS_MEMBER(memberid, pass, name, gender, email, subject1, subject2, subject3) 
values ('choi', '123', '최기웅', '남', 'dddd@naver.com', '미술', '역사', '문화')

select * from BLS_MEMBER







