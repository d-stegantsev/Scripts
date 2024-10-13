create or replace TRIGGER delete_as_log
    BEFORE INSERT ON logs
    FOR EACH ROW
DECLARE
    PRAGMA autonomous_transaction;
BEGIN
    DELETE FROM logs l
    WHERE l.log_date < trunc(SYSDATE, 'dd') -45;
    COMMIT;
END delete_as_log;

create or replace TRIGGER hire_date_update
    BEFORE UPDATE ON employees
    FOR EACH ROW
DECLARE
    PRAGMA autonomous_transaction;
BEGIN

    IF :OLD.job_id != :NEW.job_id THEN
    
        :NEW.hire_date := TRUNC(SYSDATE,'DD');

    END IF;

    COMMIT;

END hire_date_update;

create or replace TRIGGER job_history_log
    AFTER UPDATE ON employees
    FOR EACH ROW
DECLARE
    PRAGMA autonomous_transaction;
BEGIN

    IF :OLD.job_id != :NEW.job_id THEN

        UPDATE job_history jb
        SET jb.end_date = TRUNC(SYSDATE, 'DD')
        WHERE jb.employee_id = :OLD.employee_id
        AND jb.job_id = :OLD.job_id;

            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO job_history(employee_id, start_date, end_date, job_id)
                VALUES (:OLD.employee_id, :OLD.hire_date, TRUNC(SYSDATE, 'DD'), :OLD.job_id);
            END IF;

        INSERT INTO job_history(employee_id, start_date, end_date, job_id)
        VALUES (:NEW.employee_id, TRUNC(SYSDATE, 'DD'), to_date('31.12.2999', 'DD.MM.YYYY'), :NEW.job_id);

    END IF;

    COMMIT;

END job_history_log;
