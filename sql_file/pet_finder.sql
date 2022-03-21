-- ----------------------------------------------------------------------------------------------------------------             
-- DB생성
-- ----------------------------------------------------------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS pet_finder;
USE pet_finder;

-- ----------------------------------------------------------------------------------------------------------------               
-- USER테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
	`user_id`	varchar(10)	NOT NULL	COMMENT '자동부여',
	`email`	varchar(50)	NOT NULL	COMMENT '이메일 30자 제한',
	`password`	varchar(20)	NOT NULL,
	`nickname`	varchar(20)	NOT NULL	COMMENT '유니크(제약조건 없이 개발과정에서 구현)',
	`name`	varchar(20)	NOT NULL	COMMENT '실명인증시 필요하다는 의견',
	`phone_no`	varchar(20)	NOT NULL	COMMENT '전화인증시 필요하다는 의견',
	`zipcode`	varchar(5)	NOT NULL,
	`address`	varchar(50)	NOT NULL	COMMENT '도로명주소',
	`detail_address`	varchar(50)	NOT NULL	COMMENT '동호수나  번지 입력',
	`member_point`	varchar(10)	NOT NULL	DEFAULT 0,
	`last_access`	datetime	NULL	COMMENT '로그인시 자동갱신',
	`join_date`	datetime	NOT NULL	COMMENT '자동 등록'
);

ALTER TABLE `user` ADD CONSTRAINT `PK_USER` PRIMARY KEY (
	`user_id`,
	`email`
);

-- ----------------------------------------------------------------------------------------------------------------           
-- find_board 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `find_board`;

CREATE TABLE `find_board` (
	`find_board_num`	varchar(10)	NOT NULL	COMMENT '자동부여',
	`board_code`	char(2)	NOT NULL	COMMENT 'fi',
	`nickname`	varchar(10)	NOT NULL,
	`subject`	varchar(30)	NOT NULL,
	`content`	varchar(500)	NOT NULL,
	`readcount`	int	NOT NULL	DEFAULT 0,
	`pet_type`	char(1)	NOT NULL	COMMENT '0 개1 고양이2기타',
	`missing_date`	datetime	NOT NULL,
	`pet_name`	varchar(10)	NULL,
	`pet_age`	int	NULL	COMMENT 'nvl',
	`pet_gender`	char(1)	NOT NULL	COMMENT '0암1수2모름',
	`address`	varchar(30)	NOT NULL,
	`detail_address`	varchar(30)	NOT NULL,
	`status`	char(1)	NOT NULL	COMMENT '0해결1미해결',
	`insert_date`	datetime	NOT NULL	COMMENT '자동 등록',
	`delete_date`	datetime	NULL
);

