read_sdc -scenario "place_and_route" -netlist "user" -pin_separator "/" -ignore_errors {D:/CASES/coretse/CoreTSE_Webserver/designer/CoreTSE_Webserver/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\CoreTSE_Webserver_place_and_route_constraint_coverage.xml}]
set reportfile {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp
