

cov_work : tb.sv trans.svh pre_source.svh refmod_decodificadorAAC.svh sink.svh 
	rm -rf cov_work; irun -ovmhome /usr/local/cds/ovm-2.0 -input tb.tcl -access +r -coverage functional tb.sv gain.c dequantizador.c libs_C.c

clean :
	rm -rf cov_work INCA_libs .tb_cpld

