DECLARE
  v_result VARCHAR2(100);
BEGIN
    util.copy_table(p_source_scheme  => 'HR',
                  --p_target_scheme  => VARCHAR2 DEFAULT USER,
                    p_list_table     => 'SALES,COUNTRIES',
                    p_copy_data      => TRUE,
                    po_result => v_result);
               
    dbms_output.put_line(v_result);            
END;
/
