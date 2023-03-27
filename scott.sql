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
SELECT '            DLRJTDL               ',TRIM('            DLRJTDL               ')00
FROM
dual;

--2.숫자합수
 -- 1) ROUND, TRUNC, CEIL, FLOOR, MOD
  --  round : 반올림
  --  round(숫자, 반올림 위치(선택))
SELECT
    round(1234.5678)      AS round,     --소수점 첫째 자리에서 반올림,  1235
    round(1234.5678, 0)   AS round0,         --소수점 첫째 자리에서 반올림,  1235
    round(1234.5678, 1)   AS round1,         --소수점 둘째 자리에서 반올림,  1234.6
    round(1234.5678, 2)   AS round2,         --소수점 셋째 자리에서 반올림,  1234.57
    round(1234.5678, - 1) AS round_minus1,  --자연수 첫째 자리에서 반올림,  1230
    round(1234.5678, - 2) AS round_minus2   --자연수 첫째 자리에서 반올림,  1200
FROM
    dual;

  --  trunc : 특정 위치에서 버리는 함수
  --  trunc(숫자, 버림위치(선택))
SELECT
    trunc(1234.5678)      AS trunc,     --소수점 첫째 자리에서 버림,  1234
    trunc(1234.5678, 0)   AS trunc0,         --소수점 첫째 자리에서 버림,  1234
    trunc(1234.5678, 1)   AS trunc1,         --소수점 둘째 자리에서 버림,  1234.5
    trunc(1234.5678, 2)   AS trunc2,         --소수점 셋째 자리에서 버림,  1234.56
    trunc(1234.5678, - 1) AS trunc_minus1,  --자연수 첫째 자리에서 버림,  1230
    trunc(1234.5678, - 2) AS trunc_minus2   --자연수 첫째 자리에서 버림,  1200
FROM
    dual;

  --  ceil(숫자), floor(숫자) : 입력된 숫자와 가까운 큰 정수, 작은정수
SELECT
    ceil(3.14),    -- 4
    floor(3.14),   -- 3 
    ceil(- 3.14),  -- -3
    floor(- 3.14)  -- -4
FROM
    dual;

  -- mod(숫자, 나눌수) : 나머지값
SELECT
    mod(15, 6),
    mod(10, 2),
    mod(11, 2)
FROM
    dual;


-- 날짜 함수
  -- 날짜 데이터(+/-)숫자 : 날짜 데이터보다 숫자만큼 일수 이후/이전 의 날짜
  -- 날짜 데이터 - 날짜 데이터 : 두 날짜 데이터 간의 일수 차이
  -- 날짜 데이터 + 날짜 데이터 : 연산불가

 --1) sysdate 함수 : 오라클 데이터베이스 서버가 설치된 os의 현재날짜와 시간을 가져옴
SELECT
    sysdate,
    sysdate - 1 AS yesterday,
    sysdate + 1 AS tomorrow
FROM
    dual;
    
 --2) add_months(날짜, 더할 개월수) : 몇 개월 이후 날짜 구하기

SELECT
    sysdate,
    add_months(sysdate, 3)
FROM
    dual;

--입사 50주년 되는 날짜 구하기
--empno, ename, hiredate, 입사 50주년 날짜 조회
SELECT
    empno,
    ename,
    hiredate,
    add_months(hiredate, 600)
FROM
    emp;

-- 3) months_between : 두 날짜 데이터 간의 날짜 차이를 개월수로 계산하여 출력
--입사 45년 미만인 사원 데이터 조회
SELECT
    empno,
    ename,
    hiredate
FROM
    emp
WHERE
    months_between(sysdate, hiredate) < 540;

--현재 날짜와 6개월 후 날짜가 출력
SELECT
    sysdate,
    add_months(sysdate, 6)
FROM
    dual;

SELECT
    empno,
    ename,
    hiredate,
    sysdate,
    months_between(hiredate, sysdate)        AS month1,
    months_between(sysdate, hiredate)        AS month2,
    trunc(months_between(sysdate, hiredate)) AS month3
FROM
    emp;

 -- 4) next_day(날짜, 요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
  --   last_day(날짜) : 특정 날짜가 속한 달의 마지막 날짜를 출력
SELECT
    sysdate,
    next_day(sysdate, '금요일'),
    last_day('23_03_21')
FROM
    dual;

-- 날짜의 반올림, 버림 : round, trunc 할때 format
  -- cc : 네 자리 연도의 끝 두자리를 기준으로 사용
SELECT
    sysdate,
    round(sysdate, 'cc')   AS format_cc,
    round(sysdate, 'yyyy') AS format_yyyy,
    round(sysdate, 'ddd')  AS format_ddd,
    round(sysdate, 'hh')   AS format_hh
FROM
    dual;


-- 형변환 함수 : 자료형을 형 변환
-- NUMBER, VARCHAR2, DATE

SELECT
    empno,
    ename,
    empno + '500'
FROM
    emp
WHERE
    ename = 'FORD';

SELECT
    empno,
    ename,
    'abcd' + empno --ORA-01722: 수치가 부적합합니다
FROM
    emp
WHERE
    ename = 'FORD';

 -- TO_CHAR() : 숫자 또는 날짜 데이터를 문자 데이터로 변환
 -- TO_NUMBER() : 문자 데이터를 숫자 데이터로 변환
 -- TO)DATE() : 문자 데이터를 날짜 데이터로 변환

 --MON, MONTH : 월이름
 -- DDD : 365일중에 몇일인지
SELECT
    sysdate,
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') AS 현재날짜시간,
    to_char(sysdate, 'MON')                   AS mon,
    to_char(sysdate, 'MONTH')                 AS month
FROM
    dual;

-- SAL 필드에 ','나 통화표시를 하고 싶다면?
 -- L(Local) 지역 화폐 단위 기호 붙여줌
SELECT
    sal,
    to_char(sal, '$999,999') AS sal_$,
    to_char(sal, 'L999,999') AS sal_l
FROM
    emp;


-- TO_NUMBER(문자열데이터, 인식될 숫자형태)

--자동형변환
SELECT
    1300 - '1500',
    '1300' + '1500'
FROM
    dual;

-- , 가 있으면 뒤에 인식될 숫자형태 써줘야함
SELECT
    TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
FROM
    dual;

 -- to_date(문자열데이터, '인식될 날짜 형태')
SELECT
    TO_DATE('2018-07-14', 'yyyy-mm-dd') AS todate1,
    TO_DATE('20230320', 'yyyy-mm-dd')   AS todate1
FROM
    dual;

SELECT
    '2023-03-21' - '2023-02-01' -- 문자로 인식해서 계산 안됨
FROM
    dual;

SELECT
    TO_DATE('2023-02-01') - TO_DATE('2023-03-21')
FROM
    dual;

-- null 처리 함수
-- null + 300 => null
-- NVL(데이터, 널일경우 반환할 데이터)
SELECT
    empno,
    ename,
    sal,
    comm,
    sal + comm,
    nvl(comm, 0),
    sal + nvl(comm, 0)
