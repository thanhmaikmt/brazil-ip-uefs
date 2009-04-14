

cov_work : tb.sv trans.svh pre_source.svh refmod_reescalador.svh sink.svh gain.c 
	rm -rf cov_work; irun -ovmhome /usr/local/cds/ovm-2.0 -input tb.tcl -access +r -coverage functional tb.sv gain.c 

clean :
	rm -rf cov_work INCA_libs .tb_cpld

