set_family {SmartFusion2}
read_adl {D:\Microsemi_prj\CoreTSE_Webserver\designer\CoreTSE_Webserver\CoreTSE_Webserver.adl}
map_netlist
read_sdc {D:\Microsemi_prj\CoreTSE_Webserver\constraint\CoreTSE_Webserver_derived_constraints.sdc}
read_sdc {D:\Microsemi_prj\CoreTSE_Webserver\constraint\user.sdc}
check_constraints {D:\Microsemi_prj\CoreTSE_Webserver\constraint\timing_sdc_check.log}
