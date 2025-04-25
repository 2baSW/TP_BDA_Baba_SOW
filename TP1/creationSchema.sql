DROP TABLE classroom CASCADE CONSTRAINTS;
DROP TABLE department CASCADE CONSTRAINTS;
DROP TABLE time_slot CASCADE CONSTRAINTS;
DROP TABLE section CASCADE CONSTRAINTS;
DROP TABLE course CASCADE CONSTRAINTS;
DROP TABLE teacher CASCADE CONSTRAINTS;
DROP TABLE teaches CASCADE CONSTRAINTS;
DROP TABLE student CASCADE CONSTRAINTS;
DROP TABLE takes CASCADE CONSTRAINTS;
DROP TABLE supervisor CASCADE CONSTRAINTS;
DROP TABLE prereq CASCADE CONSTRAINTS;

CREATE TABLE classroom (
    building VARCHAR(15),
    room_number VARCHAR(7),
    capacity_classroom NUMERIC(4, 0),
    PRIMARY KEY (building, room_number)
);

CREATE TABLE department (
    dept_name VARCHAR(20),
    building VARCHAR(15),
    budget NUMERIC(12, 2),
    PRIMARY KEY (dept_name)
);

CREATE TABLE time_slot (
    time_slot_id VARCHAR(4),
    time_slot_day VARCHAR(1),
    start_hr NUMERIC(2),
    start_min NUMERIC(2),
    end_hr NUMERIC(2),
    end_min NUMERIC(2),
    PRIMARY KEY (time_slot_id, time_slot_day, start_hr, start_min)
);

CREATE TABLE course (
    course_id VARCHAR(8),
    title VARCHAR(50),
    dept_name VARCHAR(20),
    credits NUMERIC(2, 0),
    PRIMARY KEY (course_id),
    FOREIGN KEY (dept_name) REFERENCES department ON DELETE CASCADE
);

CREATE TABLE section (
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(8) CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer')),
    year_semester NUMERIC(4, 0),
    building VARCHAR(15),
    room_number VARCHAR(7),
    time_slot_id VARCHAR(4),
    PRIMARY KEY (course_id, sec_id, semester, year_semester),
    FOREIGN KEY (course_id) REFERENCES course ON DELETE CASCADE,
    FOREIGN KEY (building, room_number) REFERENCES classroom ON DELETE CASCADE
);

CREATE TABLE teacher (
    teacher_id VARCHAR(5),
    teacher_name VARCHAR(20),
    dept_name VARCHAR(20),
    salary NUMERIC(8, 2),
    PRIMARY KEY (teacher_id),
    FOREIGN KEY (dept_name) REFERENCES department ON DELETE CASCADE
);

CREATE TABLE teaches (
    teacher_id VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    semester_year NUMERIC(4, 0),
    PRIMARY KEY (teacher_id, course_id, sec_id, semester, semester_year),
    FOREIGN KEY (course_id, sec_id, semester, semester_year) REFERENCES section ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES teacher ON DELETE CASCADE
);

CREATE TABLE student (
    student_id VARCHAR(5),
    student_name VARCHAR(20),
    dept_name VARCHAR(20),
    tot_cred NUMERIC(3, 0),
    PRIMARY KEY (student_id),
    FOREIGN KEY (dept_name) REFERENCES department
);

CREATE TABLE takes (
    student_id VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    semester_year NUMERIC(4, 0),
    grade VARCHAR(2),
    PRIMARY KEY (student_id, course_id, sec_id, semester, semester_year),
    FOREIGN KEY (course_id, sec_id, semester, semester_year) REFERENCES section ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student ON DELETE CASCADE
);

CREATE TABLE supervisor (
    s_ID VARCHAR(5),
    i_ID VARCHAR(5),
    PRIMARY KEY (s_ID),
    FOREIGN KEY (i_ID) REFERENCES teacher (teacher_id) ON DELETE CASCADE,
    FOREIGN KEY (s_ID) REFERENCES student (student_id) ON DELETE CASCADE
);

CREATE TABLE prereq (
    course_id VARCHAR(8),
    prereq_id VARCHAR(8),
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES course ON DELETE CASCADE,
    FOREIGN KEY (prereq_id) REFERENCES course ON DELETE CASCADE
);
