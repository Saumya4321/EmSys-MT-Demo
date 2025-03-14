// REVISION    : $Revision: 1.1 $
//                   MENTOR Proprietary and Confidential
//                       Copyright (c) 2003, MENTOR
`timescale 1ns/1ns
module
pemgt
(
CORETSE_AHBio11
,
CORETSE_AHBoOOo
,
CORETSE_AHBiOOo
,
CORETSE_AHBOIOo
,
CORETSE_AHBiIOo
,
CORETSE_AHBlIOo
,
CORETSE_AHBIIOo
,
CORETSE_AHBioOo
,
CORETSE_AHBOlOo
,
CORETSE_AHBIlOo
,
CORETSE_AHBo01
,
CORETSE_AHBO1Oo
,
CORETSE_AHBO11
,
CORETSE_AHBI11
,
CORETSE_AHBi01
,
CORETSE_AHBiOi1
,
CORETSE_AHBOIi1
,
CORETSE_AHBOiOo
,
CORETSE_AHBIiOo
,
CORETSE_AHBIIi1
,
CORETSE_AHBlIi1
)
;
input
CORETSE_AHBio11
;
input
[
2
:
0
]
CORETSE_AHBoOOo
;
input
[
15
:
0
]
CORETSE_AHBiIOo
;
input
[
4
:
0
]
CORETSE_AHBlIOo
,
CORETSE_AHBIIOo
;
input
CORETSE_AHBiOOo
,
CORETSE_AHBOIOo
;
input
CORETSE_AHBioOo
,
CORETSE_AHBOlOo
,
CORETSE_AHBIlOo
;
input
CORETSE_AHBo01
;
input
CORETSE_AHBO1Oo
;
output
CORETSE_AHBi01
,
CORETSE_AHBO11
,
CORETSE_AHBI11
;
output
CORETSE_AHBiOi1
,
CORETSE_AHBIIi1
,
CORETSE_AHBlIi1
;
output
[
4
:
0
]
CORETSE_AHBOiOo
;
output
CORETSE_AHBIiOo
;
output
[
15
:
0
]
CORETSE_AHBOIi1
;
reg
CORETSE_AHBi01
,
CORETSE_AHBO11
,
CORETSE_AHBI11
;
wire
CORETSE_AHBiOi1
;
reg
CORETSE_AHBIIi1
;
reg
CORETSE_AHBlIi1
;
reg
[
15
:
0
]
CORETSE_AHBOIi1
;
parameter
CORETSE_AHBIoII
=
1
;
wire
[
4
:
0
]
CORETSE_AHBoooo
;
reg
[
4
:
0
]
CORETSE_AHBiooo
;
wire
CORETSE_AHBOioo
;
wire
CORETSE_AHBIioo
;
wire
CORETSE_AHBlioo
;
reg
CORETSE_AHBoioo
,
CORETSE_AHBiioo
;
wire
CORETSE_AHBOOio
;
wire
CORETSE_AHBIOio
;
wire
[
7
:
0
]
CORETSE_AHBlOio
;
wire
[
7
:
0
]
CORETSE_AHBoOio
;
wire
CORETSE_AHBiOio
;
reg
CORETSE_AHBOIio
;
wire
CORETSE_AHBIIio
;
reg
CORETSE_AHBlIio
;
reg
CORETSE_AHBoIio
,
CORETSE_AHBiIio
,
CORETSE_AHBOlio
;
reg
CORETSE_AHBIlio
,
CORETSE_AHBllio
,
CORETSE_AHBolio
;
reg
CORETSE_AHBilio
,
CORETSE_AHBO0io
,
CORETSE_AHBI0io
;
reg
CORETSE_AHBl0io
,
CORETSE_AHBo0io
,
CORETSE_AHBi0io
,
CORETSE_AHBO1io
;
wire
CORETSE_AHBI1io
,
CORETSE_AHBl1io
,
CORETSE_AHBo1io
,
CORETSE_AHBi1io
;
wire
CORETSE_AHBOoio
;
reg
CORETSE_AHBIoio
,
CORETSE_AHBloio
,
CORETSE_AHBooio
,
CORETSE_AHBioio
;
wire
CORETSE_AHBOiio
;
reg
CORETSE_AHBIiio
;
wire
[
5
:
0
]
CORETSE_AHBliio
;
reg
[
5
:
0
]
CORETSE_AHBoiio
;
wire
CORETSE_AHBiiio
;
wire
CORETSE_AHBOOOi
,
CORETSE_AHBIOOi
,
CORETSE_AHBlOOi
,
CORETSE_AHBoOOi
,
CORETSE_AHBiOOi
;
wire
[
7
:
0
]
CORETSE_AHBOIOi
;
reg
[
7
:
0
]
CORETSE_AHBIIOi
;
wire
CORETSE_AHBlIOi
;
reg
CORETSE_AHBoIOi
,
CORETSE_AHBiIOi
;
reg
CORETSE_AHBOlOi
,
CORETSE_AHBIlOi
;
wire
CORETSE_AHBllOi
,
CORETSE_AHBolOi
;
reg
CORETSE_AHBilOi
,
CORETSE_AHBO0Oi
,
CORETSE_AHBI0Oi
,
CORETSE_AHBl0Oi
;
wire
[
4
:
0
]
CORETSE_AHBo0Oi
;
reg
[
4
:
0
]
CORETSE_AHBi0Oi
;
wire
[
4
:
0
]
CORETSE_AHBO1Oi
;
reg
[
4
:
0
]
CORETSE_AHBOiOo
;
wire
CORETSE_AHBI1Oi
;
reg
CORETSE_AHBIiOo
;
reg
CORETSE_AHBl1Oi
;
assign
CORETSE_AHBOioo
=
(
CORETSE_AHBiooo
==
5
'h
0
)
;
assign
CORETSE_AHBoooo
=
{
5
{
CORETSE_AHBOioo
&
CORETSE_AHBoOOo
==
3
'h
7
}
}
&
5
'h
d
|
{
5
{
CORETSE_AHBOioo
&
CORETSE_AHBoOOo
==
3
'h
6
}
}
&
5
'h
9
|
{
5
{
CORETSE_AHBOioo
&
CORETSE_AHBoOOo
==
3
'h
5
}
}
&
5
'h
6
|
{
5
{
CORETSE_AHBOioo
&
CORETSE_AHBoOOo
==
3
'h
4
}
}
&
5
'h
4
|
{
5
{
CORETSE_AHBOioo
&
CORETSE_AHBoOOo
==
3
'h
3
}
}
&
5
'h
3
|
{
5
{
CORETSE_AHBOioo
&
CORETSE_AHBoOOo
==
3
'h
2
}
}
&
5
'h
2
|
{
5
{
CORETSE_AHBOioo
&
CORETSE_AHBoOOo
<=
3
'h
1
}
}
&
5
'h
1
|
{
5
{
~
CORETSE_AHBOioo
}
}
&
CORETSE_AHBiooo
[
4
:
0
]
-
5
'h
1
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBiooo
[
4
:
0
]
<=
#
CORETSE_AHBIoII
5
'h
1
;
else
CORETSE_AHBiooo
[
4
:
0
]
<=
#
CORETSE_AHBIoII
CORETSE_AHBoooo
[
4
:
0
]
;
end
assign
CORETSE_AHBlioo
=
CORETSE_AHBOioo
&
~
CORETSE_AHBi01
;
assign
CORETSE_AHBIioo
=
{
CORETSE_AHBOioo
}
&
~
CORETSE_AHBi01
|
{
~
CORETSE_AHBOioo
}
&
CORETSE_AHBi01
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBi01
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBi01
<=
#
CORETSE_AHBIoII
CORETSE_AHBIioo
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBoioo
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBoioo
<=
#
CORETSE_AHBIoII
~
CORETSE_AHBooio
&
CORETSE_AHBioio
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBiioo
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBiioo
<=
#
CORETSE_AHBIoII
CORETSE_AHBoioo
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBoIio
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBoIio
<=
#
CORETSE_AHBIoII
CORETSE_AHBioOo
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBiIio
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBiIio
<=
#
CORETSE_AHBIoII
CORETSE_AHBoIio
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBOlio
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBOlio
<=
#
CORETSE_AHBIoII
CORETSE_AHBiIio
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBIlio
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBIlio
<=
#
CORETSE_AHBIoII
CORETSE_AHBOlOo
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBllio
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBllio
<=
#
CORETSE_AHBIoII
CORETSE_AHBIlio
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBolio
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBolio
<=
#
CORETSE_AHBIoII
CORETSE_AHBllio
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBilio
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBilio
<=
#
CORETSE_AHBIoII
CORETSE_AHBIlOo
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBO0io
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBO0io
<=
#
CORETSE_AHBIoII
CORETSE_AHBilio
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBI0io
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
if
(
CORETSE_AHBlioo
)
CORETSE_AHBI0io
<=
#
CORETSE_AHBIoII
CORETSE_AHBO0io
;
end
assign
CORETSE_AHBiOio
=
~
CORETSE_AHBOIio
&
CORETSE_AHBiIio
&
~
CORETSE_AHBOlio
|
CORETSE_AHBOIio
&
~
CORETSE_AHBiioo
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBOIio
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBOIio
<=
#
CORETSE_AHBIoII
CORETSE_AHBiOio
;
end
assign
CORETSE_AHBIIio
=
~
CORETSE_AHBlIio
&
CORETSE_AHBllio
&
~
CORETSE_AHBolio
|
CORETSE_AHBlIio
&
~
CORETSE_AHBiioo
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBlIio
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBlIio
<=
#
CORETSE_AHBIoII
CORETSE_AHBIIio
;
end
assign
CORETSE_AHBOOio
=
~
CORETSE_AHBlIi1
&
CORETSE_AHBO0io
&
~
CORETSE_AHBI0io
|
CORETSE_AHBlIi1
&
~
CORETSE_AHBiioo
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBlIi1
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBlIi1
<=
#
CORETSE_AHBIoII
CORETSE_AHBOOio
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBl0io
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
if
(
CORETSE_AHBlioo
)
CORETSE_AHBl0io
<=
#
CORETSE_AHBIoII
CORETSE_AHBOIio
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBo0io
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
if
(
CORETSE_AHBlioo
)
CORETSE_AHBo0io
<=
#
CORETSE_AHBIoII
CORETSE_AHBl0io
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBi0io
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
if
(
CORETSE_AHBlioo
)
CORETSE_AHBi0io
<=
#
CORETSE_AHBIoII
CORETSE_AHBlIio
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBO1io
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
if
(
CORETSE_AHBlioo
)
CORETSE_AHBO1io
<=
#
CORETSE_AHBIoII
CORETSE_AHBi0io
;
end
assign
CORETSE_AHBiOi1
=
CORETSE_AHBOIio
|
CORETSE_AHBlIio
|
CORETSE_AHBI0io
|
CORETSE_AHBiioo
|
CORETSE_AHBIoio
|
CORETSE_AHBioio
;
assign
CORETSE_AHBI1io
=
CORETSE_AHBl0io
&
~
CORETSE_AHBo0io
;
assign
CORETSE_AHBl1io
=
CORETSE_AHBi0io
&
~
CORETSE_AHBO1io
;
assign
CORETSE_AHBo1io
=
CORETSE_AHBI0io
&
~
CORETSE_AHBIoio
&
~
CORETSE_AHBloio
&
~
CORETSE_AHBooio
;
assign
CORETSE_AHBi1io
=
CORETSE_AHBI1io
|
CORETSE_AHBl1io
|
CORETSE_AHBo1io
;
assign
CORETSE_AHBOoio
=
~
CORETSE_AHBIoio
&
CORETSE_AHBlioo
&
CORETSE_AHBi1io
|
CORETSE_AHBIoio
&
~
(
CORETSE_AHBlioo
&
CORETSE_AHBiiio
)
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBIoio
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBIoio
<=
#
CORETSE_AHBIoII
CORETSE_AHBOoio
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBloio
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
if
(
CORETSE_AHBlioo
)
CORETSE_AHBloio
<=
#
CORETSE_AHBIoII
CORETSE_AHBIoio
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBooio
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
if
(
CORETSE_AHBlioo
)
CORETSE_AHBooio
<=
#
CORETSE_AHBIoII
CORETSE_AHBloio
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBioio
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
if
(
CORETSE_AHBlioo
)
CORETSE_AHBioio
<=
#
CORETSE_AHBIoII
CORETSE_AHBooio
;
end
assign
CORETSE_AHBOiio
=
{
(
CORETSE_AHBlioo
&
CORETSE_AHBi1io
&
~
CORETSE_AHBIoio
)
}
&
CORETSE_AHBI1io
|
{
~
(
CORETSE_AHBlioo
&
CORETSE_AHBi1io
&
~
CORETSE_AHBIoio
)
}
&
CORETSE_AHBIiio
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBIiio
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBIiio
<=
#
CORETSE_AHBIoII
CORETSE_AHBOiio
;
end
assign
CORETSE_AHBliio
=
{
6
{
CORETSE_AHBlioo
&
~
CORETSE_AHBIoio
}
}
&
6
'h
0
|
{
6
{
CORETSE_AHBlioo
&
(
CORETSE_AHBiOOo
&
CORETSE_AHBoiio
==
6
'h
0
)
&
CORETSE_AHBIoio
}
}
&
6
'h
21
|
{
6
{
CORETSE_AHBlioo
&
~
(
CORETSE_AHBiOOo
&
CORETSE_AHBoiio
==
6
'h
0
)
&
CORETSE_AHBIoio
}
}
&
CORETSE_AHBoiio
+
6
'h
1
|
{
6
{
~
CORETSE_AHBlioo
}
}
&
CORETSE_AHBoiio
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBoiio
[
5
:
0
]
<=
#
CORETSE_AHBIoII
6
'h
0
;
else
CORETSE_AHBoiio
[
5
:
0
]
<=
#
CORETSE_AHBIoII
CORETSE_AHBliio
;
end
assign
CORETSE_AHBiiio
=
&
CORETSE_AHBoiio
[
5
:
0
]
;
assign
CORETSE_AHBOOOi
=
CORETSE_AHBIoio
&
(
(
(
CORETSE_AHBoiio
==
6
'h
00
)
&
CORETSE_AHBiOOo
)
|
(
(
CORETSE_AHBoiio
==
6
'h
20
)
&
~
CORETSE_AHBiOOo
)
)
;
assign
CORETSE_AHBIOOi
=
CORETSE_AHBIoio
&
CORETSE_AHBoiio
==
6
'h
28
;
assign
CORETSE_AHBlOOi
=
CORETSE_AHBIoio
&
CORETSE_AHBIiio
&
CORETSE_AHBoiio
==
6
'h
30
;
assign
CORETSE_AHBoOOi
=
CORETSE_AHBIoio
&
CORETSE_AHBIiio
&
CORETSE_AHBoiio
==
6
'h
38
;
assign
CORETSE_AHBiOOi
=
CORETSE_AHBOOOi
|
CORETSE_AHBIOOi
|
CORETSE_AHBlOOi
|
CORETSE_AHBoOOi
;
assign
CORETSE_AHBOIOi
=
{
8
{
CORETSE_AHBlioo
&
CORETSE_AHBiOOi
&
CORETSE_AHBoOOi
}
}
&
CORETSE_AHBiIOo
[
7
:
0
]
|
{
8
{
CORETSE_AHBlioo
&
CORETSE_AHBiOOi
&
CORETSE_AHBlOOi
}
}
&
CORETSE_AHBiIOo
[
15
:
8
]
|
{
8
{
CORETSE_AHBlioo
&
CORETSE_AHBiOOi
&
CORETSE_AHBIOOi
}
}
&
{
CORETSE_AHBi0Oi
[
0
]
,
CORETSE_AHBlIOo
[
4
:
0
]
,
2
'b
10
}
|
{
8
{
CORETSE_AHBlioo
&
CORETSE_AHBiOOi
&
CORETSE_AHBOOOi
}
}
&
{
2
'b
01
,
~
CORETSE_AHBIiio
,
CORETSE_AHBIiio
,
CORETSE_AHBi0Oi
[
4
:
1
]
}
|
{
8
{
CORETSE_AHBlioo
&
~
CORETSE_AHBiOOi
}
}
&
{
CORETSE_AHBIIOi
[
6
:
0
]
,
CORETSE_AHBo01
}
|
{
8
{
~
CORETSE_AHBlioo
}
}
&
CORETSE_AHBIIOi
[
7
:
0
]
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBIIOi
[
7
:
0
]
<=
#
CORETSE_AHBIoII
8
'h
0
;
else
CORETSE_AHBIIOi
[
7
:
0
]
<=
#
CORETSE_AHBIoII
CORETSE_AHBOIOi
[
7
:
0
]
;
end
assign
CORETSE_AHBo0Oi
=
{
5
{
(
CORETSE_AHBOIOo
&
CORETSE_AHBI0io
)
&
CORETSE_AHBIOOi
&
CORETSE_AHBlioo
&
CORETSE_AHBi0Oi
==
5
'h
1F
}
}
&
CORETSE_AHBIIOo
[
4
:
0
]
|
{
5
{
(
CORETSE_AHBOIOo
&
CORETSE_AHBI0io
)
&
CORETSE_AHBIOOi
&
CORETSE_AHBlioo
&
CORETSE_AHBi0Oi
!=
5
'h
1F
}
}
&
CORETSE_AHBi0Oi
[
4
:
0
]
+
5
'h
1
|
{
5
{
(
CORETSE_AHBOIOo
&
CORETSE_AHBI0io
)
&
CORETSE_AHBIOOi
&
~
CORETSE_AHBlioo
}
}
&
CORETSE_AHBi0Oi
[
4
:
0
]
|
{
5
{
(
CORETSE_AHBOIOo
&
CORETSE_AHBI0io
)
&
~
CORETSE_AHBIOOi
}
}
&
CORETSE_AHBi0Oi
[
4
:
0
]
|
{
5
{
~
(
CORETSE_AHBOIOo
&
CORETSE_AHBI0io
)
}
}
&
CORETSE_AHBIIOo
[
4
:
0
]
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBi0Oi
[
4
:
0
]
<=
#
CORETSE_AHBIoII
5
'h
0
;
else
CORETSE_AHBi0Oi
[
4
:
0
]
<=
#
CORETSE_AHBIoII
CORETSE_AHBo0Oi
[
4
:
0
]
;
end
assign
CORETSE_AHBO1Oi
=
{
5
{
CORETSE_AHBI0io
&
(
CORETSE_AHBOIOo
&
CORETSE_AHBIOOi
&
CORETSE_AHBlioo
)
}
}
&
CORETSE_AHBi0Oi
[
4
:
0
]
|
{
5
{
CORETSE_AHBI0io
&
~
(
CORETSE_AHBOIOo
&
CORETSE_AHBIOOi
&
CORETSE_AHBlioo
)
}
}
&
CORETSE_AHBOiOo
[
4
:
0
]
|
{
5
{
~
CORETSE_AHBI0io
}
}
&
CORETSE_AHBIIOo
[
4
:
0
]
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBOiOo
[
4
:
0
]
<=
#
CORETSE_AHBIoII
5
'h
0
;
else
CORETSE_AHBOiOo
[
4
:
0
]
<=
#
CORETSE_AHBIoII
CORETSE_AHBO1Oi
[
4
:
0
]
;
end
assign
CORETSE_AHBI1Oi
=
~
CORETSE_AHBl1Oi
&
CORETSE_AHBl0Oi
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBIiOo
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBIiOo
<=
#
CORETSE_AHBIoII
CORETSE_AHBI1Oi
;
end
assign
CORETSE_AHBlIOi
=
CORETSE_AHBIiio
&
CORETSE_AHBIoio
&
(
CORETSE_AHBoiio
[
5
]
|
(
(
CORETSE_AHBoiio
==
6
'h
0
)
&
CORETSE_AHBiOOo
)
)
|
~
CORETSE_AHBIiio
&
CORETSE_AHBIoio
&
(
(
CORETSE_AHBoiio
[
5
]
&
~
CORETSE_AHBoiio
[
4
]
&
~&
CORETSE_AHBoiio
[
3
:
1
]
)
|
(
(
CORETSE_AHBoiio
==
6
'h
0
)
&
CORETSE_AHBiOOo
)
)
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBoIOi
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
if
(
CORETSE_AHBlioo
)
CORETSE_AHBoIOi
<=
#
CORETSE_AHBIoII
CORETSE_AHBlIOi
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBiIOi
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
if
(
CORETSE_AHBlioo
)
CORETSE_AHBiIOi
<=
#
CORETSE_AHBIoII
CORETSE_AHBlIOi
|
CORETSE_AHBIoio
&
~
CORETSE_AHBoiio
[
5
]
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBOlOi
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBOlOi
<=
#
CORETSE_AHBIoII
CORETSE_AHBiIOi
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBI11
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBI11
<=
#
CORETSE_AHBIoII
CORETSE_AHBOlOi
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBIlOi
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBIlOi
<=
#
CORETSE_AHBIoII
CORETSE_AHBIIOi
[
7
]
|
~
CORETSE_AHBoIOi
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBO11
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBO11
<=
#
CORETSE_AHBIoII
CORETSE_AHBIlOi
;
end
assign
CORETSE_AHBllOi
=
CORETSE_AHBIoio
&
~
CORETSE_AHBIiio
&
CORETSE_AHBoiio
==
6
'h
37
;
assign
CORETSE_AHBolOi
=
CORETSE_AHBIoio
&
~
CORETSE_AHBIiio
&
CORETSE_AHBoiio
==
6
'h
3F
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBilOi
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
if
(
CORETSE_AHBlioo
)
CORETSE_AHBilOi
<=
#
CORETSE_AHBIoII
CORETSE_AHBllOi
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBO0Oi
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
if
(
CORETSE_AHBlioo
)
CORETSE_AHBO0Oi
<=
#
CORETSE_AHBIoII
CORETSE_AHBolOi
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBI0Oi
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
if
(
CORETSE_AHBlioo
)
CORETSE_AHBI0Oi
<=
#
CORETSE_AHBIoII
CORETSE_AHBilOi
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBl0Oi
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
if
(
CORETSE_AHBlioo
)
CORETSE_AHBl0Oi
<=
#
CORETSE_AHBIoII
CORETSE_AHBO0Oi
;
end
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBl1Oi
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBl1Oi
<=
#
CORETSE_AHBIoII
CORETSE_AHBl0Oi
;
end
assign
CORETSE_AHBlOio
=
{
8
{
CORETSE_AHBl0Oi
}
}
&
CORETSE_AHBIIOi
[
7
:
0
]
|
{
8
{
~
CORETSE_AHBl0Oi
}
}
&
CORETSE_AHBOIi1
[
7
:
0
]
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBOIi1
[
7
:
0
]
<=
#
CORETSE_AHBIoII
8
'h
0
;
else
CORETSE_AHBOIi1
[
7
:
0
]
<=
#
CORETSE_AHBIoII
CORETSE_AHBlOio
;
end
assign
CORETSE_AHBoOio
=
{
8
{
CORETSE_AHBI0Oi
}
}
&
CORETSE_AHBIIOi
[
7
:
0
]
|
{
8
{
~
CORETSE_AHBI0Oi
}
}
&
CORETSE_AHBOIi1
[
15
:
8
]
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBOIi1
[
15
:
8
]
<=
#
CORETSE_AHBIoII
8
'h
0
;
else
CORETSE_AHBOIi1
[
15
:
8
]
<=
#
CORETSE_AHBIoII
CORETSE_AHBoOio
;
end
assign
CORETSE_AHBIOio
=
{
(
CORETSE_AHBl0Oi
&
CORETSE_AHBlIOo
==
5
'h
01
)
}
&
~
CORETSE_AHBIIOi
[
2
]
|
{
~
(
CORETSE_AHBl0Oi
&
CORETSE_AHBlIOo
==
5
'h
01
)
}
&
CORETSE_AHBIIi1
;
always
@
(
posedge
CORETSE_AHBio11
or
posedge
CORETSE_AHBO1Oo
)
begin
if
(
CORETSE_AHBO1Oo
)
CORETSE_AHBIIi1
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBIIi1
<=
#
CORETSE_AHBIoII
CORETSE_AHBIOio
;
end
endmodule
