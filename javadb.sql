javadb.sql
-- javadb

-- userTBL 테이블 생성
-- no(번호-숫자(4)), username(이름-한글(4)), birthYear(년도-숫자(4)), addr(주소-문자(한글,숫자)), mobile(010-1234-1234)
-- no pk 제약조건 지정(제약조건명 pk_userTBL)

CREATE TABLE usertbl (
    no        NUMBER(4)
        CONSTRAINT pk_usertbl PRIMARY KEY,
    username  NVARCHAR2(10) NOT NULL,  -- varchar2(20)
    birthyear NUMBER(4) NOT NULL,
    addr      NVARCHAR2(50) NOT NULL,      -- varchar2(50)
    mobile    NVARCHAR2(20)
);            -- varchar2(20)

DROP TABLE usertbl;


-- select(+서브쿼리,조인) + DML(insert,delete,update)
-- 전체조회
SELECT
    *
FROM
    usertbl;

-- 개별조회(특정번호, 특정이름...)
-- 여러행이 나오는 상태냐? 하나의 행이 결과로 나올것이냐?
SELECT
    *
FROM
    usertbl
WHERE
    no = 1;

SELECT
    *
FROM
    usertbl
WHERE
    username = '홍길동';

-- like : _ or %
SELECT
    *
FROM
    usertbl
WHERE
    username LIKE '_길동%';

--insert into 테이블명(필드명1,필드명2..)
--values();

--update 테이블명
--set 업데이트할 필드명=값, 업데이트할 필드명=값,.....
--where 조건;

--delete 테이블명 where 조건

--delete from 테이블명 where 조건


-- 시퀀스 생성
-- user_seq 생성(기본)

CREATE SEQUENCE user_seq;


-- insert
-- no : user_seq 값 넣기
INSERT INTO usertbl (
    no,
    username,
    birthyear,
    addr,
    mobile
) VALUES (
    user_seq.NEXTVAL,
    '홍길동',
    2010,
    '서울시 종로구 123',
    '010-1234-5678'
);

COMMIT;

-- 모든 컬럼 not null

-- paytype : pay_no(숫자-1 pk), info(문자-card, cash)
-- paytype_seq 생성

CREATE TABLE paytype (
    pay_no NUMBER(1) PRIMARY KEY,
    info   VARCHAR2(10) NOT NULL
);

CREATE SEQUENCE paytype_seq;

INSERT INTO paytype VALUES (
    paytype_seq.NEXTVAL,
    'card'
);

INSERT INTO paytype VALUES (
    paytype_seq.NEXTVAL,
    'cash'
);

SELECT
    *
FROM
    paytype; -- 1 : card, 2 : cash

-- suser : user_id(숫자-4 pk) , name(문자-한글), pay_no(숫자-1 : paytype 테이블에 있는 pay_no 참조 해서 사용)
CREATE TABLE suser (
    user_id NUMBER(4) PRIMARY KEY,
    name    VARCHAR2(20) NOT NULL,
    pay_no  NUMBER(1) NOT NULL
        REFERENCES paytype ( pay_no )
);

SELECT
    *
FROM
    suser;

-- product
-- product_id(숫자-8 pk), pname(문자), price(숫자), content(문자)
CREATE TABLE product (
    product_id NUMBER(8) PRIMARY KEY,
    pname      VARCHAR2(30) NOT NULL,
    price      NUMBER(8) NOT NULL,
    content    VARCHAR2(50) NOT NULL
);

CREATE SEQUENCE product_seq;

-- sorder
-- order_id(숫자-8 pk), user_id(user 테이블의 user_id 참조), product_id(product 테이블의 product_id 참조)
-- order_seq 생성

CREATE TABLE sorder (
    order_id   NUMBER(8) PRIMARY KEY,
    user_id    NUMBER(4) NOT NULL
        REFERENCES suser ( user_id ),
    product_id NUMBER(8) NOT NULL
        REFERENCES product ( product_id )
);

ALTER TABLE sorder ADD order_date DATE; -- 구매날짜

CREATE SEQUENCE order_seq;

--INSERT INTO sorder VALUES(order_seq.nextval,물건을 구매한id,상품id,sysdate);

DELETE product
WHERE
    product_id = 1001;

SELECT
    *
FROM
    sorder;

COMMIT;

SELECT
    *
FROM
    suser   u,
    paytype p
