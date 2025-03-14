// VERSION     : $Revision: 1.15 $
//                   MENTOR Proprietary and Confidential
//                       Copyright (c) 2003, MENTOR
`timescale 1ns/1ns
module
pe_mcxmac_core
#
(
parameter
CORETSE_AHBlOI
=
1
'b
0
,
parameter
CORETSE_AHBoOI
=
1
'b
0
,
parameter
CORETSE_AHBiOI
=
1
'b
0
)
(
CORETSE_AHBiOO1
,
CORETSE_AHBo1Oo
,
CORETSE_AHBo111
,
CORETSE_AHBi1Oo
,
CORETSE_AHBiI
,
CORETSE_AHBlI
,
CORETSE_AHBIl
,
CORETSE_AHBol
,
CORETSE_AHBll
,
CORETSE_AHBiio
,
CORETSE_AHBiOi
,
CORETSE_AHBIIi
,
CORETSE_AHBOIi
,
CORETSE_AHBoOi
,
CORETSE_AHBlOi
,
CORETSE_AHBOOi
,
CORETSE_AHBoo11
,
CORETSE_AHBIOi
,
CORETSE_AHBlIi
,
CORETSE_AHBi111
,
CORETSE_AHBOoOo
,
CORETSE_AHBoo01
,
CORETSE_AHBIOOo
,
CORETSE_AHBOOOo
,
CORETSE_AHBio01
,
CORETSE_AHBoIi1
,
CORETSE_AHBiIi1
,
CORETSE_AHBll00
,
CORETSE_AHBl0i1
,
CORETSE_AHBo0i1
,
CORETSE_AHBIoOo
,
CORETSE_AHBlii1
,
CORETSE_AHBI1i1
,
CORETSE_AHBl1i1
,
CORETSE_AHBo1i1
,
CORETSE_AHBi1i1
,
CORETSE_AHBOoi1
,
CORETSE_AHBoii1
,
CORETSE_AHBiii1
,
CORETSE_AHBIoi1
,
CORETSE_AHBiIi
,
CORETSE_AHBioi1
,
CORETSE_AHBloOo
,
CORETSE_AHBi0i1
,
CORETSE_AHBIii1
,
CORETSE_AHBloi1
,
CORETSE_AHBo0Oo
,
CORETSE_AHBi0Oo
,
CORETSE_AHBIio1
,
CORETSE_AHBlio1
,
CORETSE_AHBlli1
,
CORETSE_AHBlOOo
,
CORETSE_AHBIli1
,
CORETSE_AHBOli1
,
CORETSE_AHBiii0
,
CORETSE_AHBolo
,
CORETSE_AHBOOo1
,
CORETSE_AHBO0o
,
CORETSE_AHBilo
,
CORETSE_AHBI0o
,
CORETSE_AHBIoo
,
CORETSE_AHBoOo1
,
CORETSE_AHBIOo1
,
CORETSE_AHBlOo1
,
CORETSE_AHBoOi1
,
CORETSE_AHBoI
,
CORETSE_AHBII
,
CORETSE_AHBOl
,
CORETSE_AHBIOi1
,
CORETSE_AHBlOi1
,
CORETSE_AHBo0o
,
CORETSE_AHBi0o
,
CORETSE_AHBO1o
,
CORETSE_AHBI1o
,
CORETSE_AHBiOo1
,
CORETSE_AHBOIo1
,
CORETSE_AHBo1o
,
CORETSE_AHBl1o
,
CORETSE_AHBlIo1
,
CORETSE_AHBIIo1
,
CORETSE_AHBI0o1
,
CORETSE_AHBl0o1
,
CORETSE_AHBo0o1
,
CORETSE_AHBi0o1
,
CORETSE_AHBO1o1
,
CORETSE_AHBI1o1
,
CORETSE_AHBl1o1
,
CORETSE_AHBo1o1
,
CORETSE_AHBi1o1
,
CORETSE_AHBOoo1
,
CORETSE_AHBIoo1
,
CORETSE_AHBloo1
,
CORETSE_AHBooo1
,
CORETSE_AHBioo1
,
CORETSE_AHBOio1
,
CORETSE_AHBiI00
,
CORETSE_AHBOl00
,
CORETSE_AHBIl00
)
;
input
CORETSE_AHBiOO1
,
CORETSE_AHBo1Oo
;
input
CORETSE_AHBo111
,
CORETSE_AHBi1Oo
;
input
CORETSE_AHBiI
;
input
[
7
:
0
]
CORETSE_AHBlI
;
input
CORETSE_AHBIl
;
input
CORETSE_AHBol
,
CORETSE_AHBll
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
CORETSE_AHBiOi
,
CORETSE_AHBIIi
,
CORETSE_AHBOIi
,
CORETSE_AHBoOi
;
input
CORETSE_AHBlOi
,
CORETSE_AHBOOi
,
CORETSE_AHBoo11
,
CORETSE_AHBIOi
;
input
CORETSE_AHBlIi
;
input
[
15
:
0
]
CORETSE_AHBi111
,
CORETSE_AHBOoOo
;
input
[
1
:
0
]
CORETSE_AHBoo01
;
input
CORETSE_AHBIOOo
,
CORETSE_AHBOOOo
,
CORETSE_AHBio01
;
input
CORETSE_AHBoIi1
,
CORETSE_AHBiIi1
;
input
[
47
:
0
]
CORETSE_AHBll00
;
input
CORETSE_AHBl0i1
,
CORETSE_AHBo0i1
,
CORETSE_AHBIoOo
;
input
[
3
:
0
]
CORETSE_AHBlii1
;
input
[
6
:
0
]
CORETSE_AHBI1i1
,
CORETSE_AHBl1i1
,
CORETSE_AHBo1i1
;
input
[
9
:
0
]
CORETSE_AHBi1i1
;
input
[
3
:
0
]
CORETSE_AHBOoi1
,
CORETSE_AHBoii1
;
input
CORETSE_AHBiii1
;
input
CORETSE_AHBIoi1
,
CORETSE_AHBiIi
,
CORETSE_AHBioi1
,
CORETSE_AHBloi1
;
input
[
15
:
0
]
CORETSE_AHBloOo
;
input
CORETSE_AHBi0i1
;
input
[
7
:
0
]
CORETSE_AHBIii1
;
input
CORETSE_AHBo0Oo
,
CORETSE_AHBi0Oo
;
input
CORETSE_AHBIio1
,
CORETSE_AHBlio1
;
input
CORETSE_AHBlli1
;
input
CORETSE_AHBlOOo
,
CORETSE_AHBIli1
,
CORETSE_AHBOli1
,
CORETSE_AHBiii0
;
output
CORETSE_AHBolo
,
CORETSE_AHBOOo1
,
CORETSE_AHBO0o
,
CORETSE_AHBilo
;
output
CORETSE_AHBI0o
;
output
CORETSE_AHBIoo
,
CORETSE_AHBoOo1
;
output
CORETSE_AHBIOo1
;
output
[
51
:
0
]
CORETSE_AHBlOo1
;
output
CORETSE_AHBoOi1
;
output
CORETSE_AHBoI
;
output
[
7
:
0
]
CORETSE_AHBII
;
output
CORETSE_AHBOl
;
output
CORETSE_AHBIOi1
,
CORETSE_AHBlOi1
;
output
[
7
:
0
]
CORETSE_AHBo0o
;
output
CORETSE_AHBi0o
,
CORETSE_AHBO1o
,
CORETSE_AHBI1o
;
output
CORETSE_AHBiOo1
,
CORETSE_AHBOIo1
;
output
CORETSE_AHBo1o
;
output
[
32
:
0
]
CORETSE_AHBl1o
;
output
CORETSE_AHBlIo1
;
output
[
8
:
0
]
CORETSE_AHBIIo1
;
output
CORETSE_AHBiI00
,
CORETSE_AHBOl00
,
CORETSE_AHBIl00
;
output
CORETSE_AHBI0o1
;
output
[
7
:
0
]
CORETSE_AHBl0o1
;
output
[
7
:
0
]
CORETSE_AHBo0o1
;
output
CORETSE_AHBi0o1
;
output
[
7
:
0
]
CORETSE_AHBO1o1
;
output
[
7
:
0
]
CORETSE_AHBI1o1
;
output
CORETSE_AHBl1o1
;
output
CORETSE_AHBo1o1
;
output
CORETSE_AHBi1o1
;
input
CORETSE_AHBOoo1
;
input
CORETSE_AHBIoo1
;
input
[
15
:
0
]
CORETSE_AHBloo1
;
input
CORETSE_AHBooo1
;
input
CORETSE_AHBOio1
;
input
[
79
:
0
]
CORETSE_AHBioo1
;
wire
[
7
:
0
]
CORETSE_AHBOlIo
;
wire
CORETSE_AHBIlIo
,
CORETSE_AHBllIo
,
CORETSE_AHBolIo
;
wire
CORETSE_AHBoOo1
,
CORETSE_AHBilIo
,
CORETSE_AHBO0Io
;
wire
CORETSE_AHBI0Io
;
wire
CORETSE_AHBl0Io
,
CORETSE_AHBo0Io
,
CORETSE_AHBi0Io
,
CORETSE_AHBO1Io
;
wire
CORETSE_AHBIOi1
;
wire
CORETSE_AHBlOi1
;
wire
[
7
:
0
]
CORETSE_AHBI1Io
;
wire
CORETSE_AHBl1Io
,
CORETSE_AHBo1Io
,
CORETSE_AHBi1Io
;
wire
CORETSE_AHBOoIo
;
wire
[
32
:
0
]
CORETSE_AHBIoIo
;
wire
CORETSE_AHBloIo
,
CORETSE_AHBooIo
;
wire
[
7
:
0
]
CORETSE_AHBioIo
;
wire
CORETSE_AHBOiIo
;
wire
CORETSE_AHBIiIo
,
CORETSE_AHBliIo
,
CORETSE_AHBoiIo
;
wire
CORETSE_AHBiiIo
;
petmc_top
CORETSE_AHBOOlo
(
.CORETSE_AHBiOO1
(
CORETSE_AHBiOO1
)
,
.CORETSE_AHBo1Oo
(
CORETSE_AHBo1Oo
)
,
.CORETSE_AHBiio
(
CORETSE_AHBiio
)
,
.CORETSE_AHBiOi
(
CORETSE_AHBiOi
)
,
.CORETSE_AHBIIi
(
CORETSE_AHBIIi
)
,
.CORETSE_AHBOIi
(
CORETSE_AHBOIi
)
,
.CORETSE_AHBoOi
(
CORETSE_AHBoOi
)
,
.CORETSE_AHBl0Io
(
CORETSE_AHBl0Io
)
,
.CORETSE_AHBo0Io
(
CORETSE_AHBo0Io
)
,
.CORETSE_AHBi0Io
(
CORETSE_AHBi0Io
)
,
.CORETSE_AHBO1Io
(
CORETSE_AHBO1Io
)
,
.CORETSE_AHBoIi1
(
CORETSE_AHBoIi1
)
,
.CORETSE_AHBoo01
(
CORETSE_AHBoo01
)
,
.CORETSE_AHBll00
(
CORETSE_AHBll00
)
,
.CORETSE_AHBlIi
(
CORETSE_AHBlIi
)
,
.CORETSE_AHBi111
(
CORETSE_AHBi111
)
,
.CORETSE_AHBOoOo
(
CORETSE_AHBOoOo
)
,
.CORETSE_AHBOiIo
(
CORETSE_AHBOiIo
)
,
.CORETSE_AHBo0Oo
(
CORETSE_AHBo0Oo
)
,
.CORETSE_AHBOlIo
(
CORETSE_AHBOlIo
)
,
.CORETSE_AHBIlIo
(
CORETSE_AHBIlIo
)
,
.CORETSE_AHBllIo
(
CORETSE_AHBllIo
)
,
.CORETSE_AHBolIo
(
CORETSE_AHBolIo
)
,
.CORETSE_AHBolo
(
CORETSE_AHBolo
)
,
.CORETSE_AHBOOo1
(
CORETSE_AHBOOo1
)
,
.CORETSE_AHBO0o
(
CORETSE_AHBO0o
)
,
.CORETSE_AHBilo
(
CORETSE_AHBilo
)
,
.CORETSE_AHBIoo
(
CORETSE_AHBIoo
)
,
.CORETSE_AHBo0o1
(
CORETSE_AHBo0o1
)
,
.CORETSE_AHBoOo1
(
CORETSE_AHBoOo1
)
,
.CORETSE_AHBilIo
(
CORETSE_AHBilIo
)
,
.CORETSE_AHBO0Io
(
CORETSE_AHBO0Io
)
)
;
petfn_top
#
(
.CORETSE_AHBiOI
(
CORETSE_AHBiOI
)
,
.CORETSE_AHBlOI
(
CORETSE_AHBlOI
)
)
CORETSE_AHBIOlo
(
.CORETSE_AHBiOO1
(
CORETSE_AHBiOO1
)
,
.CORETSE_AHBo1Oo
(
CORETSE_AHBo1Oo
)
,
.CORETSE_AHBol
(
CORETSE_AHBiiIo
)
,
.CORETSE_AHBll
(
CORETSE_AHBll
)
,
.CORETSE_AHBiio
(
CORETSE_AHBOlIo
)
,
.CORETSE_AHBiOi
(
CORETSE_AHBIlIo
)
,
.CORETSE_AHBIIi
(
CORETSE_AHBllIo
)
,
.CORETSE_AHBOIi
(
CORETSE_AHBolIo
)
,
.CORETSE_AHBoOo1
(
CORETSE_AHBoOo1
)
,
.CORETSE_AHBilIo
(
CORETSE_AHBilIo
)
,
.CORETSE_AHBoo01
(
CORETSE_AHBoo01
)
,
.CORETSE_AHBIOOo
(
CORETSE_AHBIOOo
)
,
.CORETSE_AHBio01
(
CORETSE_AHBio01
)
,
.CORETSE_AHBi0i1
(
CORETSE_AHBi0i1
)
,
.CORETSE_AHBlOi
(
CORETSE_AHBlOi
)
,
.CORETSE_AHBOOi
(
CORETSE_AHBOOi
)
,
.CORETSE_AHBoo11
(
CORETSE_AHBoo11
)
,
.CORETSE_AHBIOi
(
CORETSE_AHBIOi
)
,
.CORETSE_AHBl0i1
(
CORETSE_AHBl0i1
)
,
.CORETSE_AHBo0i1
(
CORETSE_AHBo0i1
)
,
.CORETSE_AHBIoOo
(
CORETSE_AHBIoOo
)
,
.CORETSE_AHBlii1
(
CORETSE_AHBlii1
)
,
.CORETSE_AHBI1i1
(
CORETSE_AHBI1i1
)
,
.CORETSE_AHBl1i1
(
CORETSE_AHBl1i1
)
,
.CORETSE_AHBo1i1
(
CORETSE_AHBo1i1
)
,
.CORETSE_AHBi1i1
(
CORETSE_AHBi1i1
)
,
.CORETSE_AHBOoi1
(
CORETSE_AHBOoi1
)
,
.CORETSE_AHBoii1
(
CORETSE_AHBoii1
)
,
.CORETSE_AHBiii1
(
CORETSE_AHBiii1
)
,
.CORETSE_AHBlli1
(
CORETSE_AHBlli1
)
,
.CORETSE_AHBIoi1
(
CORETSE_AHBIoi1
)
,
.CORETSE_AHBiIi
(
CORETSE_AHBiIi
)
,
.CORETSE_AHBioi1
(
CORETSE_AHBioi1
)
,
.CORETSE_AHBloOo
(
CORETSE_AHBloOo
)
,
.CORETSE_AHBIio1
(
CORETSE_AHBIio1
)
,
.CORETSE_AHBlOOo
(
CORETSE_AHBlOOo
)
,
.CORETSE_AHBloi1
(
CORETSE_AHBloi1
)
,
.CORETSE_AHBlOi1
(
CORETSE_AHBlOi1
)
,
.CORETSE_AHBI0Io
(
CORETSE_AHBI0Io
)
,
.CORETSE_AHBolo
(
CORETSE_AHBl0Io
)
,
.CORETSE_AHBOOo1
(
CORETSE_AHBo0Io
)
,
.CORETSE_AHBO0o
(
CORETSE_AHBi0Io
)
,
.CORETSE_AHBilo
(
CORETSE_AHBO1Io
)
,
.CORETSE_AHBI0o
(
CORETSE_AHBI0o
)
,
.CORETSE_AHBIOo1
(
CORETSE_AHBIOo1
)
,
.CORETSE_AHBlOo1
(
CORETSE_AHBlOo1
)
,
.CORETSE_AHBoOi1
(
CORETSE_AHBoOi1
)
,
.CORETSE_AHBI0o1
(
CORETSE_AHBI0o1
)
,
.CORETSE_AHBl0o1
(
CORETSE_AHBl0o1
)
,
.CORETSE_AHBi0o1
(
CORETSE_AHBi0o1
)
,
.CORETSE_AHBOoo1
(
CORETSE_AHBOoo1
)
,
.CORETSE_AHBIoo1
(
CORETSE_AHBIoo1
)
,
.CORETSE_AHBloo1
(
CORETSE_AHBloo1
)
,
.CORETSE_AHBooo1
(
CORETSE_AHBooo1
)
,
.CORETSE_AHBOio1
(
CORETSE_AHBOio1
)
,
.CORETSE_AHBioo1
(
CORETSE_AHBioo1
)
,
.CORETSE_AHBoI
(
CORETSE_AHBoI
)
,
.CORETSE_AHBII
(
CORETSE_AHBII
)
,
.CORETSE_AHBOl
(
CORETSE_AHBOl
)
)
;
assign
CORETSE_AHBloIo
=
~
CORETSE_AHBiii0
&
CORETSE_AHBiI
|
CORETSE_AHBiii0
&
CORETSE_AHBoI
;
assign
CORETSE_AHBooIo
=
~
CORETSE_AHBiii0
&
CORETSE_AHBIl
|
CORETSE_AHBiii0
&
CORETSE_AHBOl
;
assign
CORETSE_AHBioIo
[
7
:
0
]
=
{
8
{
~
CORETSE_AHBiii0
}
}
&
CORETSE_AHBlI
[
7
:
0
]
|
{
8
{
CORETSE_AHBiii0
}
}
&
CORETSE_AHBII
[
7
:
0
]
;
assign
CORETSE_AHBiiIo
=
CORETSE_AHBol
;
assign
CORETSE_AHBlOlo
=
1
'b
0
;
perfn_top
#
(
.CORETSE_AHBoOI
(
CORETSE_AHBoOI
)
,
.CORETSE_AHBlOI
(
CORETSE_AHBlOI
)
)
CORETSE_AHBoOlo
(
.CORETSE_AHBo111
(
CORETSE_AHBo111
)
,
.CORETSE_AHBi1Oo
(
CORETSE_AHBi1Oo
)
,
.CORETSE_AHBiI
(
CORETSE_AHBloIo
)
,
.CORETSE_AHBlI
(
CORETSE_AHBioIo
)
,
.CORETSE_AHBIl
(
CORETSE_AHBooIo
)
,
.CORETSE_AHBol
(
CORETSE_AHBiiIo
)
,
.CORETSE_AHBI0Io
(
CORETSE_AHBI0Io
)
,
.CORETSE_AHBoo01
(
CORETSE_AHBoo01
)
,
.CORETSE_AHBOOOo
(
CORETSE_AHBOOOo
)
,
.CORETSE_AHBio01
(
CORETSE_AHBio01
)
,
.CORETSE_AHBi0i1
(
CORETSE_AHBi0i1
)
,
.CORETSE_AHBO1i1
(
CORETSE_AHBIoOo
)
,
.CORETSE_AHBIii1
(
CORETSE_AHBIii1
)
,
.CORETSE_AHBloOo
(
CORETSE_AHBloOo
)
,
.CORETSE_AHBIiIo
(
CORETSE_AHBIiIo
)
,
.CORETSE_AHBliIo
(
CORETSE_AHBliIo
)
,
.CORETSE_AHBoiIo
(
CORETSE_AHBoiIo
)
,
.CORETSE_AHBlio1
(
CORETSE_AHBlio1
)
,
.CORETSE_AHBIOi1
(
CORETSE_AHBIOi1
)
,
.CORETSE_AHBo0o
(
CORETSE_AHBI1Io
)
,
.CORETSE_AHBi0o
(
CORETSE_AHBl1Io
)
,
.CORETSE_AHBO1o
(
CORETSE_AHBo1Io
)
,
.CORETSE_AHBI1o
(
CORETSE_AHBi1Io
)
,
.CORETSE_AHBOIo1
(
CORETSE_AHBOIo1
)
,
.CORETSE_AHBiOo1
(
CORETSE_AHBiOo1
)
,
.CORETSE_AHBo1o
(
CORETSE_AHBOoIo
)
,
.CORETSE_AHBl1o
(
CORETSE_AHBIoIo
)
,
.CORETSE_AHBO1o1
(
CORETSE_AHBO1o1
)
,
.CORETSE_AHBI1o1
(
CORETSE_AHBI1o1
)
,
.CORETSE_AHBl1o1
(
CORETSE_AHBl1o1
)
,
.CORETSE_AHBo1o1
(
CORETSE_AHBo1o1
)
,
.CORETSE_AHBi1o1
(
CORETSE_AHBi1o1
)
,
.CORETSE_AHBlIo1
(
CORETSE_AHBlIo1
)
,
.CORETSE_AHBIIo1
(
CORETSE_AHBIIo1
)
,
.CORETSE_AHBiI00
(
CORETSE_AHBiI00
)
,
.CORETSE_AHBOl00
(
CORETSE_AHBOl00
)
)
;
permc_top
CORETSE_AHBiOlo
(
.CORETSE_AHBo111
(
CORETSE_AHBo111
)
,
.CORETSE_AHBi1Oo
(
CORETSE_AHBi1Oo
)
,
.CORETSE_AHBI1Io
(
CORETSE_AHBI1Io
)
,
.CORETSE_AHBl1Io
(
CORETSE_AHBl1Io
)
,
.CORETSE_AHBo1Io
(
CORETSE_AHBo1Io
)
,
.CORETSE_AHBi1Io
(
CORETSE_AHBi1Io
)
,
.CORETSE_AHBOoIo
(
CORETSE_AHBOoIo
)
,
.CORETSE_AHBIoIo
(
CORETSE_AHBIoIo
)
,
.CORETSE_AHBoo01
(
CORETSE_AHBoo01
)
,
.CORETSE_AHBOli1
(
CORETSE_AHBOli1
)
,
.CORETSE_AHBiIi1
(
CORETSE_AHBiIi1
)
,
.CORETSE_AHBll00
(
CORETSE_AHBll00
)
,
.CORETSE_AHBIli1
(
CORETSE_AHBIli1
)
,
.CORETSE_AHBi0Oo
(
CORETSE_AHBi0Oo
)
,
.CORETSE_AHBO0Io
(
CORETSE_AHBO0Io
)
,
.CORETSE_AHBo0o
(
CORETSE_AHBo0o
)
,
.CORETSE_AHBi0o
(
CORETSE_AHBi0o
)
,
.CORETSE_AHBO1o
(
CORETSE_AHBO1o
)
,
.CORETSE_AHBI1o
(
CORETSE_AHBI1o
)
,
.CORETSE_AHBo1o
(
CORETSE_AHBo1o
)
,
.CORETSE_AHBl1o
(
CORETSE_AHBl1o
)
,
.CORETSE_AHBOiIo
(
CORETSE_AHBOiIo
)
,
.CORETSE_AHBIiIo
(
CORETSE_AHBIiIo
)
,
.CORETSE_AHBliIo
(
CORETSE_AHBliIo
)
,
.CORETSE_AHBoiIo
(
CORETSE_AHBoiIo
)
,
.CORETSE_AHBIl00
(
CORETSE_AHBIl00
)
)
;
endmodule
