CREATE TABLE dim_gender(
	gender_key SERIAL PRIMARY KEY,
	gender VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE dim_education(
	education_key SERIAL PRIMARY KEY,
	parental_education VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE dim_student(
	student_key SERIAL PRIMARY KEY,
	student_id INTEGER NOT NULL UNIQUE,
	
	gender_key INTEGER NOT NULL,
	education_key INTEGER NOT NULL,
	
	internet_access BOOLEAN NOT NULL,
	extracurricular_activities BOOLEAN NOT NULL,
	part_time_job BOOLEAN NOT NULL,
	
	CONSTRAINT fk_student_gender
		FOREIGN KEY (gender_key)
		REFERENCES dim_gender(gender_key),
	
	CONSTRAINT fk_student_education
		FOREIGN KEY (education_key)
		REFERENCES dim_education(education_key)
);

CREATE TABLE fact_student_performance (
	performance_key SERIAL PRIMARY KEY,

	student_key INTEGER NOT NULL,
	
	study_time_hours NUMERIC(4,2) NOT NULL,
	attendance_percent NUMERIC(5,2) NOT NULL,
	sleep_hours NUMERIC(4,2) NOT NULL,
	previous_grade NUMERIC(5,2) NOT NULL,
	final_exam_score NUMERIC(5,2) NOT NULL,

	CONSTRAINT fk_performance_student
        FOREIGN KEY (student_key)
        REFERENCES dim_student(student_key)
);

ALTER TABLE fact_student_performance
ADD CONSTRAINT uq_fact_student UNIQUE (student_key);