WHERE
    u.pay_no = p.pay_no;

SELECT
    u.user_id,
    u.name,
    u.pay_no,
    t.info,
    p.product_id,
    p.pname,
    p.price,
    p.content,
    s.order_date
FROM
    suser   u,
    sorder  s,
    product p,
    paytype t
WHERE
        s.user_id = u.user_id
    AND u.pay_no = t.pay_no
    AND s.product_id = p.product_id;


-- 도서 테이블
-- code, title, writer, price
-- code : 1001(pk)
-- title : '자바의 신' (varchar2 or nvarchar2 ==> 한글 varchar2 : 한글 3byte 처리, nvarchar2 : 한글 문자 갯수만큼)
-- writer : '홍길동'
-- price : 25000

-- bookTBL 테이블 생성
CREATE TABLE booktbl (
    code   NUMBER(4) PRIMARY KEY,  -- not null+unique
    title  NVARCHAR2(50) NOT NULL,
    writer NVARCHAR2(20) NOT NULL,
    price  NUMBER(8) NOT NULL
);

INSERT INTO booktbl (
    code,
    title,
    writer,
    price
) VALUES (
    1001,
    '이것이 자바다',
    '신용균',
    25000
);

INSERT INTO booktbl (
    code,
    title,
    writer,
    price
) VALUES (
    1002,
    '자바의 신',
    '강신용',
    28000
);

INSERT INTO booktbl (
    code,
    title,
    writer,
    price
) VALUES (
    1003,
    '오라클로 배우는 데이터베이스',
    '이지훈',
    28000
);

INSERT INTO booktbl (
    code,
    title,
    writer,
    price
) VALUES (
    1004,
    '자바 1000제',
    '김용만',
    29000
);

INSERT INTO booktbl (
    code,
    title,
    writer,
    price
) VALUES (
    1005,
    '자바 프로그래밍 입문',
    '박은종',
    30000
);

COMMIT;

ALTER TABLE booktbl ADD description NVARCHAR2(100);

UPDATE booktbl
SET
    description = '자바로 '
WHERE
    code = 1004;


-- member 테이블 (membertbl) not null
-- userid (영어,숫자,특수문자) 최대 12 허용, pk
-- password (영어,숫자,특수문자) 최대 15 허용
-- name (한글) 
-- gender (한글-남 or 여)
-- email 
CREATE TABLE membertbl (
    userid   VARCHAR2(15) PRIMARY KEY,
    password VARCHAR2(20) NOT NULL,
    name     NVARCHAR2(10) NOT NULL,
    gender   NVARCHAR2(2) NOT NULL,
    email    VARCHAR2(50) NOT NULL
);

INSERT INTO membertbl VALUES (
    'hong123',
    'hong123@',
    '홍길동',
    '남',
    'hong123@gmail.com'
);

COMMIT;

SELECT
    COUNT(*)
FROM
    membertbl
WHERE
    userid = 'kim123@';