FROM
    emp;

-- NVL2(데이터, 널이 아닐경우 반환할 데이터, 널일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    sal,
    comm,
    nvl2(comm, 'O', 'X'),
    nvl2(comm, sal * 12 + comm, sal * 12) AS annsal
FROM
    emp;

-- DECODE 함수 / CASE 문
-- DECODE( 검사 대상이 될 데이터, 
--          조건1, 조건1이 일치할 때 실행할 구문
--          조건2, 조건1이 일치할 때 실행할 구문 )

-- EMP 테이블에 직책이 MANAGER인 사람은 급여의 10% 인상, 
-- SALESMAN 인 사람은 5%, ANALYS인 사람은 그대로, 나머지는 3% 인상된 급여 출력

--decode
SELECT 
empno, ENAME, JOB, SAL, 
decode(
    job, 'manager', sal * 1.1,
         'salesman', sal * 1.05, 
         'analyst',  sal,
          sal * 1.03
) as upsal    
FROM emp;

--case
SELECT 
empno, ename, job, sal, 
case job
 when 'manager'then sal * 1.1
 when 'salesman'then sal * 1.05
 when 'analyst'then sal
 else sal * 1.03
 end 
 as upsal    
FROM emp;

SELECT 
empno, ename, job, sal, 
case
    when comm is null then '해당사항 없음'
    when comm =0 then '수당없음'
    when comm>0 then '수당 : ' || comm
    end
    as comm_text
FROM emp;


--실습1
select empno, ename, sal, TRUNC(sal/21.5,2) as DAY_PAY, ROUND(sal/21.5/8,1) AS TIME_PAY
FROM EMP;

--실습2
SELECT EMPNO, ENAME, HIREDATE, NEXT_DAY(ADD_MONTHS(HIREDATE,3),'월요일') AS R_JOB, NVL2(COMM, TO_CHAR(COMM) ,'N/A') AS COMM
FROM EMP;

--실습3

SELECT 
    EMPNO, ENAME, MGR,
    DECODE (SUBSTR(MGR,1,2), NULL, 0000,
                             75,5555,
                             76,6666,
                             77,7777,
                             78,8888,
                             MGR
        )AS CHG_MGR
FROM
emp;

SELECT
    empno,
    ename,
    mgr,
    CASE
        WHEN mgr IS NULL THEN
            0000
        WHEN substr(mgr, 1, 2) = 75 THEN
            5555
        WHEN substr(mgr, 1, 2) = 76 THEN
            6666
        WHEN substr(mgr, 1, 2) = 77 THEN
            7777
        WHEN substr(mgr, 1, 2) = 78 THEN
            8888
        ELSE
            mgr
    END AS chg_mgr
FROM
    emp;


--다중행 함수(집계함수) : sum, count, max, min, avg

--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
SELECT
    ename,
    SUM(sal)
FROM
    emp;

-- SUM만 하면 나옴, 결과가 하나만 나오는걸 다중행 함수
SELECT
    SUM(sal)
FROM
    emp;
    
-- distinct 중복제거, 후 합계    
SELECT
    SUM(distinct sal),
    sum(ALL sal),
    sum(sal)
FROM
    emp;    
  
--sum() : null 은 제외하고 합계 구해줌  
SELECT
    SUM(comm)
FROM
    emp;    
    
--count : 갯수 , null제외하고 갯수 셈
SELECT
    count(sal)
FROM
    emp;    

SELECT
    count(comm)
FROM
    emp;   

-- * : emp 테이블의 행의 갯수가 몇개인지 
SELECT
    count(*)
FROM
    emp;  

SELECT
    count(*)
FROM
    emp    
where deptno=30;

-- MAX : 최대값, 가장 최신날짜
SELECT
    MAX(SAL)
FROM
    emp;

--부서번호 20인 사원의 입사일 중 제일 최근 입사일
SELECT
    MAX(HIREDATE)
FROM
    emp
WHERE DEPTNO=20;

--MIN : 최소값, 가장 오래된 날짜
--부서번호 20인 사원의 입사일 중 제일 오래된 입사일
SELECT
    MIN(HIREDATE)
FROM
    emp
WHERE DEPTNO=20;

--AVG : 평균
SELECT
    ROUND(AVG(SAL),1)
FROM
    emp
WHERE DEPTNO=30;

--group by : 결과 값을 원하는 열로 묶어 출력
             group by 절에 나온것만 앞에 쓸수 있음

-- 부서별 sal 평균 구하기
select avg(sal) from emp where deptno=10;
select avg(sal) from emp where deptno=20;
select avg(sal) from emp where deptno=30;

select avg(sal), deptno from emp group by deptno order by deptno desc;

--부서별 추가수당 평균 구하기
select deptno, avg(comm) from emp group by deptno;

--GROUP BY + HAVING : GROUP BY 절에 조건을 줄 때
-- HAVING : 긃화된 대상을 출력 제한 걸때
--각 부서의 직책별 평균 급여 구하기(단, 평균 급여가 2000이상인 그룹만 출력)
-- WHERE 절에 하면 안됨
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >=2000
ORDER BY DEPTNO, JOB;

--ORA-00934: 그룹 함수는 허가되지 않습니다
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE AVG(SAL) >=2000 --안됨
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

--WHERE 와 HAVING 같이 쓰이는 경우
-- 실행순서 : 1)From 2)where 3)group by 4) having 5) select 6)order by 
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE SAL<=3000
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >=2000
ORDER BY DEPTNO, JOB;

--실습1

select deptno, FLOOR(avg(sal)) avg_sal, max(sal) max_sal,  min(sal) min_sal,  count(*) CNT
from emp
group by deptno
order by deptno desc;

--실습2
select job, count(*) 
from emp
group by job
HAVING COUNT(JOB)>=3;

실습3
SELECT TO_CHAR(HIREDATE,'YYYY'), DEPTNO, COUNT(*)
FROM EMP
GROUP BY TO_CHAR(HIREDATE,'YYYY'), DEPTNO
ORDER BY DEPTNO;


--23/03/22
--조인 : 여러 테이블을 하나의 테이블처럼 사용(데이터베이스 면접 단골 질문)
-- 1)내부조인 (inner join 이라고 부름) : 여러 개의 테이블에서 공통된 부분만 추출
--   ① 등가조인 : 두 개의 열이 일치할 때 값 추출
--   ② 비등가조인 : 범위에 해당할 때 값 추출

-- 2) 외부조인 (outer join 이라고 부름)
--   ① left outer join
--   ② right outer join
--   ③ full outer join

--  inner join

-- 조건을 안주면 dept : 4행, emp 12행 => 4*12= 48행 나옴 (->크로스조인, 잘 사용은 안함)
select *
from emp, dept
order by empno;

