// REVISION    : $Revision: 1.5 $
//              Mentor Proprietary and Confidential
//              Copyright (c) 2000, Mentor Intellectual Property Development
`timescale 1ns/1ns
module
pemstat_cntrl
(
CORETSE_AHBo1Oi
,
CORETSE_AHBi1Oi
,
CORETSE_AHBl1o
,
CORETSE_AHBo1o
,
CORETSE_AHBlOo1
,
CORETSE_AHBIOo1
,
CORETSE_AHBOoOi
,
CORETSE_AHBIoOi
,
CORETSE_AHBloOi
,
CORETSE_AHBOiOi
,
CORETSE_AHBIiOi
,
CORETSE_AHBiOIi
,
CORETSE_AHBOIIi
,
CORETSE_AHBIIIi
)
;
input
CORETSE_AHBo1Oi
,
CORETSE_AHBi1Oi
;
input
CORETSE_AHBo1o
;
input
[
30
:
0
]
CORETSE_AHBl1o
;
input
CORETSE_AHBIOo1
;
input
[
51
:
0
]
CORETSE_AHBlOo1
;
input
CORETSE_AHBOoOi
,
CORETSE_AHBIoOi
;
input
CORETSE_AHBloOi
;
input
CORETSE_AHBOiOi
;
input
CORETSE_AHBIiOi
;
output
[
15
:
0
]
CORETSE_AHBiOIi
;
output
[
3
:
0
]
CORETSE_AHBOIIi
;
output
[
43
:
0
]
CORETSE_AHBIIIi
;
parameter
CORETSE_AHBIoII
=
1
;
wire
CORETSE_AHBi1li
,
CORETSE_AHBOoli
;
reg
CORETSE_AHBIoli
,
CORETSE_AHBloli
,
CORETSE_AHBooli
,
CORETSE_AHBioli
,
CORETSE_AHBOili
;
reg
CORETSE_AHBOOoI
,
CORETSE_AHBIili
,
CORETSE_AHBlili
,
CORETSE_AHBoili
,
CORETSE_AHBiili
;
wire
CORETSE_AHBOO0i
,
CORETSE_AHBIO0i
;
reg
CORETSE_AHBlO0i
,
CORETSE_AHBoO0i
;
wire
[
43
:
0
]
CORETSE_AHBiO0i
;
reg
[
43
:
0
]
CORETSE_AHBIIIi
;
wire
[
15
:
0
]
CORETSE_AHBOI0i
;
reg
[
15
:
0
]
CORETSE_AHBiOIi
;
reg
[
3
:
0
]
CORETSE_AHBOIIi
;
wire
CORETSE_AHBII0i
;
always
@
(
posedge
CORETSE_AHBo1Oi
or
posedge
CORETSE_AHBi1Oi
)
begin
if
(
CORETSE_AHBi1Oi
)
CORETSE_AHBooli
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBooli
<=
#
CORETSE_AHBIoII
CORETSE_AHBIOo1
;
end
always
@
(
posedge
CORETSE_AHBo1Oi
or
posedge
CORETSE_AHBi1Oi
)
begin
if
(
CORETSE_AHBi1Oi
)
CORETSE_AHBioli
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBioli
<=
#
CORETSE_AHBIoII
CORETSE_AHBooli
;
end
always
@
(
posedge
CORETSE_AHBo1Oi
or
posedge
CORETSE_AHBi1Oi
)
begin
if
(
CORETSE_AHBi1Oi
)
CORETSE_AHBOili
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBOili
<=
#
CORETSE_AHBIoII
CORETSE_AHBioli
;
end
always
@
(
posedge
CORETSE_AHBo1Oi
or
posedge
CORETSE_AHBi1Oi
)
begin
if
(
CORETSE_AHBi1Oi
)
CORETSE_AHBlili
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBlili
<=
#
CORETSE_AHBIoII
CORETSE_AHBo1o
;
end
always
@
(
posedge
CORETSE_AHBo1Oi
or
posedge
CORETSE_AHBi1Oi
)
begin
if
(
CORETSE_AHBi1Oi
)
CORETSE_AHBoili
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBoili
<=
#
CORETSE_AHBIoII
CORETSE_AHBlili
;
end
always
@
(
posedge
CORETSE_AHBo1Oi
or
posedge
CORETSE_AHBi1Oi
)
begin
if
(
CORETSE_AHBi1Oi
)
CORETSE_AHBiili
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBiili
<=
#
CORETSE_AHBIoII
CORETSE_AHBoili
;
end
assign
CORETSE_AHBOO0i
=
CORETSE_AHBooli
&
~
CORETSE_AHBioli
&
CORETSE_AHBOiOi
;
assign
CORETSE_AHBIO0i
=
(
~
CORETSE_AHBOO0i
&
CORETSE_AHBlili
&
~
CORETSE_AHBoili
&
CORETSE_AHBOiOi
)
|
(
CORETSE_AHBioli
&
~
CORETSE_AHBOili
&
CORETSE_AHBoili
&
~
CORETSE_AHBiili
&
CORETSE_AHBOiOi
)
;
always
@
(
posedge
CORETSE_AHBo1Oi
or
posedge
CORETSE_AHBi1Oi
)
begin
if
(
CORETSE_AHBi1Oi
)
CORETSE_AHBlO0i
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBlO0i
<=
#
CORETSE_AHBIoII
CORETSE_AHBloOi
;
end
always
@
(
posedge
CORETSE_AHBo1Oi
or
posedge
CORETSE_AHBi1Oi
)
begin
if
(
CORETSE_AHBi1Oi
)
CORETSE_AHBoO0i
<=
#
CORETSE_AHBIoII
1
'b
0
;
else
CORETSE_AHBoO0i
<=
#
CORETSE_AHBIoII
CORETSE_AHBlO0i
;
end
assign
CORETSE_AHBOI0i
=
{
16
{
CORETSE_AHBOO0i
}
}
&
CORETSE_AHBlOo1
[
15
:
0
]
|
{
16
{
CORETSE_AHBIO0i
}
}
&
CORETSE_AHBl1o
[
15
:
0
]
;
assign
CORETSE_AHBII0i
=
(
|
CORETSE_AHBl1o
[
29
:
23
]
|
CORETSE_AHBl1o
[
21
]
|
CORETSE_AHBl1o
[
19
]
)
&
~
CORETSE_AHBl1o
[
20
]
&
~
(
(
~
CORETSE_AHBl1o
[
30
]
&
(
CORETSE_AHBl1o
[
15
:
0
]
>
2000
)
)
|
(
CORETSE_AHBl1o
[
30
]
&
(
CORETSE_AHBl1o
[
15
:
0
]
>
2000
)
)
)
;
assign
CORETSE_AHBiO0i
[
00
]
=
(
64
==
CORETSE_AHBOI0i
)
;
assign
CORETSE_AHBiO0i
[
01
]
=
(
65
<=
CORETSE_AHBOI0i
)
&
(
CORETSE_AHBOI0i
<=
127
)
;
assign
CORETSE_AHBiO0i
[
02
]
=
(
128
<=
CORETSE_AHBOI0i
)
&
(
CORETSE_AHBOI0i
<=
255
)
;
assign
CORETSE_AHBiO0i
[
03
]
=
(
256
<=
CORETSE_AHBOI0i
)
&
(
CORETSE_AHBOI0i
<=
511
)
;
assign
CORETSE_AHBiO0i
[
04
]
=
(
512
<=
CORETSE_AHBOI0i
)
&
(
CORETSE_AHBOI0i
<=
1023
)
;
assign
CORETSE_AHBiO0i
[
05
]
=
(
1024
<=
CORETSE_AHBOI0i
)
&
(
CORETSE_AHBOI0i
<=
1518
)
;
assign
CORETSE_AHBiO0i
[
06
]
=
CORETSE_AHBIO0i
&
(
CORETSE_AHBl1o
[
30
]
&
1519
<=
CORETSE_AHBOI0i
)
&
(
CORETSE_AHBOI0i
<=
1522
)
&
~
CORETSE_AHBl1o
[
20
]
&
(
~
CORETSE_AHBIiOi
|
~
CORETSE_AHBl1o
[
19
]
)
|
CORETSE_AHBOO0i
&
(
(
(
CORETSE_AHBlOo1
[
51
]
&
~
CORETSE_AHBIiOi
)
|
(
CORETSE_AHBlOo1
[
50
]
&
CORETSE_AHBIiOi
)
)
&
1519
<=
CORETSE_AHBOI0i
)
&
(
CORETSE_AHBOI0i
<=
1522
)
&
~
CORETSE_AHBlOo1
[
20
]
;
assign
CORETSE_AHBiO0i
[
07
]
=
CORETSE_AHBIO0i
;
assign
CORETSE_AHBiO0i
[
08
]
=
CORETSE_AHBIO0i
;
assign
CORETSE_AHBiO0i
[
09
]
=
(
~
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
CORETSE_AHBl1o
[
20
]
&
~
CORETSE_AHBl1o
[
26
]
&
(
64
<=
CORETSE_AHBl1o
[
15
:
0
]
)
&
(
CORETSE_AHBl1o
[
15
:
0
]
<=
1518
)
)
|
(
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
CORETSE_AHBl1o
[
20
]
&
|
CORETSE_AHBiO0i
[
6
:
0
]
)
;
assign
CORETSE_AHBiO0i
[
10
]
=
(
~
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
CORETSE_AHBII0i
&
CORETSE_AHBl1o
[
24
]
)
|
(
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
|
CORETSE_AHBiO0i
[
6
:
0
]
&
~
CORETSE_AHBl1o
[
20
]
&
~
CORETSE_AHBl1o
[
19
]
&
CORETSE_AHBl1o
[
24
]
)
;
assign
CORETSE_AHBiO0i
[
11
]
=
(
~
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
CORETSE_AHBII0i
&
CORETSE_AHBl1o
[
25
]
)
|
(
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
|
CORETSE_AHBiO0i
[
6
:
0
]
&
~
CORETSE_AHBl1o
[
20
]
&
~
CORETSE_AHBl1o
[
19
]
&
CORETSE_AHBl1o
[
25
]
)
;
assign
CORETSE_AHBiO0i
[
12
]
=
(
~
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
CORETSE_AHBII0i
&
CORETSE_AHBl1o
[
27
]
)
|
(
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
|
CORETSE_AHBiO0i
[
6
:
0
]
&
~
CORETSE_AHBl1o
[
20
]
&
~
CORETSE_AHBl1o
[
19
]
&
CORETSE_AHBl1o
[
27
]
)
;
assign
CORETSE_AHBiO0i
[
13
]
=
(
~
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
CORETSE_AHBl1o
[
28
]
)
|
(
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
CORETSE_AHBl1o
[
28
]
&
~
CORETSE_AHBl1o
[
20
]
&
~
CORETSE_AHBl1o
[
19
]
&
|
CORETSE_AHBiO0i
[
6
:
0
]
)
;
assign
CORETSE_AHBiO0i
[
14
]
=
(
~
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
CORETSE_AHBl1o
[
29
]
)
|
(
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
|
CORETSE_AHBiO0i
[
6
:
0
]
&
~
CORETSE_AHBl1o
[
20
]
&
~
CORETSE_AHBl1o
[
19
]
&
CORETSE_AHBl1o
[
29
]
)
;
assign
CORETSE_AHBiO0i
[
15
]
=
CORETSE_AHBIO0i
&
CORETSE_AHBl1o
[
20
]
&
CORETSE_AHBl1o
[
26
]
&
(
64
<=
CORETSE_AHBl1o
[
15
:
0
]
)
&
(
CORETSE_AHBl1o
[
15
:
0
]
<=
1518
)
;
assign
CORETSE_AHBiO0i
[
16
]
=
(
~
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
CORETSE_AHBl1o
[
21
]
)
|
(
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
CORETSE_AHBl1o
[
21
]
&
~
CORETSE_AHBl1o
[
20
]
&
~
CORETSE_AHBl1o
[
19
]
&
(
64
<=
CORETSE_AHBl1o
[
15
:
0
]
)
&
(
(
~
CORETSE_AHBl1o
[
30
]
&
(
CORETSE_AHBl1o
[
15
:
0
]
<=
1518
)
)
|
(
CORETSE_AHBl1o
[
30
]
&
(
CORETSE_AHBl1o
[
15
:
0
]
<=
1522
)
)
)
)
;
assign
CORETSE_AHBiO0i
[
17
]
=
CORETSE_AHBIO0i
&
CORETSE_AHBl1o
[
19
]
;
assign
CORETSE_AHBiO0i
[
18
]
=
CORETSE_AHBIO0i
&
CORETSE_AHBl1o
[
18
]
;
assign
CORETSE_AHBiO0i
[
19
]
=
(
~
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
(
16
'd
64
>
CORETSE_AHBl1o
[
15
:
0
]
)
&
~
CORETSE_AHBl1o
[
20
]
)
|
(
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
(
16
'd
64
>
CORETSE_AHBl1o
[
15
:
0
]
)
&
~
CORETSE_AHBl1o
[
20
]
&
~
CORETSE_AHBl1o
[
19
]
)
;
assign
CORETSE_AHBiO0i
[
20
]
=
CORETSE_AHBIO0i
&
~
CORETSE_AHBl1o
[
20
]
&
(
(
~
CORETSE_AHBl1o
[
30
]
&
(
CORETSE_AHBl1o
[
15
:
0
]
>
1518
)
)
|
(
CORETSE_AHBl1o
[
30
]
&
(
CORETSE_AHBl1o
[
15
:
0
]
>
1522
)
)
)
;
assign
CORETSE_AHBiO0i
[
21
]
=
(
~
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
(
16
'd
64
>
CORETSE_AHBl1o
[
15
:
0
]
)
&
CORETSE_AHBl1o
[
20
]
)
|
(
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
(
16
'd
64
>
CORETSE_AHBl1o
[
15
:
0
]
)
&
(
CORETSE_AHBl1o
[
20
]
|
CORETSE_AHBl1o
[
19
]
)
)
;
assign
CORETSE_AHBiO0i
[
22
]
=
(
~
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
CORETSE_AHBl1o
[
20
]
&
(
(
~
CORETSE_AHBl1o
[
30
]
&
(
CORETSE_AHBl1o
[
15
:
0
]
>
1518
)
)
|
(
CORETSE_AHBl1o
[
30
]
&
(
CORETSE_AHBl1o
[
15
:
0
]
>
1522
)
)
)
)
|
(
CORETSE_AHBIiOi
&
CORETSE_AHBIO0i
&
(
CORETSE_AHBl1o
[
20
]
|
CORETSE_AHBl1o
[
19
]
)
&
(
(
~
CORETSE_AHBl1o
[
30
]
&
(
CORETSE_AHBl1o
[
15
:
0
]
>
1518
)
)
|
(
CORETSE_AHBl1o
[
30
]
&
(
CORETSE_AHBl1o
[
15
:
0
]
>
1522
)
)
)
)
;
assign
CORETSE_AHBiO0i
[
23
]
=
CORETSE_AHBOoOi
&
CORETSE_AHBIO0i
&
~
CORETSE_AHBIIIi
[
23
]
;
assign
CORETSE_AHBiO0i
[
24
]
=
CORETSE_AHBOO0i
;
assign
CORETSE_AHBiO0i
[
25
]
=
CORETSE_AHBOO0i
;
assign
CORETSE_AHBiO0i
[
26
]
=
(
~
CORETSE_AHBIiOi
&
CORETSE_AHBOO0i
&
~
CORETSE_AHBlOo1
[
20
]
&
CORETSE_AHBlOo1
[
24
]
&
~
CORETSE_AHBlOo1
[
25
]
)
|
(
CORETSE_AHBIiOi
&
CORETSE_AHBOO0i
&
|
CORETSE_AHBiO0i
[
6
:
0
]
&
~
CORETSE_AHBlOo1
[
20
]
&
CORETSE_AHBlOo1
[
24
]
&
~
CORETSE_AHBlOo1
[
25
]
)
;
assign
CORETSE_AHBiO0i
[
27
]
=
(
~
CORETSE_AHBIiOi
&
CORETSE_AHBOO0i
&
~
CORETSE_AHBlOo1
[
20
]
&
CORETSE_AHBlOo1
[
24
]
&
CORETSE_AHBlOo1
[
25
]
)
|
(
CORETSE_AHBIiOi
&
CORETSE_AHBOO0i
&
|
CORETSE_AHBiO0i
[
6
:
0
]
&
~
CORETSE_AHBlOo1
[
20
]
&
CORETSE_AHBlOo1
[
24
]
&
CORETSE_AHBlOo1
[
25
]
)
;
assign
CORETSE_AHBiO0i
[
28
]
=
(
~
CORETSE_AHBIiOi
&
CORETSE_AHBOO0i
&
CORETSE_AHBlOo1
[
49
]
)
|
(
CORETSE_AHBIiOi
&
CORETSE_AHBOO0i
&
|
CORETSE_AHBiO0i
[
6
:
0
]
&
~
CORETSE_AHBlOo1
[
20
]
&
CORETSE_AHBlOo1
[
49
]
)
;
assign
CORETSE_AHBiO0i
[
29
]
=
CORETSE_AHBOO0i
&
CORETSE_AHBlOo1
[
26
]
;
assign
CORETSE_AHBiO0i
[
30
]
=
CORETSE_AHBOO0i
&
CORETSE_AHBlOo1
[
27
]
;
assign
CORETSE_AHBiO0i
[
31
]
=
CORETSE_AHBOO0i
&
~|
CORETSE_AHBlOo1
[
19
:
17
]
&
CORETSE_AHBlOo1
[
16
]
;
assign
CORETSE_AHBiO0i
[
32
]
=
CORETSE_AHBOO0i
&
|
CORETSE_AHBlOo1
[
19
:
17
]
;
assign
CORETSE_AHBiO0i
[
33
]
=
CORETSE_AHBOO0i
&
CORETSE_AHBlOo1
[
29
]
;
assign
CORETSE_AHBiO0i
[
34
]
=
CORETSE_AHBOO0i
&
CORETSE_AHBlOo1
[
28
]
;
assign
CORETSE_AHBiO0i
[
35
]
=
CORETSE_AHBOO0i
&
(
(
~|
CORETSE_AHBlOo1
[
19
:
17
]
&
CORETSE_AHBlOo1
[
16
]
)
|
(
|
CORETSE_AHBlOo1
[
19
:
17
]
)
)
;
assign
CORETSE_AHBiO0i
[
36
]
=
CORETSE_AHBoO0i
&
~
CORETSE_AHBIIIi
[
36
]
;
assign
CORETSE_AHBiO0i
[
37
]
=
CORETSE_AHBIoOi
&
CORETSE_AHBOO0i
;
assign
CORETSE_AHBiO0i
[
38
]
=
(
CORETSE_AHBOO0i
&
(
CORETSE_AHBOI0i
>
16
'd
1518
)
&
CORETSE_AHBlOo1
[
20
]
&
~
(
(
CORETSE_AHBlOo1
[
51
]
&
~
CORETSE_AHBIiOi
)
|
(
CORETSE_AHBlOo1
[
50
]
&
CORETSE_AHBIiOi
)
)
)
|
(
CORETSE_AHBOO0i
&
(
CORETSE_AHBOI0i
>
16
'd
1522
)
&
CORETSE_AHBlOo1
[
20
]
&
(
(
CORETSE_AHBlOo1
[
51
]
&
~
CORETSE_AHBIiOi
)
|
(
CORETSE_AHBlOo1
[
50
]
&
CORETSE_AHBIiOi
)
)
)
;
assign
CORETSE_AHBiO0i
[
39
]
=
CORETSE_AHBOO0i
&
CORETSE_AHBlOo1
[
20
]
&
(
~
CORETSE_AHBIiOi
|
(
(
64
<=
CORETSE_AHBlOo1
[
15
:
0
]
)
&
(
CORETSE_AHBlOo1
[
15
:
0
]
<=
1518
)
)
)
;
assign
CORETSE_AHBiO0i
[
40
]
=
(
~
CORETSE_AHBIiOi
&
CORETSE_AHBOO0i
&
CORETSE_AHBlOo1
[
48
]
)
|
(
CORETSE_AHBIiOi
&
CORETSE_AHBOO0i
&
|
CORETSE_AHBiO0i
[
6
:
0
]
&
~
CORETSE_AHBlOo1
[
20
]
&
CORETSE_AHBlOo1
[
48
]
)
;
assign
CORETSE_AHBiO0i
[
41
]
=
(
CORETSE_AHBOO0i
&
(
CORETSE_AHBOI0i
>
16
'd
1518
)
&
~
CORETSE_AHBlOo1
[
20
]
&
~
(
(
CORETSE_AHBlOo1
[
51
]
&
~
CORETSE_AHBIiOi
)
|
(
CORETSE_AHBlOo1
[
50
]
&
CORETSE_AHBIiOi
)
)
)
|
(
CORETSE_AHBOO0i
&
(
CORETSE_AHBOI0i
>
16
'd
1522
)
&
~
CORETSE_AHBlOo1
[
20
]
&
(
(
CORETSE_AHBlOo1
[
51
]
&
~
CORETSE_AHBIiOi
)
|
(
CORETSE_AHBlOo1
[
50
]
&
CORETSE_AHBIiOi
)
)
)
;
assign
CORETSE_AHBiO0i
[
42
]
=
CORETSE_AHBOO0i
&
CORETSE_AHBOI0i
<
16
'd
64
&
~
CORETSE_AHBlOo1
[
20
]
;
assign
CORETSE_AHBiO0i
[
43
]
=
CORETSE_AHBOO0i
&
CORETSE_AHBOI0i
<
16
'd
64
&
CORETSE_AHBlOo1
[
20
]
;
always
@
(
posedge
CORETSE_AHBo1Oi
or
posedge
CORETSE_AHBi1Oi
)
begin
if
(
CORETSE_AHBi1Oi
)
CORETSE_AHBIIIi
<=
#
CORETSE_AHBIoII
44
'h
0
;
else
CORETSE_AHBIIIi
<=
#
CORETSE_AHBIoII
CORETSE_AHBiO0i
;
end
always
@
(
posedge
CORETSE_AHBo1Oi
or
posedge
CORETSE_AHBi1Oi
)
begin
if
(
CORETSE_AHBi1Oi
)
CORETSE_AHBiOIi
<=
#
CORETSE_AHBIoII
16
'h
0
;
else
if
(
CORETSE_AHBOO0i
&
~
CORETSE_AHBIiOi
)
CORETSE_AHBiOIi
<=
#
CORETSE_AHBIoII
CORETSE_AHBlOo1
[
47
:
32
]
;
else
if
(
CORETSE_AHBOO0i
&
CORETSE_AHBIiOi
)
CORETSE_AHBiOIi
<=
#
CORETSE_AHBIoII
CORETSE_AHBlOo1
[
15
:
0
]
;
else
CORETSE_AHBiOIi
<=
#
CORETSE_AHBIoII
CORETSE_AHBl1o
[
15
:
0
]
;
end
always
@
(
posedge
CORETSE_AHBo1Oi
or
posedge
CORETSE_AHBi1Oi
)
begin
if
(
CORETSE_AHBi1Oi
)
CORETSE_AHBOIIi
<=
#
CORETSE_AHBIoII
4
'h
0
;
else
CORETSE_AHBOIIi
<=
#
CORETSE_AHBIoII
CORETSE_AHBlOo1
[
19
:
16
]
;
end
endmodule
