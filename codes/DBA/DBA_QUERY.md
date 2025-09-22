DBA CODE 1일차
```
-- AAA database  생성

CREATE database AAA;
create database k_test;
show databases;
use k_test;
show databases;
use k_test;

-- btc 테이블 생성

create table btc
( ID VARCHAR(10) ,
  NAME VARCHAR(20),
  ADDR VARCHAR(50),
  PHONE_NUM INTEGER,
  CLASS VARCHAR(5)
 );

use aaa;
use k_test;

use aaa;

create table btc
( ID VARCHAR(10) ,
  NAME VARCHAR(20),
  ADDR VARCHAR(50),
  PHONE_NUM INTEGER,
  CLASS VARCHAR(5)
 );

drop table aaa.btc;


USE aaa;
SHOW DATABASES;

USE k_test;

create table btc_1
( ID VARCHAR(10) ,
  NAME VARCHAR(20),
  ADDR VARCHAR(50),
  PHONE_NUM INTEGER,
  CLASS VARCHAR(5),
  PRIMARY KEY (ID)
 );

create table btc_1_1
( ID VARCHAR(10) PRIMARY KEY ,
  NAME VARCHAR(20),
  ADDR VARCHAR(50),
  PHONE_NUM INTEGER,
  CLASS VARCHAR(5)
 );
 
SHOW CREATE TABLE btc_1;


CREATE TABLE `btc_1` (
  `ID` varchar(10) NOT NULL,
  `NAME` varchar(20) DEFAULT NULL,
  `ADDR` varchar(50) DEFAULT NULL,
  `PHONE_NUM` int DEFAULT NULL,
  `CLASS` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

SHOW CREATE TABLE btc_1_1;

CREATE TABLE `btc_1_1` (
  `ID` varchar(10) NOT NULL,
  `NAME` varchar(20) DEFAULT NULL,
  `ADDR` varchar(50) DEFAULT NULL,
  `PHONE_NUM` int DEFAULT NULL,
  `CLASS` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


CREATE TABLE BTC_2
( ID VARCHAR(10)
, NAME VARCHAR(20)
, ADDR VARCHAR(50)
, PHONE_NUM INTEGER
, CLASS VARCHAR(5)
, PRIMARY KEY(ID)
, UNIQUE KEY(PHONE_NUM) 
);

SHOW CREATE TABLE BTC_2;

USE k_test;



CREATE TABLE MEMBER 
( 
	mem_id char(8) NOT NULL,
	mem_name varchar(10) NOT NULL,
	mem_number integer NOT NULL,
	addr char(2) NOT NULL,
	phone1 char(3),
	phone2 char(13),
	height SMALLINT,
	debut_date date,
	PRIMARY key(mem_id)	
);

CREATE TABLE BTC_3 (
    ID VARCHAR(10),
    NAME VARCHAR(20),
    ADDR VARCHAR(50) NOT NULL,
    PHONE_NUM INTEGER,
    CLASS VARCHAR(5),
    PRIMARY KEY(ID),
    UNIQUE KEY(PHONE_NUM),
    CHECK (CLASS IN ('BTC-1', 'BTC-2')) 
);

SHOW DATABASES;

ALTER TABLE MEMBER MODIFY COLUMN mem_id char(8) NOT NULL COMMENT '사용자 아이디';

CREATE TABLE MEMBER_1 
( 
	mem_id char(8) NOT NULL COMMENT '사용자 아이디',
	mem_name varchar(10) NOT NULL COMMENT '사용자 이름',
	mem_number integer NOT NULL COMMENT '사용자 번호',
	addr char(2) NOT NULL COMMENT '주소' ,
	phone1 char(3) COMMENT '전화 번호 국번' ,
	phone2 char(13) COMMENT '전화 번호',
	height SMALLINT COMMENT '평균 키',
	debut_date date COMMENT '데뷔 일자',
	PRIMARY key(mem_id)	
);


CREATE TABLE test (
id varchar(10)
,name varchar(20)
, addr varchar(10)

);

CREATE TABLE test1 (
id varchar(10)
,name varchar(20) NOT NULL	
, addr varchar(10) NOT NULL 

);

CREATE TABLE test2 (
id varchar(10)
,name varchar(20) NOT NULL	
, addr varchar(10) 
, phone integer 
);

INSERT INTO test2 (id,name,phone) VALUES ('111','홍길동',12345678);

INSERT INTO test1 VALUES ('111','홍길동','서울특별시');

INSERT INTO test1 (id,name,addr) VALUES ('111','홍길동','');

INSERT INTO test1 (id,name,addr) VALUES ('111','홍길동', null);

SELECT * FROM test1;

SELECT * FROM test2;


INSERT INTO  BTC VALUES('1','홍길동','부산시','01012345678','BTC-1');
INSERT INTO  BTC VALUES('1','홍길동','부산시','01012345678','BTC-1');
INSERT INTO  BTC VALUES('1','홍길동','부산시','01012345678','BTC-1');
INSERT INTO  BTC VALUES('1','홍길동','부산시','01012345678','BTC-1');
INSERT INTO  BTC VALUES('1','홍길동','부산시','01012345678','BTC-1');
INSERT INTO  BTC VALUES('1','홍길동','부산시','01012345678','BTC-1');
INSERT INTO  BTC VALUES('1','홍길동','부산시','01012345678','BTC-1');
INSERT INTO  BTC VALUES('1','홍길동','부산시','01012345678','BTC-1');
INSERT INTO  BTC VALUES('1','홍길동','부산시','01012345678','BTC-1');
INSERT INTO  BTC VALUES('1','홍길동','부산시','01012345678','BTC-1');

INSERT INTO  BTC_1 VALUES('1','홍길동','부산시','01012345678','BTC-1');
INSERT INTO  BTC_1 VALUES('2','강감찬','부산시','01013579990','BTC-1');
INSERT INTO  BTC_1 VALUES('3','이순신','부산시','01043532535','BTC-1');
INSERT INTO  BTC_1 VALUES('4','김유신','부산시','01076568766','BTC-2');
INSERT INTO  BTC_1 VALUES('5','손오공','부산시','01087649273','BTC-2');
INSERT INTO  BTC_1 VALUES('6','사오정','부산시','01065352829','BTC-2');


SELECT * FROM BTC;
SELECT * FROM BTC_1;

INSERT INTO BTC_2 VALUES('1','홍길동','부산시','01012345679','BTC-1');
INSERT INTO BTC_2 VALUES('2', '강감찬', '부산시', '01012345678', 'BTC-1');

SELECT * FROM BTC_2;



CREATE TABLE test3 (
id INTEGER AUTO_INCREMENT PRIMARY KEY
,name varchar(20)
, addr varchar(10) 
, phone integer 
);

INSERT INTO TEST3 (name, addr, phone) VALUES ('홍길동','서울시',123456)

SELECT * FROM test3;


CREATE TABLE test4 (
id INTEGER AUTO_INCREMENT PRIMARY KEY
,name varchar(20)
, addr varchar(10) NOT NULL DEFAULT '강남구'
, phone integer 
);

INSERT INTO TEST4 (name, phone) VALUES ('홍길동',123456)

SELECT * FROM test4;

INSERT INTO btc_3 values('1','홍길동','부산시','01012345678','btc-1'); 
INSERT INTO btc_3 values('2','강감찬','부산시','01012345679','btc-1'); 
INSERT INTO btc_3 values('3','이순신','부산시','01043532535','btc-1'); 
INSERT INTO btc_3 values('4','김유신','서울시','01076568766','btc-2'); 

SELECT * FROM BTC_3 

CREATE TABLE employees (
emp_no integer NOT NULL ,
birth_date date NOT NULL ,
FIRST_name varchar(14) NOT NULL ,
last_name varchar (16) NOT NULL ,
gender char(1) NOT NULL ,
hire_date date NOT NULL ,
PRIMARY KEY (emp_no)
);



ALTER TABLE employees MODIFY COLUMN emp_no integer COMMENT '사원 번호';
ALTER TABLE employees MODIFY COLUMN birth_date  date COMMENT '생년 월 일';
ALTER TABLE employees MODIFY COLUMN FIRST_name varchar(14) COMMENT '성';
ALTER TABLE employees MODIFY COLUMN last_name varchar (16) COMMENT '이름';
ALTER TABLE employees MODIFY COLUMN gender char(1) COMMENT '성별';
ALTER TABLE employees MODIFY COLUMN hire_date date COMMENT '입사일';

SELECT * FROM employees;



INSERT INTO employees VALUES('0001', '20220101', '강', '감찬', 'M', '20000101');
INSERT INTO employees VALUES('0002', '20220201', '이', '순신', 'M', '20010101');
INSERT INTO employees VALUES('0003', '20220301', '유', '관순', 'F', '20020101');
INSERT INTO employees VALUES('0004', '20220401', '김', '유신', 'M', '20030101');
INSERT INTO employees VALUES('0005', '20220501', '정', '약용', 'M', '20040101');
INSERT INTO employees VALUES('0006', '20220601', '윤', '봉길', 'M', '20050101');


SELECT * FROM employees;
delete FROM employees;
SELECT * FROM employees;

INSERT INTO employees VALUES ('0001', '20220101', '강','감찬','M','20000101')
,							 ('0002', '20220201', '이','순신','M','20010101')
,							 ('0003', '20220301', '유','관순','F','20020101')
,                            ('0004', '20220401', '김','유신','M','20030101')
,                            ('0005', '20220501', '정','약용','M','20040101')
,                            ('0006', '20220601', '윤','봉길','M','20050101');

SELECT * FROM employees;


CREATE DATABASE k_sample;

SHOW DATABASES;

USE k_sample;

SELECT DATABASE();

CREATE TABLE employees (
emp_no integer NOT NULL comment '사원 번호' ,
brith_date date NOT NULL comment '생년 월 일',
first_name varchar(14) NOT NULL comment '성',
last_name varchar(16) NOT NULL comment '이름',
gender char(1) NOT NULL comment '성별',
hire_date date NOT NULL comment '입사일'
);

ALTER TABLE employees
ADD PRIMARY KEY (emp_no);

CREATE TABLE departments (
dept_no char(4) NOT NULL comment '부서 번호',
dept_name varchar(40) NOT NULL comment ' 부서 명',
PRIMARY KEY (dept_no),
UNIQUE	KEY (dept_name)
);

CREATE TABLE dept_manager (
  emp_no integer NOT NULL comment '사원 번호' ,
  dept_no char(4) NOT NULL comment '부서 번호',
  from_date date comment '발령 일시',
  to_date date comment '발령 종료 일시',
  PRIMARY KEY(emp_no, dept_no)
); 


CREATE TABLE dept_emp (
emp_no integer NOT NULL comment '사원 번호' ,
dept_no char(4) NOT NULL comment '부서 번호' ,
from_date date comment '발령 일시'
);

ALTER TABLE dept_emp
ADD PRIMARY KEY (emp_no, dept_no);

ALTER TABLE dept_emp
ADD CONSTRAINT fk_dept_emp 
FOREIGN KEY (emp_no)
REFERENCES employees(emp_no);

ALTER TABLE dept_emp
ADD CONSTRAINT fk_emp_dept
FOREIGN KEY (dept_no)
REFERENCES departments (dept_no);

CREATE TABLE titles (
emp_no integer NOT NULL comment '사원 번호',
title varchar(50) NOT NULL comment '직책 이름',
from_date date NOT NULL comment '발령 일시',
To_date date comment '종료 일시',
PRIMARY KEY(emp_no, title, from_date)
);

CREATE TABLE salaries(
emp_no integer NOT NULL comment '사원 번호',
salary integer NOT NULL comment '급여액',
from_date date NOT NULL comment '시작일',
To_date date comment '종료일',
PRIMARY KEY(emp_no, from_date)
);



SELECT  * FROM salaries;
SELECT  * FROM titles;
SELECT  * FROM dept_emp;
SELECT  * FROM dept_manager;
SELECT  * FROM departments;
SELECT  * FROM employees;


CREATE TABLE stadium (
stadium_id varchar(3) NOT NULL comment '경기장 아이디',
stadium_name varchar(10) NOT NULL comment '경기장 이름',
seat_count integer NOT NULL comment '좌석 수',
PRIMARY KEY (stadium_id)
);

CREATE TABLE player (
player_id varchar(7) NOT NULL comment '선수 아이디',
player_name varchar(5) NOT NULL comment '선수 이름',
team_id varchar(3) NOT NULL comment '소속팀 아이디',
PRIMARY KEY(player_id)
);

ALTER TABLE player	
ADD CONSTRAINT fk_player
FOREIGN KEY (team_id)
REFERENCES  team(team_id);




CREATE TABLE team (
team_id varchar(3) NOT NULL comment '팀 아이디',
team_name varchar(10) NOT NULL comment '팀 이름', 
region_name varchar(5) NOT NULL comment '지역명',
stadium_id varchar(3) NOT NULL comment '홈구장 아이디',
PRIMARY KEY(team_id)
);

ALTER TABLE team	
ADD CONSTRAINT fk_stadium_id
FOREIGN KEY (stadium_id)
REFERENCES  stadium (stadium_id);


SELECT emp_no, birth_date, first_name, last_name, gender FROM employees;

SELECT emp_no FROM employees;

SELECT gender FROM employees;

SELECT DISTINCT gender FROM employees;

SELECT * FROM EMPLOYEES;

SELECT emp_no '사원번호' FROM employees; 
SELECT emp_no AS '사원번호' FROM employees; 

SELECT * FROM EMPLOYEES;

SELECT emp_no '직원번호', birth_date '생일' ,first_name '성', last_name'이름',gender '성별',hire_date '입사일' FROM EMPLOYEES;

SELECT concat(first_name,last_name)  FROM employees;

SELECT emp_no* 100000 FROM employees;
SELECT emp_no, emp_no * 100000 FROM employees;
SELECT emp_no * 100000 / 2 FROM employees;
select emp_no, (emp_no * 100000) / 2 from employees;


SELECT concat(player_name, '선수(',team_id , '소속)') 선수명단 FROM player;

SELECT * FROM employees;


SELECT concat(first_name, last_name , '님') 이름 FROM employees;
```