--ORA-00918: 열의 정의가 애매합니다(에러메시지) : 중복된 칼럼이 있을때
select e.empno, e.ename, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno;
-- SQL-99 표준버전
-- JOIN ~ ON
select e.empno, e.ename, e.deptno, d.dname, d.loc
from emp e join dept d on e.deptno = d.deptno;


--테이블에 별칭 붙여서 selct 칼럼 명확하게 명시, where 추가 조건도 가능
select e.empno, e.ename, d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno and sal >=3000;

-- SQL-99 표준버전
-- JOIN ~ ON
select e.empno, e.ename, d.deptno, d.dname, d.loc
from emp e JOIN dept d ON e.deptno = d.deptno 
WHERE sal >=3000;





--급여가 2500 이하이고, 사원번호가 9999이하인 사원 정보 조회
select e.empno, e.ename, e.sal, d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno and e.sal<=2500; and e.empno<=9999;
-- SQL-99 표준버전
-- JOIN ~ ON
select e.empno, e.ename, e.sal, d.deptno, d.dname, d.loc
from emp e join dept d on e.deptno = d.deptno 
where e.sal<=2500; and e.empno<=9999;


--emp 와 salgrade 조인
--emp테이블의 sal이 salgrade테이블의 losal 과 hisal 범위에 들어가는 형태로 조인
select *
from emp e, salgrade s
where e.sal between s.losal and s.hisal;
-- SQL-99 표준버전
-- JOIN ~ ON
select *
from emp e join salgrade s on e.sal between s.losal and s.hisal;



--셀프조인 self join : 자기 자신 테이블과 조인
select e1.empno, e1.ename, e1.mgr, e2.empno mgr_empno, e2.ename mgr_ename
from emp e1, emp e2
where e1.mgr=e2.empno;

-- outer join 
-- 1) left outer join (앞에나오는 e1 이 왼쪽, e2가 오른쪽)
select e1.empno, e1.ename, e1.mgr, e2.empno mgr_empno, e2.ename mgr_ename
from emp e1, emp e2
where e1.mgr=e2.empno(+);
-- SQL-99 표준버전
-- JOIN ~ ON
select e1.empno, e1.ename, e1.mgr, e2.empno mgr_empno, e2.ename mgr_ename
from emp e1 left outer join emp e2 on e1.mgr=e2.empno;


-- 2) rigth outer join
select e1.empno, e1.ename, e1.mgr, e2.empno mgr_empno, e2.ename mgr_ename
from emp e1, emp e2
where e1.mgr(+)=e2.empno;
--양쪽다 + 는 안됨
-- SQL-99 표준버전
-- JOIN ~ ON
select e1.empno, e1.ename, e1.mgr, e2.empno mgr_empno, e2.ename mgr_ename
from emp e1 right outer join emp e2 on e1.mgr=e2.empno;

-- 3) full outer join
select e1.empno, e1.ename, e1.mgr, e2.empno mgr_empno, e2.ename mgr_ename
from emp e1 full outer join emp e2 on e1.mgr=e2.empno;


-- 연결해야 할 테이블이 세개일때
--select *
--from table t1, table2 t2, table t3
--where t1.empno = t2.empno and t2.deptno = t3.deptno

---- SQL-99 표준버전
--select *
--from table t1 join table2 t2 on t1.empno = t2.empno join table t3 on t2.deptno = t3.deptno;
 

--[실습1] 급여가 2000초과인 사원들의 부서 정보, 사원 정보를 아래와 같이 출력하는 SQL 문을 작성하시오.

select e.deptno, d.dname, e.empno, e.ename, e.sal
from emp e, dept d
where e.deptno=d.deptno and e.sal>2000
order by e.deptno;

select e.deptno, d.dname, e.empno, e.ename, e.sal
from emp e join dept d on e.deptno=d.deptno 
where e.sal>2000
order by e.deptno;

--[실습2] 각 부서별 평균 급여, 최대 급여, 최소 급여, 사원수를 출력하는 SQL문을 작성하시오.

select e.deptno, d.dname, trunc(avg(e.sal)) avg_sal, max(e.sal) max_sal, min(e.sal) min_sal, count(*) cnt
from emp e, dept d
where  e.deptno=d.deptno
group by e.deptno, d.dname
order by deptno;

select e.deptno, d.dname, trunc(avg(e.sal)) avg_sal, max(e.sal) max_sal, min(e.sal) min_sal, count(*) cnt
from emp e join dept d on e.deptno=d.deptno
group by e.deptno, d.dname
order by deptno;


--[실습3] 모든 부서정보와 사원 정보를 아래와 같이 부서번호, 사원이름 순으로 정렬하여 출력하는 SQL문을 작성하시오.
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e, dept d
where  e.deptno(+)=d.deptno
order by deptno;

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e join dept d on e.deptno(+)=d.deptno
order by deptno;

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e right outer join dept d on e.deptno(+)=d.deptno
order by deptno;


-- 서브쿼리
-- sql 문을 실행하는 데 필요한 데이터를 추가로 조회하기 위해 sql 문 내부에서 사용하는 select문
-- 1) 단일행 서브쿼리 2) 다중행 서브쿼리 3) 다중열 서브쿼리

--SELECT 조회할 열
--FROM 테이별명
--WHERE 조건식(SELECT 조회할 열 FROM 테이블 WHERE 조건식)

