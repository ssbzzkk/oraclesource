-- PL/SQL : SQL 만으로는 구현이 어렵거나 구현 불가능한 작업을 수행하기 위해 오라클에서 제공하는 프로그래밍 언어

-- 실행 결과를 화면에 출력
SET SERVEROUTPUT ON;
--블록 : DECLEAR~ BEGING~ END
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello PL/SQL');
END;
/

--변수 선언
DECLARE
    V_EMPNO NUMBER(4) :=7788;  -- := 대입
    V_ENAME VARCHAR2(10);
BEGIN --해야하는일
    V_ENAME :='SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
 END;
    /

--상수 선언
DECLARE
    V_TAX CONSTANT NUMBER(4) :=7788;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);
END;
/
  
--변수+DEFAULT
DECLARE
    V_TAX NUMBER(4) DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);
END;
/  

--변수+NOT NULL
DECLARE
    V_TAX NUMBER(4) NOT NULL :=10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);
END;
/  

--변수+NOT NULL+DEFAULT
DECLARE
    V_TAX NUMBER(4) NOT NULL DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);
END;
/  

-- 변수와 상수의 자료형
-- 스칼라 : 오라클이 사용하는 타입 (NUMBER, CHAR, VARCHAR2,DATE ...
-- 참조형 : 오라클 데이터 베이스에 존재하는 특정 테이블의 열의 자료형이나 하나의 행 구조를 참조
--  1) 변수이름 테이블명.열이름%TYPE : 특정 테이블에 속한 열과 같은 크기의 자료형을 사용
--  2) 변수이름 테이블명%ROWTYPE : 특정 테이블에 속한 행구조 전체 참조

DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE:=50;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || v_deptno);
END;
/  

DECLARE
    -- V_DEPT_ROW 변수가 DEPT 테이블의 한 행의 구조를 참조
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
    SELECT DEPTNO, DNAME, LOC INTO V_DEPT_ROW
    FROM DEPT
    WHERE DEPTNO=40;
    
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || v_dept_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('V_DNAME : ' || v_dept_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('V_LOC : ' || v_dept_ROW.LOC);
END;
/  

-- 조건문 : IF, IF~THEN~END IF,
DECLARE
    V_NUMBER NUMBER:=14;
BEGIN
    --V_NUMBER 값이 홀수인지 짝수인지 구별
    -- MOD() : 나머지를 구하는 오라클 함수
    IF MOD(V_NUMBER,2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수');
    ELSE
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 짝수');
    END IF;
END;
/  

-- 학점 출력 (IF ELSIF 문)
DECLARE
    V_NUMBER NUMBER:=97;
BEGIN
    IF V_NUMBER >=90 THEN
        DBMS_OUTPUT.PUT_LINE('A학점');
    ELSIF V_NUMBER >=80 THEN
        DBMS_OUTPUT.PUT_LINE('B학점');
    ELSIF V_NUMBER >=70 THEN
        DBMS_OUTPUT.PUT_LINE('C학점');
    ELSIF V_NUMBER >=60 THEN
        DBMS_OUTPUT.PUT_LINE('D학점');        
    ELSE      
        DBMS_OUTPUT.PUT_LINE('F학점');
    END IF;
END;
/  
-- 학점 출력 (CASE 문)
DECLARE
    V_NUMBER NUMBER:=97;
BEGIN
    CASE TRUNC(V_NUMBER/10)
    WHEN 10 THEN
        DBMS_OUTPUT.PUT_LINE('A학점');
    WHEN 9 THEN
        DBMS_OUTPUT.PUT_LINE('A학점');           
     WHEN 8 THEN
        DBMS_OUTPUT.PUT_LINE('B학점');
     WHEN 7 THEN
        DBMS_OUTPUT.PUT_LINE('C학점');
     WHEN 6 THEN
        DBMS_OUTPUT.PUT_LINE('D학점');        
    ELSE      
        DBMS_OUTPUT.PUT_LINE('F학점');
    END CASE;
END;
/  
-- 학점 출력 (CASE 문-범위)
DECLARE
    V_NUMBER NUMBER:=67;
BEGIN
    CASE 
    WHEN V_NUMBER>=90 THEN
        DBMS_OUTPUT.PUT_LINE('A학점');          
    WHEN V_NUMBER>=80 THEN
        DBMS_OUTPUT.PUT_LINE('B학점');
    WHEN V_NUMBER>=70 THEN
        DBMS_OUTPUT.PUT_LINE('C학점');
    WHEN V_NUMBER>=60 THEN
        DBMS_OUTPUT.PUT_LINE('D학점');        
    ELSE      
        DBMS_OUTPUT.PUT_LINE('F학점');
    END CASE;
END;
/  

-- 반복문
-- LOOP ~ END LOOP, WHILE LOOP, FOR LOOP, Cusor FOR LOOP

--LOOP ~ END LOOP 문
DECLARE
    V_NUM NUMBER:=0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('V_NUM : ' || v_NUM);
        V_NUM := V_NUM+1;
        EXIT WHEN V_NUM>4;
    END LOOP;
END;
/  

--WHILE LOOP 문
DECLARE
    V_NUM NUMBER:=0;
BEGIN
    WHILE V_NUM <4 LOOP
        DBMS_OUTPUT.PUT_LINE('V_NUM : ' || v_NUM);
        V_NUM := V_NUM+1;
    END LOOP;
END;
/  
--FOR 문 : FOR i IN 시작값..종료값 LOOP
--         반복 수행 작업;
--         END LOOP;
BEGIN
    FOR i IN 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('i : ' || i);
    END LOOP;
END;
/  
--FOR - REVERSE 문
BEGIN
    FOR i IN REVERSE 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('i : ' || i);
    END LOOP;
END;
/  

--FOR - CONTINUE WHEN ~ 일땐 건너띔
BEGIN
    FOR i IN 0..4 LOOP
        CONTINUE WHEN MOD(i,2)=1;
       DBMS_OUTPUT.PUT_LINE('i : ' || i);
    END LOOP;
END;
/  

-- 1~10까지 홀수만 출력
BEGIN
    FOR i IN 1..10 LOOP
        CONTINUE WHEN MOD(i,2)=0;
       DBMS_OUTPUT.PUT_LINE('i : ' || i);
    END LOOP;
END;
/  
BEGIN
    FOR i IN 1..10 LOOP
        IF I MOD 2=1 THEN
       DBMS_OUTPUT.PUT_LINE('i : ' || i);
       END IF;
    END LOOP;
END;
/  

