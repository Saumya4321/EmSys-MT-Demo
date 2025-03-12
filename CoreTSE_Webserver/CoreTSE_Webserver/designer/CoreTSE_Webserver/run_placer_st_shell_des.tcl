set_device \
    -family  SmartFusion2 \
    -die     PA4M7500_TS \
    -package fg484 \
    -speed   -1 \
    -tempr   {COM} \
    -voltr   {COM}
set_def {VOLTAGE} {1.2}
set_def {VCCI_1.2_VOLTR} {COM}
set_def {VCCI_1.5_VOLTR} {COM}
set_def {VCCI_1.8_VOLTR} {COM}
set_def {VCCI_2.5_VOLTR} {COM}
set_def {VCCI_3.3_VOLTR} {COM}
set_def {RTG4_MITIGATION_ON} {0}
set_def USE_CONSTRAINTS_FLOW 1
set_def NETLIST_TYPE EDIF
set_name CoreTSE_Webserver
set_workdir {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver}
set_log     {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\CoreTSE_Webserver_sdc.log}
set_design_state pre_layout