-- 단일행 서브쿼리 : 서브쿼리 결과로 하나의 행 통합
-- 연산자(=,<,>,=<,=.,!=,^= 연산자 허용

--존스의 급여보다 높은 급여를 받는 사원 조회
-- JONES 급여 알아내기 / 알아낸 JONES급여를 가지고 조건식

SELECT SAL
FROM EMP
WHERE ENAME='JONES';  --2975

SELECT *
FROM EMP
WHERE SAL>2975;

SELECT *
FROM EMP
WHERE SAL>(SELECT SAL
FROM EMP
WHERE ENAME='JONES');

--사원이름이 ALLEN인 사원의 추가수당 보다 많은 추가수당을 받는 사원 조회

SELECT *
FROM EMP
WHERE COMM > (SELECT COMM FROM EMP WHERE ENAME='ALLEN');

--사원이름이 WARD 인 사원의 입사일보다 빨리 입사한 사원 조회

SELECT *
FROM EMP
WHERE HIREDATE<
  (SELECT HIREDATE
    FROM EMP
    WHERE ENAME='WARD'
    );


--20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원정보 및 부서정보 조회
--사원번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역

SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO = 20; AND E.SAL>평균급여>(SELECT AVG(SAL) FROM EMP

--20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 작거나 같은 급여를 받는 사원정보

SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO = 20; AND E.SAL>평균급여>( SELECT
    AVG(sal)
FROM
    emp

--다중행 서브쿼리 : 서브쿼리 결과로 여러개의 행 반환
  -- IN, ANY(SOME), ALL, EXISTS 연산자 허용(단일행 서브쿼리에 쓰는 연산자 사용 불가)
-- 각 부서별 최고 급여와 동일한 급여를 받는 사원정보 조회
 --각 부서별 최고 급여
 
-- IN : 메인쿼리 결과가 서브커리 결과 중 하나라도 일치하면 TRUE 
SELECT * FROM EMP WHERE SAL IN(SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

--  30번 부서 사원들의 급여보다 적은 급여를 받는 사원 정보 조회

-- ANY(SOME) : 메인쿼리 결과가 서브쿼리 결과가 하나이상이면 TRUE
SELECT * FROM EMP WHERE SAL < ANY (SELECT SAL FROM EMP WHERE DEPTNO=30);
SELECT * FROM EMP WHERE SAL < SOME (SELECT SAL FROM EMP WHERE DEPTNO=30);

-- 위 결과는 단일행 쿼리로 작성이 가능한 상황임

--  30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보 조회
SELECT * FROM EMP WHERE SAL >(SELECT MIN(SAL) FROM EMP WHERE DEPTNO=30);  --단일행
SELECT
    *
FROM
    emp
WHERE
    sal > ANY (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );  --다중행


--ALL : 서브쿼리 모든 결과가 조건식에 맞아 떨어져야만 메인쿼리 조건식이 TRUE
SELECT
    *
FROM
    emp
WHERE
    sal < ALL (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );  --ALL
SELECT
    *
FROM
    emp
WHERE
    sal < ANY (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );  --ANY

--EXISTS : 서브 쿼리에 결과 값이 하나 이상 존재하면 조건식이 모두 TRUE, 존재하지 않으면 FALSE
  --서브쿼리가 하나라도 나오면 메인 모두 나오게 해줘
SELECT
    *
FROM
    emp
WHERE
    EXISTS (
        SELECT
            dname
        FROM
            dept
        WHERE
            deptno = 30
    );


--[실습]
SELECT
    e.job,
    e.empno,
    e.ename,
    e.sal,
    e.deptno,
    d.dname
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.job = (
        SELECT
            job
        FROM
            emp
        WHERE
            ename = 'ALLEN'
    );

--실습2] 전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 사원정보, 부서정보, 급여 등급 정보를 출력하는 SQL문을 작성하시오
--(단, 출력할 때 급여가 많은 순으로 정렬하되 급여가 같을 경우에는 사원 번호를 기준으로 오름차순으로 정렬하기)
SELECT
    e.empno,
    e.ename,
    d.dname,
    e.hiredate,
    d.loc,
    e.sal,
    s.grade
FROM
    emp      e,
    dept     d,
    salgrade s
WHERE
        e.deptno = d.deptno
    AND e.sal BETWEEN s.losal AND s.hisal
        AND e.sal > (
        SELECT
            AVG(sal)
        FROM
            emp
    )
ORDER BY
    e.sal DESC,
    e.empno ASC;

--다중열 서브쿼리 : 서브쿼리의 SELECT절에 비교할 데이터를 여러 개 지정
SELECT
    *
FROM
    emp
WHERE
    ( deptno, sal ) IN (
        SELECT
            deptno, MAX(sal)
        FROM
            emp
        GROUP BY
            deptno
    );

-- FROM 절에 사용하는 서브쿼리 (인라인 뷰)
-- FROM 절에 직접 테이블을 명시해서 사용하기에는 테이블 내 데이터 규모가 클 때, 불필요한 열이 많을 때
SELECT
    e10.empno,
    e10.ename,
    e10.deptno,
    d.dname,
    d.loc
FROM
    (
        SELECT
            *
        FROM
            emp
        WHERE
            deptno = 10
    ) e10,
    (
        SELECT
            *
        FROM
            dept
    ) d
WHERE
    e10.deptno = d.deptno;


--SELECT 절에 사용하는 서브쿼리( 스칼라 서브쿼리)
--SELECT절에 사용하는 서브쿼리는 반드시 하나의 결과만 반환해야 함
SELECT
    empno,
    ename,
    job,
    sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            e.sal BETWEEN losal AND hisal
    ) AS salgrade,
    deptno,
    (
        SELECT
            dname
        FROM
            dept
        WHERE
            e.deptno = dept.deptno
    ) AS dname
FROM
    emp e;

--[실습1] 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원정보, 부서 정보를 다음과 같이 출력하는 SQL문을 작성하시오.
SELECT
    e.empno,
    e.ename,
    e.job,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.job NOT IN (
        SELECT
            job
        FROM
            emp
        WHERE
            deptno = 30
    )
        AND e.deptno = 10;

--[실습2] 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 
--사원정보, 급여등급 정보를 출력하는 SQL문을 작성하시오
--(단, 서브쿼리를 활용할 때 다중행 함수를 사용하는 방법과 사용하지 않는 방법을 통해 
--사원번호를 기준으로 오름차순 정렬하여 출력하시오.)

  --단일행 서브쿼리
SELECT
    e.empno,
    e.ename,
    e.sal,
    s.grade
FROM
    emp      e,
    salgrade s
WHERE
    e.sal BETWEEN s.losal AND s.hisal
    AND e.sal > (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;

SELECT
    e.empno,
    e.ename,
    e.sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            sal BETWEEN losal AND hisal
    ) grade
FROM
    emp e
WHERE
    e.sal > (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;

--다중행 함수 사용시 (IN, ANY, SOME, ALL, EXISTS)
SELECT
    e.empno,
    e.ename,
    e.sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            sal BETWEEN losal AND hisal
    ) grade
FROM
    emp e
WHERE
    e.sal > ALL(
        SELECT
            sal
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;

--■ DML(★)(Data manipulation Language) : 데이터 추가(INSERT), 수정(UPDATE), 삭제(DELETE)하는 데이터 조작어
-- select + DML ==> 자주 사용하는 SQL임
-- COMMIT 개념 : DML 작업을 데이터베이스에 최종 반영시키라는 의미
-- ROLLBACK 개념 : DML 작업을 취소할게요

-- 연습용 테이블 생성
-- 기존 테이블 복사
CREATE TABLE dept_temp AS SELECT * FROM DEPT;  --DEPT 테이블의 모든것을 COPY
-- 테이블 삭제
DROP TABLE dept_temp;

-- □INSERT 구문
-- insert into 테이블이름(열이름1, 열이름2....)  *열이름은 선택사항임
-- values(데이터1, 데이터2....)

-- DEPT_TEMP 새로운 부서 추가하기 ①
INSERT INTO DEPT_TEMP(deptno, dname, loc)
values(50, 'database', 'seoul');

select* from dept_temp; --확인용

-- DEPT_TEMP 새로운 부서 추가하기 ② 열이름 제거
INSERT INTO DEPT_TEMP
values(60, 'network', 'seoul');

select* from dept_temp; --확인용

-- INSERT 시 오류 
-- ① ORA-01438: 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
  -- DATA_TYPE 이 NUMBER(2.0) : 숫자(두자리, 소숫점자리)
INSERT INTO DEPT_TEMP
values(600, 'network', 'seoul'); --자리수 에러

INSERT INTO DEPT_TEMP
values('NO', 'network', 'seoul'); -- 형태 에러(NUMBER는 숫자가 들어와야함)

  -- '60' 문자처리해도 자동 형변환 시켜서 에러 안남
INSERT INTO DEPT_TEMP
values('60', 'network', 'seoul');

--② SQL 오류: ORA-00947: 값의 수가 충분하지 않습니다
  -- 칼럼은 세개 넣고 VALUE 는 두개 집어넣으면 매칭안돼서 에러남
INSERT INTO DEPT_TEMP(deptno, dname, loc)
values(70, 'database');

-- NULL 을 넣을수 있음 : 1)NULL, 2)'', 3)NULL 삽입할 컬럼명 지정하지 않기
INSERT INTO DEPT_TEMP(deptno, dname, loc)
values(80, 'WEB', NULL);

