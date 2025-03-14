// REVISION    : $Revision: 1.2 $
// Mentor Graphics Corporation Proprietary and Confidential
// Copyright 2007 Mentor Graphics Corporation and Licensors
`timescale 1ps/1ps
module
t8b10b
(
CORETSE_AHBiio
,
CORETSE_AHBIi0II
,
CORETSE_AHBli0II
,
CORETSE_AHBIO1II
,
CORETSE_AHBoi0II
)
;
input
[
7
:
0
]
CORETSE_AHBiio
;
input
[
3
:
0
]
CORETSE_AHBIi0II
;
input
CORETSE_AHBli0II
;
output
[
9
:
0
]
CORETSE_AHBIO1II
;
output
CORETSE_AHBoi0II
;
wire
[
9
:
0
]
CORETSE_AHBIO1II
;
wire
CORETSE_AHBoi0II
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
CORETSE_AHBl00oI
;
wire
[
2
:
0
]
CORETSE_AHBo00oI
;
reg
[
5
:
0
]
CORETSE_AHBi00oI
;
reg
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
;
reg
[
1
:
0
]
CORETSE_AHBI10oI
;
reg
[
3
:
0
]
CORETSE_AHBl10oI
;
reg
CORETSE_AHBo10oI
,
CORETSE_AHBi10oI
,
CORETSE_AHBOo0oI
;
reg
CORETSE_AHBIo0oI
;
reg
[
9
:
0
]
CORETSE_AHBlo0oI
;
assign
CORETSE_AHBl00oI
=
CORETSE_AHBiio
[
4
:
0
]
;
always
@
(
CORETSE_AHBiio
[
4
:
0
]
)
case
(
{
CORETSE_AHBiio
[
4
]
,
CORETSE_AHBiio
[
3
]
,
CORETSE_AHBiio
[
2
]
,
CORETSE_AHBiio
[
1
]
,
CORETSE_AHBiio
[
0
]
}
)
5
'b
00000
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
100111_0_0_00
;
5
'b
00001
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
011101_0_0_00
;
5
'b
00010
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
101101_0_0_00
;
5
'b
00011
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
110001_1_1_00
;
5
'b
00100
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
110101_0_0_00
;
5
'b
00101
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
101001_1_1_00
;
5
'b
00110
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
011001_1_1_00
;
5
'b
00111
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
111000_1_0_00
;
5
'b
01000
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
111001_0_0_00
;
5
'b
01001
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
100101_1_1_00
;
5
'b
01010
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
010101_1_1_00
;
5
'b
01011
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
110100_1_1_01
;
5
'b
01100
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
001101_1_1_00
;
5
'b
01101
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
101100_1_1_01
;
5
'b
01110
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
011100_1_1_01
;
5
'b
01111
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
010111_0_0_00
;
5
'b
10000
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
011011_0_0_00
;
5
'b
10001
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
100011_1_1_10
;
5
'b
10010
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
010011_1_1_10
;
5
'b
10011
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
110010_1_1_00
;
5
'b
10100
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
001011_1_1_10
;
5
'b
10101
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
101010_1_1_00
;
5
'b
10110
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
011010_1_1_00
;
5
'b
10111
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
111010_0_0_00
;
5
'b
11000
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
110011_0_0_00
;
5
'b
11001
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
100110_1_1_00
;
5
'b
11010
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
010110_1_1_00
;
5
'b
11011
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
110110_0_0_00
;
5
'b
11100
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
001110_1_1_00
;
5
'b
11101
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
101110_0_0_00
;
5
'b
11110
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
011110_0_0_00
;
5
'b
11111
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
101011_0_0_00
;
default
:
{
CORETSE_AHBi00oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBO10oI
,
CORETSE_AHBI10oI
}
=
10
'b
000000_0_0_00
;
endcase
assign
CORETSE_AHBo00oI
=
CORETSE_AHBiio
[
7
:
5
]
;
always
@
(
CORETSE_AHBiio
[
7
:
5
]
)
case
(
{
CORETSE_AHBiio
[
7
]
,
CORETSE_AHBiio
[
6
]
,
CORETSE_AHBiio
[
5
]
}
)
3
'b
000
:
{
CORETSE_AHBl10oI
,
CORETSE_AHBo10oI
,
CORETSE_AHBi10oI
,
CORETSE_AHBOo0oI
}
=
7
'b
0100_1_0_0
;
3
'b
001
:
{
CORETSE_AHBl10oI
,
CORETSE_AHBo10oI
,
CORETSE_AHBi10oI
,
CORETSE_AHBOo0oI
}
=
7
'b
1001_0_1_0
;
3
'b
010
:
{
CORETSE_AHBl10oI
,
CORETSE_AHBo10oI
,
CORETSE_AHBi10oI
,
CORETSE_AHBOo0oI
}
=
7
'b
0101_0_1_0
;
3
'b
011
:
{
CORETSE_AHBl10oI
,
CORETSE_AHBo10oI
,
CORETSE_AHBi10oI
,
CORETSE_AHBOo0oI
}
=
7
'b
0011_1_1_0
;
3
'b
100
:
{
CORETSE_AHBl10oI
,
CORETSE_AHBo10oI
,
CORETSE_AHBi10oI
,
CORETSE_AHBOo0oI
}
=
7
'b
0010_1_0_0
;
3
'b
101
:
{
CORETSE_AHBl10oI
,
CORETSE_AHBo10oI
,
CORETSE_AHBi10oI
,
CORETSE_AHBOo0oI
}
=
7
'b
1010_0_1_0
;
3
'b
110
:
{
CORETSE_AHBl10oI
,
CORETSE_AHBo10oI
,
CORETSE_AHBi10oI
,
CORETSE_AHBOo0oI
}
=
7
'b
0110_0_1_0
;
3
'b
111
:
{
CORETSE_AHBl10oI
,
CORETSE_AHBo10oI
,
CORETSE_AHBi10oI
,
CORETSE_AHBOo0oI
}
=
7
'b
0001_1_0_1
;
default
:
{
CORETSE_AHBl10oI
,
CORETSE_AHBo10oI
,
CORETSE_AHBi10oI
,
CORETSE_AHBOo0oI
}
=
7
'b
0000_0_0_0
;
endcase
// Reversal of ten bit symbols by tdi are blocked corresponding
always
@
(
CORETSE_AHBli0II
or
CORETSE_AHBO10oI
or
CORETSE_AHBIi0II
or
CORETSE_AHBi00oI
)
casex
(
{
CORETSE_AHBli0II
,
CORETSE_AHBO10oI
,
CORETSE_AHBIi0II
}
)
6
'b
0_x_1000
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
11_0110
;
6
'b
1_x_1000
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
00_1001
;
6
'b
0_x_1001
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
01_1110
;
6
'b
1_x_1001
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
10_0001
;
6
'b
0_x_1010
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
10_1110
;
6
'b
1_x_1010
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
01_0001
;
6
'b
0_x_1011
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
11_1010
;
6
'b
1_x_1011
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
00_0101
;
6
'b
0_x_1100
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
00_1111
;
6
'b
1_x_1100
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
11_0000
;
6
'b
x_x_1110
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
10_1010
;
6
'b
0_x_1111
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
10_1101
;
6
'b
1_x_1111
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
01_0010
;
6
'b
x_x_0000
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
10_1001
;
6
'b
0_x_0001
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
01_1011
;
6
'b
1_x_0001
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
10_0100
;
6
'b
x_x_0010
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
01_1001
;
6
'b
X_x_0011
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
01_0110
;
6
'b
0_x_1101
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
CORETSE_AHBi00oI
;
6
'b
1_0_1101
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
~
CORETSE_AHBi00oI
;
6
'b
1_1_1101
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
CORETSE_AHBi00oI
;
default
:
CORETSE_AHBlo0oI
[
5
:
0
]
=
6
'b
00_0000
;
endcase
always
@
(
CORETSE_AHBli0II
or
CORETSE_AHBo10oI
or
CORETSE_AHBoOOoI
or
CORETSE_AHBIi0II
or
CORETSE_AHBl10oI
or
CORETSE_AHBOo0oI
or
CORETSE_AHBI10oI
)
casex
(
{
CORETSE_AHBli0II
,
CORETSE_AHBo10oI
,
CORETSE_AHBoOOoI
,
CORETSE_AHBIi0II
,
CORETSE_AHBOo0oI
,
CORETSE_AHBI10oI
}
)
10
'b
0_x_x_1000_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
10_00
;
10
'b
1_x_x_1000_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
01_11
;
10
'b
0_x_x_1001_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
10_00
;
10
'b
1_x_x_1001_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
01_11
;
10
'b
0_x_x_1010_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
10_00
;
10
'b
1_x_x_1010_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
01_11
;
10
'b
0_x_x_1011_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
10_00
;
10
'b
1_x_x_1011_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
01_11
;
10
'b
0_x_x_1100_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
10_10
;
10
'b
1_x_x_1100_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
01_01
;
10
'b
x_x_x_1110_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
10_10
;
10
'b
x_x_x_1111_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
01_01
;
10
'b
x_x_x_0000_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
01_10
;
10
'b
x_x_x_0001_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
01_01
;
10
'b
x_x_x_0010_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
10_10
;
10
'b
0_x_x_0011_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
11_01
;
10
'b
1_x_x_0011_x_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
00_10
;
10
'b
0_0_x_1101_0_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
CORETSE_AHBl10oI
;
10
'b
0_0_x_1101_x_00
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
CORETSE_AHBl10oI
;
10
'b
0_0_x_1101_1_x1
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
CORETSE_AHBl10oI
;
10
'b
0_0_x_1101_1_10
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
0111
;
10
'b
0_x_0_1101_0_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
CORETSE_AHBl10oI
;
10
'b
0_x_0_1101_x_00
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
CORETSE_AHBl10oI
;
10
'b
0_x_0_1101_1_x1
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
CORETSE_AHBl10oI
;
10
'b
0_x_0_1101_1_10
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
0111
;
10
'b
0_1_1_1101_0_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
~
CORETSE_AHBl10oI
;
10
'b
0_1_1_1101_x_00
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
~
CORETSE_AHBl10oI
;
10
'b
0_1_1_1101_1_x1
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
~
CORETSE_AHBl10oI
;
10
'b
0_1_1_1101_1_10
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
0111
;
10
'b
1_0_x_1101_0_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
CORETSE_AHBl10oI
;
10
'b
1_0_x_1101_x_00
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
CORETSE_AHBl10oI
;
10
'b
1_0_x_1101_1_1x
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
CORETSE_AHBl10oI
;
10
'b
1_0_x_1101_1_01
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
1000
;
10
'b
1_1_0_1101_0_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
~
CORETSE_AHBl10oI
;
10
'b
1_1_0_1101_x_00
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
~
CORETSE_AHBl10oI
;
10
'b
1_1_0_1101_1_1x
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
~
CORETSE_AHBl10oI
;
10
'b
1_1_0_1101_1_01
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
1000
;
10
'b
1_1_1_1101_0_xx
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
CORETSE_AHBl10oI
;
10
'b
1_1_1_1101_x_00
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
CORETSE_AHBl10oI
;
10
'b
1_1_1_1101_1_1x
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
CORETSE_AHBl10oI
;
10
'b
1_1_1_1101_1_01
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
1000
;
default
:
CORETSE_AHBlo0oI
[
9
:
6
]
=
4
'b
0000
;
endcase
assign
CORETSE_AHBIO1II
=
{
CORETSE_AHBlo0oI
[
6
]
,
CORETSE_AHBlo0oI
[
7
]
,
CORETSE_AHBlo0oI
[
8
]
,
CORETSE_AHBlo0oI
[
9
]
,
CORETSE_AHBlo0oI
[
0
]
,
CORETSE_AHBlo0oI
[
1
]
,
CORETSE_AHBlo0oI
[
2
]
,
CORETSE_AHBlo0oI
[
3
]
,
CORETSE_AHBlo0oI
[
4
]
,
CORETSE_AHBlo0oI
[
5
]
}
;
always
@
(
CORETSE_AHBIi0II
or
CORETSE_AHBi10oI
or
CORETSE_AHBoOOoI
)
casex
(
{
CORETSE_AHBIi0II
}
)
4
'b
1000
:
CORETSE_AHBIo0oI
=
1
'b
0
;
4
'b
1001
:
CORETSE_AHBIo0oI
=
1
'b
0
;
4
'b
1010
:
CORETSE_AHBIo0oI
=
1
'b
0
;
4
'b
1011
:
CORETSE_AHBIo0oI
=
1
'b
0
;
4
'b
1100
:
CORETSE_AHBIo0oI
=
1
'b
1
;
4
'b
1110
:
CORETSE_AHBIo0oI
=
1
'b
0
;
4
'b
1111
:
CORETSE_AHBIo0oI
=
1
'b
1
;
4
'b
0000
:
CORETSE_AHBIo0oI
=
1
'b
0
;
4
'b
0001
:
CORETSE_AHBIo0oI
=
1
'b
1
;
4
'b
1101
:
CORETSE_AHBIo0oI
=
CORETSE_AHBi10oI
^
CORETSE_AHBoOOoI
;
default
:
CORETSE_AHBIo0oI
=
1
'b
0
;
endcase
assign
CORETSE_AHBoi0II
=
CORETSE_AHBIo0oI
;
endmodule
