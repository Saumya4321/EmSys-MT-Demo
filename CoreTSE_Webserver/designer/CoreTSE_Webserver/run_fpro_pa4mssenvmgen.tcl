set_device \
    -fam SmartFusion2 \
    -die PA4M7500_TS \
    -pkg fg484
set_input_cfg \
	-path {D:/CASES/coretse/CoreTSE_Webserver/component/work/CoreTSE_Webserver_MSS/ENVM.cfg}
set_output_efc \
    -path {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\CoreTSE_Webserver.efc}
set_proj_dir \
    -path {D:\CASES\coretse\CoreTSE_Webserver}
gen_prg -use_init false
