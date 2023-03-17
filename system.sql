#대소문자 구별 하지 않음 (단 비밀번호는 구별함)
# CREATE : 생성 / ALTER:수정 / DROP : 삭제, DELETE :삭제 

#오라클 버전이 변경되면서 사용자 생성시 C##문자를 넣어서 만들도록 변경 됨
# JAVADB ==> C##JAVADB이런 방식을 C## 사용하지 않겠음

alter session set "_oracle_script" = true;

# USER생성은 SYS, SYSTEM 만 가능
# USER 생성 (공간할당)
# CREATE USER 사용자이름 IDENTIFIED BY 비밀번호
CREATE USER JAVADB IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

# GRANT : 권한 부여(사용자 생성만 해서는 아무것도 할 수 없음)
GRANT CONNECT, RESOURCE TO JAVADB;


alter session set "_oracle_script" = true;

CREATE USER SCOTT IDENTIFIED BY TIGER
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

GRANT CONNECT, RESOURCE TO SCOTT;
