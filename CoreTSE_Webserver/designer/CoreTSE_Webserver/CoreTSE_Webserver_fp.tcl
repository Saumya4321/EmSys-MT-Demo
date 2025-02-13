new_project \
         -name {CoreTSE_Webserver} \
         -location {D:\Microsemi_prj\CoreTSE_Webserver\designer\CoreTSE_Webserver\CoreTSE_Webserver_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {M2S090TS} \
         -name {M2S090TS}
enable_device \
         -name {M2S090TS} \
         -enable {TRUE}
save_project
close_project