DBA CODE 2일차

```
--- 2일차 

SELECT * FROM departments;
SELECT concat('insert into departments values(', dept_no, ',' , dept_name, ');') name FROM  departments;
SELECT * FROM stadium;
SELECT concat (stadium_name , '(', seat_count, '명)') 경기장관중석 FROM stadium;

-- 조건절

SELECT * FROM player WHERE player_id = '2012134';
SELECT * FROM player WHERE player_name = '레오' ; -- ‘레오’ 인 선수ID와 팀ID 만 출력하려면 *이 아닌
SELECT PLAYER_ID, TEAM_ID FROM PLAYER WHERE PLAYER_NAME = '레오';
SELECT * FROM stadium WHERE seat_count >= '40000';

-- 조건절 in

SELECT * FROM employees WHERE last_name IN ('Koblick', 'Merro');
select * from employees where (last_name, gender) = ( 'Koblick', 'M');
select * from employees where (last_name, gender) in (('Koblick', 'M'));
select * from employees where (last_name, gender) in (('Koblick', 'M'), ('Merro', 'F'));

-- LIKE 와일드 카드
-- % 0개 이상의 어떤 문자를 의미한다.
-- _1개인 단일 문자를 의미한다.

SELECT PLAYER_NAME 선수이름, TEAM_ID
FROM PLAYER
WHERE PLAYER_NAME LIKE '_F';

SELECT PLAYER_NAME 선수이름, TEAM_ID
FROM PLAYER
WHERE PLAYER_NAME LIKE '장%';

SELECT first_name 성 FROM employees WHERE first_name LIKE 'P%';
SELECT last_name 이름 FROM employees WHERE last_name LIKE '__p%';

-- WHERE 조건 – IS NULL,  NULL : 아직 정의되지 않은 미지의 값, 또는 현재 알 수 없는 값
-- NULL 값과의 수칙연산은 NULL 값을 리턴한다.
--  NULL 값과의 비교연산은 거짓(FALSE)를 리턴한다

SELECT * FROM titles WHERE to_date = null ;
SELECT * FROM titles WHERE to_date is not null ;


-- WHERE 조건 – 부정 연산자
SELECT * FROM player;

SELECT PLAYER_NAME 선수이름, POSITION 포지션, BACK_NO 백넘버, HEIGHT 키
FROM PLAYER
WHERE NOT POSITION = 'MF'
and NOT HEIGHT BETWEEN 175 AND 185;


-- 실습 
SELECT * FROM employees WHERE gender = 'M';

SELECT * FROM employees WHERE birth_date BETWEEN '1955-01-01' AND '1961-01-01'; 
SELECT * FROM employees WHERE birth_date >= '1955-01-01' AND  birth_date <= '1961-01-01'


SELECT * FROM employees WHERE last_name LIKE '%f%' 

SELECT emp_no FROM employees WHERE emp_no >= '15000';

SELECT * FROM DEPARTMENTS WHERE dept_name in ('Marketing' ,'Sales');
SELECT * FROM DEPARTMENTS WHERE dept_name = 'Marketing' or  dept_name = 'Sales';


SELECT * FROM titles WHERE title = 'Staff';
 


-- update 

SELECT * FROM player1;
SELECT * FROM player2;
CREATE TABLE player2 AS SELECT * FROM player; -- 특정 테이블 만들고 데이터 옮기기 

update player1 SET team_id = 'kor'; -- team_id 값을 kor로 바꾸기 
SELECT * FROM player1;

update player2 SET team_id = 'kor' WHERE team_id = 'K01';

-- delete 

DELETE FROM player2;
SELECT * FROM player4;

DELETE FROM player1 WHERE team_id = 'kor';
SHOW CREATE TABLE player;


-- table new and copy 
 
CREATE TABLE player4 (
  player_id varchar(7) NOT NULL COMMENT '선수 아이디',
  player_name varchar(5) NOT NULL COMMENT '선수 이름',
  team_id varchar(3) NOT NULL COMMENT '소속팀 아이디',
  PRIMARY KEY (player_id)
)

INSERT INTO player4 (SELECT * FROM player)

SELECT * FROM player4;

-- Function

SELECT abs(-15);
SELECT ascii('A');

-- 현재 날짜 시간 출력
SELECT now();
SELECT sysdate();
SELECT current_timestamp();

-- 실습 

SELECT *  FROM employees;

-- 사원(employees) 테이블에서 모든 컬럼의 값을 출력하되,
-- 이름에 해당하는 컬럼은 소문자로 출력하고 컬럼에 맞는 Alias를 작성하세요
SELECT emp_no '사원 번호' , birth_date '생일' , lower(first_name) '성' , lower(last_name) '이름', gender '성별',
hire_date '입사일'  FROM employees 

-- 사원(employees) 테이블에서 모든 컬럼의 값을 출력하되, First_name, Last_name은 소문자로 하나의 컬럼으로 출력하고 
-- 컬럼에 맞는 Alias를 작성하세요.
SELECT emp_no '사원 번호' , birth_date '생일' , lower(concat(first_name,last_name)) ' 이름 ', gender '성별',
hire_date '입사일'  FROM employees 

-- 사원(employees) 테이블에서 모든 컬럼의 값을 출력하되,
-- First_name의 첫번째 자리만 출력하는 신규 컬럼을 생성하여 출력하세요.
SELECT emp_no '사원 번호' , birth_date '생일' , first_name '성' ,last_name '이름', gender '성별',
hire_date '입사일', lower(substr(first_name,1,1)) 'new_first'  FROM employees

-- 사원(employees) 테이블에서 모든 컬럼의 값을 출력하되, First_name, Last_name은 소문자로 하나의 컬럼으로 출력하고
-- 이름의 길이를 출력하는 신규 컬럼을 생성하시오
SELECT emp_no '사원 번호' , birth_date '생일' , lower(concat(first_name,last_name)) ' 이름 ', gender '성별',
hire_date '입사일' , length(lower(concat(first_name,last_name)))'new_name' FROM employees   



SELECT emp_no '사원 번호' , birth_date '생일' , lower(concat(first_name,last_name)) ' 이름 ', gender '성별',
hire_date '입사일' , length(lower(concat(first_name,last_name)))'new_name' , ascii(last_name) 'zz'  FROM employees  


SELECT ascii('F');

-- case 

SELECT emp_no '사원번호' ,
CASE dept_no  WHEN 'd001' THEN '마케팅'
	     WHEN 'd002' THEN '재무'
	     WHEN 'd003' THEN '인사'
	     WHEN 'd004' THEN '상품'
	     WHEN 'd005' THEN '개발'
	     WHEN  'd006' THEN '품질'
	     WHEN  'd007' THEN '영업'
	     WHEN  'd008' THEN '연구'
    ELSE 'no'
     END AS '부서명'
, FROM_DATE AS '일사일'
, TO_DATE AS '퇴사일'
FROM DEPT_EMP

SELECT * FROM DEPT_EMP;
SELECT * FROM player;

SELECT player_id 'id' ,
CASE player_name WHEN '디디' THEN '최고'
ELSE '최악'
END '선수명'
,team_id 'aa'
FROM player

-- 그룹 함수

SELECT * FROM salaries;
INSERT INTO player1 (SELECT * FROM player)
SELECT count(*) FROM player1
UPDATE player1 SET player_name = null WHERE player_id = '2012131'

SELECT * FROM player1;
SELECT COUNT(*) FROM player1; -- NULL 값 포함
SELECT COUNT(player_name) , player_name FROM player1 GROUP BY player_name; -- NULL 값 제외

SELECT min(player_name) FROM player1;
SELECT max(player_name) FROM player1;

-- 실습 

SELECT emp_no '부서', round(avg(salary)) '평균' FROM SALARIES GROUP BY emp_no; 

SELECT * FROM salaries;
SELECT * FROM employees;

SELECT  count(gender) '성별' FROM employees GROUP BY gender;


SELECT GENDER AS 성별 , COUNT(*) AS 직원수
FROM EMPLOYEES
GROUP BY GENDER
HAVING COUNT(*) >= 150052 ;


SELECT CASE WHEN GENDER = 'M' THEN '남자'
 ELSE '여자'
 END AS '성별'
 , COUNT(*) AS CNT
FROM EMPLOYEES
GROUP BY GENDER;


-- having 절

SELECT * FROM EMPLOYEES;


select hire_date 입사일, gender 성, count(*) 사원수
from employees
where gender = 'M'
group by hire_date, gender
having count(*) >= 50;

select hire_date 입사일, gender 성, count(*) 사원수
from employees
group by hire_date, gender 
having count(*) >= 50
and gender = 'M';


-- order by

SELECT * FROM salaries

SELECT from_date , salary from salaries
ORDER BY from_date, salary DESC;

SELECT emp_no '부서 번호' , salary  FROM salaries 
ORDER BY emp_no, salary DESC;

SELECT emp_no '사원 이름' , salary '급여' , salary * 12   '연봉'  FROM salaries
ORDER BY salary * 12 DESC, emp_no;

SELECT * FROM employees;
SELECT emp_no '부서 번호', concat(last_name,first_name) '이름', gender '성별' , '급여' FROM employees 
ORDER BY   gender DESC, emp_no;


-- inner join

SELECT * FROM  player a , team b WHERE a.TEAM_ID = b.TEAM_ID;
SELECT * FROM player a INNER JOIN team b ON a.team_id = b.team_id; 

SELECT count(*) FROM PLAYER;
SELECT count(*) FROM team;

SELECT 12*15


--  outer join

SELECT * FROM  player a , team b WHERE a.TEAM_ID = b.TEAM_ID(+)
 -- orcle 에서 (+) 하면 실행 가능 / mysql 은 outer join 실행 안됨

SELECT * FROM  player a RIGHT OUTER JOIN TEAM b ON a.team_id = b.TEAM_ID  
-- on 절은 where의 역할
```

