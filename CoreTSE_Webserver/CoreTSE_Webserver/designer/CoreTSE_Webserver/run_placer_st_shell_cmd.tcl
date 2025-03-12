read_sdc -scenario "place_and_route" -netlist "user" -pin_separator "/" -ignore_errors {D:/CASES/coretse/CoreTSE_Webserver/designer/CoreTSE_Webserver/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
report -type combinational_loops -format xml {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\CoreTSE_Webserver_layout_combinational_loops.xml}
report -type slack {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\pinslacks.txt}
