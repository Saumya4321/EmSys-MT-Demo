// REVISION    : $Revision: 1.12 $
//         Mentor Graphics Corporation Proprietary and Confidential
//         Copyright Mentor Graphics Corporation and Licensors 2004
`include "include.v"
module
dmarx
#
(
parameter
CORETSE_AHBoOI
=
0
)
(
CORETSE_AHBI01l
,
HREADY
,
HRESP
,
HRDATA
,
CORETSE_AHBl1Il
,
HCLK
,
CORETSE_AHBl01l
,
HTRANS
,
HADDR
,
HWRITE
,
HWDATA
,
CORETSE_AHBO10l
,
CORETSE_AHBIo0l
,
CORETSE_AHBi10l
,
CORETSE_AHBI00l
,
CORETSE_AHBIill
,
CORETSE_AHBlill
,
CORETSE_AHBil1l
,
CORETSE_AHBlI0l
,
CORETSE_AHBl10l
,
CORETSE_AHBIIll
,
CORETSE_AHBilll
,
CORETSE_AHBI1ll
,
CORETSE_AHBl1ll
,
CORETSE_AHBo1ll
,
CORETSE_AHBi1ll
,
CORETSE_AHBOoll
)
;
input
CORETSE_AHBI01l
;
input
HREADY
;
input
[
1
:
0
]
HRESP
;
input
[
31
:
0
]
HRDATA
;
input
CORETSE_AHBl1Il
;
input
HCLK
;
output
CORETSE_AHBl01l
;
output
[
1
:
0
]
HTRANS
;
output
[
31
:
2
]
HADDR
;
output
HWRITE
;
output
[
31
:
0
]
HWDATA
;
output
CORETSE_AHBO10l
;
output
CORETSE_AHBIo0l
;
output
[
31
:
2
]
CORETSE_AHBi10l
;
output
[
7
:
0
]
CORETSE_AHBI00l
;
output
CORETSE_AHBlI0l
;
input
CORETSE_AHBIill
;
input
CORETSE_AHBlill
;
input
CORETSE_AHBil1l
;
input
[
31
:
2
]
CORETSE_AHBl10l
;
input
[
15
:
0
]
CORETSE_AHBIIll
;
output
CORETSE_AHBilll
;
input
CORETSE_AHBI1ll
;
input
CORETSE_AHBl1ll
;
input
CORETSE_AHBo1ll
;
input
[
31
:
0
]
CORETSE_AHBi1ll
;
input
[
1
:
0
]
CORETSE_AHBOoll
;
`define CORETSE_AHBi01l  \
2 \
'b \
00
`define CORETSE_AHBO11l  \
2 \
'b \
01
`define CORETSE_AHBI11l  \
2 \
'b \
11
`define CORETSE_AHBl11l  \
2 \
'b \
10
`define CORETSE_AHBo11l  \
1 \
'b \
0
`define CORETSE_AHBi11l  \
1 \
'b \
1
`define CORETSE_AHBOo1l  \
{ \
1 \
'b \
0 \
, \
`CORETSE_AHBIo1l \
}
`define CORETSE_AHBlo1l  \
{ \
1 \
'b \
1 \
, \
`CORETSE_AHBIo1l \
}
`define CORETSE_AHBoo1l  \
{ \
1 \
'b \
1 \
, \
`CORETSE_AHBio1l \
}
`define CORETSE_AHBOi1l  \
{ \
1 \
'b \
1 \
, \
`CORETSE_AHBIi1l \
}
`define CORETSE_AHBli1l  \
{ \
1 \
'b \
1 \
, \
`CORETSE_AHBoi1l \
}
reg
[
7
:
0
]
CORETSE_AHBI00l
,
CORETSE_AHBii1l
;
reg
[
1
:
0
]
CORETSE_AHBOOol
,
CORETSE_AHBIOol
;
reg
CORETSE_AHBlI0l
;
reg
CORETSE_AHBlOol
;
reg
CORETSE_AHBoOol
,
CORETSE_AHBIo0l
;
reg
[
31
:
2
]
CORETSE_AHBi10l
;
reg
[
1
:
0
]
CORETSE_AHBiOol
;
reg
[
31
:
2
]
CORETSE_AHBOIol
;
reg
CORETSE_AHBIIol
;
reg
[
31
:
2
]
CORETSE_AHBlIol
;
wire
CORETSE_AHBoIol
;
reg
[
31
:
2
]
CORETSE_AHBiIol
;
reg
[
15
:
0
]
CORETSE_AHBOlol
;
reg
[
15
:
0
]
CORETSE_AHBIlol
;
reg
CORETSE_AHBllol
;
reg
CORETSE_AHBolol
;
reg
CORETSE_AHBilol
;
reg
[
31
:
0
]
CORETSE_AHBO0ol
;
reg
[
2
:
0
]
CORETSE_AHBI0ol
,
CORETSE_AHBl0ol
;
reg
CORETSE_AHBo0ol
;
reg
CORETSE_AHBi0ol
;
wire
CORETSE_AHBO1ol
;
reg
HWRITE
;
reg
[
31
:
0
]
HWDATA
;
reg
[
31
:
2
]
HADDR
,
CORETSE_AHBI1ol
;
reg
[
15
:
0
]
CORETSE_AHBl1ol
,
CORETSE_AHBo1ol
;
assign
CORETSE_AHBO10l
=
CORETSE_AHBO1ol
;
assign
CORETSE_AHBoIol
=
CORETSE_AHBlI0l
;
always
@
(
posedge
HCLK
or
negedge
CORETSE_AHBl1Il
)
begin
:
CORETSE_AHBi1ol
if
(
!
CORETSE_AHBl1Il
)
begin
CORETSE_AHBlI0l
<=
0
;
CORETSE_AHBI00l
<=
0
;
end
else
begin
CORETSE_AHBlI0l
<=
(
CORETSE_AHBlI0l
||
CORETSE_AHBIill
)
&&
CORETSE_AHBlOol
&&
!
CORETSE_AHBlill
;
CORETSE_AHBI00l
<=
CORETSE_AHBii1l
-
{
7
'h
00
,
(
CORETSE_AHBil1l
&&
|
CORETSE_AHBI00l
)
}
;
end
end
always
@
(
posedge
HCLK
or
negedge
CORETSE_AHBl1Il
)
begin
:
CORETSE_AHBOool
if
(
!
CORETSE_AHBl1Il
)
begin
CORETSE_AHBOOol
<=
`CORETSE_AHBi01l
;
CORETSE_AHBlIol
<=
0
;
CORETSE_AHBIIol
<=
0
;
CORETSE_AHBOIol
<=
0
;
CORETSE_AHBiOol
<=
0
;
end
else
begin
CORETSE_AHBOOol
<=
CORETSE_AHBIOol
;
if
(
HREADY
)
if
(
CORETSE_AHBOOol
==
`CORETSE_AHBO11l
)
CORETSE_AHBiOol
<=
CORETSE_AHBl1ol
+
1
;
else
CORETSE_AHBiOol
<=
0
;
case
(
CORETSE_AHBiOol
)
2
'b
11
:
CORETSE_AHBlIol
<=
HRDATA
[
31
:
2
]
;
2
'b
10
:
begin
CORETSE_AHBIIol
<=
HRDATA
[
31
]
;
end
2
'b
01
:
CORETSE_AHBOIol
<=
HRDATA
[
31
:
2
]
;
endcase
end
end
always
@
(
*
)
begin
:
CORETSE_AHBIool
CORETSE_AHBIOol
=
CORETSE_AHBOOol
;
CORETSE_AHBlOol
=
1
;
CORETSE_AHBIo0l
=
0
;
CORETSE_AHBii1l
=
CORETSE_AHBI00l
;
CORETSE_AHBi10l
=
CORETSE_AHBl10l
;
if
(
CORETSE_AHBO1ol
)
begin
CORETSE_AHBIOol
=
`CORETSE_AHBi01l
;
CORETSE_AHBlOol
=
0
;
end
else
case
(
CORETSE_AHBOOol
)
`CORETSE_AHBi01l
:
begin
if
(
CORETSE_AHBoIol
&&
CORETSE_AHBl1ll
&&
CORETSE_AHBI1ll
)
CORETSE_AHBIOol
=
`CORETSE_AHBO11l
;
else
CORETSE_AHBIOol
=
`CORETSE_AHBi01l
;
end
`CORETSE_AHBO11l
:
begin
if
(
CORETSE_AHBi0ol
)
if
(
(
CORETSE_AHBiOol
==
2
'b
10
)
?
HRDATA
[
31
]
:
CORETSE_AHBIIol
)
CORETSE_AHBIOol
=
`CORETSE_AHBI11l
;
else
begin
CORETSE_AHBlOol
=
0
;
CORETSE_AHBIo0l
=
1
;
CORETSE_AHBIOol
=
`CORETSE_AHBi01l
;
end
end
`CORETSE_AHBI11l
:
begin
if
(
CORETSE_AHBi0ol
)
CORETSE_AHBIOol
=
`CORETSE_AHBl11l
;
end
`CORETSE_AHBl11l
:
begin
if
(
CORETSE_AHBi0ol
)
begin
CORETSE_AHBii1l
=
CORETSE_AHBI00l
+
1
;
if
(
CORETSE_AHBoIol
&&
CORETSE_AHBl1ll
&&
CORETSE_AHBI1ll
)
CORETSE_AHBIOol
=
`CORETSE_AHBO11l
;
else
CORETSE_AHBIOol
=
`CORETSE_AHBi01l
;
end
end
endcase
if
(
CORETSE_AHBI01l
&&
HREADY
&&
CORETSE_AHBIOol
==
`CORETSE_AHBl11l
)
CORETSE_AHBi10l
=
CORETSE_AHBOIol
;
end
always
@
(
*
)
begin
:
CORETSE_AHBlool
case
(
CORETSE_AHBIOol
)
`CORETSE_AHBO11l
:
begin
CORETSE_AHBIlol
=
16
'h
0002
;
CORETSE_AHBilol
=
0
;
CORETSE_AHBllol
=
1
;
CORETSE_AHBiIol
=
CORETSE_AHBl10l
;
end
`CORETSE_AHBI11l
:
begin
CORETSE_AHBilol
=
1
;
CORETSE_AHBIlol
=
0
;
CORETSE_AHBllol
=
CORETSE_AHBI1ll
;
CORETSE_AHBiIol
=
CORETSE_AHBlIol
;
end
`CORETSE_AHBl11l
:
begin
CORETSE_AHBIlol
=
{
16
{
CORETSE_AHBi0ol
}
}
&
(
CORETSE_AHBl1ol
+
16
'h
0004
-
{
14
'h
0000
,
(
CORETSE_AHBOoll
&
{
2
{
CORETSE_AHBI1ll
}
}
)
}
)
|
{
16
{
~
CORETSE_AHBi0ol
}
}
&
CORETSE_AHBl1ol
;
CORETSE_AHBilol
=
1
;
CORETSE_AHBllol
=
1
;
CORETSE_AHBiIol
=
CORETSE_AHBl10l
+
1
;
end
default
:
begin
CORETSE_AHBIlol
=
0
;
CORETSE_AHBilol
=
0
;
CORETSE_AHBllol
=
0
;
CORETSE_AHBiIol
=
0
;
end
endcase
case
(
CORETSE_AHBOOol
)
`CORETSE_AHBO11l
:
begin
CORETSE_AHBOlol
=
16
'h
FFFF
;
CORETSE_AHBolol
=
~|
CORETSE_AHBl1ol
;
CORETSE_AHBO0ol
=
0
;
end
`CORETSE_AHBI11l
:
begin
CORETSE_AHBOlol
=
4
;
CORETSE_AHBolol
=
(
CORETSE_AHBo1ll
&&
CORETSE_AHBI1ll
)
||
!
CORETSE_AHBI1ll
||
CORETSE_AHBl1ol
>
CORETSE_AHBIIll
;
CORETSE_AHBO0ol
=
(
CORETSE_AHBi1ll
&
{
32
{
CORETSE_AHBI1ll
}
}
)
;
end
`CORETSE_AHBl11l
:
begin
CORETSE_AHBOlol
=
0
;
CORETSE_AHBolol
=
1
;
CORETSE_AHBO0ol
[
31
]
=
0
;
CORETSE_AHBO0ol
[
30
:
0
]
=
{
{
15
{
1
'b
0
}
}
,
CORETSE_AHBl1ol
}
;
end
default
:
begin
CORETSE_AHBOlol
=
0
;
CORETSE_AHBolol
=
1
;
CORETSE_AHBO0ol
=
0
;
end
endcase
end
always
@
(
posedge
HCLK
or
negedge
CORETSE_AHBl1Il
)
begin
:
CORETSE_AHBoool
if
(
!
CORETSE_AHBl1Il
)
begin
CORETSE_AHBI0ol
<=
`CORETSE_AHBOo1l
;
CORETSE_AHBo0ol
<=
0
;
HADDR
<=
0
;
HWRITE
<=
0
;
HWDATA
<=
0
;
CORETSE_AHBl1ol
<=
0
;
end
else
begin
CORETSE_AHBI0ol
<=
CORETSE_AHBl0ol
;
CORETSE_AHBo0ol
<=
HREADY
?
CORETSE_AHBI0ol
[
1
]
:
CORETSE_AHBo0ol
;
HWDATA
<=
HREADY
?
CORETSE_AHBO0ol
:
HWDATA
;
HWRITE
<=
HREADY
?
CORETSE_AHBilol
:
HWRITE
;
HADDR
<=
CORETSE_AHBI1ol
;
CORETSE_AHBl1ol
<=
CORETSE_AHBo1ol
;
end
end
assign
CORETSE_AHBO1ol
=
CORETSE_AHBo0ol
&&
HREADY
&&
(
HRESP
!=
`CORETSE_AHBiool
)
;
always
@
(
HREADY
or
CORETSE_AHBI0ol
or
CORETSE_AHBI01l
or
HADDR
or
CORETSE_AHBllol
or
CORETSE_AHBolol
or
CORETSE_AHBiIol
or
CORETSE_AHBIlol
or
CORETSE_AHBOlol
or
CORETSE_AHBl1ol
)
begin
:
CORETSE_AHBOiol
CORETSE_AHBl0ol
=
CORETSE_AHBI0ol
;
CORETSE_AHBI1ol
=
HADDR
;
CORETSE_AHBo1ol
=
CORETSE_AHBl1ol
;
CORETSE_AHBi0ol
=
0
;
if
(
HREADY
)
case
(
CORETSE_AHBI0ol
)
`CORETSE_AHBOo1l
:
if
(
CORETSE_AHBllol
)
begin
CORETSE_AHBl0ol
=
CORETSE_AHBI01l
?
`CORETSE_AHBOi1l
:
`CORETSE_AHBlo1l
;
CORETSE_AHBI1ol
=
CORETSE_AHBiIol
;
CORETSE_AHBo1ol
=
CORETSE_AHBIlol
;
end
`CORETSE_AHBlo1l
:
CORETSE_AHBl0ol
=
CORETSE_AHBI01l
?
`CORETSE_AHBOi1l
:
`CORETSE_AHBlo1l
;
`CORETSE_AHBOi1l
,
`CORETSE_AHBli1l
:
begin
CORETSE_AHBI1ol
=
HADDR
+
1
;
CORETSE_AHBo1ol
=
CORETSE_AHBl1ol
+
CORETSE_AHBOlol
;
if
(
CORETSE_AHBolol
)
begin
CORETSE_AHBi0ol
=
1
;
if
(
CORETSE_AHBllol
&&
CORETSE_AHBI01l
)
begin
CORETSE_AHBI1ol
=
CORETSE_AHBiIol
;
CORETSE_AHBo1ol
=
CORETSE_AHBIlol
;
CORETSE_AHBl0ol
=
`CORETSE_AHBOi1l
;
end
else
begin
CORETSE_AHBl0ol
=
`CORETSE_AHBOo1l
;
CORETSE_AHBo1ol
=
CORETSE_AHBIlol
;
end
end
else
if
(
!
CORETSE_AHBI01l
)
CORETSE_AHBl0ol
=
`CORETSE_AHBlo1l
;
else
if
(
~|
CORETSE_AHBI1ol
[
9
:
2
]
)
CORETSE_AHBl0ol
=
`CORETSE_AHBOi1l
;
else
CORETSE_AHBl0ol
=
`CORETSE_AHBli1l
;
end
default
:
begin
CORETSE_AHBl0ol
=
`CORETSE_AHBOo1l
;
end
endcase
end
assign
HTRANS
=
CORETSE_AHBI0ol
[
1
:
0
]
;
assign
CORETSE_AHBl01l
=
CORETSE_AHBI0ol
[
2
]
;
assign
CORETSE_AHBilll
=
CORETSE_AHBI0ol
[
1
]
&&
HREADY
&&
(
CORETSE_AHBOOol
==
`CORETSE_AHBI11l
)
;
endmodule
