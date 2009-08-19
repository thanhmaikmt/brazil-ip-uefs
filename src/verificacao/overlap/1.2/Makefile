

cov_work : .tb_cpld
	rm -rf cov_work; irun -ovmhome /usr/local/cds/ovm-2.0 -input tb.tcl -access +r -coverage functional tb.sv


.tb_cpld : tb.sv trans.svh source.svh refmod_overlap.svh checker.svh 
	irun -ovmhome /usr/local/cds/ovm-2.0 -compile tb.sv && touch .tb_cpld

clean :
	rm -rf cov_work INCA_libs .tb_cpld

