CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50),
    salary NUMBER
);
INSERT INTO employees VALUES (101, 'Alice', 5000);
INSERT INTO employees VALUES (102, 'Bob', 6000);
INSERT INTO employees VALUES (103, 'Charlie', 7000);
COMMIT;
-- Package specification
CREATE OR REPLACE PACKAGE hr_pkg AUTHID CURRENT_USER AS
    -- Function to calculate net salary after RSSB tax
    FUNCTION calc_rssb_tax(p_emp_id NUMBER) RETURN NUMBER;

    -- Dynamic procedure to update employee salary
    PROCEDURE update_salary(p_emp_id NUMBER, p_new_salary NUMBER);

END hr_pkg;
/
CREATE OR REPLACE PACKAGE BODY hr_pkg AS

    -- Function to calculate net salary after RSSB tax (assume 5% tax)
    FUNCTION calc_rssb_tax(p_emp_id NUMBER) RETURN NUMBER IS
        v_salary NUMBER;
        v_net_salary NUMBER;
        v_current_user VARCHAR2(30);
    BEGIN
        -- Get employee salary
        SELECT salary INTO v_salary FROM employees WHERE emp_id = p_emp_id;

        -- Deduct 5% RSSB tax
        v_net_salary := v_salary * 0.95;

        -- Get CURRENT_USER using SYS_CONTEXT
        v_current_user := SYS_CONTEXT('USERENV', 'CURRENT_USER');

        -- Optional: output info about who executed the function
        DBMS_OUTPUT.PUT_LINE('Function executed by USER: ' || USER || 
                             ', CURRENT_USER: ' || v_current_user);

        RETURN v_net_salary;
    END calc_rssb_tax;

    -- Dynamic procedure to update employee salary
    PROCEDURE update_salary(p_emp_id NUMBER, p_new_salary NUMBER) IS
        v_sql VARCHAR2(200);
        v_current_user VARCHAR2(30);
    BEGIN
        v_sql := 'UPDATE employees SET salary = :1 WHERE emp_id = :2';
        EXECUTE IMMEDIATE v_sql USING p_new_salary, p_emp_id;

        -- Get CURRENT_USER using SYS_CONTEXT
        v_current_user := SYS_CONTEXT('USERENV', 'CURRENT_USER');

        DBMS_OUTPUT.PUT_LINE('Salary updated for employee ' || p_emp_id || 
                             ' by USER: ' || USER || ', CURRENT_USER: ' || v_current_user);
    END update_salary;

END hr_pkg;
/
-- 1. Calculate net salary
DECLARE
    v_net_salary NUMBER;
BEGIN
    v_net_salary := hr_pkg.calc_rssb_tax(101);
    DBMS_OUTPUT.PUT_LINE('Net salary for employee 101: ' || v_net_salary);
END;
/

-- 2. Update employee salary dynamically
BEGIN
    hr_pkg.update_salary(101, 5500);
END;
/

-- 3. Check updated salary
SELECT * FROM employees WHERE emp_id = 101;
DECLARE
    CURSOR emp_cur IS SELECT emp_id FROM employees;
BEGIN
    FOR emp_rec IN emp_cur LOOP
        DBMS_OUTPUT.PUT_LINE('Employee ' || emp_rec.emp_id || 
                             ' Net Salary: ' || hr_pkg.calc_rssb_tax(emp_rec.emp_id));
    END LOOP;
END;
/