DBA 4일차 

```
-- join 

SELECT * FROM player;

SELECT * FROM team;

-- inner join
SELECT a.player_id , a.player_name, a.TEAM_ID, b.stadium_id, b.REGION_NAME , b.TEAM_ID , b.TEAM_NAME 
FROM player a INNER JOIN team b ON a.team_id = b.TEAM_ID; 

-- left outer
SELECT a.player_id , a.player_name, a.TEAM_ID, b.stadium_id, b.REGION_NAME , b.TEAM_ID , b.TEAM_NAME  
FROM player a left OUTER jOIN team b ON a.team_id = b.TEAM_ID; 

-- right outer
SELECT a.player_id , a.player_name, a.TEAM_ID, b.stadium_id, b.REGION_NAME , b.TEAM_ID , b.TEAM_NAME 
FROM player a right OUTER jOIN team b ON a.team_id = b.TEAM_ID;


-- full outer mysql 은 안됨 그래서 
-- UNION/UNION ALL -- union은 중복된 행 제거 / union all은 위랑 아래 중복 제거 안하고 전부 표현
SELECT a.player_id , a.player_name, a.TEAM_ID, b.stadium_id, b.REGION_NAME , b.TEAM_ID , b.TEAM_NAME 
FROM player a LEFT OUTER jOIN team b ON a.team_id = b.TEAM_ID
union
SELECT a.player_id , a.player_name, a.TEAM_ID, b.stadium_id, b.REGION_NAME , b.TEAM_ID , b.TEAM_NAME 
FROM player a right OUTER jOIN team b ON a.team_id = b.TEAM_ID;


SELECT a.player_id , a.player_name, a.TEAM_ID, b.stadium_id, b.REGION_NAME , b.TEAM_ID , b.TEAM_NAME 
FROM player a LEFT OUTER jOIN team b ON a.team_id = b.TEAM_ID
UNION all
SELECT a.player_id , a.player_name, a.TEAM_ID, b.stadium_id, b.REGION_NAME , b.TEAM_ID , b.TEAM_NAME 
FROM player a right OUTER jOIN team b ON a.team_id = b.TEAM_ID

-- cross join 
SELECT a.player_id , a.player_name, a.TEAM_ID, b.stadium_id, b.REGION_NAME , b.TEAM_ID , b.TEAM_NAME FROM player 
a CROSS JOIN team b 

SELECT E.EMP_NO, E.BIRTH_DATE, E.FIRST_NAME, E.LAST_NAME
, E.GENDER, E.HIRE_DATE
FROM EMPLOYEES E, DEPT_EMP DE
WHERE E.EMP_NO = DE.EMP_NO
AND FIRST_NAME LIKE 'P%'

-- 2개 이상 join

SELECT E.EMP_NO, E.BIRTH_DATE, E.FIRST_NAME, E.LAST_NAME
, E.GENDER, E.HIRE_DATE, D.DEPT_NAME
FROM EMPLOYEES E, DEPT_EMP DE, DEPARTMENTS D
WHERE E.EMP_NO = DE.EMP_NO
AND DE.DEPT_NO = D.DEPT_NO;


SELECT E.EMP_NO, E.BIRTH_DATE, E.FIRST_NAME, E.LAST_NAME
, E.GENDER, E.HIRE_DATE, DE.DEPT_NO, T.TITLE
FROM EMPLOYEES E, DEPT_EMP DE, TITLES T
WHERE E.EMP_NO = DE.EMP_NO
AND DE.EMP_NO = T.EMP_NO;

-- minus mysql에서 지원 안함
-- 원래는  위 아래 컬럼수가 동일하고 데이터 타입이 동일해야함 
-- INTERSECT

SELECT player_name FROM player
INTERSECT 
SELECT player_name FROM player WHERE player_name = '쟈스민';

-- 실습

SELECT * FROM EMPLOYEES;
SELECT * FROM dept_emp;

SELECT a.emp_no, a.gender, b.FROM_DATE , b.DEPT_NO  FROM EMPLOYEES a 
INNER JOIN dept_emp b ON a.EMP_NO = b.EMP_NO ;


-- 2번 문제
SELECT * FROM DEPT_MANAGER;

SELECT a.emp_no , b.emp_no , b.DEPT_NO  FROM EMPLOYEES a , dept_manager b
WHERE a.emp_no = b.emp_no AND b.dept_no = 'd001'
ORDER BY a.emp_no;

-- 3번 
SELECT * FROM EMPLOYEES;

SELECT E.EMP_NO, E.BIRTH_DATE, E.GENDER, DE.DEPT_NO, D.DEPT_NAME
FROM EMPLOYEES E, DEPT_EMP DE, DEPARTMENTS D
WHERE E.EMP_NO = DE.EMP_NO
AND DE.DEPT_NO = D.DEPT_NO
AND E.LAST_NAME = 'WEGERLE'
AND E.FIRST_NAME = 'SHIRISH';

-- 4번 
SELECT E.EMP_NO, E.BIRTH_DATE, CONCAT(E.FIRST_NAME, E.LAST_NAME) AS EMP_NAME
, E.GENDER, E.HIRE_DATE
FROM DEPARTMENTS D, DEPT_EMP DE, EMPLOYEES E
WHERE D.DEPT_NAME = 'RESEARCH'
AND D.DEPT_NO = DE.DEPT_NO
AND DE.EMP_NO = E.EMP_NO;

-- 5번
SELECT E.EMP_NO, E.BIRTH_DATE, E.FIRST_NAME, E.LAST_NAME, E.GENDER
, S.SALARY
FROM EMPLOYEES E, SALARIES S
WHERE E.EMP_NO = S.EMP_NO
AND S.TO_DATE > CURRENT_DATE();

-- 6번
SELECT E.*, T.TITLE
FROM EMPLOYEES E INNER JOIN TITLES T ON E.EMP_NO = T.EMP_NO
WHERE T.TO_DATE is null;


SELECT MIN(BIRTH_DATE)
FROM EMPLOYEES;

SELECT *
FROM EMPLOYEES
ORDER BY hire_date DESC;

-- 1번
SELECT emp_no , hire_date
FROM EMPLOYEES
WHERE YEAR(HIRE_DATE)=1999;

-- 2번 
SELECT GENDER AS 성별 , hire_date
FROM EMPLOYEES
WHERE YEAR(HIRE_DATE)=1998
AND gender = 'M'
GROUP BY hire_date

-- 3번
SELECT * FROM titles 

SELECT title , count(*) FROM titles
GROUP BY title;

-- 4번
SELECT gender, count(*) FROM employees
GROUP BY gender;

-- 5번

SELECT E.*, SALARY
FROM DEPT_EMP DE
INNER JOIN EMPLOYEES E ON E.EMP_NO = DE.EMP_NO
INNER JOIN SALARIES S ON S.EMP_NO = DE.EMP_NO
WHERE DE.TO_DATE = '9999-01-01' AND DEPT_NO='D005'
ORDER BY SALARY DESC
LIMIT 7;


-- 6번 
SELECT CASE WHEN gender = 'M' THEN '남자'
	ELSE '여자'
 END '성별'
 ,count(*) AS cnt 
FROM EMPLOYEES
GROUP BY gender;

-- 7번

SELECT title , count(*) FROM titles
GROUP BY title; 

SELECT * FROM titles;
SELECT * FROM SALARIES

-- 문제 1
SELECT b.emp_no, b.salary, a.title FROM titles a 
INNER JOIN salaries b ON a.EMP_NO = b.emp_no
ORDER BY salary DESC
LIMIT 5;

SELECT b.emp_no, b.salary, a.title FROM titles a 
INNER JOIN salaries b ON a.EMP_NO = b.emp_no
ORDER BY salary



SELECT * FROM  player a , team b WHERE a.TEAM_ID = b.TEAM_ID;
SELECT * FROM player a INNER JOIN team b ON a.team_id = b.team_id;

SELECT CASE WHEN SALARY >= 100000 THEN 1
WHEN SALARY >= 80000 THEN 2
WHEN SALARY >= 65000 THEN 3
WHEN SALARY >= 45000 THEN 4
ELSE 5 END SALARYGRADE
, COUNT(*) CNT
FROM SALARIES
WHERE TO_DATE='9999-01-01'
GROUP BY CASE WHEN SALARY >= 100000 THEN 1
WHEN SALARY >= 80000 THEN 2
WHEN SALARY >= 65000 THEN 3
WHEN SALARY >= 45000 THEN 4
ELSE 5 END ,
ORDER BY salary desc;
```