INSERT INTO DEPT_TEMP(deptno, dname, loc)
values(90, 'WEB', '');
--NULL 삽입할 컬럼명 지정하지 않기, 삽입시 전체 칼럽을 삽입하지 않는다면 필드명 필수
INSERT INTO DEPT_TEMP(deptno, LOC)
values(91,'INCHEON');


--□ EMP_TEMP 생성(EMP 테이블 복사- 데이터는 복사를 하지 않을 때,  WHERE 1<>1 )
CREATE TABLE emp_temp AS SELECT * FROM emp WHERE 1 <> 1;
DROP TABLE emp_temp;

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(9999, '홍길동', 'president', null, '2001/01/01', 5000,1000,10);

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(1111, '성춘향', 'manager', 9999, '2002-01-05', 4000,null,20);
--날짜 입력 시 년/월/일 순서-> 일/월/년 삽입
--날짜 형식의 지정에 불필요한 데이터가 포함
-- to_date('날짜', '날짜형식') 으로 가능
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(1111, '이순신', 'manager', 9999, '07/01/2001', 4000,null,20);

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(2222, '이순신', 'manager', 9999, to_date('07/01/2001','dd/mm/yyyy'),4000,null,20);

--sysdate
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(3333, '심봉사', 'manager', 9999, sysdate, 4000,null,30);


--□ 서브쿼리로 insert 구현
-- emp, salgrade 테이블을 조인 후 급여 등급이 1인 사원만 emp_temp 에 추가
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno
from emp e, salgrade s
where e.sal between s.losal and hisal and s.grade=1; 

-- 여기까지 DML 한것을 COMMIT;
COMMIT;

--□ UPDATE : 테이블에 있는 데이터 수정

--UPDATE 테이블명
--SET 변경할열이름 = 데이터, 변경할열이름 = 데이터....
--WHERE 변경을 위한 대상 행을 선별하기 위한 조건

SELECT * FROM dept_temp;
-- dept_temp loc 열의 모든 값을 seoul로 변경
update dept_temp
set loc='soul';
-- commit안했으니 rollback 할수이씀
rollback;

--데이터 일부분 수정 : where 사용
-- dept_temp 부서번호가 40번인 loc값을 seoul로 변경
update dept_temp
set loc='seoul'
where deptno=40;

-- dept_temp 부서번호가 80번 dname 은 sales, loc 는 chicago로 변경 
update dept_temp
set dname='sales', loc='chicago'
where deptno=80;


-- emp_temp 사원들 중에서 급여가 2500이하인 사원들만 추가수당을 50으로 수정
update emp_temp
set comm=50
where sal<=2500;

-- 서브쿼리를 사용하여 데이터 수정 가능
-- dept 테이블의 40번 부서의 dname, loc를 dept_temp 40번 부서의 dname, loc로 업데이트

update dept_temp
set (dname, loc) = (select dname, loc
                    from dept
                    where deptno=40)
where deptno=40;

commit;

--□ DELETE : 테이블에 있는 데이터 삭제
--DELETE 테이블명
--FROM (선택)
--WHERE 삭제 데이터를 선별하기 위한 조건식

CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP;

--JOB이 MANAGER인 사원 삭제
DELETE FROM EMP_TEMP2
WHERE JOB='MANAGER';

--FROM 안씀
DELETE EMP_TEMP2
WHERE JOB='SALESMAN';

--전체 데이터 삭제
DELETE EMP_TEMP2;

ROLLBACK;


--서브쿼리 사용하여 삭제
--급여등급이 3등급이고, 30번 부서의 사원 삭제

DELETE FROM EMP_TEMP2
WHERE EMPNO IN (SELECT E.EMPNO
                FROM EMP_TEMP2 E, SALGRADE S
                WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL AND E.DEPTNO=30 AND S.GRADE=3);

COMMIT;

--[실습1] 실습을 위하여 기존 테이블을 이용하여 테이블을 생성한다.
--① EMP 테이블의 내용을 이용하여 EXAM_EMP 생성
--② DEPT 테이블의 내용을 이용하여 EXAM_DEPT 생성
--③ SALGRADE 테이블의 내용을 이용하여 EXAM_SALGRADE 생성
create table exam_emp as select* from emp;
create table exam_dept as select* from dept;
create table exam_salgrade as select* from salgrade;

--[실습2] 다음의 정보를 EXAM_EMP 테이블에 입력하시오.

select * from exam_emp;
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values (7201,'TEST_USER1','MANAGER',7788,'16/01/02',4500,null,50);
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values (7202,'TEST_USER2','CLERK',7201,'16/02/21',1800,null,50);
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values (7203,'TEST_USER3','ANALYST',7201,'16/04/11',3400,null,60);
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values (7204,'TEST_USER4','SALESMAN',7201,'16/05/31',2700,300,60);
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values (7205,'TEST_USER5','CLERK',7201,'16/07/20',2600,null,70);
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values (7206,'TEST_USER6','CLERK',7201,'16/09/08',2600,null,70);
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values (7207,'TEST_USER7','LECTURER',7201,'16/10/28',2300,null,80);
INSERT INTO exam_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values (7208,'TEST_USER8','STUDENT',7201,'18/03/09',1200,null,80);

--실습3] EXAM_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를 받고 있는 사원들을 70번 부서로 옮기는 SQL 문 작성하기
update EXAM_EMP
set DEPTNO=70
where SAL>(SELECT AVG(SAL) FROM EXAM_EMP WHERE DEPTNO=50); 

--[실습4] EXAM_EMP에 속한 사원 중 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다 늦게 입사한 사원의 급여를 10% 인상하고 80번 부서로 옮기는 SQL 문 작성하기
update EXAM_EMP
set DEPTNO=80 ,  SAL=SAL*1.1
WHERE HIREDATE > (SELECT MIN(HIREDATE) FROM EXAM_EMP WHERE DEPTNO=60); 

--[실습5] EXAM_EMP에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문을 작성하기
DELETE EXAM_EMP
WHERE EMPNO IN (SELECT EMPNO 
                FROM EXAM_EMP, SALGRADE
                WHERE SAL BETWEEN LOSAL AND HISAL AND GRADE=5);

COMMIT;


