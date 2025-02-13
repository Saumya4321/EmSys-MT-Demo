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
set_def USE_CONSTRAINTS_FLOW 1
set_name CoreTSE_Webserver
set_workdir {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver}
set_design_state post_layout
