set_family {SmartFusion2}
read_adl {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\CoreTSE_Webserver.adl}
map_netlist
read_sdc {D:\CASES\coretse\CoreTSE_Webserver\constraint\CoreTSE_Webserver_derived_constraints.sdc}
read_sdc {D:\CASES\coretse\CoreTSE_Webserver\constraint\user.sdc}
check_constraints {D:\CASES\coretse\CoreTSE_Webserver\constraint\timing_sdc_errors.log}
write_sdc -strict {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\timing_analysis.sdc}
