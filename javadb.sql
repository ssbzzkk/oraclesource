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