--scott

-- emp(employee : 사원) 테이블 구성 보기 
-- 필드명(열이름) - 제약조건 - 데이터타입
--  EMPNO(사원번호) NOT NULL    NUMBER(4)
--  ENAME(사원명), JOB(직책), MGR(직속상관번호), HIREDATE(입사일), SAL(급여), COMM(수당), DEPTNO(부서번호)
-- NUMBER : 소수점 자릿수를 포함해서 지정 가능, 숫자형태
-- NUMBER(4) : 4자리 숫자까지 허용, NUMBER(8,2) :전체 자릿수는 8자리이고 소수점 2자리를 포함한다
-- VARCHAR2 : 가변형 문자열 저장
-- VARCHAR2(10) : 10byte 문자까지 저장 가능
-- DATE : 날짜 데이터
desc emp;

-- DEPTNO(부서번호), DNAME(부서명), LOC(부서위치)
DESC DEPT;

--GRADE(급여등급), LOSAL(최소급여액), HISAL(최대 급여액)
DESC salgrade;

--select : 데이터 조회
 --셀렉션(행 단위로 조회), 프로젝션(열 단위로 조회), 조인(두 개 이상의 테이블을 사용하여 조회)

--SELECT 열이름1 열이름2....(조회할 열이 전체라면 * 로 처리)
--FROM 테이블명;

--1. EMP 테이블의 전체 열을 조회
SELECT
    *
FROM
    emp;

--2. EMP 테이블에서 사원번호, 이름, 급여 열을 조회
SELECT
    empno,
    ename,
    sal
FROM
    emp;
    
--3. DEPT 테이블 전체 조회

SELECT
    *
FROM
    dept;
--4. DEPT 테이블안에 부서번호, 지역만 조회
SELECT deptno,
loc;

--5. EMP 테이블안에 부서번호 조회
SELECT
    deptno
FROM
    emp;
--6. EMP 테이블안에 부서번호 조회(단, 중복된 부서 번호는 제거)
--DISTINCT : 중복제거
SELECT DISTINCT
    deptno
FROM
    EMP;
    
-- 열이 여러 개인 경우(묶어서 중복이냐 아니냐를 판단)
    SELECT DISTINCT
 JOB,   deptno
FROM
emp;
    
--7.연산
--사원들의 1년 연봉 구하기 (SAL*12+COMM)
SELECT
    empno,
    ename,
    sal * 12 + comm AS annsal
FROM
    emp;
--별칭 정하기 : 'AS' 필수는 아님 , 한칸띄면 됨, 공백이 있으면 " "로 묶기
SELECT
    empno,
    ename           사원명,
    job             "직  책",
    sal * 12 + comm annsal
FROM
    emp;
    
-- 8. 정렬 : ORDER BY
--          내림차순=> DESC, 오름차순=> ASC

-- ENAME, SAL 열 추출하고, SAL 내림차순으로 정렬
SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal DESC;
    
-- ENAME, SAL 열 추출하고, SAL 오름차순으로 정렬

SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal; 
 -- ASC(오름차순) 은 생략 가능
 
 --전체 내용 출력하고, 결과가 사원번호의 오름차순
SELECT
    *
FROM
    emp
ORDER BY
    empno;
 
 --전체 내용 출력하고, 결과가 부서번호의 오름차순과 급여 내림차순으로 정렬
SELECT
    *
FROM
    emp
ORDER BY
    deptno,
    sal DESC;

--[실습] EMP 테이블의 모든 열 출력
-- EMPNO => employee-no
-- ename ==> emplyee-name
-- mgr => manager
-- sal => salary
-- comm => commission
-- deptno => department_no
-- 부서 번호를 기준으로 내림차순으로 정렬하되 부서번호가 같다면 사원 이름을 기준으로 오름차순 정렬

SELECT
    ename  emplyee_name,
    empno  employee_no,
    mgr    manager,
    sal    salary,
    comm   commission,
    deptno department_no
    
FROM
    emp
ORDER BY
    deptno DESC,
    ename;

-- where : 특정 조건을 기준으로 원하는 행을 조회
-- 부서번호가 30인 데이터만 조회
select *
from emp
where deptno=30; --  '=' : 같다

-- 사원번호가 7782인 사원 조회

select *
from emp
where empno=7782;

-- 부서번호가 30이고(and), 사원직책이 salesman 정보 조회
select *
from emp
where deptno=30 and job='SALESMAN';

-- 사원번호가 7499이고, 부서번호가 30인 행 조회
SELECT *
FROM EMP
WHERE EMPNO=7499 AND DEPTNO=30;

-- 부서번호가 30이거나(OR), 사원직책이 CLERK인 행 조회
SELECT *
FROM EMP
WHERE DEPTNO=30 OR JOB='CLERK';

