// REVISION    : $Revision: 1.1 $
// Mentor Graphics Corporation Proprietary and Confidential
// Copyright 2007 Mentor Graphics Corporation and Licensors
`timescale 1ps/1ps
// improves synthesis and layout development procedures of the PE_TBI.
module
petcr
(
CORETSE_AHBloi0
,
CORETSE_AHBoO11
,
CORETSE_AHBII1
,
CORETSE_AHBOI1
,
CORETSE_AHBIO1
,
CORETSE_AHBOO1
,
CORETSE_AHBioi0
,
CORETSE_AHBii01
,
CORETSE_AHBIo01
,
CORETSE_AHBll1
,
CORETSE_AHBOl1
,
CORETSE_AHBiI1
,
CORETSE_AHBII11
,
CORETSE_AHBoI11
,
CORETSE_AHBlI11
,
CORETSE_AHBi010
,
CORETSE_AHBI1O1
)
;
input
CORETSE_AHBloi0
;
input
CORETSE_AHBoO11
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
CORETSE_AHBioi0
;
input
CORETSE_AHBii01
;
input
CORETSE_AHBIo01
;
input
CORETSE_AHBll1
;
output
CORETSE_AHBOl1
;
output
CORETSE_AHBiI1
;
output
CORETSE_AHBII11
;
output
CORETSE_AHBoI11
;
output
CORETSE_AHBlI11
;
output
CORETSE_AHBi010
;
output
CORETSE_AHBI1O1
;
wire
CORETSE_AHBOl1
;
wire
CORETSE_AHBiI1
;
wire
CORETSE_AHBII11
;
wire
CORETSE_AHBoI11
;
wire
CORETSE_AHBlI11
;
wire
CORETSE_AHBi010
;
wire
CORETSE_AHBI1O1
;
parameter
CORETSE_AHBIoII
=
1
;
reg
CORETSE_AHBioIII
,
CORETSE_AHBOiIII
;
wire
CORETSE_AHBIiIII
;
reg
CORETSE_AHBliIII
;
wire
CORETSE_AHBOO0o
;
reg
CORETSE_AHBIO0o
,
CORETSE_AHBlO0o
;
wire
CORETSE_AHBoO0o
;
wire
CORETSE_AHBiO0o
;
reg
CORETSE_AHBOI0o
,
CORETSE_AHBII0o
;
wire
CORETSE_AHBlI0o
;
reg
CORETSE_AHBoiIII
,
CORETSE_AHBiiIII
;
wire
CORETSE_AHBOOlII
;
reg
CORETSE_AHBIOlII
,
CORETSE_AHBlOlII
;
wire
CORETSE_AHBoOlII
;
wire
CORETSE_AHBiOlII
;
reg
CORETSE_AHBOIlII
,
CORETSE_AHBIIlII
;
wire
CORETSE_AHBlIlII
;
always
@
(
posedge
CORETSE_AHBOI1
)
begin
CORETSE_AHBioIII
<=
#
CORETSE_AHBIoII
CORETSE_AHBioi0
;
end
always
@
(
posedge
CORETSE_AHBOI1
)
begin
CORETSE_AHBOiIII
<=
#
CORETSE_AHBIoII
CORETSE_AHBioIII
;
end
assign
CORETSE_AHBIiIII
=
CORETSE_AHBioi0
|
CORETSE_AHBOiIII
;
always
@
(
posedge
CORETSE_AHBOI1
)
begin
if
(
CORETSE_AHBIiIII
)
CORETSE_AHBliIII
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBliIII
<=
#
CORETSE_AHBIoII
~
CORETSE_AHBliIII
;
end
assign
CORETSE_AHBiI1
=
(
CORETSE_AHBoO11
)
?
CORETSE_AHBliIII
:
CORETSE_AHBOI1
;
assign
CORETSE_AHBOl1
=
(
CORETSE_AHBoO11
)
?
~
CORETSE_AHBliIII
:
CORETSE_AHBII1
;
assign
CORETSE_AHBOO0o
=
CORETSE_AHBioi0
|
CORETSE_AHBii01
|
CORETSE_AHBIo01
;
always
@
(
posedge
CORETSE_AHBloi0
)
begin
CORETSE_AHBIO0o
<=
#
CORETSE_AHBIoII
CORETSE_AHBOO0o
;
end
always
@
(
posedge
CORETSE_AHBloi0
)
begin
CORETSE_AHBlO0o
<=
#
CORETSE_AHBIoII
CORETSE_AHBIO0o
;
end
assign
CORETSE_AHBoO0o
=
CORETSE_AHBOO0o
|
CORETSE_AHBlO0o
;
assign
CORETSE_AHBII11
=
CORETSE_AHBll1
?
CORETSE_AHBioi0
:
CORETSE_AHBoO0o
;
assign
CORETSE_AHBiO0o
=
CORETSE_AHBioi0
|
CORETSE_AHBii01
|
CORETSE_AHBIo01
;
always
@
(
posedge
CORETSE_AHBloi0
)
begin
CORETSE_AHBOI0o
<=
#
CORETSE_AHBIoII
CORETSE_AHBiO0o
;
end
always
@
(
posedge
CORETSE_AHBloi0
)
begin
CORETSE_AHBII0o
<=
#
CORETSE_AHBIoII
CORETSE_AHBOI0o
;
end
assign
CORETSE_AHBlI0o
=
CORETSE_AHBiO0o
|
CORETSE_AHBII0o
;
assign
CORETSE_AHBoI11
=
CORETSE_AHBll1
?
CORETSE_AHBioi0
:
CORETSE_AHBlI0o
;
always
@
(
posedge
CORETSE_AHBIO1
)
begin
CORETSE_AHBoiIII
<=
#
CORETSE_AHBIoII
CORETSE_AHBiO0o
;
end
always
@
(
posedge
CORETSE_AHBIO1
)
begin
CORETSE_AHBiiIII
<=
#
CORETSE_AHBIoII
CORETSE_AHBoiIII
;
end
assign
CORETSE_AHBOOlII
=
CORETSE_AHBiO0o
|
CORETSE_AHBiiIII
;
assign
CORETSE_AHBlI11
=
CORETSE_AHBll1
?
CORETSE_AHBioi0
:
CORETSE_AHBOOlII
;
always
@
(
posedge
CORETSE_AHBOO1
)
begin
CORETSE_AHBIOlII
<=
#
CORETSE_AHBIoII
CORETSE_AHBiO0o
;
end
always
@
(
posedge
CORETSE_AHBOO1
)
begin
CORETSE_AHBlOlII
<=
#
CORETSE_AHBIoII
CORETSE_AHBIOlII
;
end
assign
CORETSE_AHBoOlII
=
CORETSE_AHBiO0o
|
CORETSE_AHBlOlII
;
assign
CORETSE_AHBi010
=
CORETSE_AHBll1
?
CORETSE_AHBioi0
:
CORETSE_AHBoOlII
;
assign
CORETSE_AHBiOlII
=
CORETSE_AHBioi0
|
CORETSE_AHBii01
|
CORETSE_AHBIo01
;
always
@
(
posedge
CORETSE_AHBloi0
)
begin
CORETSE_AHBOIlII
<=
#
CORETSE_AHBIoII
CORETSE_AHBiOlII
;
end
always
@
(
posedge
CORETSE_AHBloi0
)
begin
CORETSE_AHBIIlII
<=
#
CORETSE_AHBIoII
CORETSE_AHBOIlII
;
end
assign
CORETSE_AHBlIlII
=
CORETSE_AHBiOlII
|
CORETSE_AHBIIlII
;
assign
CORETSE_AHBI1O1
=
CORETSE_AHBll1
?
CORETSE_AHBioi0
:
CORETSE_AHBlIlII
;
endmodule
