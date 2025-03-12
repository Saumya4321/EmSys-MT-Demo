open_project -project {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\CoreTSE_Webserver_fp\CoreTSE_Webserver.pro}\
         -connect_programmers {FALSE}
load_programming_data \
    -name {M2S090TS} \
    -fpga {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\CoreTSE_Webserver.map} \
    -header {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\CoreTSE_Webserver.hdr} \
    -envm {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\CoreTSE_Webserver.efc}  \
    -spm {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\CoreTSE_Webserver.spm} \
    -dca {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\CoreTSE_Webserver.dca}
export_single_stapl \
    -name {M2S090TS} \
    -file {D:\CASES\coretse\CoreTSE_Webserver\designer\CoreTSE_Webserver\export\CoreTSE_Webserver.stp} \
    -secured
set_programming_file -name {M2S090TS} -no_file
save_project
close_project
