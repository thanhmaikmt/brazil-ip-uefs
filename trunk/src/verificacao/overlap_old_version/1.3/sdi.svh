  // IUS needs wrappers 
  function int record_begin(int fiber, string s);
    $display("fiber %d, name %s", fiber, s);
    record_begin = $sdi_transaction("",fiber,"tr_type",s);
  endfunction

  function void record_error(int fiber, string s);
    int record;
    record = $sdi_transaction("error",fiber,s);
  endfunction

  function void record_end(integer record);
    $sdi_end_transaction(record);
  endfunction

