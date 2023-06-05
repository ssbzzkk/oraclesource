--대소문자 구별 하지 않음 (단 비밀번호는 구별함)
-- CREATE : 생성 / ALTER:수정 / DROP : 삭제, DELETE :삭제 
--
--오라클 버전이 변경되면서 사용자 생성시 C##문자를 넣어서 만들도록 변경 됨
-- JAVADB ==> C##JAVADB이런 방식을 C## 사용하지 않겠음

-- 오라클 버전 올라가면서 사용자 생성시 요구하는 접두사 생략을 위해
alter session set "_oracle_script" = true;

-- USER생성은 SYS, SYSTEM 만 가능
-- USER 생성 (공간할당)
-- CREATE USER 사용자이름 IDENTIFIED BY 비밀번호
CREATE USER JAVADB IDENTIFIED BY 12345;
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;
ALTER USER javadb QUOTA 2M ON USERS;

-- GRANT : 권한 부여(사용자 생성만 해서는 아무것도 할 수 없음)
GRANT CONNECT, RESOURCE TO JAVADB;


alter session set "_oracle_script" = true;

--23-3-28 
--사용자 : scott, hr => 데이터베이스 접속하여 데이터를 관리하는 계정
--         테이블, 인덱스, 뷰 등 여러 객체가 사용자별로 생성됨
--         업무에 따라 사용자들을 나눠서 관리

-- 스키마 : 데이터간 관계, 데이터 구조, 제약조건 등 데이터를 관리 저장하기 위해 정의한 데이터베이스 구조의 범위
-- 스키마 == 사용자 (오라클 데이터베이스 경우)

-- 사용자 생성 : 사용자 생성 권한이 필요함 ==> sys, system 


-- 사용자 생성
-- 비밀번호는 대소문자 구별함
CREATE USER SCOTT IDENTIFIED BY TIGER
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

--SCOTT에게 부여된 권한
GRANT CONNECT, RESOURCE TO SCOTT;

--뷰 생성 권한 부여
GRANT CREATE VIEW TO SCOTT;

--시노님 권한 부여
grant create synonym to scott;
grant create public synonym to scott;


select * from all_users;

GRANT UNLIMITED TABLESPACE TO SCOTT;

GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT IDENTIFIED BY TIGER;
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;

-- test사용자 생성 / 비번 12345
CREATE USER test IDENTIFIED BY 12345;

-- 접속권한 부여하지 않으면 안됨

-- 권한 권리
-- 1) 시스템 권한
--    사용자 생성(create user) / 수정(alter user) / 삭제(drop user)
--    데이터베이스 접근 (create session) / 수정 (alter session)
--    여러 객체 생성(view, synonym) 및 관리

-- 2) 객체 권한
--  테이블 수정, 삭제, 인덱스 생성, 삽입, 참조, 조회, 수정
--  뷰 삭제, 삽입, 생성, 조회, 수정
--  시퀀스 수정, 조회
--  프로시저, 함수, 패키지 권한

-- 권한 부여
-- create session 권한을 test에게 부여
grant create session to test;

grant resource, create table to test;

--테이블 스페이스 USERS에 권한이 없습니다.
ALTER USER test DEFAULT TABLESPACE USERS;
ALTER USER test TEMPORARY TABLESPACE TEMP;
ALTER USER test QUOTA 2M ON USERS; --USERS에 공간 설정

-- SCOTT에게 TEST가 생성한 MEMBER테이블 조회 권한 부여
--GRANT SELECT ON MEMBER TO SCOTT;

-- 권한 취소(REVOKE)
--REVOKE SELECT, INSERT ON MEMBER FROM SCOTT;

--롤 : 여러 권한들의 모임
-- CONNECT 롤 : CREATE SESSION 권한 들어있음
-- RESOURCE 롤 : CREATE TRIGGER, CREATE SEQUENCE, CREATE PROCEDURE, CREATE TABLE...

--사용자 삭제(DROP)
DROP USER TEST;
DROP USER TEST CASCADE; -- TEST와 관련된 모든 객체 삭제



--사용자 생성 + 테이블 스페이스 권한 부여
CREATE USER TEST2 IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;
--권한 부여
GRANT CONNECT, RESOURCE TO TEST2;

ALTER USER JAVADB QUOTA UNLIMITED ON USERS;