-- 게시판 board
-- 글번호(bno, 숫자, 시퀀스 삽입, pk(pk_board 제약조건명), 작성자(name, 한글), 비밀번호(password, 숫자,영문자), 제목(title, 한글),
-- 내용(content, 한글), 파일첨부(attach, 파일명), 답변글 작성시 참조되는 글번호(re_ref, 숫자), 답변글 레벨(re_lev 숫자),
-- 답변글 순서(re_seq, 숫자)
-- 조회수(cnt, 숫자, default 0 지정), 작성날짜(regdate, default 로 sysdate 지정)

CREATE TABLE board (
    bno      NUMBER(8)
        CONSTRAINT pk_board PRIMARY KEY,
    name     NVARCHAR2(10) NOT NULL,
    password VARCHAR2(20) NOT NULL,
    title    NVARCHAR2(50) NOT NULL,
    content  NVARCHAR2(1000) NOT NULL,
    attach   NVARCHAR2(100),
    re_ref   NUMBER(8) NOT NULL,
    re_lev   NUMBER(8) NOT NULL,
    re_seq   NUMBER(8) NOT NULL,
    cnt      NUMBER(8) DEFAULT 0,
    regdate  DATE DEFAULT sysdate
);

-- 시퀀스 생성 board_seq 
CREATE SEQUENCE board_seq;

SELECT
    *
FROM
    board;

SELECT
    *
FROM
    board
WHERE
    bno = 5;

SELECT
    *
FROM
    board
WHERE
    name = '홍길동';

UPDATE board
SET
    title = '',
    content = ''
WHERE
        bno = 3
    AND password = '12345';

UPDATE board
SET
    title = '',
    content = '',
    attach = ''
WHERE
        bno = 3
    AND password = '12345';


-- 서브쿼리

INSERT INTO board (
    bno,
    name,
    password,
    title,
    content,
    re_ref,
    re_lev,
    re_seq
)
    (
        SELECT
            board_seq.NEXTVAL,
            name,
            password,
            title,
            content,
            board_seq.CURRVAL,
            re_lev,
            re_seq
        FROM
            board
    );
    
commit;


-- 댓글
-- re_ref, re_lev, re_seq

-- 원본글 작성 re_ref : bno 값과 동일
--             re_lev : 0, re_seq : 0


select bno, title, re_ref, re_lev, re_seq from board where bno=8193;

-- re_ref : 그룹번호, re_seq : 그룹 내에서 댓글의 순서, 
-- re_lev : 그룹 내에서 댓글의 깊이(원본글의 댓글인지? 댓글의 댓글인지?)

-- 댓글도 새글임 => insert 작업
--                  bno : board_seq.nextval
--                  re_ref : 원본글의 re_ref 값과 동일
--                  re_seq : 원본글의 re_seq + 1
--                  re_lev : 원본글의 re_lev + 1


-- 첫번째 댓글 작성
insert into board(bno,name,password,title,content,attach,re_ref,re_lev,re_seq) 
values(board_seq.nextval,'김댓글','12345','Re : 게시글','게시글 댓글',null,8193,1,1);

commit;

-- 가장 최신글과 댓글 가지고 오기(+ re_seq asc : 댓글의 최신)
select bno, title, re_ref, re_lev, re_seq from board where re_ref=8193 order by re_seq;

-- 두번째 댓글 작성
-- re_seq 가 값이 작을수록 최신글임

-- 기존 댓글이 있는가? 기존 댓글의 re_seq 변경을 한 후 insert 작업 해야 함

-- update 구문에서 where => re_ref 는 원본글의 re_ref 값, re_seq 비교구문은 원본글의 re_seq 값과 비교

update board set re_seq = re_seq + 1 where re_ref = 8193 and re_seq > 2;

commit;

insert into board(bno,name,password,title,content,attach,re_ref,re_lev,re_seq) 
values(board_seq.nextval,'김댓글','12345','Re : 게시글2','게시글 댓글2',null,8193,1,1);


-- 댓글의 댓글 작성
-- update / insert

update board set re_seq = re_seq + 1 where re_ref = 8193 and re_seq > 2;


insert into board(bno,name,password,title,content,attach,re_ref,re_lev,re_seq) 
values(board_seq.nextval,'김댓글','12345','ReRe : 게시글','댓글의 댓글',null,8193,2,3);


-- 페이지 나누기
-- rownum : 조회된 결과에 번호를 매겨줌
--          order by 구문에 index 가 들어가지 않는다면 제대로 된 결과를 보장하지 않음
--          pk 가 index로 사용됨


select rownum, bno, title from board order by bno desc;

select /*+INDEX_DESC(board pk_board)*/ rownum, bno, title from board;

select rownum, bno, title, re_ref, re_lev, re_seq 
from board order by re_ref desc, re_seq asc;

-- 해결
-- order by 구문을 먼저 실행한 후 rownum 붙여야 함

select rownum, bno, title, re_ref, re_lev, re_seq
from (select bno, title, re_ref, re_lev, re_seq 
      from board order by re_ref desc, re_seq asc)
where rownum <= 30;

-- 한 페이지에 30개의 목록을 보여준다 할 때
-- 1 2 3 4 5 6 .......
-- 1 page 요청 (1 ~ 30)
-- 2 page 요청 (31 ~ 60)
-- 3 page 요청 (61 ~ 90)

select *
from (select rownum rnum, bno, title, re_ref, re_lev, re_seq
      from (select bno, title, re_ref, re_lev, re_seq 
            from board order by re_ref desc, re_seq asc)
      where rownum <= 90)
where rnum > 60;


select *
from (select rownum rnum, bno, title, re_ref, re_lev, re_seq
      from (select bno, title, re_ref, re_lev, re_seq 
            from board order by re_ref desc, re_seq asc)
      where rownum <= ?)
where rnum > ?;

-- 1 page : rnum > 0, rownum <= 30
-- 2 page : rnum > 30, rownum <= 60
-- 3 page : rnum > 60, rownum <= 90

-- 1,2,3 
-- rownum 값 : 페이지번호 * 한 페이지에 보여줄 목록 개수
-- rnum 값 : (페이지번호-1) * 한 페이지에 보여줄 목록 개수



select *
from (select rownum rnum, bno, title, re_ref, re_lev, re_seq
      from (select bno, title, re_ref, re_lev, re_seq 
            from board order by re_ref desc, re_seq asc)
      where rownum <= 90)
where rnum > 60;


select count(*) from board;


select count(*) from board where title like '%게시글%';


------ spring_board 
-- bno 숫자(10) 제약조건 pk 제약조건명 pk_spring_board
-- title varchar2(200) 제약조건 not null
-- content varchar2(2000) 제약조건 not null
-- writer varchar2(50) 제약조건 not null
-- regdate date default 로 현재시스템날짜
-- updatedate date default 로 현재시스템날짜
create table spring_board(
    bno number(10) constraint pk_spring_board primary key,
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate);

-- 시퀀스 seq_board
create sequence seq_board;


-- mybatis 연습용 테이블
create table person(
    id varchar2(20) primary key,
    name varchar2(30) not null);
    
select * from person;

insert into person values('kim123','김길동');

commit;


-- 트랜잭션 테스트 테이블
-- 트랜잭션 : 하나의 업무에 여러개의 작은 업무들이 같이 묶여 있음 / 하나의 단위로 처리
-- 계좌이체 : 계좌 출금 => 타 계좌 입금

create table tbl_sample1(col1 varchar2(500));
create table tbl_sample2(col1 varchar2(50));

select * from tbl_sample1;
select * from tbl_sample2;

delete tbl_sample1;
commit;


ALTER TABLE membertbl MODIFY
    password varchar2(100);


-- 페이지 나누기(GET 방식)
-- rownum : 조회된 결과에 번호를 매겨줌
-- spring_board : bno 가 pk 상황(order by 기준도 bno)
-- 1 page : 가장 최신글 20개 
-- 2 page : 그 다음 최신글 20개

insert into spring_board(bno,title,content,writer)
(select seq_board.nextval,title,content,writer from spring_board);

commit;

select count(*) from spring_board;

-- 페이지 나누기를 할 때 필요한 sql 코드
select * 
from (select rownum rn, bno, title, writer
      from (select bno, title, writer from spring_board order by bno desc)
      where rownum <= 20)
where rn>0;


-- 오라클 힌트 사용
select bno, title, writer,regdate,updatedate
from (select /*+INDEX_DESC(spring_board pk_spring_board)*/ rownum rn, bno, title, writer,regdate,updatedate
      from spring_board
      where rownum <= 40)
where rn > 20;

commit;

--댓글 테이블
create table spring_reply(
rno number(10,0) constraint pk_reply primary key, --댓글 글번호
bno number(10,0) not null,                        --원본글 글번호
reply varchar2(1000) not null,                    --댓글 내용
replyer varchar2(50) not null,                    --댓글 작성자
replydate date default sysdate,                   --댓글 작성날짜
constraint fk_reply_board foreign key(bno) references spring_board(bno) --외래키 제약조건
);

--댓글 테이블 수정(컬럼 추가) updatedate
alter table spring_reply add updatedate date default sysdate;

create sequence seq_reply;
commit;

select* from spring_board order by bno desc;

insert into spring_reply(rno, bno, reply, replyer)
values(seq_reply.nextval, 272,'댓글을 달아요', 'test1');
commit;

--spring_reply 인덱스 추가 설정
create index idx_reply on spring_reply(bno desc, rno asc);

select rno, bno, reply, replyer,replydate,updatedate
from (select /*+INDEX(spring_reply idx_reply)*/ rownum rn,rno, bno, reply,replyer,replydate, updatedate
      from spring_reply
      where bno=272 and rownum <= 10)
where rn > 0;

--spring_board에 칼럼 추가(댓글 수 저장)
alter table spring_board add replycnt number default 0;
--이미 들어간 댓글 수 삽입
update spring_board
set replycnt=(select count(rno) from spring_reply where spring_board.bno=spring_reply.bno);
select * from spring_board where bno=272;