--■ 트렌잭션(transaction) : 최소 수행 단위
-- 트랜잭션 제어하는 구문 TCL (Transaction Control Language) : commit, rollback (DML구문만)
create table dept_tcl
as select * from dept;


insert into dept_tcl values(50,'database','seoul');
update dept_tcl set loc='busan' where deptno=40;
delete from dept_tcl where dname='RESEARCH';
 --트랜잭션 취소
 ROLLBACK;
 --트랜잭션 최종 반영
 COMMIT;
 
 --세션 : 어떤 활동을 위한 시간이나 기간
 --데이터베이스 세션 : 데이터베이스 접속을 시작으로 관련작업 수행한 후 접속 종료
 
 --50번 삭제, COMMIT 하지 않으면 SQL PLUS에는 반영안되어 있음
delete from dept_tcl where DEPTNO=50;

COMMIT;

--디벨로퍼에서 물고 있는데 sql plus에 다른걸로 업데이트 하면 Lock됨 , 디벨로퍼에서 commit되기 전까지, 읽기의 일관성을 위해
-- LOCK : 잠금(수정 중인 데이터 접근 막기)
update dept_tcl set loc='SEOUL' where deptno=30;
commit;

 select * from dept_tcl;

--3/27 
--select+join, subquery
--DML(update, delete, insert)


--■-- DDL : 데이터 정의어(데이터 베이스 객체 생성, 수정, 삭제)   
-- 1. 테이블 생성 
-- CREATE TABLE 테이블명(
--    열이름1 자료형,
--    열이름2 자료형,
--    열이름3 자료형,
--    열이름4 자료형
-- );

-- 테이블 생성 / 열이름 지정 규칙
-- 1) 테이블 이름은 문자로 시작
-- 2) 테이블 이름은 30BYTE 이하
-- 3) 같은 사용자 소유의 테이블 이름은 중복될 수 없음
-- 4) 테이블 명에 사용할 수 있는 특수문자는 $, #, _ 가능
-- 5) SQL 키워드(ex SELECT, FROM, WHERE...)는 테이블명에 사용할 수 없음

-- 자료형

-- 1. 문자
-- VARCHAR2(길이) : 가변 길이 문자열 데이터 저장(최대 4000BYTE)
-- CHAR(길이) : 고정 길이 문자열 데이터 저장
-- NVARCHAR2(길이) : 가변 길이(unicode) 데이터 저장
--    name varchar2(10) : 영어는 10자, 한글은 3자 까지 입력
--    name nvarchar2(10) : 영어 10자, 한글 10자 까지 입력
-- NCHAR(길이) : 고정 길이(unicode)
--    name char(10) : 영어는 10자, 한글은 3자, + 메모리 10byte 고정
--    name nchar(10) : 영어는 10자, 한글은 10자, + 메모리 10byte 고정

-- 2. 숫자
-- NUMBER(전체자릿수,소수점이하자릿수)

-- 3. 날짜
-- DATE : 날짜,시간 저장
-- TIMESTAMP

-- 4. 기타
-- BLOB : 대용량 이진 데이터 저장
-- CLOB : 대용량 텍스트 데이터 저장
-- JSON : JSON 데이터 저장

CREATE TABLE emp_ddl (
    empno    NUMBER(4),     -- 사번을 총 4자리 지정
    ename    VARCHAR2(10),  -- 사원명을 총 10byte 로 지정
    job      VARCHAR2(9),     -- 직무 총 9byte 지정
    mgr      NUMBER(4),       -- 매니저 번호
    hiredate DATE,       -- 날짜/시간 저장
    sal      NUMBER(7, 2),     -- 급여를 전체 자릿수 7자리 지정(소수점 2자리까지 허용)
    comm     NUMBER(7, 2),    -- 추가수당
    deptno   NUMBER(2)     -- 부서번호
);

desc emp_ddl;


-- 2. 테이블 수정 : ALTER
-- 1) 열 추가 : ADD
ALTER TABLE emp_temp2 ADD hp VARCHAR2(20);

-- 2) 열 이름 변경 : RENAME
ALTER TABLE emp_temp2 RENAME COLUMN hp TO tel;

-- 3) 열 자료형(길이) 변경 : MODIFY
ALTER TABLE emp_temp2 MODIFY
    empno NUMBER(5);

-- 4) 특정 열을 삭제 : DROP
ALTER TABLE emp_temp2 DROP COLUMN tel;



-- 3. 테이블 삭제 : DROP
DROP TABLE emp_rename;



-- 테이블 명 변경
RENAME emp_temp2 TO emp_rename;

-- 테이블 데이터 전체 삭제
DELETE FROM emp_rename;

SELECT
    *
FROM
    emp_rename;

ROLLBACK;

--  rollback 안됨 : DDL 구문이기 때문
TRUNCATE TABLE emp_rename;

-- 
CREATE TABLE member (
    id     CHAR(8),
    name   VARCHAR2(10),
    addr   VARCHAR2(50),
    nation NCHAR(4),
    email  VARCHAR2(50),
    age    NUMBER(7, 2)
);

ALTER TABLE member ADD bigo VARCHAR2(20);

ALTER TABLE member MODIFY
    bigo VARCHAR2(30);

ALTER TABLE member RENAME COLUMN bigo TO remark;

DROP TABLE member;


-- "SCOTT"."MEMBER"."NATION" 열에 대한 값이 너무 큼(실제: 12, 최대값: 4)
INSERT INTO member VALUES (
    'hong1234',
    '홍길동',
    '서울시 구로구 개봉동',
    '대한민국',
    'hong123@naver.com',
    25,
    NULL
);


-- 데이터 베이스 객체
-- 테이블, 인덱스, 뷰, 데이터 사전, 시퀀스, 시노님, 프로시저, 함수, 패키지, 트리거
-- 생성 : create, 수정 : alter, 삭제 : drop

-- 인덱스 : 더 빠른 검색을 도와줌
-- 인덱스 : 사용자가 직접 특정 테이블 열에 지정 가능
--          기본키(혹은 unique key) 를 생성하면 인덱스로 지정

-- CREATE INDEX 인덱스이름 ON 테이블명(인덱스로 사용할 열이름)

-- emp 테이블의 sal 열을 인덱스로 지정
CREATE INDEX idx_emp_sal ON
    emp (
        sal
    );

-- select : 검색방식
-- FULL Scan
-- Index Scan

SELECT
    *
FROM
    emp
WHERE
    empno = 7900;


-- 인덱스 삭제
DROP INDEX idx_emp_sal;

-- View : 가상 테이블
-- 편리성 : SELECT 문의 복잡도를 완화하기 위해
-- 보안성 : 테이블의 특정 열을 노출하고 싶지 않을 때

-- CREATE[OR REPLACE]  [FORCE | NOFORCE] VIEW 뷰이름(열이름1,열이름2...)
-- AS (저장할 SELECT 구문) 
-- [WITH CHECK OPTION]
-- [WITH READ ONLY]

-- SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO=20 뷰로 생성
CREATE VIEW vm_emp20 AS
    (
        SELECT
            empno,
            ename,
            job,
            deptno
        FROM
            emp
        WHERE
            deptno = 20
    );


-- 서브쿼리를 사용
SELECT
    *
FROM
    (
        SELECT
            empno,
            ename,
            job,
            deptno
        FROM
            emp
        WHERE
            deptno = 20
    );

-- 뷰 사용
SELECT
    *
FROM
    vm_emp20;


-- 뷰 삭제 
DROP VIEW vm_emp20;

-- 뷰 생성 시 읽기만 가능
CREATE VIEW vm_emp_read AS
    SELECT
        empno,
        ename,
        job
    FROM
        emp
WITH READ ONLY;

-- VIEW 에 INSERT 작업?
INSERT INTO vm_emp20 VALUES (
    8888,
    'KIM',
    'SALES',
    20
);
-- 원본 변경이 일어남
SELECT
    *
FROM
    emp;

-- 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
INSERT INTO vm_emp_read VALUES (
    9999,
    'KIM',
    'SALES'
);

-- 인라인 뷰 : 일회성으로 만들어서 사용하는 뷰
-- rownum : 조회된 순서대로 일련번호 매김

SELECT
    ROWNUM,
    e.*
FROM
    emp e;

SELECT
    ROWNUM,
    e.*
FROM
    (
        SELECT
            *
        FROM
            emp e
        ORDER BY
            sal DESC
    ) e;

-- 급여 높은 상위 세 사람 조회
SELECT
    ROWNUM,
    e.*
FROM
    (
        SELECT
            *
        FROM
            emp e
        ORDER BY
            sal DESC
    ) e
WHERE
    ROWNUM <= 3;


-- 시퀀스 : 규칙에 따라 순번 생성
-- CREATE SEQUENCE 시퀀스이름; (설정안하는 것들은 다 기본값으로 세팅)

--CREATE SEQUENCE 시퀀스명
--[INCREMENT BY 숫자]  기본값 1
--[START WITH 숫자]    기본값 1
--[MAXVALUE 숫자 | NOMAXVALUE ]
--[MINVALUE 숫자 | NOMINVALUE]
--[CYCLE | NOCYCLE ]   CYCLE 인 경우 MAXVALUE에 값이 다다르면 시작값부터 다시 시작
--[CACHE 숫자 | NOCACHE ]  시퀀스가 생성할 번호를 미리 메모리에 할당해 놓음(기본 CACHE 20)

CREATE TABLE dept_sequence
    AS
        SELECT
            *
        FROM
            dept
        WHERE
            1 <> 1;

CREATE SEQUENCE seq_dept_sequence INCREMENT BY 10 START WITH 10 MAXVALUE 90 MINVALUE 0 NOCYCLE CACHE 2;

-- 시퀀스 사용 : 시퀀스이름.CURRVAL(마지막으로 생성된 시퀀스 조회), 시퀀스이름.NEXTVAL(시퀀스 생성)

-- 부서번호 입력시 시퀀스 사용
INSERT INTO dept_sequence (
    deptno,
    dname,
    loc
) VALUES (
    seq_dept_sequence.NEXTVAL,
    'DATABASE',
    'SEOUL'
);

SELECT
    *
FROM
    dept_sequence;

-- 최대값 90 까지 가능
-- 시퀀스 SEQ_DEPT_SEQUENCE.NEXTVAL exceeds MAXVALUE : NOCYCLE 옵션으로 생성했기 때문에 번호가 순환되지 않음

-- 시퀀스 삭제
DROP SEQUENCE seq_dept_sequence;

CREATE SEQUENCE seq_dept_sequence INCREMENT BY 3 START WITH 10 MAXVALUE 99 MINVALUE 0 CYCLE CACHE 2;

SELECT
    seq_dept_sequence.CURRVAL
FROM
    dual;
    
-- synonym(동의어) : 테이블, 뷰, 시퀀스 등 객체 이름 대신 사용할 수 있는 다른 이름을 부여하는 객체  

-- EMP 테이블의 별칭을 E 로 지정    
CREATE SYNONYM e FOR emp; 

-- PUBLIC : 동의어를 데이터베이스 내 모든 사용자가 사용할 수 있도록 설정 
-- CREATE [PUBLIC] SYNONYM E FOR EMP;  

SELECT
    *
FROM
    emp;

SELECT
    *
FROM
    e;

DROP SYNONYM e;
 
 
--[실습1] 다음 SQL문을 작성해 보세요
--① EMP테이블과 같은 구조의 데이터를 저장하는 EMPIDX 테이블을 생성하시오.

CREATE TABLE empidx
    AS
        SELECT
            *
        FROM
            emp;

--② 생성한 EMPIDX 테이블의 EMPNO 열에 IDX_EMPIDX_EMPNO 인덱스를 생성하시오.
CREATE INDEX idx_empidx_empno ON
    empidx (
        empno
    );

--데이터 사전 뷰를 통해 인덱스 확인
SELECT
    *
FROM
    user_indexes;


--[실습2] 실습1에서 생성한 EMPIDX 테이블의 데이터 중 급여가 1500 초과인 
--사원들만 출력하는 EMPIDX_OVER15K 뷰를 생성하시오. 
--(사원번호, 사원이름, 직책,부서번호,급여,추가수당 열을 가지고 있다)
CREATE VIEW empidx_over15k AS
    (
        SELECT
            empno,
            ename,
            job,
            deptno,
            sal,
            comm
        FROM
            empidx
        WHERE
            sal > 1500
    );



--[실습3] 다음 SQL문을 작성해 보세요
--① DEPT 테이블과 같은 열과 행 구성을 가지는 DEPTSEQ 테이블을 작성하시오.


CREATE TABLE deptseq
    AS
        SELECT
            *
        FROM
            dept;

--② 생성한 DEPTSEQ 테이블의 DEPTNO 열에 사용할 시퀀스를 아래에 제시된 특성에 맞춰 생성해 보시오.
--부서 번호의 시작값 : 1
--부서 번호의 증가 : 1
--부서 번호의 최댓값 : 99
--부서 번호의 최소값 : 1
--부서 번호 최댓값에서 생성 중단
--캐시 없음

CREATE SEQUENCE seq_dept START WITH 1 INCREMENT BY 1 MAXVALUE 99 MINVALUE 1 NOCYCLE NOCACHE;


--데이터 사전 뷰를 통해 시퀀스 확인
SELECT
    *
FROM
    user_sequences;


-- 제약조건 : 테이블의 특정 열에 지정
--            NULL 허용 / 불허용, 유일한 값, 조건식을 만족하는 데이터만 입력 가능...
--            데이터 무결성(데이터 정확성, 일관성 보장) 유지 ==> DML 작업 시 지켜야 함
--            영역 무결성, 개체 무결성, 참조 무결성
--            테이블 생성 시 제약조건 지정, OR 생성 후에 ALTER 를 통해 추가, 변경 가능

