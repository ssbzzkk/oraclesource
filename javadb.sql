#javadb

--userTBL 테이블 생성
--no(번호-숫자(4)), username(이름-한글(4)), birthYear(년도-숫자(4)), addr(주소-문자(한글,숫자)), mobile(010-1234-1234)
-- no pk 제약조건 지정(제약조건명 pk_userTBL)
DROP TABLE USERTBL;
CREATE TABLE usertbl (
    no        NUMBER(4) constraint pk_userTBL primary key,
    username  NVARCHAR2(10)NOT NULL,
    birthyear NUMBER(4) NOT NULL,
    addr      VARCHAR2(50) NOT NULL,
    mobile    NVARCHAR2(20)
);

--시퀀스 생성
-- user_seq 생성(기본)
CREATE SEQUENCE USER_SEQ;

--insert
-- no: user_seq값 넣기
insert into usertbl(no, username, birthyear, addr, mobile)
            values(user_seq.nextval, '홍길동', '2010', '서울시 종로구 123', '010-1234-5678');
            
 commit; 
 
 
 -- select(+서브쿼리,조인) + DML(insert, delete, update)
-- 전체조회
select* from usertbl;
--개별조회(특정번호,특정이름...)
--여러행이 나오는 상태냐? 하나의 행이 결과로 나올것이냐?
select*from usertbl where no=1;
select*from usertbl where username='홍길동';

-- like : _ or % 랑 같이 씀
select*from usertbl where username like '%홍길동'; --앞에는 상관없고 끝에만 홍길동  %(여러글자), _(한글자)

--insert into 테이블명(필드명1, 필드명2...)
--values();

--update 테이블명
--set 업데이트할 필드명=값, 업데이트할 필드명=값, ...
--where 조건;

--delete 테이블명 where 조건
--delete from 테이블명 where 조건
 
 
 
 
 
 
 --모든 칼럼 not null
 drop table paytype;
--paytype 테이블 생성 : pay_no(숫자-1 pk), info(문자-card,cash)
create table paytype (
        pay_no number(1) primary key,
        info varchar2(10)not null
        );

--paytype_seq 생성
create sequence paytype_seq;

insert into paytype values(paytype_seq.nextval, 'card');
insert into paytype values(paytype_seq.nextval, 'cash');
select*from paytype; -- 1:card, 2:cash

-- user : user_id(숫자(4)-pk), name(문자-한글), pay_no(숫자-1:paytype 테이블에 있는 pay_no참조해서 사용)
create table suser (
    user_id number(4) primary key,
    name varchar2(20) not null,
    pay_no number(1) not null references paytype(pay_no));
    
drop table suser;
 
 --product 테이블
 --product_id(숫자-8-pk), pname(문자), price(숫자), content(문자)
-- create table product (
create table product(
    product_id number(8) primary key,
    pname varchar2(30) not null,
    price number(20) not null,
    content varchar2(50) not null
    );
CREATE SEQUENCE product_seq;
  
 --sorder 테이블
 --order_id(숫자-8-pk), user_id(user테이블 user_id참조), product_id(product테이블의 product_id참조)
 --order_seq생성
 
CREATE TABLE sorder(
    order_id   NUMBER(8) PRIMARY KEY,
    user_id    NUMBER(8) NOT NULL
        REFERENCES suser ( user_id ),
    product_id NUMBER(8) NOT NULL
        REFERENCES product ( product_id )
);

ALTER TABLE sorder ADD order_date DATE; --구매날짜



CREATE SEQUENCE order_seq;

--insert into sorder values(order_seq.nextval,물건을 구매한 id,상품id,sysdate); 



select u.user_id, u.name, u.pay_no, p.info
from suser u, paytype p
where u.pay_no = p.pay_no and u.user_id=1000;

--주문정보 전체 조회
select * from sorder;

--주문목록 조회
--user_id, name, card/cash, product_id, pname, price, content 화면에 띄우기

--기준 sorder
--suser테이블 : name
--paytype테이블 : card/cash
--prodcut테이블 : product_id, pname, price, content

--전체주문목록
select s.user_id, u.name, t.info, p.product_id, p.pname, p.price, p.content, s.order_date
from sorder s, product p, suser u, paytype t
where s.user_id=u.user_id and u.pay_no=t.pay_no and s.product_id=p.product_id;

--홍길동 주문목록 조회
select s.user_id, u.name, t.info, p.product_id, p.pname, p.price, p.content, s.order_date
from sorder s, product p, suser u, paytype t
where s.user_id=u.user_id and u.pay_no=t.pay_no and s.product_id=p.product_id and s.user_id=1000; 

delete from suser where user_id=1111; 
delete from suser where user_id=2222; 

commit;


--도서 테이블
--code, title, writer, price
--code: 1001(pk)
--title : '자바의 신'
--writer : '홍길동'
--price : 25000

--bookTBL 테이블 생성

CREATE TABLE booktbl (
    code   NUMBER(4) primary key, --not null+unique
    title  nVARCHAR2(50) NOT NULL, -- varchr2 : 한글3 byte처리, nvarchar2 : 한글문자 1byte처리
    writer   nVARCHAR2(20) NOT NULL,
    price    number(8) not null
);

insert into booktbl(code, title, writer, price) values(1001, '이것이 자바다', '신용균', 25000);
insert into booktbl(code, title, writer, price) values(1002, '자바의 신', '강신용', 28000);
insert into booktbl(code, title, writer, price) values(1003, '오라클로 배우는 데이터베이스', '이지훈', 28000);
insert into booktbl(code, title, writer, price) values(1004, '자바1000제', '김용만', 29000);
insert into booktbl(code, title, writer, price) values(1005, '자바 프로그래밍 입문', '박은종', 30000);

commit;

alter table booktbl add description nvarchar2(100);

update booktbl
set description = '상세설명'
where code=1001;

commit;

-- member 테이블
-- userid (영어,숫자,특수문자) 최대 12 허용, pk
-- password (영어,숫자,특수문자) 최대 15 허용
-- name (한글) 5자
-- gender (한글) 남 or 여
-- email 
create table membertbl (
    userid varchar2(15) primary key,
    password varchar2(20) not null,
    name nvarchar2(10) not null,
    gender nvarchar2(2) not null,
    email varchar2(50) not null
    );
insert into membertbl values('hong123', 'hong123@','홍길동','남','hong123@gmail.com');
commit;

select count(*) from membertbl where userid='hong123';

-- 게시판 board
-- 글번호(bno 숫자, 시퀀스 삽입, pk(pk_board 제약조건명), 작성자(name, 한글), 비밀번호(password, 숫자, 영문자), 제목(title, 한글), 내용(content, 한글), 파일첨부(attach, 파일명), 
   -- 답변글 작성시 참조되는 글번호(re_ref, 숫자), 답변글 레벨(re_lev, 숫자), 답변글 순서(re_seq, 숫자)
-- 조회수(cnt, 숫자, default 0 지정), 작성날짜(regdate, default 로 sysdate지정)


create table board (
    bno number(8) constraint pk_board primary key,
    name nvarchar2(10) not null,
    password varchar2(20) not null,
    title nvarchar2(50) not null,
    content nvarchar2(1000) not null,
    attach nvarchar2(100),
    re_ref number(8) not null,
    re_lev number(8) not null,
    re_seq number(8) not null,
    cnt number(8) default 0,
    regdate date default sysdate
    );
    
-- 시퀀스 생성 board_seq
create sequence board_seq;

delete board where bno=1;
commit;





























