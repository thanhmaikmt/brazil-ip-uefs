

cov_work : .tb_cpld .duv_cpld top.sv gene_clock.sv AXI_cover.sv
	rm -rf cov_work; irun -ovmhome /usr/local/cds/ovm-2.0 -input top.tcl -access +r -coverage functional top.sv gene_clock.sv AXI_cover.sv


.tb_cpld : tb.sv trans.svh source.svh refmod_overlap.svh checker.svh in_overlap_driver.svh  out_overlap_actor.svh out_overlap_monitor.svh 
	irun -ovmhome /usr/local/cds/ovm-2.0 -compile tb.sv && touch .tb_cpld

.duv_cpld : overlap.sv trans.svh in_overlap_actor.svh in_overlap_monitor.svh  refmod_overlap.svh out_overlap_driver.svh 
	irun -ovmhome /usr/local/cds/ovm-2.0 -compile overlap.sv && touch .duv_cpld

clean :
	rm -rf cov_work INCA_libs .tb_cpld .duv_cpld

