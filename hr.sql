-- employee 테이블 전체 내용 조회

SELECT
    *
FROM
    employees;

-- employee 테이블 first_name, last_name, job_id 조회
SELECT
    first_name,
    last_name,
    job_id
FROM
    employees;
    
-- 사원번호가 176인 사람의 LAST_NAME조회
SELECT LAST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID=176;  --TAYLOR

--연봉이 12000 이상 되는 직원들의 LAST_NAME, SALARY조회
SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY>=12000;

--연봉이 5000에서 12000 범위가 아닌 사람들의 LAST_NAME, SALARY
SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY>12000 OR SALARY<5000
ORDER BY SALARY;

--20.50번 부서에서 근무하는 모든 사원딀의 last_name,부서번호를 오름차순으로 조회
SELECT LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(20,50) ORDER BY LAST_NAME, DEPARTMENT_ID;

--커미션을 받는 모든 사원들의 last_name, 연봉, 커미션 조회(연봉의 내림차순, 커미션 내림차순)
SELECT LAST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE commission_pct >0 ORDER BY SALARY DESC, COMMISSION_PCT DESC;
--연봉이 2500, 3500, 7000이 아니며 직업이 SA_REP나 ST_CLERK인 사원 조회
SELECT * 
FROM EMPLOYEES
WHERE SALARY NOT IN (2500, 3500,7000) AND JOB_ID IN('SA_REP','ST_CLERK');

--2008/02/20~2008/05/01 사이에 고용된 사원들의 LAST_NAME, 사번, 고용일자 조회
--고용일자 내림차순 정렬
--날짜 표현시 홀따옴표 안에 표현 '-' OR '/' 사용 가능

SELECT LAST_NAME, EMPLOYEE_ID, HIRE_DATE 
FROM EMPLOYEES
WHERE HIRE_DATE<='2008/05/01' AND HIRE_DATE>='2008-02-20'
ORDER BY HIRE_DATE DESC;

SELECT LAST_NAME, EMPLOYEE_ID, HIRE_DATE 
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2008-02-20' AND '2008/05/01'
ORDER BY HIRE_DATE DESC;



--2004년도에 고용된 사원들의 LAST_NAME, HIRE_DATE, 고용일자 오름차순 정렬
SELECT LAST_NAME, HIRE_DATE 
FROM EMPLOYEES
WHERE HIRE_DATE<='2004/12/31' AND HIRE_DATE>='2004-01-01'
ORDER BY HIRE_DATE;

--부서가 20,50이고 연봉이 5000에서 12000 범위인 사람들의 LAST_NAME, SALARY
--연봉 오름차순 정렬
SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(20,50) AND  SALARY BETWEEN 5000 AND 12000
ORDER BY SALARY;

--2004년도에 고용된 사원들의 LAST_NAME, HIRE_DATE 오름차순 정렬 (LIKE사용)
SELECT LAST_NAME, HIRE_DATE 
FROM EMPLOYEES
WHERE HIRE_DATE like '04%'
ORDER BY HIRE_DATE;

--LAST_NAME에 u가 포함된 사원들의 사번, last_name
SELECT employee_id, LAST_NAME 
FROM EMPLOYEES
WHERE LAST_NAME like '%u%'
ORDER BY HIRE_DATE;

--LAST_NAME에 네번째 글자가 a인 사원들의 last_name
SELECT LAST_NAME 
FROM EMPLOYEES
WHERE LAST_NAME like '___a%'
ORDER BY last_name;

--LAST_NAME에 a혹은 e가 포함된 사원들의 last_name
--last_name 오름차순 정렬
SELECT LAST_NAME 
FROM EMPLOYEES
WHERE LAST_NAME like '%a%' or LAST_NAME like '%e'
ORDER BY last_name;
-- last_name 오름차순 정렬

--LAST_NAME에 a와 e가 포함된 사원들의 last_name
--last_name 오름차순 정렬
SELECT LAST_NAME 
FROM EMPLOYEES
WHERE LAST_NAME like '%a%e%' or LAST_NAME like '%e%a%'
ORDER BY last_name;


-- 메니저(manager_id)가 없는 사람들의 LAST_NAME, JOB_ID 조회
SELECT LAST_NAME, job_id
FROM EMPLOYEES
WHERE manager_id is null OR manager_id='';

-- JOB_ID가 ST_CLERK인 사원의 부서번호조회(단, 부서번호가 NULL인 사원은 제외)
-- 중복을 제거한 후 부서번호만 조회
SELECT distinct department_id
FROM EMPLOYEES
WHERE job_id='ST_CLERK' and department_id is not null; 


-- commission_pct가 null 이 아닌 사원들 중에서 commission=salary*comission_pct 를 구하여
-- employee_id, first_name, job_id 출력 
SELECT employee_id, first_name, job_id, salary*commission_pct as commission
FROM EMPLOYEES
WHERE COMMISSION_PCT is not null;

--first_name 이 Curtis 인 사람의 first_name, last_name, email, phone_number, job_id 를 조회한다.
--단, job_id의 결과는 소문자로 출력되도록 한다.
SELECT first_name, last_name, email, phone_number, LOWER(job_id)
FROM EMPLOYEES
WHERE first_name='Curtis';


--부서번호가 60,70,80,90인 사원들의 employee_id, first_name, hire_date, job_id 조회
--단, job_id가 IT_PROG 인 사원의 경우 프로그래머로 변경한 후 출력
SELECT employee_id, first_name, hire_date, REPLACE(job_id,'IT_PROG','프로그래머')   
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(60,70,80,90);


--JOB_ID가 AD_PRES, PU_CLERK인 사원들의 employee_id, first_name, last_name, department_id, job_id를 조회한다.
--단 사원명은 first_name과 last_name을 연결하여 출력
SELECT employee_id, first_name ||' ' || last_name, department_id, job_id
                        --CONCAT(FIRST_NAME,CONCAT(' ',LAST_NAME)
FROM EMPLOYEES
WHERE JOB_ID IN('AD_PRES','PU_CLERK');

--예제 3
select last_name,
    salary, 
    CASE
    WHEN SALARY <1999 THEN 0
    WHEN SALARY BETWEEN 2000 AND 3999 THEN 0.09
    WHEN SALARY BETWEEN 4000 AND 5999 THEN 0.2
    WHEN SALARY BETWEEN 6000 AND 7999 THEN 0.3
    WHEN SALARY BETWEEN 8000 AND 9999 THEN 0.4
    WHEN SALARY BETWEEN 10000 AND 11999 THEN 0.42
    WHEN SALARY BETWEEN 12000 AND 13999 THEN 0.44
    WHEN SALARY >14000 THEN 0.45
    END
    as TAX_RATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID=80;

select last_name,
    salary,
    DECODE(TRUNC(SALARY/2000,0),
      0,
      0.00,
      1,
      0.09,
      2,
      0.20,
      3,
      0.30,
      4,
      0.40,
      5,
      0.42,
      6,
      0.44,
      0.45)
      AS TAX_RATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID=80;

-- 회사 내의 최대 연봉 및 최소 연봉의 차이를 출력
SELECT MAX(SALARY)-MIN(SALARY)
FROM EMPLOYEES;

--메니저로 근무하는 사원들의 총 숫자 출력(매니저 중복 제거)
SELECT  COUNT(distinct MANAGER_ID)
FROM EMPLOYEES;





