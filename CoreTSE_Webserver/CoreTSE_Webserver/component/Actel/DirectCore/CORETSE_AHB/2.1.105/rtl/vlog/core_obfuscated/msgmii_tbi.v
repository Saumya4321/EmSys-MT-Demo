// REVISION    : $Revision: 1.4 $
// Mentor Graphics Corporation Proprietary and Confidential
// Copyright 2007 Mentor Graphics Corporation and Licensors
`timescale 1ps/1ps
module
msgmii_tbi
#
(
parameter
CORETSE_AHBlOI
=
1
'b
0
)
(
CORETSE_AHBloi0
,
CORETSE_AHBoI
,
CORETSE_AHBII
,
CORETSE_AHBOl
,
CORETSE_AHBII1
,
CORETSE_AHBOI1
,
CORETSE_AHBIO1
,
CORETSE_AHBOO1
,
CORETSE_AHBil1
,
CORETSE_AHBl01
,
CORETSE_AHBi01
,
CORETSE_AHBO11
,
CORETSE_AHBI11
,
CORETSE_AHBl11
,
CORETSE_AHBooi0
,
CORETSE_AHBioi0
,
CORETSE_AHBll1
,
CORETSE_AHBol1
,
CORETSE_AHBOl1
,
CORETSE_AHBiI1
,
CORETSE_AHBi010
,
CORETSE_AHBOii0
,
CORETSE_AHBIii0
,
CORETSE_AHBlii0
,
CORETSE_AHBo01
,
CORETSE_AHBoii0
,
CORETSE_AHBiii0
,
CORETSE_AHBOOO1
,
CORETSE_AHBI1i0
,
CORETSE_AHBl1i0
,
CORETSE_AHBIOO1
)
;
input
CORETSE_AHBloi0
;
input
CORETSE_AHBoI
;
input
[
7
:
0
]
CORETSE_AHBII
;
input
CORETSE_AHBOl
;
input
CORETSE_AHBII1
;
input
CORETSE_AHBOI1
;
input
CORETSE_AHBIO1
;
input
CORETSE_AHBOO1
;
input
[
9
:
0
]
CORETSE_AHBil1
;
input
CORETSE_AHBl01
;
input
CORETSE_AHBi01
;
input
CORETSE_AHBO11
;
input
CORETSE_AHBI11
;
input
CORETSE_AHBl11
;
input
[
4
:
0
]
CORETSE_AHBooi0
;
input
CORETSE_AHBioi0
;
input
CORETSE_AHBll1
;
output
[
9
:
0
]
CORETSE_AHBol1
;
output
CORETSE_AHBOl1
;
output
CORETSE_AHBiI1
;
output
CORETSE_AHBi010
;
output
[
15
:
0
]
CORETSE_AHBOii0
;
output
[
1
:
0
]
CORETSE_AHBIii0
;
output
[
1
:
0
]
CORETSE_AHBlii0
;
output
CORETSE_AHBo01
;
output
CORETSE_AHBoii0
;
output
CORETSE_AHBOOO1
;
output
CORETSE_AHBiii0
;
output
[
8
:
0
]
CORETSE_AHBI1i0
;
output
CORETSE_AHBl1i0
;
output
CORETSE_AHBIOO1
;
parameter
CORETSE_AHBIoII
=
1
;
wire
CORETSE_AHBOo1
;
wire
CORETSE_AHBOIO1
;
wire
CORETSE_AHBIIO1
;
wire
CORETSE_AHBlIO1
;
wire
[
15
:
0
]
CORETSE_AHBoIO1
;
wire
CORETSE_AHBl1O1
;
wire
CORETSE_AHBi1O1
;
wire
[
15
:
0
]
CORETSE_AHBOoO1
;
wire
[
15
:
0
]
CORETSE_AHBIoO1
;
wire
CORETSE_AHBloO1
;
wire
CORETSE_AHBooO1
;
wire
[
1
:
0
]
CORETSE_AHBioO1
;
wire
[
15
:
0
]
CORETSE_AHBOiO1
;
wire
CORETSE_AHBIo01
,
CORETSE_AHBlo01
;
wire
[
1
:
0
]
CORETSE_AHBoo01
;
wire
CORETSE_AHBiIO1
,
CORETSE_AHBOlO1
;
wire
CORETSE_AHBio01
;
wire
[
15
:
0
]
CORETSE_AHBIlO1
,
CORETSE_AHBolO1
;
wire
CORETSE_AHBOi01
,
CORETSE_AHBIi01
;
wire
CORETSE_AHBO0O1
,
CORETSE_AHBI0O1
;
wire
CORETSE_AHBl0O1
;
wire
[
2
:
0
]
CORETSE_AHBli01
;
wire
[
9
:
0
]
CORETSE_AHBoi01
;
wire
CORETSE_AHBo0O1
;
wire
CORETSE_AHBii01
,
CORETSE_AHBi0O1
;
wire
CORETSE_AHBOO11
,
CORETSE_AHBIO11
;
wire
CORETSE_AHBlO11
,
CORETSE_AHBoO11
;
wire
[
19
:
0
]
CORETSE_AHBiO11
;
wire
CORETSE_AHBOI11
;
wire
CORETSE_AHBII11
;
wire
CORETSE_AHBlI11
;
wire
CORETSE_AHBoI11
;
wire
CORETSE_AHBI1O1
;
wire
CORETSE_AHBo1O1
;
wire
CORETSE_AHBo101
;
assign
CORETSE_AHBiii0
=
CORETSE_AHBlo01
;
assign
CORETSE_AHBl1i0
=
CORETSE_AHBlIO1
;
assign
CORETSE_AHBIOO1
=
CORETSE_AHBOo1
;
petex_top
#
(
.CORETSE_AHBlOI
(
CORETSE_AHBlOI
)
)
CORETSE_AHBiI11
(
.CORETSE_AHBloi0
(
CORETSE_AHBloi0
)
,
.CORETSE_AHBoI
(
CORETSE_AHBoI
)
,
.CORETSE_AHBOl11
(
CORETSE_AHBII
)
,
.CORETSE_AHBOl
(
CORETSE_AHBOl
)
,
.CORETSE_AHBlO11
(
CORETSE_AHBlO11
)
,
.CORETSE_AHBioO1
(
CORETSE_AHBioO1
)
,
.CORETSE_AHBOiO1
(
CORETSE_AHBOiO1
)
,
.CORETSE_AHBIO11
(
CORETSE_AHBIO11
)
,
.CORETSE_AHBIl11
(
CORETSE_AHBl0O1
)
,
.CORETSE_AHBli01
(
CORETSE_AHBli01
)
,
.CORETSE_AHBll11
(
CORETSE_AHBoi01
)
,
.CORETSE_AHBII11
(
CORETSE_AHBII11
)
,
.CORETSE_AHBol1
(
CORETSE_AHBol1
)
)
;
perex_pma
CORETSE_AHBol11
(
.CORETSE_AHBIO1
(
CORETSE_AHBIO1
)
,
.CORETSE_AHBOO1
(
CORETSE_AHBOO1
)
,
.CORETSE_AHBil1
(
CORETSE_AHBil1
)
,
.CORETSE_AHBlO11
(
CORETSE_AHBlO11
)
,
.CORETSE_AHBol1
(
CORETSE_AHBol1
)
,
.CORETSE_AHBlo01
(
CORETSE_AHBlo01
)
,
.CORETSE_AHBlI11
(
CORETSE_AHBlI11
)
,
.CORETSE_AHBi010
(
CORETSE_AHBi010
)
,
.CORETSE_AHBiO11
(
CORETSE_AHBiO11
)
,
.CORETSE_AHBOI11
(
CORETSE_AHBOI11
)
)
;
perex_pcs
#
(
.CORETSE_AHBlOI
(
CORETSE_AHBlOI
)
)
CORETSE_AHBil11
(
.CORETSE_AHBOO1
(
CORETSE_AHBOO1
)
,
.CORETSE_AHBiO11
(
CORETSE_AHBiO11
)
,
.CORETSE_AHBOI11
(
CORETSE_AHBOI11
)
,
.CORETSE_AHBl01
(
CORETSE_AHBl01
)
,
.CORETSE_AHBoii0
(
CORETSE_AHBoii0
)
,
.CORETSE_AHBioO1
(
CORETSE_AHBioO1
)
,
.CORETSE_AHBlO11
(
CORETSE_AHBlO11
)
,
.CORETSE_AHBOO11
(
CORETSE_AHBOO11
)
,
.CORETSE_AHBlo01
(
CORETSE_AHBlo01
)
,
.CORETSE_AHBi010
(
CORETSE_AHBi010
)
,
.CORETSE_AHBiIO1
(
CORETSE_AHBiIO1
)
,
.CORETSE_AHBOo1
(
CORETSE_AHBOo1
)
,
.CORETSE_AHBOIO1
(
CORETSE_AHBOIO1
)
,
.CORETSE_AHBIIO1
(
CORETSE_AHBIIO1
)
,
.CORETSE_AHBlIO1
(
CORETSE_AHBlIO1
)
,
.CORETSE_AHBoIO1
(
CORETSE_AHBoIO1
)
,
.CORETSE_AHBIii0
(
CORETSE_AHBIii0
)
,
.CORETSE_AHBOii0
(
CORETSE_AHBOii0
)
,
.CORETSE_AHBlii0
(
CORETSE_AHBlii0
)
)
;
msgmii_peanx_top
CORETSE_AHBO011
(
.CORETSE_AHBiOO1
(
CORETSE_AHBloi0
)
,
.CORETSE_AHBOo1
(
CORETSE_AHBOo1
)
,
.CORETSE_AHBOIO1
(
CORETSE_AHBOIO1
)
,
.CORETSE_AHBIIO1
(
CORETSE_AHBIIO1
)
,
.CORETSE_AHBlIO1
(
CORETSE_AHBlIO1
)
,
.CORETSE_AHBoIO1
(
CORETSE_AHBoIO1
)
,
.CORETSE_AHBiIO1
(
CORETSE_AHBiIO1
)
,
.CORETSE_AHBOlO1
(
CORETSE_AHBOlO1
)
,
.CORETSE_AHBIlO1
(
CORETSE_AHBIlO1
)
,
.CORETSE_AHBllO1
(
CORETSE_AHBOi01
)
,
.CORETSE_AHBolO1
(
CORETSE_AHBolO1
)
,
.CORETSE_AHBilO1
(
CORETSE_AHBIi01
)
,
.CORETSE_AHBO0O1
(
CORETSE_AHBO0O1
)
,
.CORETSE_AHBI0O1
(
CORETSE_AHBI0O1
)
,
.CORETSE_AHBl0O1
(
CORETSE_AHBl0O1
)
,
.CORETSE_AHBo0O1
(
CORETSE_AHBo0O1
)
,
.CORETSE_AHBi0O1
(
CORETSE_AHBi0O1
)
,
.CORETSE_AHBO1O1
(
CORETSE_AHBO1O1
)
,
.CORETSE_AHBI1O1
(
CORETSE_AHBI1O1
)
,
.CORETSE_AHBI1i0
(
CORETSE_AHBI1i0
)
,
.CORETSE_AHBl1O1
(
CORETSE_AHBl1O1
)
,
.CORETSE_AHBo1O1
(
CORETSE_AHBo1O1
)
,
.CORETSE_AHBi1O1
(
CORETSE_AHBi1O1
)
,
.CORETSE_AHBOoO1
(
CORETSE_AHBOoO1
)
,
.CORETSE_AHBIoO1
(
CORETSE_AHBIoO1
)
,
.CORETSE_AHBloO1
(
CORETSE_AHBloO1
)
,
.CORETSE_AHBooO1
(
CORETSE_AHBooO1
)
,
.CORETSE_AHBioO1
(
CORETSE_AHBioO1
)
,
.CORETSE_AHBOiO1
(
CORETSE_AHBOiO1
)
)
;
petbm
#
(
.CORETSE_AHBlOI
(
CORETSE_AHBlOI
)
)
CORETSE_AHBI011
(
.CORETSE_AHBO11
(
CORETSE_AHBO11
)
,
.CORETSE_AHBI11
(
CORETSE_AHBI11
)
,
.CORETSE_AHBl11
(
CORETSE_AHBl11
)
,
.CORETSE_AHBi01
(
CORETSE_AHBi01
)
,
.CORETSE_AHBl011
(
CORETSE_AHBioi0
)
,
.CORETSE_AHBl1O1
(
CORETSE_AHBl1O1
)
,
.CORETSE_AHBo1O1
(
CORETSE_AHBo1O1
)
,
.CORETSE_AHBi1O1
(
CORETSE_AHBi1O1
)
,
.CORETSE_AHBOoO1
(
CORETSE_AHBOoO1
)
,
.CORETSE_AHBIoO1
(
CORETSE_AHBIoO1
)
,
.CORETSE_AHBloO1
(
CORETSE_AHBloO1
)
,
.CORETSE_AHBooO1
(
CORETSE_AHBooO1
)
,
.CORETSE_AHBooi0
(
CORETSE_AHBooi0
)
,
.CORETSE_AHBo01
(
CORETSE_AHBo01
)
,
.CORETSE_AHBIo01
(
CORETSE_AHBIo01
)
,
.CORETSE_AHBlo01
(
CORETSE_AHBlo01
)
,
.CORETSE_AHBoo01
(
CORETSE_AHBoo01
)
,
.CORETSE_AHBiIO1
(
CORETSE_AHBiIO1
)
,
.CORETSE_AHBOlO1
(
CORETSE_AHBOlO1
)
,
.CORETSE_AHBio01
(
CORETSE_AHBio01
)
,
.CORETSE_AHBIlO1
(
CORETSE_AHBIlO1
)
,
.CORETSE_AHBOi01
(
CORETSE_AHBOi01
)
,
.CORETSE_AHBolO1
(
CORETSE_AHBolO1
)
,
.CORETSE_AHBIi01
(
CORETSE_AHBIi01
)
,
.CORETSE_AHBO0O1
(
CORETSE_AHBO0O1
)
,
.CORETSE_AHBI0O1
(
CORETSE_AHBI0O1
)
,
.CORETSE_AHBl0O1
(
CORETSE_AHBl0O1
)
,
.CORETSE_AHBli01
(
CORETSE_AHBli01
)
,
.CORETSE_AHBoi01
(
CORETSE_AHBoi01
)
,
.CORETSE_AHBo0O1
(
CORETSE_AHBo0O1
)
,
.CORETSE_AHBii01
(
CORETSE_AHBii01
)
,
.CORETSE_AHBi0O1
(
CORETSE_AHBi0O1
)
,
.CORETSE_AHBO1O1
(
CORETSE_AHBO1O1
)
,
.CORETSE_AHBOO11
(
CORETSE_AHBOO11
)
,
.CORETSE_AHBIO11
(
CORETSE_AHBIO11
)
,
.CORETSE_AHBoii0
(
CORETSE_AHBoii0
)
,
.CORETSE_AHBOOO1
(
CORETSE_AHBOOO1
)
,
.CORETSE_AHBlO11
(
CORETSE_AHBlO11
)
,
.CORETSE_AHBoO11
(
CORETSE_AHBoO11
)
,
.CORETSE_AHBo011
(
)
)
;
petcr
CORETSE_AHBi011
(
.CORETSE_AHBloi0
(
CORETSE_AHBloi0
)
,
.CORETSE_AHBoO11
(
CORETSE_AHBoO11
)
,
.CORETSE_AHBII1
(
CORETSE_AHBII1
)
,
.CORETSE_AHBOI1
(
CORETSE_AHBOI1
)
,
.CORETSE_AHBIO1
(
CORETSE_AHBIO1
)
,
.CORETSE_AHBOO1
(
CORETSE_AHBOO1
)
,
.CORETSE_AHBioi0
(
CORETSE_AHBioi0
)
,
.CORETSE_AHBii01
(
CORETSE_AHBii01
)
,
.CORETSE_AHBIo01
(
CORETSE_AHBIo01
)
,
.CORETSE_AHBll1
(
CORETSE_AHBll1
)
,
.CORETSE_AHBOl1
(
CORETSE_AHBOl1
)
,
.CORETSE_AHBiI1
(
CORETSE_AHBiI1
)
,
.CORETSE_AHBII11
(
CORETSE_AHBII11
)
,
.CORETSE_AHBoI11
(
CORETSE_AHBoI11
)
,
.CORETSE_AHBlI11
(
CORETSE_AHBlI11
)
,
.CORETSE_AHBi010
(
CORETSE_AHBi010
)
,
.CORETSE_AHBI1O1
(
CORETSE_AHBI1O1
)
)
;
endmodule