-- 1) NOT NULL : 빈값 허용 불가
-- 사용자로부터 입력값이 필수로 입력되어야 할 때
CREATE TABLE table_notnull (
    login_id  VARCHAR2(20) NOT NULL,
    login_pwd VARCHAR2(20) NOT NULL,
    tel       VARCHAR2(20)
);

INSERT INTO table_notnull (
    login_id,
    login_pwd
) VALUES (
    'hong123',
    'hong123'
);

-- ORA-01400: NULL을 ("SCOTT"."TABLE_NOTNULL"."LOGIN_PWD") 안에 삽입할 수 없습니다
INSERT INTO table_notnull (
    login_id,
    login_pwd,
    tel
) VALUES (
    'hong123',
    NULL,
    '010-1234-1234'
);

SELECT
    *
FROM
    table_notnull;
    
-- 전체 제약조건 조회  
SELECT
    *
FROM
    user_constraints;
    
    
-- 제약조건 + 제약조건 명 지정    
CREATE TABLE table_notnull2 (
    login_id  VARCHAR2(20)
        CONSTRAINT tblnn2_login_nn NOT NULL,
    login_pwd VARCHAR2(20)
        CONSTRAINT tblnn2_lgpwd_nn NOT NULL,
    tel       VARCHAR2(20)
);    
 
-- 생성한 테이블에 제약조건 추가
-- (SCOTT.) 사용으로 설정 불가 - 널 값이 발견되었습니다.
-- 이미 삽입된 데이터도 체크 대상이 되기 됨
ALTER TABLE table_notnull MODIFY (
    tel NOT NULL
);

ALTER TABLE table_notnull2 MODIFY (
    tel
        CONSTRAINT tblnn2_tel_nn NOT NULL
);

UPDATE table_notnull
SET
    tel = '010-1234-5678'
WHERE
    login_id = 'hong123';
    
-- 제약조건 명 변경
ALTER TABLE table_notnull2 RENAME CONSTRAINT tblnn2_tel_nn TO tblnn3_tel_nn;
    
-- 제약조건 명 삭제    
ALTER TABLE table_notnull2 DROP CONSTRAINT tblnn3_tel_nn;
 
 
-- 2) UNIQUE : 중복되지 않는 값(null 삽입 가능)
--             아이디, 전화번호

CREATE TABLE table_unique (
    login_id  VARCHAR2(20) UNIQUE,
    login_pwd VARCHAR2(20) NOT NULL,
    tel       VARCHAR2(20)
);

INSERT INTO table_unique (
    login_id,
    login_pwd,
    tel
) VALUES (
    'hong123',
    'hong123',
    '010-1234-1234'
);

-- login_id 가 중복된 상황일 때 : unique 위배
-- 무결성 제약 조건(SCOTT.SYS_C008364)에 위배됩니다
INSERT INTO table_unique (
    login_id,
    login_pwd,
    tel
) VALUES (
    NULL,
    'hong123',
    '010-1234-1234'
);

SELECT
    *
FROM
    table_unique;

-- 테이블 생성 제약조건 지정, 변경, 삭제 not null 형태와 동일함


--3) PRIMARY KEY(PK) : UNIQUE + NOT NULL
CREATE TABLE table_primary (
    login_id  VARCHAR2(20) PRIMARY KEY,
    login_pwd VARCHAR2(20) NOT NULL,
    tel       VARCHAR2(20)
);

-- PRIMARY KEY ==> INDEX 자동 생성 됨

-- NULL을 ("SCOTT"."TABLE_PRIMARY"."LOGIN_ID") 안에 삽입할 수 없습니다
INSERT INTO table_primary (
    login_id,
    login_pwd,
    tel
) VALUES (
    NULL,
    'hong123',
    '010-1234-1234'
);

INSERT INTO table_primary (
    login_id,
    login_pwd,
    tel
) VALUES (
    'hong123',
    'hong123',
    '010-1234-1234'
);

-- 4) 외래키 : Foreign key(FK) : 다른 테이블 간 관계를 정의하는데 사용
--             특정 테이블에서 primary key 제약조건을 지정한 열을 다른 테이블의 특정 열에서 참조

-- 사원 추가 시 부서 번호 입력을 해야 함 => dept 테이블의 deptno 만 삽입

-- 부모 테이블
CREATE TABLE DEPT_FK(
    DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)
);

-- 자식 테이블
-- REFERENCES 참조할테이블명(참조할 열) : 외래키 지정
CREATE TABLE EMP_FK(
    EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO));
    
-- 무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO EMP_FK VALUES(1000, 'TEST', 'SALES', 10);

-- 외래키 제약 조건
-- 부모 테이블 데이터가 데이터 먼저 입력

INSERT INTO DEPT_FK VALUES(10, 'DATABASE', 'SEOUL');

-- 삭제 시 
-- 자식 테이블 데이터 먼저 삭제
-- 부모 테이블 데이터 삭제

-- 무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
-- DELETE FROM DEPT_FK WHERE DEPTNO=10;


-- 외래 키 제약조건 옵션
-- ON DELETE CASCADE : 부모가 삭제되면 부모를 참조하는 자식 레코드도 같이 삭제
-- ON DELETE SET NULL : 부모가 삭제되면 부모를 참조하는 자식 레코드의 값을 NULL 변경

CREATE TABLE DEPT_FK2(
    DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK2 PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)
);

CREATE TABLE EMP_FK2(
    EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK2 PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK2 REFERENCES DEPT_FK2(DEPTNO) ON DELETE CASCADE);
    
INSERT INTO DEPT_FK2 VALUES(10, 'DATABASE', 'SEOUL');
INSERT INTO EMP_FK2 VALUES(1000, 'TEST', 'SALES', 10);

DELETE FROM DEPT_FK2 WHERE DEPTNO=10;

-- 5) CHECK : 열에 지정할 수 있는 값의 범위 또는 패턴 지정
-- 비밀번호는 3 자리보다 커야 한다

CREATE TABLE table_CHECK (
    login_id  VARCHAR2(20) PRIMARY KEY,
    login_pwd VARCHAR2(20) CHECK (LENGTH(LOGIN_PWD) > 3),
    tel       VARCHAR2(20)
);
-- 체크 제약조건(SCOTT.SYS_C008373)이 위배
INSERT INTO TABLE_CHECK VALUES('TEST','123','010-1234-5678');

INSERT INTO TABLE_CHECK VALUES('TEST','1234','010-1234-5678');


-- 6) DEFAULT : 기본값 지정
CREATE TABLE table_default (
    login_id  VARCHAR2(20) PRIMARY KEY,
    login_pwd VARCHAR2(20) DEFAULT '1234',
    tel       VARCHAR2(20)
);

INSERT INTO TABLE_DEFAULT VALUES('TEST',NULL,'010-1234-5678');
INSERT INTO TABLE_DEFAULT(login_id, tel) VALUES('TEST1','010-1234-5678');

SELECT * FROM TABLE_DEFAULT;