--산술연산자 : +,=,*,/, mod(나머지 - 표준은 아님(오라클에서만 제공))
--비교연산자 : >,<,<=,>=
--등가비교연산자 : =, !=, <>, ^= (세개다 : 같지 않으면 true, 같을경우 false)
--논리부정연산자 : NOT
--IN 연산자
--BETWEEN A AND B 연산자
--LIKE연산자와 와일드 카드(_, %)
--IS NULL 연산자
--집합연산자 : UNION(합집합-중복제거), UNION ALL(합집합-중복포함), MINUS(차집합), INTERSECT(교집합)

--연산자 우선순위
--  1) 산술연산자 * , /
--  2) 산술연산자 +, -
--  3) 비교연산자
--  4) is null, is not null, like, in 
--  5) BETWEEN A AND B
--  6) NOT
--  7) AND
--  8) OR
-- 우선순위를 줘야 한다면 소괄호 사용 추천


--EMP테이블에서 급여 열에 12를 곱한 값이 36000인 행 조회
SELECT *
FROM EMP
WHERE SAL*12=36000;

--ename 이 f이후의 문자로 시작하는 사원 조회
--문자 표현시 ' ' 만 사용
SELECT *
FROM EMP
WHERE ename >='F';

--job 이 manager 이거나, salesman, clerk사원 조회
SELECT *
FROM EMP
WHERE job='MANAGER' or job='SALESMAN' or job='CLERK';


--SAL 이 3000이 아닌 사원 조회
SELECT *
FROM EMP
WHERE SAL!=3000;

--job 이 manager 이거나, salesman, clerk사원 조회 =>IN 연산자 (하나만이라도 만족되면)
SELECT *
FROM EMP
WHERE job IN('MANAGER','SALESMAN','CLERK');

--job 이 manager 이거나, salesman, clerk 아니라면
SELECT *
FROM EMP
WHERE job not IN('MANAGER','SALESMAN','CLERK');

SELECT *
FROM EMP
WHERE job!='MANAGER' and job<>'SALESMAN' and job^='CLERK';

--부서번호가 10, 20 사원 조회(in사용)
SELECT *
FROM EMP
WHERE deptno in(10,20);

--급여가 2000이상 3000이하인 사원 조회
SELECT *
FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;
-- (NOT) BETWEEN 최소값 AND 최대값;

--LIKE연산자와 와일드 카드(_, %)

--사원 이름이 S로 시작하는 사원 정보 조회
SELECT *
FROM EMP
WHERE ENAME LIKE 'S%';

--사원 이름의 두번째 글자 L인 사원만 조회 
-- '_' : 어떤 값이든 상관없이 한 개의 문자 데이터를 의미
-- '%' : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자 데이터를 의미
SELECT *
FROM EMP
WHERE ENAME LIKE '_L%';

--사원 이름에 AM이 포함된 사원만 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '%AM%';
--사원 이름에 AM이 포함되지 않은 사원만 조회

SELECT *
FROM EMP
WHERE ENAME NOT LIKE '%AM%';


--null : 데이터 값이 완전히 비어 있는 상태

--COMM 이 NULL인 사원조회
select *
from emp
where comm is NULL;

--MGR 이 NULL인 사원조회
select *
from emp
where MGR is NULL;


--MGR 이 NULL인 사원조회
select *
from emp
where MGR is NULL;

-MGR 이 NULL이 아닌 사원조회
select *
from emp
where MGR is NOT NULL;

--집합연산자 : 열의 갯수가 같아야 함
 -- 합집합 (union, union all)
    -- union
select empno, ename, sal, deptno
from emp
where deptno = 10
union
select empno, ename, sal, deptno
from emp
where deptno = 10;

    -- union all
select empno, ename, sal, deptno
from emp
where deptno = 10
union all
select empno, ename, sal, deptno
from emp
where deptno = 10;

-- minus : 차집합
select empno, ename, sal, deptno
from emp
minus
select empno, ename, sal, deptno
from emp
where deptno = 10;

-- intersect : 교집합
select empno, ename, sal, deptno
from emp
intersect
select empno, ename, sal, deptno
from emp
where deptno = 10;

--EMP 테이블에서 사원이름이 S로 끝나는 사원 데이터 조회
SELECT *
FROM emp
WHERE ename LIKE '%S';


--EMP 테이블에서 30번 부서에 근무하는 사원 중에서 직책이 salesman인 사원의
--사원번호, 이름 , 급여 조회(sal 내림차순)
SELECT empno, ename, sal
FROM emp
WHERE deptno=30 and job='SALESMAN'
order by sal desc;

--EMP 테이블을 사용하여 20,30번 부서에 근무하고 있는 사원 중 급여가 2000초과인 사원 조회
--사원번호, 이름, 급여, 부서번호 조회
-- 집합 연산자를 사용하는 방식과 사용하지 않는 방식 두가지를 사용

