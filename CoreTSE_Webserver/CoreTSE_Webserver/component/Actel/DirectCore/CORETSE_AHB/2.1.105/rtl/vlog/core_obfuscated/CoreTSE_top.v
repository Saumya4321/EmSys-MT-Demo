module
CoreTSE_top
(
RSTBP_I
,
TXCLK_I
,
RXCLK_I
,
GTXCLK_I
,
PMARX_CLK0_I
,
PMARX_CLK1_I
,
TSMAC_RCG_I
,
TSMAC_TCG_O
,
SIGNAL_DETECT_I
,
TSMAC_TXD_O
,
TSMAC_TXEN_O
,
TSMAC_TXER_O
,
TSMAC_RXD_I
,
TSMAC_RXDV_I
,
TSMAC_RXER_I
,
TSMAC_CRS_I
,
TSMAC_COL_I
,
HRESET_NI
,
HCLK_I
,
AHBS_HWDATA_I
,
AHBS_HADDR_I
,
AHBS_HSEL_I
,
AHBS_HTRANS_I
,
AHBS_HWRITE_I
,
AHBS_HRDATA_O
,
AHBS_HRESP_O
,
AHBS_HREADY_O
,
AHBS_HREADY_I
,
AHBM_TXHGRANT_I
,
AHBM_TXHREADY_I
,
AHBM_TXHRESPM_I
,
AHBM_TXHRDATAM_I
,
AHBM_TXHBUSREQ_O
,
AHBM_TXHSEL_O
,
AHBM_TXHTRANSM_O
,
AHBM_TXHADDRM_O
,
AHBM_TXHWRITEM_O
,
AHBM_TXHWDATAM_O
,
AHBM_RXHGRANT_I
,
AHBM_RXHREADY_I
,
AHBM_RXHRESPM_I
,
AHBM_RXHRDATAM_I
,
AHBM_RXHBUSREQ_O
,
AHBM_RXHSEL_O
,
AHBM_RXHTRANSM_O
,
AHBM_RXHADDRM_O
,
AHBM_RXHWRITEM_O
,
AHBM_RXHWDATAM_O
,
MGMT_MDI_I
,
MGMT_MDC_O
,
MGMT_MDO_O
,
MGMT_MDOEN_O
,
AHBS_HBURST_I
,
AHBS_HMASTLOCK_I
,
AHBS_HPROT_I
,
AHBS_HSIZE_I
,
AHBM_TXHBURST_O
,
AHBM_RXHBURST_O
,
AHBM_TXMASTLOCK_O
,
AHBM_RXMASTLOCK_O
,
AHBM_TXHSIZE_O
,
AHBM_RXHSIZE_O
,
AHBM_TXHSPLIT_O
,
AHBM_RXHSPLIT_O
,
TBI_READY_I
,
TBI_TXVAL_O
,
TSM_CONTROL_O
,
TSM_INTR_O
,
ANX_STATE_O
,
SYNC_O
)
;
parameter
FAMILY
=
19
;
parameter
GMII_TBI
=
1
;
parameter
TABITS
=
12
;
parameter
RABITS
=
12
;
parameter
MCXMAC_SAL_ON
=
1
;
parameter
MCXMAC_WOL_ON
=
1
;
parameter
MCXMAC_STATS_ON
=
1
;
parameter
MDIO_PHYID
=
18
;
input
RSTBP_I
;
input
TXCLK_I
;
input
RXCLK_I
;
input
GTXCLK_I
;
input
PMARX_CLK0_I
;
input
PMARX_CLK1_I
;
input
[
9
:
0
]
TSMAC_RCG_I
;
output
[
9
:
0
]
TSMAC_TCG_O
;
input
SIGNAL_DETECT_I
;
output
[
7
:
0
]
TSMAC_TXD_O
;
output
TSMAC_TXEN_O
;
output
TSMAC_TXER_O
;
input
[
7
:
0
]
TSMAC_RXD_I
;
input
TSMAC_RXDV_I
;
input
TSMAC_RXER_I
;
input
TSMAC_CRS_I
;
input
TSMAC_COL_I
;
input
HRESET_NI
;
input
HCLK_I
;
input
[
31
:
0
]
AHBS_HWDATA_I
;
input
[
31
:
0
]
AHBS_HADDR_I
;
input
AHBS_HSEL_I
;
input
[
1
:
0
]
AHBS_HTRANS_I
;
input
AHBS_HWRITE_I
;
output
[
31
:
0
]
AHBS_HRDATA_O
;
output
[
1
:
0
]
AHBS_HRESP_O
;
output
AHBS_HREADY_O
;
input
AHBS_HREADY_I
;
input
AHBM_TXHGRANT_I
;
input
AHBM_TXHREADY_I
;
input
[
1
:
0
]
AHBM_TXHRESPM_I
;
input
[
31
:
0
]
AHBM_TXHRDATAM_I
;
output
AHBM_TXHBUSREQ_O
;
output
AHBM_TXHSEL_O
;
output
[
1
:
0
]
AHBM_TXHTRANSM_O
;
output
[
31
:
0
]
AHBM_TXHADDRM_O
;
output
AHBM_TXHWRITEM_O
;
output
[
31
:
0
]
AHBM_TXHWDATAM_O
;
input
AHBM_RXHGRANT_I
;
input
AHBM_RXHREADY_I
;
input
[
1
:
0
]
AHBM_RXHRESPM_I
;
input
[
31
:
0
]
AHBM_RXHRDATAM_I
;
output
AHBM_RXHBUSREQ_O
;
output
AHBM_RXHSEL_O
;
output
[
1
:
0
]
AHBM_RXHTRANSM_O
;
output
[
31
:
0
]
AHBM_RXHADDRM_O
;
output
AHBM_RXHWRITEM_O
;
output
[
31
:
0
]
AHBM_RXHWDATAM_O
;
input
MGMT_MDI_I
;
output
MGMT_MDC_O
;
output
MGMT_MDO_O
;
output
MGMT_MDOEN_O
;
output
[
31
:
0
]
TSM_CONTROL_O
;
output
[
2
:
0
]
TSM_INTR_O
;
input
TBI_READY_I
;
output
TBI_TXVAL_O
;
input
AHBS_HBURST_I
;
input
AHBS_HMASTLOCK_I
;
input
AHBS_HPROT_I
;
input
AHBS_HSIZE_I
;
output
[
2
:
0
]
AHBM_TXHBURST_O
;
output
[
2
:
0
]
AHBM_RXHBURST_O
;
output
AHBM_TXMASTLOCK_O
;
output
AHBM_RXMASTLOCK_O
;
output
[
2
:
0
]
AHBM_TXHSIZE_O
;
output
[
2
:
0
]
AHBM_RXHSIZE_O
;
output
AHBM_TXHSPLIT_O
;
output
AHBM_RXHSPLIT_O
;
output
[
9
:
0
]
ANX_STATE_O
;
output
SYNC_O
;
wire
CORETSE_AHBl
;
wire
CORETSE_AHBo
;
wire
CORETSE_AHBi
;
wire
CORETSE_AHBOI
;
wire
[
7
:
0
]
CORETSE_AHBII
;
wire
[
7
:
0
]
CORETSE_AHBlI
;
wire
CORETSE_AHBoI
;
wire
CORETSE_AHBiI
;
wire
CORETSE_AHBOl
;
wire
CORETSE_AHBIl
;
wire
CORETSE_AHBll
;
wire
CORETSE_AHBol
;
wire
CORETSE_AHBil
;
wire
[
1
:
0
]
CORETSE_AHBO0
;
wire
CORETSE_AHBI0
;
wire
CORETSE_AHBl0
;
wire
CORETSE_AHBo0
;
wire
CORETSE_AHBi0
;
wire
CORETSE_AHBO1
;
wire
CORETSE_AHBI1
;
wire
[
TABITS
-
1
:
0
]
CORETSE_AHBl1
;
wire
[
39
:
0
]
CORETSE_AHBo1
;
wire
[
TABITS
-
1
:
0
]
CORETSE_AHBi1
;
wire
[
39
:
0
]
CORETSE_AHBOo
;
wire
CORETSE_AHBIo
;
wire
CORETSE_AHBlo
;
wire
CORETSE_AHBoo
;
wire
[
RABITS
-
1
:
0
]
CORETSE_AHBio
;
wire
[
35
:
0
]
CORETSE_AHBOi
;
wire
[
RABITS
-
1
:
0
]
CORETSE_AHBIi
;
wire
[
35
:
0
]
CORETSE_AHBli
;
wire
[
7
:
0
]
CORETSE_AHBoi
;
wire
[
31
:
0
]
CORETSE_AHBii
,
CORETSE_AHBOOI
;
assign
TSM_CONTROL_O
=
CORETSE_AHBii
;
assign
MGMT_MDC_O
=
CORETSE_AHBo
;
assign
MGMT_MDO_O
=
CORETSE_AHBi
;
assign
MGMT_MDOEN_O
=
CORETSE_AHBOI
;
assign
TSM_INTR_O
[
2
:
0
]
=
{
CORETSE_AHBoi
[
3
]
,
CORETSE_AHBoi
[
1
]
,
CORETSE_AHBoi
[
0
]
}
;
assign
AHBM_RXHADDRM_O
[
1
:
0
]
=
2
'b
00
;
assign
AHBM_TXHADDRM_O
[
1
:
0
]
=
2
'b
00
;
reg
[
8
:
0
]
CORETSE_AHBIOI
;
always
@
(
posedge
GTXCLK_I
)
CORETSE_AHBIOI
<=
{
CORETSE_AHBIOI
[
7
:
0
]
,
TBI_READY_I
}
;
assign
TBI_TXVAL_O
=
CORETSE_AHBIOI
[
8
]
;
assign
AHBM_TXHBURST_O
=
3
'b
001
;
assign
AHBM_RXHBURST_O
=
3
'b
001
;
assign
AHBM_TXMASTLOCK_O
=
1
'b
0
;
assign
AHBM_RXMASTLOCK_O
=
1
'b
0
;
assign
AHBM_TXHSIZE_O
=
2
'b
10
;
assign
AHBM_RXHSIZE_O
=
2
'b
10
;
assign
AHBM_TXHSPLIT_O
=
1
'b
0
;
assign
AHBM_RXHSPLIT_O
=
1
'b
0
;
assign
AHBM_TXHBUSREQ_O
=
1
'b
1
;
assign
AHBM_RXHBUSREQ_O
=
1
'b
1
;
assign
CORETSE_AHBil
=
(
(
GMII_TBI
==
0
)
&&
(
CORETSE_AHBO0
==
'b
10
)
)
?
GTXCLK_I
:
TXCLK_I
;
tsmac_top
#
(
.TABITS
(
TABITS
)
,
.RABITS
(
RABITS
)
,
.MCXMAC_SAL_ON
(
MCXMAC_SAL_ON
)
,
.MCXMAC_WOL_ON
(
MCXMAC_WOL_ON
)
,
.MCXMAC_STATS_ON
(
MCXMAC_STATS_ON
)
,
.CORETSE_AHBlOI
(
0
)
,
.CORETSE_AHBoOI
(
0
)
,
.CORETSE_AHBiOI
(
0
)
,
.CORETSE_AHBOII
(
0
)
,
.CORETSE_AHBIII
(
1
)
,
.CORETSE_AHBlII
(
2
)
,
.CORETSE_AHBoII
(
1
)
,
.CORETSE_AHBiII
(
2
)
,
.CORETSE_AHBOlI
(
18
)
,
.CORETSE_AHBIlI
(
18
)
,
.CORETSE_AHBllI
(
5
)
,
.CORETSE_AHBolI
(
5
)
)
CORETSE_AHBilI
(
.CORETSE_AHBO0I
(
CORETSE_AHBil
)
,
.CORETSE_AHBI0I
(
RXCLK_I
)
,
.CORETSE_AHBl0I
(
RSTBP_I
)
,
.CORETSE_AHBo0I
(
CORETSE_AHBol
)
,
.CORETSE_AHBi0I
(
CORETSE_AHBll
)
,
.CORETSE_AHBO1I
(
CORETSE_AHBiI
)
,
.CORETSE_AHBI1I
(
CORETSE_AHBlI
)
,
.CORETSE_AHBl1I
(
CORETSE_AHBIl
)
,
.CORETSE_AHBo1I
(
CORETSE_AHBoI
)
,
.CORETSE_AHBi1I
(
CORETSE_AHBII
)
,
.CORETSE_AHBOoI
(
CORETSE_AHBOl
)
,
.CORETSE_AHBIoI
(
HRESET_NI
)
,
.CORETSE_AHBloI
(
HCLK_I
)
,
.CORETSE_AHBooI
(
AHBS_HREADY_I
)
,
.CORETSE_AHBioI
(
AHBS_HWDATA_I
)
,
.CORETSE_AHBOiI
(
AHBS_HADDR_I
[
9
:
2
]
)
,
.CORETSE_AHBIiI
(
AHBS_HSEL_I
)
,
.CORETSE_AHBliI
(
AHBS_HTRANS_I
)
,
.CORETSE_AHBoiI
(
AHBS_HWRITE_I
)
,
.CORETSE_AHBiiI
(
AHBS_HRDATA_O
)
,
.CORETSE_AHBOOl
(
AHBS_HRESP_O
)
,
.CORETSE_AHBIOl
(
AHBS_HREADY_O
)
,
.CORETSE_AHBlOl
(
AHBM_TXHGRANT_I
)
,
.CORETSE_AHBoOl
(
AHBM_TXHREADY_I
)
,
.CORETSE_AHBiOl
(
AHBM_TXHRESPM_I
)
,
.CORETSE_AHBOIl
(
AHBM_TXHRDATAM_I
)
,
.CORETSE_AHBIIl
(
AHBM_TXHSEL_O
)
,
.CORETSE_AHBlIl
(
AHBM_TXHTRANSM_O
)
,
.CORETSE_AHBoIl
(
AHBM_TXHADDRM_O
[
31
:
2
]
)
,
.CORETSE_AHBiIl
(
AHBM_TXHWRITEM_O
)
,
.CORETSE_AHBOll
(
AHBM_TXHWDATAM_O
)
,
.CORETSE_AHBIll
(
AHBM_RXHGRANT_I
)
,
.CORETSE_AHBlll
(
AHBM_RXHREADY_I
)
,
.CORETSE_AHBoll
(
AHBM_RXHRESPM_I
)
,
.CORETSE_AHBill
(
AHBM_RXHRDATAM_I
)
,
.CORETSE_AHBO0l
(
AHBM_RXHSEL_O
)
,
.CORETSE_AHBI0l
(
AHBM_RXHTRANSM_O
)
,
.CORETSE_AHBl0l
(
AHBM_RXHADDRM_O
[
31
:
2
]
)
,
.CORETSE_AHBo0l
(
AHBM_RXHWRITEM_O
)
,
.CORETSE_AHBi0l
(
AHBM_RXHWDATAM_O
)
,
.CORETSE_AHBO1l
(
CORETSE_AHBl
)
,
.CORETSE_AHBI1l
(
CORETSE_AHBo
)
,
.CORETSE_AHBl1l
(
CORETSE_AHBi
)
,
.CORETSE_AHBo1l
(
CORETSE_AHBOI
)
,
.CORETSE_AHBi1l
(
CORETSE_AHBi0
)
,
.CORETSE_AHBOol
(
CORETSE_AHBO1
)
,
.CORETSE_AHBIol
(
CORETSE_AHBI1
)
,
.CORETSE_AHBlol
(
CORETSE_AHBl1
)
,
.CORETSE_AHBool
(
CORETSE_AHBo1
)
,
.CORETSE_AHBiol
(
CORETSE_AHBi1
)
,
.CORETSE_AHBOil
(
CORETSE_AHBOo
)
,
.CORETSE_AHBIil
(
CORETSE_AHBIo
)
,
.CORETSE_AHBlil
(
CORETSE_AHBlo
)
,
.CORETSE_AHBoil
(
CORETSE_AHBoo
)
,
.CORETSE_AHBiil
(
CORETSE_AHBio
)
,
.CORETSE_AHBOO0
(
CORETSE_AHBOi
)
,
.CORETSE_AHBIO0
(
CORETSE_AHBIi
)
,
.CORETSE_AHBlO0
(
CORETSE_AHBli
)
,
.CORETSE_AHBO0
(
CORETSE_AHBO0
)
,
.CORETSE_AHBI0
(
CORETSE_AHBI0
)
,
.CORETSE_AHBoO0
(
CORETSE_AHBoO0
)
,
.CORETSE_AHBl0
(
CORETSE_AHBl0
)
,
.CORETSE_AHBiO0
(
)
,
.CORETSE_AHBOI0
(
)
,
.CORETSE_AHBII0
(
)
,
.CORETSE_AHBlI0
(
)
,
.CORETSE_AHBoI0
(
)
,
.CORETSE_AHBiI0
(
)
,
.CORETSE_AHBOl0
(
)
,
.CORETSE_AHBIl0
(
)
,
.CORETSE_AHBll0
(
)
,
.CORETSE_AHBol0
(
)
,
.CORETSE_AHBil0
(
)
,
.CORETSE_AHBO00
(
)
,
.CORETSE_AHBI00
(
)
,
.CORETSE_AHBl00
(
32
'b
0
)
,
.CORETSE_AHBo00
(
CORETSE_AHBii
)
,
.CORETSE_AHBi00
(
CORETSE_AHBoi
)
)
;
tx2048x40
#
(
.TABITS
(
TABITS
)
)
CORETSE_AHBO10
(
.CORETSE_AHBI10
(
CORETSE_AHBi0
)
,
.CORETSE_AHBl10
(
CORETSE_AHBO1
)
,
.CORETSE_AHBo10
(
CORETSE_AHBI1
)
,
.CORETSE_AHBi10
(
CORETSE_AHBl1
)
,
.CORETSE_AHBOo0
(
CORETSE_AHBo1
)
,
.CORETSE_AHBIo0
(
CORETSE_AHBi1
)
,
.CORETSE_AHBlo0
(
CORETSE_AHBOo
)
)
;
rx4096x36
#
(
.RABITS
(
RABITS
)
)
CORETSE_AHBoo0
(
.CORETSE_AHBI10
(
CORETSE_AHBIo
)
,
.CORETSE_AHBl10
(
CORETSE_AHBlo
)
,
.CORETSE_AHBo10
(
CORETSE_AHBoo
)
,
.CORETSE_AHBi10
(
CORETSE_AHBio
)
,
.CORETSE_AHBOo0
(
CORETSE_AHBOi
)
,
.CORETSE_AHBIo0
(
CORETSE_AHBIi
)
,
.CORETSE_AHBlo0
(
CORETSE_AHBli
)
)
;
generate
if
(
GMII_TBI
==
1
)
begin
:
CORETSE_AHBio0
msgmii_core
#
(
.CORETSE_AHBlOI
(
0
)
,
.MDIO_PHYID
(
MDIO_PHYID
)
)
CORETSE_AHBOi0
(
.CORETSE_AHBIi0
(
~
HRESET_NI
)
,
.CORETSE_AHBli0
(
GTXCLK_I
)
,
.CORETSE_AHBoi0
(
TXCLK_I
)
,
.CORETSE_AHBii0
(
RXCLK_I
)
,
.CORETSE_AHBOO1
(
PMARX_CLK0_I
)
,
.CORETSE_AHBIO1
(
PMARX_CLK1_I
)
,
.CORETSE_AHBlO1
(
1
'b
0
)
,
.CORETSE_AHBoO1
(
)
,
.CORETSE_AHBiO1
(
1
'b
0
)
,
.CORETSE_AHBOI1
(
1
'b
0
)
,
.CORETSE_AHBII1
(
1
'b
0
)
,
.CORETSE_AHBlI1
(
)
,
.CORETSE_AHBoI1
(
)
,
.CORETSE_AHBiI1
(
)
,
.CORETSE_AHBOl1
(
)
,
.CORETSE_AHBIl1
(
)
,
.CORETSE_AHBll1
(
RSTBP_I
)
,
.CORETSE_AHBol1
(
TSMAC_TCG_O
)
,
.CORETSE_AHBII
(
CORETSE_AHBII
)
,
.CORETSE_AHBoI
(
CORETSE_AHBoI
)
,
.CORETSE_AHBOl
(
CORETSE_AHBOl
)
,
.CORETSE_AHBil1
(
TSMAC_RCG_I
)
,
.CORETSE_AHBlI
(
CORETSE_AHBlI
)
,
.CORETSE_AHBiI
(
CORETSE_AHBiI
)
,
.CORETSE_AHBIl
(
CORETSE_AHBIl
)
,
.CORETSE_AHBO01
(
CORETSE_AHBll
)
,
.CORETSE_AHBol
(
CORETSE_AHBol
)
,
.CORETSE_AHBI01
(
)
,
.CORETSE_AHBl01
(
SIGNAL_DETECT_I
)
,
.CORETSE_AHBo01
(
CORETSE_AHBl
)
,
.CORETSE_AHBi01
(
CORETSE_AHBo
)
,
.CORETSE_AHBO11
(
CORETSE_AHBi
)
,
.CORETSE_AHBI11
(
CORETSE_AHBOI
)
,
.CORETSE_AHBl11
(
MGMT_MDI_I
)
,
.CORETSE_AHBo11
(
CORETSE_AHBO0
)
,
.CORETSE_AHBi11
(
ANX_STATE_O
)
,
.CORETSE_AHBOo1
(
SYNC_O
)
)
;
end
else
begin
assign
TSMAC_TXD_O
=
CORETSE_AHBII
;
assign
TSMAC_TXEN_O
=
CORETSE_AHBoI
;
assign
TSMAC_TXER_O
=
CORETSE_AHBOl
;
assign
CORETSE_AHBlI
=
TSMAC_RXD_I
;
assign
CORETSE_AHBiI
=
TSMAC_RXDV_I
;
assign
CORETSE_AHBIl
=
TSMAC_RXER_I
;
assign
CORETSE_AHBol
=
TSMAC_CRS_I
;
assign
CORETSE_AHBll
=
TSMAC_COL_I
;
assign
CORETSE_AHBl
=
MGMT_MDI_I
;
end
endgenerate
endmodule
