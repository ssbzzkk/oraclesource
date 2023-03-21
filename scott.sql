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