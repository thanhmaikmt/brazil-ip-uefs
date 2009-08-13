set idmp 0
proc covering {} {
  upvar 1 idmp idmp 
  rm -rf ./cov_work/design/$idmp
  set idmp [expr {$idmp+1}]
  coverage -dump $idmp
  set fileId [open "cov.cmd" w]
  puts $fileId "load_test $idmp\nreport_summary -cgopt tb\nquit\n\n"
  close $fileId
  exec iccr cov.cmd | grep DC > DC_log.txt 
  set fileId [open "DC_log.txt" r]
  set log [read $fileId]
  close $fileId
  if {[regexp "DC:  100%" $log] == 1} {
    puts "================================= Coverage completed ================================="
    quit
  } else {
    puts "Coverage $log"
  }
}
stop -create -condition {#tb.cov == 1'b1} -execute covering -continue
run
quit
