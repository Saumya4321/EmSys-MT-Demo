# ===========================================================
# Created by Microsemi SmartDesign Thu Nov 17 15:25:42 2016
# 
# Warning: Do not modify this file, it may lead to unexpected 
#          simulation failures in your design.
#
# ===========================================================

if {$tcl_platform(os) == "Linux"} {
  exec "$env(ACTEL_SW_DIR)/bin/bfmtovec"   -in SERDESIF_0_PCIE_0_user.bfm   -out SERDESIF_0_PCIE_0.vec
  exec "$env(ACTEL_SW_DIR)/bin/bfmtovec"   -in SERDESIF_0_PCIE_1_user.bfm   -out SERDESIF_0_PCIE_1.vec
} else {
  exec "$env(ACTEL_SW_DIR)/bin/bfmtovec.exe"   -in SERDESIF_0_PCIE_0_user.bfm   -out SERDESIF_0_PCIE_0.vec
  exec "$env(ACTEL_SW_DIR)/bin/bfmtovec.exe"   -in SERDESIF_0_PCIE_1_user.bfm   -out SERDESIF_0_PCIE_1.vec
}