ALTER TABLE `find_board` ADD CONSTRAINT `PK_FIND_BOARD` PRIMARY KEY (
	`find_board_num`,
	`board_code`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- find_board_file 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `find_board_file`;

CREATE TABLE `find_board_file` (
	`file_num`	int(20)	NOT NULL	COMMENT 'AUTO_INCREMENT',
	`board_num`	varchar(10)	NOT NULL,
	`board_code`	char(2)	NOT NULL,
	`upload`	varchar(30)	NOT NULL,
	`filename`	varchar(30)	NOT NULL,
	`save_filename`	varchar(30)	NOT NULL,
	`file_upload_date`	datetime	NOT NULL	DEFAULT now()	COMMENT 'DATETIME // TIMESTAMP',
	`int_ext`	int	NULL	COMMENT 'int 여분필드',
	`var_ext`	varchar(30)	NULL	COMMENT 'varchar 여분필드'
);

ALTER TABLE `find_board_file` ADD CONSTRAINT `PK_FIND_BOARD_FILE` PRIMARY KEY (
	`file_num`,
	`board_num`,
	`board_code`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- order 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
	`order_no`	varchar(10)	NOT NULL	COMMENT '자동부여  (주문일+번호)',
	`user_id`	varchar(10)	NOT NULL	COMMENT 'varchar or int',
	`order_date`	datetime	NOT NULL,
	`product_no`	varchar(10)	NOT NULL	COMMENT 'varchar or int ???',
	`order_qty`	varchar(10)	NOT NULL,
	`amount`	int	NOT NULL,
	`zipcode`	varchar(5)	NOT NULL,
	`address`	varchar(50)	NOT NULL,
	`detail_address`	varchar(50)	NOT NULL,
	`phone_no`	varchar(15)	NOT NULL,
	`status`	char(1)	NOT NULL	COMMENT 'Y/N/P(Pending)',
	`delivery_no`	varchar(20)	NULL
);

ALTER TABLE `order` ADD CONSTRAINT `PK_ORDER` PRIMARY KEY (
	`order_no`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- bookmark 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `bookmark`;

CREATE TABLE `bookmark` (
	`user_id`	varchar(10)	NOT NULL,
	`num`	int	NOT NULL,
	`board_category`	char(2)	NULL
);

ALTER TABLE `bookmark` ADD CONSTRAINT `PK_BOOKMARK` PRIMARY KEY (
	`user_id`,
	`num`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- board_report 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `board_report`;

CREATE TABLE `board_report` (
	`user_id`	varchar(10)	NOT NULL,
	`board_num`	varchar(10)	NOT NULL,
	`board_code`	char(2)	NOT NULL,
	`report_count`	int	NOT NULL
);

ALTER TABLE `board_report` ADD CONSTRAINT `PK_BOARD_REPORT` PRIMARY KEY (
	`user_id`,
	`board_num`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- comment_report 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `comment_report`;

CREATE TABLE `comment_report` (
	`user_id`	varchar(10)	NOT NULL,
	`board_num`	varchar(10)	NOT NULL,
	`comment_num`	varchar(10)	NOT NULL,
	`board_code`	char(2)	NOT NULL,
	`report_count`	int	NOT NULL
);

ALTER TABLE `comment_report` ADD CONSTRAINT `PK_COMMENT_REPORT` PRIMARY KEY (
	`user_id`,
	`board_num`,
	`comment_num`,
	`board_code`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- free_board 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `free_board`;

CREATE TABLE `free_board` (
	`free_board_num`	varchar(10)	NOT NULL	COMMENT '자동부여',
	`board_code`	char(2)	NOT NULL	COMMENT 'fr',
	`nickname`	varchar(20)	NOT NULL,
	`subject`	varchar(20)	NOT NULL,
	`content`	varchar(2000)	NOT NULL,
	`insert_date`	datetime	NOT NULL,
	`update_date`	datetime	NULL,
	`readcount`	int	NOT NULL	DEFAULT 0,
	`like_count`	int	NOT NULL	DEFAULT 0
);

ALTER TABLE `free_board` ADD CONSTRAINT `PK_FREE_BOARD` PRIMARY KEY (
	`free_board_num`,
	`board_code`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- notice 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `notice`;

CREATE TABLE `notice` (
	`notice_num`	varchar(10)	NOT NULL	COMMENT '자동부여',
	`board_code`	char(2)	NOT NULL	COMMENT 'no',
	`subject`	varchar(50)	NOT NULL,
	`content`	varchar(2000)	NOT NULL,
	`insert_date`	datetime	NOT NULL,
	`update_date`	datetime	NULL,
	`readcount`	int	NOT NULL	DEFAULT 0
);

ALTER TABLE `notice` ADD CONSTRAINT `PK_NOTICE` PRIMARY KEY (
	`notice_num`,
	`board_code`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- purchase 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `purchase`;

CREATE TABLE `purchase` (
	`product_num`	varchar(10)	NOT NULL,
	`product_name`	varchar(100)	NOT NULL,
	`insert_date`	datetime	NOT NULL	COMMENT '컬럼명',
	`product_content`	varchar(2000)	NOT NULL	COMMENT '데이터크기',
	`stock`	int	NOT NULL,
	`price`	int	NOT NULL
);

ALTER TABLE `purchase` ADD CONSTRAINT `PK_PURCHASE` PRIMARY KEY (
	`product_num`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- free_board_file 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `free_board_file`;

CREATE TABLE `free_board_file` (
	`file_num`	int(20)	NOT NULL	COMMENT 'AUTO_INCREMENT',
	`board_num`	varchar(10)	NOT NULL,
	`board_code`	char(2)	NOT NULL,
	`upload`	varchar(30)	NOT NULL,
	`filename`	varchar(30)	NOT NULL,
	`save_filename`	varchar(30)	NOT NULL,
	`file_upload_date`	datetime	NOT NULL	DEFAULT now(),
	`int_ext`	int	NULL	COMMENT 'int 여분필드',
	`var_ext`	varchar(30)	NULL	COMMENT 'varchar 여분필드'
);

ALTER TABLE `free_board_file` ADD CONSTRAINT `PK_FREE_BOARD_FILE` PRIMARY KEY (
	`file_num`,
	`board_num`,
	`board_code`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- board_category 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `board_category`;

CREATE TABLE `board_category` (
	`board_code`	char(2)	NOT NULL	COMMENT 'no,ti,fr,fi',
	`board_name`	varchar(10)	NOT NULL
);

ALTER TABLE `board_category` ADD CONSTRAINT `PK_BOARD_CATEGORY` PRIMARY KEY (
	`board_code`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- tip_board 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `tip_board`;

CREATE TABLE `tip_board` (
	`tip_board_num`	varchar(10)	NOT NULL	COMMENT '자동부여',
	`board_code`	char(2)	NOT NULL	COMMENT 'ti',
	`nickname`	varchar(20)	NOT NULL,
	`subject`	varchar(50)	NOT NULL,
	`content`	varchar(2000)	NOT NULL,
	`insert_date`	datetime	NOT NULL,
	`update_date`	datetime	NULL,
	`readcount`	int	NOT NULL	DEFAULT 0,
	`like_count`	int	NOT NULL	DEFAULT 0
);

ALTER TABLE `tip_board` ADD CONSTRAINT `PK_TIP_BOARD` PRIMARY KEY (
	`tip_board_num`,
	`board_code`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- reply_free_comment 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `reply_free_comment`;

CREATE TABLE `reply_free_comment` (
	`board_num`	varchar(10)	NOT NULL,
	`commnet_num`	varchar(10)	NOT NULL,
	`reply_comment_num`	varchar(10)	NOT NULL,
	`board_code`	char(2)	NOT NULL,
	`c2_nik`	varchar(200)	NOT NULL,
	`c2_content`	varchar(200)	NOT NULL,
	`c2_date`	datetime	NOT NULL,
	`c2_rdate`	datetime	NULL
);

ALTER TABLE `reply_free_comment` ADD CONSTRAINT `PK_REPLY_FREE_COMMENT` PRIMARY KEY (
	`board_num`,
	`commnet_num`,
	`reply_comment_num`,
	`board_code`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- free_comment 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `free_comment`;

CREATE TABLE `free_comment` (
	`board_num`	varchar(10)	NOT NULL,
	`commnet_num`	varchar(10)	NOT NULL,
	`c_nik`	varchar(200)	NOT NULL,
	`c_content`	varchar(200)	NOT NULL,
	`c_date`	datetime	NOT NULL,
	`c_rdate`	datetime	NULL
);

ALTER TABLE `free_comment` ADD CONSTRAINT `PK_FREE_COMMENT` PRIMARY KEY (
	`board_num`,
	`commnet_num`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- tip_comment 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `tip_comment`;

CREATE TABLE `tip_comment` (
	`board_num`	varchar(10)	NOT NULL,
	`commnet_num`	varchar(10)	NOT NULL,
	`c_nik`	varchar(200)	NOT NULL,
	`c_content`	varchar(200)	NOT NULL,
	`c_date`	datetime	NOT NULL,
	`c_rdate`	datetime	NULL
);

ALTER TABLE `tip_comment` ADD CONSTRAINT `PK_TIP_COMMENT` PRIMARY KEY (
	`board_num`,
	`commnet_num`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- find_comment 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `find_comment`;

CREATE TABLE `find_comment` (
	`board_num`	varchar(10)	NOT NULL,
	`commnet_num`	varchar(10)	NOT NULL,
	`c_nik`	varchar(200)	NOT NULL,
	`c_content`	varchar(200)	NOT NULL,
	`c_date`	datetime	NOT NULL,
	`c_rdate`	datetime	NULL
);

ALTER TABLE `find_comment` ADD CONSTRAINT `PK_FIND_COMMENT` PRIMARY KEY (
	`board_num`,
	`commnet_num`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- reply_tip_comment 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `reply_tip_comment`;

CREATE TABLE `reply_tip_comment` (
	`board_num`	varchar(10)	NOT NULL,
	`commnet_num`	varchar(10)	NOT NULL,
	`reply_comment_num`	varchar(10)	NOT NULL,
	`board_code`	char(2)	NOT NULL,
	`c2_nik`	varchar(200)	NOT NULL,
	`c2_content`	varchar(200)	NOT NULL,
	`c2_date`	datetime	NOT NULL,
	`c2_rdate`	datetime	NULL
);

ALTER TABLE `reply_tip_comment` ADD CONSTRAINT `PK_REPLY_TIP_COMMENT` PRIMARY KEY (
	`board_num`,
	`commnet_num`,
	`reply_comment_num`,
	`board_code`
);

-- ----------------------------------------------------------------------------------------------------------------               
-- tip_board_file 테이블 생성
-- ----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `tip_board_file`;

CREATE TABLE `tip_board_file` (
	`file_num`	int(20)	NOT NULL	COMMENT 'AUTO_INCREMENT',
	`board_num`	varchar(10)	NOT NULL,
	`board_code`	char(2)	NOT NULL,
	`upload`	varchar(30)	NOT NULL,
	`filename`	varchar(30)	NOT NULL,
	`save_filename`	varchar(30)	NOT NULL,
	`file_upload_date`	datetime	NOT NULL	DEFAULT now()	COMMENT 'DATETIME // TIMESTAMP',
	`int_ext`	int	NULL	COMMENT 'int 여분필드',
	`var_ext`	varchar(30)	NULL	COMMENT 'varchar 여분필드'
);

ALTER TABLE `tip_board_file` ADD CONSTRAINT `PK_TIP_BOARD_FILE` PRIMARY KEY (
	`file_num`,
	`board_num`,
	`board_code`
);