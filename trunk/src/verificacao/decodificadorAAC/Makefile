

cov_work : syntatic_element.svh program_config_element.svh tb.sv trans.svh pre_source.svh refmod_decodificadorAAC.svh sink.svh 
	rm -rf cov_work; irun -ovmhome /usr/local/cds/ovm-2.0 -input tb.tcl -access +r -coverage functional tb.sv

clean :
	rm -rf cov_work INCA_libs .tb_cpld

