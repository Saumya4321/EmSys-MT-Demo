
report \
    -type     timing \
    -analysis max \
    -format   text \
    CoreTSE_Webserver_timing_r6_s20.rpt
report \
    -type     timing_violations \
    -analysis max \
    -format   text \
    -use_slack_threshold no \
    -max_paths 100 \
    CoreTSE_Webserver_timing_violations_max_r6_s20.rpt
report \
    -type     timing_violations \
    -analysis min \
    -format   text \
    -use_slack_threshold no \
    -max_paths 100 \
    CoreTSE_Webserver_timing_violations_min_r6_s20.rpt
set has_violations {CoreTSE_Webserver_has_violations}
set fp [open $has_violations w]
puts $fp [has_violations -short]
close $fp
