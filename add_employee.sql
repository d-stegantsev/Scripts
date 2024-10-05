BEGIN
    util.add_employee(p_first_name     => 'Dima',
                      p_last_name      => 'Stegantsev',
                      p_email          => 'stg296',
                      p_phone_number   => '7987461',
                      p_hire_date      => SYSDATE,
                      p_job_id         => 'IT_PROG',
                      p_salary         => 7000,
                      p_commission_pct => 0.8,
                      p_manager_id     => 103,
                      p_department_id  => 50);
END;
/