SELECT empno, ename, sal
FROM emp
WHERE deptno IN(20,30) AND SAL>2000;


SELECT empno, ename, sal
FROM emp
WHERE SAL>2000
MINUS
SELECT empno, ename, sal
FROM emp
WHERE DEPTNO=10;

SELECT empno, ename, sal
FROM emp
WHERE SAL>2000 AND DEPTNO=20
UNION
SELECT empno, ename, sal
FROM emp
WHERE SAL>2000 AND DEPTNO=30;


--사원 이름에 E가 포함되어 있는 30번 부서 사원 중 급여가 1000~2000 사이가 아닌 사원의 
--이름, 사원번호, 급여, 부서번호를 조회
SELECT ename,empno, sal, DEPTNO
FROM emp
WHERE deptno=30 and ENAME LIKE '%E%' AND SAL NOT BETWEEN 1000 AND 2000;

--추가 수당이 존재하지 않으며, 상급자가 있고 직책이 MANAGER, CLERK인 사원 중에서 
--사원 이름의 두번째 글자가 L이 아닌 사원의 정보 조회
SELECT *
FROM emp
WHERE COMM IS NULL AND MGR IS NOT NULL AND JOB IN('MANAGER','CLERK') AND ENAME NOT LIKE'_L%';


-- 오라클 함수
-- 오라클에서 기본으로 제공하는 내장 함수와 사용자가 필요에 의해 직접 정의한 사용자 정의 함수


--1.문자열 함수
--1)UPPER, LOWER, INITCAP
--  UPPER:모두 대문자, LOWER:모두 소문자, INITCAP:첫 글자만 대문자
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP;

--예시
SELECT *
FROM EMP
WHERE UPPER(ENAME) = 'FORD';

SELECT *
FROM EMP
WHERE UPPER(ENAME) like UPPER('%ford%');

--2)LENGTH : 문자열 길이
SELECT ENAME, LENGTH(ENAME)
FROM EMP;
-- 사원 이름의 길이가 5이상인 사원 조회
SELECT ENAME,
    length ( ename ) FROM emp WHERE
        length(ename) >= 5;
--한글일 때
-- DUAL : SYS가 소유하는 테이블 (임시 연산이나 함수의 결과 값 확인하는 용도)
-- LENGTHB : 실제 사용하는 BYTE 수 ( 영어 문자1=>1byte, 한글 문자1=>3byte)
SELECT LENGTH('한글'), LENGTHB('한글'),LENGTHB('ab'),LENGTHB('a'),LENGTHB('하')
FROM DUAL;

--3) SUBSTR(문자열데이터, 시작위치, 추출길이) : 추출길이 생략 가능(시작위치부터 끝까지)
-- 문자열 일부 추출
SELECT JOB, SUBSTR(JOB, 1,2), SUBSTR(JOB,3,2), SUBSTR(JOB,5), SUBSTR(JOB,-3), SUBSTR(JOB,-3)
FROM EMP;

--ENAME, 세번째 글자부터 출력
SELECT ENAME, SUBSTR(ENAME,3)
FROM EMP;

--4) INSTR : 문자열 데이터 안에서 특정 문자 위치 찾기
-- INSTR(대상문자열, 위치를 찾으려는 문자열, 대상문자열에서 찾기를 시작할 위치(선택), 시작위치에서 찾으려는 문자가 몇번째인지 지정(선택))

--HELLO, ORACLE! 문자열에서 L 문자열 찾기
SELECT INSTR('HELLO, ORACLE!','L') AS INSTR_1, INSTR('HELLO, ORACLE!','L',5) AS INSTR_2, INSTR('HELLO, ORACLE!','L', 2,2) AS INSTR_3
FROM DUAL;

--5) REPLACE : 특정 문자를 다른 문자로 변경
 -- REPLACE(문자열데이터, 찾는문자, 변경문자)
--010-1234-5678  -를 빈 문자열로 변경
SELECT '010-1234-5678' AS 변경전, REPLACE('010-1234-5678','-',' ')
FROM DUAL;
-- '이것이 Oracle 이다', '이것이 --> This is 변경
select '이것이 Oracle 이다', replace('이것이 Oracle 이다','이것이','This is')
from dual;

--6)concat : 두 문자열 데이터 합치기(두개 밖에 안됨, concat또 써서 연결해야함)
-- || : 문자열 연결 연산자
select concat(empno, ename)
from emp;

select concat(empno,concat(':', ename))
from emp;

select empno||':'|| ename
from emp;

--7) TRIM, LTRIM, RTRIM : 공백 포함 특정 문자 제거
-- ' ORACLE' ='ORACLE' -->FALSE 
SELECT '            DLRJTDL               ',TRIM('            DLRJTDL               ')
FROM DUAL;