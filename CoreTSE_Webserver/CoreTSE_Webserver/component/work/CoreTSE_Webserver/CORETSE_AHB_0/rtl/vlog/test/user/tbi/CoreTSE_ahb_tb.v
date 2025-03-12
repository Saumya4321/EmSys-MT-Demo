
`timescale 1ps / 1ps


module gl;
// --------------------------------------------------------------------------
// -- GLOBAL SIGNALS AND DEFINES
`define      DSPLYVRBS 1    // Define Runtime terminal display reporting verbose
`define      MFC       1   // Define maximum falure count. 0 = infinite
reg   [31:0] glb_fc;        // Global variable failure count
real         glb_tnum;      // Global variable test number active

task dsplyend;
begin
   if ( glb_fc !== 0 )
   begin
      $display(" ");
      $display("// ------------------------------------------------------------------------ //");
      $display("//                   ----        -         ---      -                       //");
      $display("//                   -          - -         -       -                       //");
      $display("//                   ---       -----        -       -                       //");
      $display("//                   -        -     -       -       -                       //");
      $display("//                   -       -       -     ---      ------                  //");
      $display("// ------------------------------------------------------------------------ //");
   end
   else
   begin
      $display(" ");
      $display("// ------------------------------------------------------------------------ //");
      $display("//                   ++++        +         ++++      ++++                   //");
      $display("//                   +   +      + +       +         +                       //");
      $display("//                   ++++      +++++       ++++      ++++                   //");
      $display("//                   +        +     +          +         +                  //");
      $display("//                   +       +       +     ++++      ++++                   //");
      $display("// ------------------------------------------------------------------------ //");
   end
end                                                                                      
endtask

task dsplytcmnt;
   input [8*120:1] testcmnttext;
begin
   if ( `DSPLYVRBS >= 1 )
      $display("          %0s", testcmnttext);
end
endtask

task dsplystat;
   input [8*120:1] stattxt;
begin
   if ( `DSPLYVRBS >= 1 )
      $display("          STATUS  : %0s", stattxt);
end
endtask

task dsplyerr;
   input [8*120:1] toerrtxt;
begin                              
   $display("   ERROR   : %0s", toerrtxt ); 
   glb_fc = glb_fc + 1; 
end
endtask

task dsplycmperr;
   input [8*120:1] cmperrsig;
   input    [71:0] cmperrxpt;
   input    [71:0] cmperract;
begin
   $display("   ERROR   : Data miscompare on signal %0s, at time %0d.", cmperrsig, $time);
   $display("             Expected value = %h,  Actual value = %h.", cmperrxpt, cmperract); 
   glb_fc = glb_fc + 1; 
end
endtask

// -- Global Variable Initialization
initial 
begin
   glb_fc   = 0;
end

// --------------------------------------------------------------------------
// -- Simulation termination due to maximum failure count reached
always @ ( glb_fc )
begin
   if (( `MFC <= glb_fc ) & ( `MFC !== 0 ))
   begin
      #1;
      dsplystat( "Maximum testbench Error count exceeded.");
      dsplystat( "Simulation terminated prematurely");
      dsplyend;
      #1;
      $finish;
   end
   #1; 
end
endmodule

module ml;
// --------------------------------------------------------------------------
// -- GLOBAL SIGNALS AND DEFINES
reg    [7:0] bld_frm_mem  [0:35535]; // build frame task global memory
 
// --------------------------------------------------------------------------
// --- Default descriptor constant 
parameter dflt_dsc = {
      20'd0,                // unused     255 : 236
       1'b0,                // car_snse   235       // carrier sense
       1'b0,                // cf         234       // generic control frame
       1'b0,                // dat_evnt   233       // A data event occured since last packet
       1'b0,                // abrt       232       // trunc is due to abort
      16'd1536,             // truncbc    231 : 216 // 16'hFFFF is no trunc
       1'b0,                // pad_68     215        
       1'b0,                // pad_64     214
       1'b0,                // rmvfcs     213       // frame 4 bytes shorter than LEN
       1'b0,                // pf         212       // pause control frame
       2'b00,               // dlyfcs     211 : 210
       1'b0,                // drop       209
       1'b0,                // badfrm     208
       1'b0,                // coderr     207
       1'b1,                // check      206       // RSV length checking enabled
       1'b0,                // endian     205
       1'b0,                // nofcs      204       // frame length equal to LEN
       1'b0,                // zfcs       203
       1'b0,                // fcserr     202       // create ranbom bit error in FCS
       1'b0,                // tagged     201
       1'b0,                // dix        200       // force [143:128] to L/T field
       8'h01,               // pattern    199 : 192
      16'd64,               // totlenreq  191 : 176
      32'h0,                // fill       175 : 144
      16'h0,                // etype      143 : 128
      32'h8100_abcd,        // vlan tag   127 : 96  (make non-zero for stats)
      48'h5051_5253_5455,   // sa         95  : 48
      48'hd0d1_d2d3_d4d5 }; // da         47  : 0

// --------------------------------------------------------------------------
// --- Writes descriptor defined data pattern into bld_frm_mem
function [31:0] bld_frm;
//task bld_frm;
   input [255:0] fp;           // frame parameter
   reg    [47:0] macda;        // 48-bit destination MAC address
   reg    [47:0] macsa;        // 48-bit source MAC address
   reg    [31:0] tag;          // 32-bit VLAN tag {vlan_etype, pri, tr, VLAN}
   reg    [15:0] etype;        // 16-bit ethernet type
   reg    [15:0] totlenreq;    // requested Total Length of frame in bytes
   reg    [15:0] totlen;       // calculated actual Total Length of frame in bytes
   reg     [7:0] pattern;      // 8-bit data Pattern specifier: 01=count up,
                               //      - 02=count down, else random data
   reg           dix;          // 1=etype in Etype/Len field, 0=LEN
   reg           tagged;       // frame is tagged, use tag
   reg           fcserr;       // FCS error
   reg           zfcs;         // zero-out frame's FCS
   reg           nofcs;        // No FCS at end of frame (SOF qualifier is 3)
   reg           rmvfcs;       // No FCS at end of frame frame shorter by 4 bytes
   reg           coderr;       // code error
   reg     [1:0] dlyfcs;       // delayed FCS, 0=none, 1=4 bytes, 2=8 bytes
   reg           pf;           // pause control frame
   reg           cf;           // generaic control frame
   reg           endian;
   reg           badfrm;
   reg           pad_68;
   reg    [15:0] fcs_start;    // FCS calculation start offset
   reg    [15:0] load_start;   // payload start offset
   reg    [15:0] load_end;     // payload end
   reg    [31:0] seed;         // scratch random number seed
   reg    [31:0] crc, crc_out; // scratch crc data words
   reg    [15:0] len;          // scratch frame length
   reg           drop;         // Will not be passed
   reg           pad_64;       // pad to 64 bytes
   integer       j, k;         // scratch counters
begin
   // Illegal conditions
   if ( ^fp === 1'bX )
   begin
      $display( "ERROR: Illegal input condition in %m function : ( ^fp === 1'bX )");
      $stop;
   end
   pf = fp[212];
   cf = fp[234];
   if ( pf | cf )
   begin
      macda     = 48'h0180_c200_0001;
      macsa     = fp[95:48];
      if   ( pf ) tag        = 32'h8808_0001;
      else        tag[31:16] = 16'h8808;
      etype     = fp[143:128]; // pause timer value
      totlenreq = 16'h0040;
      pattern   = 8'h00;
      dix       = 1'b1;
      tagged    = 1'b1;
      rmvfcs    = fp[213];
      {fcserr,  zfcs, nofcs, coderr, dlyfcs} = 6'h00;
   end
   else begin
      macda     = fp[47:0];
      macsa     = fp[95:48];
      tag       = fp[127:96];
      etype     = fp[143:128];
      totlenreq = fp[191:176];    
      pattern   = fp[199:192];
      dix       = fp[200];
      tagged    = fp[201];
      fcserr    = fp[202];
      zfcs      = fp[203];
      nofcs     = fp[204];
      endian    = fp[205];
      coderr    = fp[207];
      badfrm    = fp[208];
      drop      = fp[209];
      dlyfcs    = fp[211:210];
      rmvfcs    = fp[213];
      pad_64    = fp[214];
      pad_68    = fp[215];       
   end
   if ( nofcs & rmvfcs )
   begin
      $display( "ERROR: Illegal input condition in %m function : ( nofcs & rmvfcs )");
      $stop;
   end
   seed = pattern;
   seed = $random(seed);
   // Calculate actual total length from requested
   if      ( pad_68 & ( totlenreq < 68 ))  totlen = 68;
   else if ( pad_64 & ( totlenreq < 64 ))  totlen = 64;
   else if ( rmvfcs & ( totlenreq >  4 ))  totlen = totlenreq - 4;
   else                                    totlen = totlenreq;
   // Add known pattern for packet header if delayed FCS is used
   j=0;
   if ( dlyfcs > 2'b00 )
   begin
      if(`DSPLYVRBS>1) $display( "  %m Adding header word 1 = dead" );
      bld_frm_mem[j] = 8'hde;       j=j+1;
      bld_frm_mem[j] = 8'had;       j=j+1;
      bld_frm_mem[j] = 8'hde;       j=j+1;
      bld_frm_mem[j] = 8'had;       j=j+1;
   end
   if ( dlyfcs > 2'b01 )
   begin
      if(`DSPLYVRBS>1) $display( "  %m Adding header word 2 = beef" );
      bld_frm_mem[j] = 8'hbe;       j=j+1;
      bld_frm_mem[j] = 8'hef;       j=j+1;
      bld_frm_mem[j] = 8'hbe;       j=j+1;
      bld_frm_mem[j] = 8'hef;       j=j+1;
   end
   if ( dlyfcs > 2'b10 )
   begin
      if(`DSPLYVRBS>1) $display( "  %m Adding header word 3 = cafe" );
      bld_frm_mem[j] = 8'hca;       j=j+1;
      bld_frm_mem[j] = 8'hfe;       j=j+1;
      bld_frm_mem[j] = 8'hca;       j=j+1;
      bld_frm_mem[j] = 8'hfe;       j=j+1;
   end
   // Add MAC addresses to frame memory
   if(`DSPLYVRBS>1) $display( "  %m Adding MAC DA = %h", macda );
   bld_frm_mem[j] = macda[47:40];   j=j+1;
   bld_frm_mem[j] = macda[39:32];   j=j+1;
   bld_frm_mem[j] = macda[31:24];   j=j+1;
   bld_frm_mem[j] = macda[23:16];   j=j+1;
   bld_frm_mem[j] = macda[15:8];    j=j+1;
   bld_frm_mem[j] = macda[7:0];     j=j+1;
   if(`DSPLYVRBS>1) $display( "  %m Adding MAC SA = %h", macsa );
   bld_frm_mem[j] = macsa[47:40];   j=j+1;
   bld_frm_mem[j] = macsa[39:32];   j=j+1;
   bld_frm_mem[j] = macsa[31:24];   j=j+1;
   bld_frm_mem[j] = macsa[23:16];   j=j+1;
   bld_frm_mem[j] = macsa[15:8];    j=j+1;
   bld_frm_mem[j] = macsa[7:0];     j=j+1;
   // Add tag to frame memory
   if ( tagged )
   begin
      if(`DSPLYVRBS>1) $display( "  %m building tag with %h_%h", tag[31:16], tag[15:0] );
      bld_frm_mem[j] = tag[31:24];  j=j+1;
      bld_frm_mem[j] = tag[23:16];  j=j+1;
      bld_frm_mem[j] = tag[15:8];   j=j+1;
      bld_frm_mem[j] = tag[7:0];    j=j+1;
   end
   // Add Etype/Len to frame memory
   if ( dix )
   begin
      if(`DSPLYVRBS>1) $display( "  %m Adding ETYPE %h", etype );
      bld_frm_mem[j] = etype[15:8]; j=j+1;
      bld_frm_mem[j] = etype[7:0];  j=j+1;
   end
   else begin
   // Subtract SA, DA, Len/type, FCS, prepend
      if ( totlenreq > 18 + dlyfcs*4 ) len = totlenreq - 18 - dlyfcs*4;
      else                          len = 0;
      if ( tagged & len > 2 ) len = len - 4;
      if(`DSPLYVRBS>1) $display( "  %m Adding LEN %h", len );
      bld_frm_mem[j] = len[15:8];   j=j+1;
      bld_frm_mem[j] = len[7:0];    j=j+1;
   end
   // Add payload data to temporary memory
   load_start = j;
   if   ( nofcs ) load_end = totlenreq;
   else           load_end = totlenreq - 4;
   for ( j=load_start; j<load_end; j=j+1 )
   begin
    // $display("load_start = %d load_end = %d ",load_start,load_end);

      case ( pattern )
         0:                        bld_frm_mem[j] = 8'h00;  
         1: begin                                  // Count up
            if ( j == load_start ) bld_frm_mem[j] = 8'h00;
            else                   bld_frm_mem[j] = bld_frm_mem[j-1] + 8'h01;
         end
         2: begin                                  // Count down
            if ( j == load_start ) bld_frm_mem[j] = 8'hFF;
            else                   bld_frm_mem[j] = bld_frm_mem[j-1] - 8'h01;
         end
         default: 
         begin
            seed = $random( seed );
            bld_frm_mem[j] = seed[7:0];                          
          end
      endcase
   end
   // Add pad optionaly
   while ( ( pad_64 & ( j < 60 ) ) | ( pad_68 & ( j < 64 ) ) )
   begin
      bld_frm_mem[j] = 8'h00;
      j = j + 1;
   end
   // Generate 32-bit CRC
   if ( ~nofcs & ~rmvfcs )            
   begin  
       if ( totlen > 7 )
       begin
         if ( zfcs ) crc = 32'h0000_0000;
         else begin
            crc = 32'hFFFF_FFFF;                        // Start with all F's
            if      ( dlyfcs == 2'b00 ) fcs_start = 16'h0000;
            else if ( dlyfcs == 2'b01 ) fcs_start = 16'h0004;
            else if ( dlyfcs == 2'b10 ) fcs_start = 16'h0008;
            else                        fcs_start = 16'h000c;
            for ( j=fcs_start; j < totlen - 4; j=j+1 )
            begin
               crc = crc_gen_32( crc, bld_frm_mem[j] );
            end
            crc = ~crc;                                 // Invert result
            if ( fcserr ) crc[seed[4:0]] = ~crc[seed[4:0]];
            crc = {crc[24], crc[25], crc[26], crc[27],  // Reverse bit order
                   crc[28], crc[29], crc[30], crc[31],
                   crc[16], crc[17], crc[18], crc[19],
                   crc[20], crc[21], crc[22], crc[23],
                   crc[8],  crc[9],  crc[10], crc[11],
                   crc[12], crc[13], crc[14], crc[15],
                   crc[0],  crc[1],  crc[2],  crc[3],
                   crc[4],  crc[5],  crc[6],  crc[7]};
         end
         if(`DSPLYVRBS>1) $display( "  %m, crc=%h", crc );
         // Add CRC to temporary memory, MSB first
         j = totlen - 4;
         bld_frm_mem[j] = crc[31:24]; j=j+1;
         bld_frm_mem[j] = crc[23:16]; j=j+1;
         bld_frm_mem[j] = crc[15:8];  j=j+1;
         bld_frm_mem[j] = crc[7:0];   j=j+1;
      end
   end
   // Perform truncation if necessary
   if (( fp[231:216] < totlen ) & ~(&fp[231:216]) ) totlen = fp[231:216];
   bld_frm = totlen;
end
endfunction

// --------------------------------------------------------------------------
// -- Generates 32 bit CRC from 8 bit input and previous 32 bit CRC
function [31:0] crc_gen_32;
   input    [31:0] crc;
   input     [7:0] d;
   reg      [31:0] o_crc;
begin
   o_crc[31] = crc[29]^d[2] ^ crc[23];
   o_crc[30] = crc[31]^d[0] ^ crc[28]^d[3] ^ crc[22];
   o_crc[29] = crc[31]^d[0] ^ crc[30]^d[1] ^ crc[27]^d[4] ^ crc[21];
   o_crc[28] = crc[30]^d[1] ^ crc[29]^d[2] ^ crc[26]^d[5] ^ crc[20];
   o_crc[27] = crc[31]^d[0] ^ crc[29]^d[2] ^ crc[28]^d[3] ^ crc[25]^d[6] ^ crc[19];
   o_crc[26] = crc[30]^d[1] ^ crc[28]^d[3] ^ crc[27]^d[4] ^ crc[24]^d[7] ^ crc[18];
   o_crc[25] = crc[27]^d[4] ^ crc[26]^d[5] ^ crc[17];
   o_crc[24] = crc[31]^d[0] ^ crc[26]^d[5] ^ crc[25]^d[6] ^ crc[16];
   o_crc[23] = crc[30]^d[1] ^ crc[25]^d[6] ^ crc[24]^d[7] ^ crc[15];
   o_crc[22] = crc[24]^d[7] ^ crc[14];
   o_crc[21] = crc[29]^d[2] ^ crc[13];
   o_crc[20] = crc[28]^d[3] ^ crc[12];
   o_crc[19] = crc[31]^d[0] ^ crc[27]^d[4] ^ crc[11];
   o_crc[18] = crc[31]^d[0] ^ crc[30]^d[1] ^ crc[26]^d[5] ^ crc[10];
   o_crc[17] = crc[30]^d[1] ^ crc[29]^d[2] ^ crc[25]^d[6] ^ crc[9];
   o_crc[16] = crc[29]^d[2] ^ crc[28]^d[3] ^ crc[24]^d[7] ^ crc[8];
   o_crc[15] = crc[31]^d[0] ^ crc[29]^d[2] ^ crc[28]^d[3] ^ crc[27]^d[4] ^ crc[7];
   o_crc[14] = crc[31]^d[0] ^ crc[30]^d[1] ^ crc[28]^d[3] ^ crc[27]^d[4] ^ crc[26]^d[5] ^ crc[6];
   o_crc[13] = crc[31]^d[0] ^ crc[30]^d[1] ^ crc[29]^d[2] ^ crc[27]^d[4] ^ crc[26]^d[5] ^ crc[25]^d[6] ^ crc[5];
   o_crc[12] = crc[30]^d[1] ^ crc[29]^d[2] ^ crc[28]^d[3] ^ crc[26]^d[5] ^ crc[25]^d[6] ^ crc[24]^d[7] ^ crc[4];
   o_crc[11] = crc[28]^d[3] ^ crc[27]^d[4] ^ crc[25]^d[6] ^ crc[24]^d[7] ^ crc[3];
   o_crc[10] = crc[29]^d[2] ^ crc[27]^d[4] ^ crc[26]^d[5] ^ crc[24]^d[7] ^ crc[2];
   o_crc[9]  = crc[29]^d[2] ^ crc[28]^d[3] ^ crc[26]^d[5] ^ crc[25]^d[6] ^ crc[1];
   o_crc[8]  = crc[28]^d[3] ^ crc[27]^d[4] ^ crc[25]^d[6] ^ crc[24]^d[7] ^ crc[0];
   o_crc[7]  = crc[31]^d[0] ^ crc[29]^d[2] ^ crc[27]^d[4] ^ crc[26]^d[5] ^ crc[24]^d[7];
   o_crc[6]  = crc[31]^d[0] ^ crc[30]^d[1] ^ crc[29]^d[2] ^ crc[28]^d[3] ^ crc[26]^d[5] ^ crc[25]^d[6];
   o_crc[5]  = crc[31]^d[0] ^ crc[30]^d[1] ^ crc[29]^d[2] ^ crc[28]^d[3] ^ crc[27]^d[4] ^ crc[25]^d[6] ^ crc[24]^d[7];
   o_crc[4]  = crc[30]^d[1] ^ crc[28]^d[3] ^ crc[27]^d[4] ^ crc[26]^d[5] ^ crc[24]^d[7];
   o_crc[3]  = crc[31]^d[0] ^ crc[27]^d[4] ^ crc[26]^d[5] ^ crc[25]^d[6];
   o_crc[2]  = crc[31]^d[0] ^ crc[30]^d[1] ^ crc[26]^d[5] ^ crc[25]^d[6] ^ crc[24]^d[7];
   o_crc[1]  = crc[31]^d[0] ^ crc[30]^d[1] ^ crc[25]^d[6] ^ crc[24]^d[7];
   o_crc[0]  = crc[30]^d[1] ^ crc[24]^d[7];
   crc_gen_32 = o_crc;
end
endfunction

// --------------------------------------------------------------------------
// -- Returns valid FCS for data in bld_frm_mem
function [31:0] fcs_calc;
   input          frm_bc;
   integer        frm_bc;
   reg     [31:0] crc;
   integer        j;
begin
   crc = 32'hFFFF_FFFF;                       // Start with all F's
   for ( j=0; j < frm_bc; j=j+1 )
      crc = crc_gen_32( crc, bld_frm_mem[j] );
   crc = ~crc;                                // Invert result
   crc = {crc[24], crc[25], crc[26], crc[27], // Reverse bit order
          crc[28], crc[29], crc[30], crc[31],
          crc[16], crc[17], crc[18], crc[19],
          crc[20], crc[21], crc[22], crc[23],
          crc[8],  crc[9],  crc[10], crc[11],
          crc[12], crc[13], crc[14], crc[15],
          crc[0],  crc[1],  crc[2],  crc[3],
          crc[4],  crc[5],  crc[6],  crc[7]};
   fcs_calc = crc;
end
endfunction
   
// --------------------------------------------------------------------------
// -- Returns random between and including maximum and minimum values
function [31:0] randinrange;
   input [31:0] max;
   input [31:0] min;
   input [31:0] seed;
begin
   randinrange = ({$random(seed)} % ((max-min) + 1 )) + min;
end
endfunction

// --------------------------------------------------------------------------
// -- Returns running disparity and 8 bit data
function [8:0] dcd10bto8b;
   input         rdi;          // running disparity in
   input   [9:0] tds;          // transmit data symbol
   reg           rdo;          // running disparity out
   reg     [7:0] tdo;          // decoded transmit data
   reg           dc, kc;       // data code, comma code
begin
  dc = 1'b0;
  kc = 1'b0;
  case ( {rdi, tds[0], tds[1], tds[2], tds[3], tds[4],
               tds[5], tds[6], tds[7], tds[8], tds[9]} )
    11'b0_1001110100 : {tdo, rdo, dc} = 10'b00000000_0_1;      // D0.0 
    11'b0_0111010100 : {tdo, rdo, dc} = 10'b00000001_0_1;      // D1.0 
    11'b0_1011010100 : {tdo, rdo, dc} = 10'b00000010_0_1;      // D2.0 
    11'b0_1100011011 : {tdo, rdo, dc} = 10'b00000011_1_1;      // D3.0 
    11'b0_1101010100 : {tdo, rdo, dc} = 10'b00000100_0_1;      // D4.0 
    11'b0_1010011011 : {tdo, rdo, dc} = 10'b00000101_1_1;      // D5.0 
    11'b0_0110011011 : {tdo, rdo, dc} = 10'b00000110_1_1;      // D6.0 
    11'b0_1110001011 : {tdo, rdo, dc} = 10'b00000111_1_1;      // D7.0 
    11'b0_1110010100 : {tdo, rdo, dc} = 10'b00001000_0_1;      // D8.0 
    11'b0_1001011011 : {tdo, rdo, dc} = 10'b00001001_1_1;      // D9.0 
    11'b0_0101011011 : {tdo, rdo, dc} = 10'b00001010_1_1;      // D10.0
    11'b0_1101001011 : {tdo, rdo, dc} = 10'b00001011_1_1;      // D11.0
    11'b0_0011011011 : {tdo, rdo, dc} = 10'b00001100_1_1;      // D12.0
    11'b0_1011001011 : {tdo, rdo, dc} = 10'b00001101_1_1;      // D13.0
    11'b0_0111001011 : {tdo, rdo, dc} = 10'b00001110_1_1;      // D14.0
    11'b0_0101110100 : {tdo, rdo, dc} = 10'b00001111_0_1;      // D15.0
    11'b0_0110110100 : {tdo, rdo, dc} = 10'b00010000_0_1;      // D16.0
    11'b0_1000111011 : {tdo, rdo, dc} = 10'b00010001_1_1;      // D17.0
    11'b0_0100111011 : {tdo, rdo, dc} = 10'b00010010_1_1;      // D18.0
    11'b0_1100101011 : {tdo, rdo, dc} = 10'b00010011_1_1;      // D19.0
    11'b0_0010111011 : {tdo, rdo, dc} = 10'b00010100_1_1;      // D20.0
    11'b0_1010101011 : {tdo, rdo, dc} = 10'b00010101_1_1;      // D21.0
    11'b0_0110101011 : {tdo, rdo, dc} = 10'b00010110_1_1;      // D22.0
    11'b0_1110100100 : {tdo, rdo, dc} = 10'b00010111_0_1;      // D23.0
    11'b0_1100110100 : {tdo, rdo, dc} = 10'b00011000_0_1;      // D24.0
    11'b0_1001101011 : {tdo, rdo, dc} = 10'b00011001_1_1;      // D25.0
    11'b0_0101101011 : {tdo, rdo, dc} = 10'b00011010_1_1;      // D26.0
    11'b0_1101100100 : {tdo, rdo, dc} = 10'b00011011_0_1;      // D27.0
    11'b0_0011101011 : {tdo, rdo, dc} = 10'b00011100_1_1;      // D28.0
    11'b0_1011100100 : {tdo, rdo, dc} = 10'b00011101_0_1;      // D29.0
    11'b0_0111100100 : {tdo, rdo, dc} = 10'b00011110_0_1;      // D30.0
    11'b0_1010110100 : {tdo, rdo, dc} = 10'b00011111_0_1;      // D31.0

    11'b0_1001111001 : {tdo, rdo, dc} = 10'b00100000_1_1;      // D0.1 
    11'b0_0111011001 : {tdo, rdo, dc} = 10'b00100001_1_1;      // D1.1 
    11'b0_1011011001 : {tdo, rdo, dc} = 10'b00100010_1_1;      // D2.1 
    11'b0_1100011001 : {tdo, rdo, dc} = 10'b00100011_0_1;      // D3.1 
    11'b0_1101011001 : {tdo, rdo, dc} = 10'b00100100_1_1;      // D4.1 
    11'b0_1010011001 : {tdo, rdo, dc} = 10'b00100101_0_1;      // D5.1 
    11'b0_0110011001 : {tdo, rdo, dc} = 10'b00100110_0_1;      // D6.1 
    11'b0_1110001001 : {tdo, rdo, dc} = 10'b00100111_0_1;      // D7.1 
    11'b0_1110011001 : {tdo, rdo, dc} = 10'b00101000_1_1;      // D8.1 
    11'b0_1001011001 : {tdo, rdo, dc} = 10'b00101001_0_1;      // D9.1 
    11'b0_0101011001 : {tdo, rdo, dc} = 10'b00101010_0_1;      // D10.1
    11'b0_1101001001 : {tdo, rdo, dc} = 10'b00101011_0_1;      // D11.1
    11'b0_0011011001 : {tdo, rdo, dc} = 10'b00101100_0_1;      // D12.1
    11'b0_1011001001 : {tdo, rdo, dc} = 10'b00101101_0_1;      // D13.1
    11'b0_0111001001 : {tdo, rdo, dc} = 10'b00101110_0_1;      // D14.1
    11'b0_0101111001 : {tdo, rdo, dc} = 10'b00101111_1_1;      // D15.1
    11'b0_0110111001 : {tdo, rdo, dc} = 10'b00110000_1_1;      // D16.1
    11'b0_1000111001 : {tdo, rdo, dc} = 10'b00110001_0_1;      // D17.1
    11'b0_0100111001 : {tdo, rdo, dc} = 10'b00110010_0_1;      // D18.1
    11'b0_1100101001 : {tdo, rdo, dc} = 10'b00110011_0_1;      // D19.1
    11'b0_0010111001 : {tdo, rdo, dc} = 10'b00110100_0_1;      // D20.1
    11'b0_1010101001 : {tdo, rdo, dc} = 10'b00110101_0_1;      // D21.1
    11'b0_0110101001 : {tdo, rdo, dc} = 10'b00110110_0_1;      // D22.1
    11'b0_1110101001 : {tdo, rdo, dc} = 10'b00110111_1_1;      // D23.1
    11'b0_1100111001 : {tdo, rdo, dc} = 10'b00111000_1_1;      // D24.1
    11'b0_1001101001 : {tdo, rdo, dc} = 10'b00111001_0_1;      // D25.1
    11'b0_0101101001 : {tdo, rdo, dc} = 10'b00111010_0_1;      // D26.1
    11'b0_1101101001 : {tdo, rdo, dc} = 10'b00111011_1_1;      // D27.1
    11'b0_0011101001 : {tdo, rdo, dc} = 10'b00111100_0_1;      // D28.1
    11'b0_1011101001 : {tdo, rdo, dc} = 10'b00111101_1_1;      // D29.1
    11'b0_0111101001 : {tdo, rdo, dc} = 10'b00111110_1_1;      // D30.1
    11'b0_1010111001 : {tdo, rdo, dc} = 10'b00111111_1_1;      // D31.1

    11'b0_1001110101 : {tdo, rdo, dc} = 10'b01000000_1_1;      // D0.2 
    11'b0_0111010101 : {tdo, rdo, dc} = 10'b01000001_1_1;      // D1.2 
    11'b0_1011010101 : {tdo, rdo, dc} = 10'b01000010_1_1;      // D2.2 
    11'b0_1100010101 : {tdo, rdo, dc} = 10'b01000011_0_1;      // D3.2 
    11'b0_1101010101 : {tdo, rdo, dc} = 10'b01000100_1_1;      // D4.2 
    11'b0_1010010101 : {tdo, rdo, dc} = 10'b01000101_0_1;      // D5.2 
    11'b0_0110010101 : {tdo, rdo, dc} = 10'b01000110_0_1;      // D6.2 
    11'b0_1110000101 : {tdo, rdo, dc} = 10'b01000111_0_1;      // D7.2 
    11'b0_1110010101 : {tdo, rdo, dc} = 10'b01001000_1_1;      // D8.2 
    11'b0_1001010101 : {tdo, rdo, dc} = 10'b01001001_0_1;      // D9.2 
    11'b0_0101010101 : {tdo, rdo, dc} = 10'b01001010_0_1;      // D10.2
    11'b0_1101000101 : {tdo, rdo, dc} = 10'b01001011_0_1;      // D11.2
    11'b0_0011010101 : {tdo, rdo, dc} = 10'b01001100_0_1;      // D12.2
    11'b0_1011000101 : {tdo, rdo, dc} = 10'b01001101_0_1;      // D13.2
    11'b0_0111000101 : {tdo, rdo, dc} = 10'b01001110_0_1;      // D14.2
    11'b0_0101110101 : {tdo, rdo, dc} = 10'b01001111_1_1;      // D15.2
    11'b0_0110110101 : {tdo, rdo, dc} = 10'b01010000_1_1;      // D16.2
    11'b0_1000110101 : {tdo, rdo, dc} = 10'b01010001_0_1;      // D17.2
    11'b0_0100110101 : {tdo, rdo, dc} = 10'b01010010_0_1;      // D18.2
    11'b0_1100100101 : {tdo, rdo, dc} = 10'b01010011_0_1;      // D19.2
    11'b0_0010110101 : {tdo, rdo, dc} = 10'b01010100_0_1;      // D20.2
    11'b0_1010100101 : {tdo, rdo, dc} = 10'b01010101_0_1;      // D21.2
    11'b0_0110100101 : {tdo, rdo, dc} = 10'b01010110_0_1;      // D22.2
    11'b0_1110100101 : {tdo, rdo, dc} = 10'b01010111_1_1;      // D23.2
    11'b0_1100110101 : {tdo, rdo, dc} = 10'b01011000_1_1;      // D24.2
    11'b0_1001100101 : {tdo, rdo, dc} = 10'b01011001_0_1;      // D25.2
    11'b0_0101100101 : {tdo, rdo, dc} = 10'b01011010_0_1;      // D26.2
    11'b0_1101100101 : {tdo, rdo, dc} = 10'b01011011_1_1;      // D27.2
    11'b0_0011100101 : {tdo, rdo, dc} = 10'b01011100_0_1;      // D28.2
    11'b0_1011100101 : {tdo, rdo, dc} = 10'b01011101_1_1;      // D29.2
    11'b0_0111100101 : {tdo, rdo, dc} = 10'b01011110_1_1;      // D30.2
    11'b0_1010110101 : {tdo, rdo, dc} = 10'b01011111_1_1;      // D31.2

    11'b0_1001110011 : {tdo, rdo, dc} = 10'b01100000_1_1;      // D0.3 
    11'b0_0111010011 : {tdo, rdo, dc} = 10'b01100001_1_1;      // D1.3 
    11'b0_1011010011 : {tdo, rdo, dc} = 10'b01100010_1_1;      // D2.3 
    11'b0_1100011100 : {tdo, rdo, dc} = 10'b01100011_0_1;      // D3.3 
    11'b0_1101010011 : {tdo, rdo, dc} = 10'b01100100_1_1;      // D4.3 
    11'b0_1010011100 : {tdo, rdo, dc} = 10'b01100101_0_1;      // D5.3 
    11'b0_0110011100 : {tdo, rdo, dc} = 10'b01100110_0_1;      // D6.3 
    11'b0_1110001100 : {tdo, rdo, dc} = 10'b01100111_0_1;      // D7.3 
    11'b0_1110010011 : {tdo, rdo, dc} = 10'b01101000_1_1;      // D8.3 
    11'b0_1001011100 : {tdo, rdo, dc} = 10'b01101001_0_1;      // D9.3 
    11'b0_0101011100 : {tdo, rdo, dc} = 10'b01101010_0_1;      // D10.3
    11'b0_1101001100 : {tdo, rdo, dc} = 10'b01101011_0_1;      // D11.3
    11'b0_0011011100 : {tdo, rdo, dc} = 10'b01101100_0_1;      // D12.3
    11'b0_1011001100 : {tdo, rdo, dc} = 10'b01101101_0_1;      // D13.3
    11'b0_0111001100 : {tdo, rdo, dc} = 10'b01101110_0_1;      // D14.3
    11'b0_0101110011 : {tdo, rdo, dc} = 10'b01101111_1_1;      // D15.3
    11'b0_0110110011 : {tdo, rdo, dc} = 10'b01110000_1_1;      // D16.3
    11'b0_1000111100 : {tdo, rdo, dc} = 10'b01110001_0_1;      // D17.3
    11'b0_0100111100 : {tdo, rdo, dc} = 10'b01110010_0_1;      // D18.3
    11'b0_1100101100 : {tdo, rdo, dc} = 10'b01110011_0_1;      // D19.3
    11'b0_0010111100 : {tdo, rdo, dc} = 10'b01110100_0_1;      // D20.3
    11'b0_1010101100 : {tdo, rdo, dc} = 10'b01110101_0_1;      // D21.3
    11'b0_0110101100 : {tdo, rdo, dc} = 10'b01110110_0_1;      // D22.3
    11'b0_1110100011 : {tdo, rdo, dc} = 10'b01110111_1_1;      // D23.3
    11'b0_1100110011 : {tdo, rdo, dc} = 10'b01111000_1_1;      // D24.3
    11'b0_1001101100 : {tdo, rdo, dc} = 10'b01111001_0_1;      // D25.3
    11'b0_0101101100 : {tdo, rdo, dc} = 10'b01111010_0_1;      // D26.3
    11'b0_1101100011 : {tdo, rdo, dc} = 10'b01111011_1_1;      // D27.3
    11'b0_0011101100 : {tdo, rdo, dc} = 10'b01111100_0_1;      // D28.3
    11'b0_1011100011 : {tdo, rdo, dc} = 10'b01111101_1_1;      // D29.3
    11'b0_0111100011 : {tdo, rdo, dc} = 10'b01111110_1_1;      // D30.3
    11'b0_1010110011 : {tdo, rdo, dc} = 10'b01111111_1_1;      // D31.3

    11'b0_1001110010 : {tdo, rdo, dc} = 10'b10000000_0_1;      // D0.4 
    11'b0_0111010010 : {tdo, rdo, dc} = 10'b10000001_0_1;      // D1.4 
    11'b0_1011010010 : {tdo, rdo, dc} = 10'b10000010_0_1;      // D2.4 
    11'b0_1100011101 : {tdo, rdo, dc} = 10'b10000011_1_1;      // D3.4 
    11'b0_1101010010 : {tdo, rdo, dc} = 10'b10000100_0_1;      // D4.4 
    11'b0_1010011101 : {tdo, rdo, dc} = 10'b10000101_1_1;      // D5.4 
    11'b0_0110011101 : {tdo, rdo, dc} = 10'b10000110_1_1;      // D6.4 
    11'b0_1110001101 : {tdo, rdo, dc} = 10'b10000111_1_1;      // D7.4 
    11'b0_1110010010 : {tdo, rdo, dc} = 10'b10001000_0_1;      // D8.4 
    11'b0_1001011101 : {tdo, rdo, dc} = 10'b10001001_1_1;      // D9.4 
    11'b0_0101011101 : {tdo, rdo, dc} = 10'b10001010_1_1;      // D10.4
    11'b0_1101001101 : {tdo, rdo, dc} = 10'b10001011_1_1;      // D11.4
    11'b0_0011011101 : {tdo, rdo, dc} = 10'b10001100_1_1;      // D12.4
    11'b0_1011001101 : {tdo, rdo, dc} = 10'b10001101_1_1;      // D13.4
    11'b0_0111001101 : {tdo, rdo, dc} = 10'b10001110_1_1;      // D14.4
    11'b0_0101110010 : {tdo, rdo, dc} = 10'b10001111_0_1;      // D15.4
    11'b0_0110110010 : {tdo, rdo, dc} = 10'b10010000_0_1;      // D16.4
    11'b0_1000111101 : {tdo, rdo, dc} = 10'b10010001_1_1;      // D17.4
    11'b0_0100111101 : {tdo, rdo, dc} = 10'b10010010_1_1;      // D18.4
    11'b0_1100101101 : {tdo, rdo, dc} = 10'b10010011_1_1;      // D19.4
    11'b0_0010111101 : {tdo, rdo, dc} = 10'b10010100_1_1;      // D20.4
    11'b0_1010101101 : {tdo, rdo, dc} = 10'b10010101_1_1;      // D21.4
    11'b0_0110101101 : {tdo, rdo, dc} = 10'b10010110_1_1;      // D22.4
    11'b0_1110100010 : {tdo, rdo, dc} = 10'b10010111_0_1;      // D23.4
    11'b0_1100110010 : {tdo, rdo, dc} = 10'b10011000_0_1;      // D24.4
    11'b0_1001101101 : {tdo, rdo, dc} = 10'b10011001_1_1;      // D25.4
    11'b0_0101101101 : {tdo, rdo, dc} = 10'b10011010_1_1;      // D26.4
    11'b0_1101100010 : {tdo, rdo, dc} = 10'b10011011_0_1;      // D27.4
    11'b0_0011101101 : {tdo, rdo, dc} = 10'b10011100_1_1;      // D28.4
    11'b0_1011100010 : {tdo, rdo, dc} = 10'b10011101_0_1;      // D29.4
    11'b0_0111100010 : {tdo, rdo, dc} = 10'b10011110_0_1;      // D30.4
    11'b0_1010110010 : {tdo, rdo, dc} = 10'b10011111_0_1;      // D31.4

    11'b0_1001111010 : {tdo, rdo, dc} = 10'b10100000_1_1;      // D0.5 
    11'b0_0111011010 : {tdo, rdo, dc} = 10'b10100001_1_1;      // D1.5 
    11'b0_1011011010 : {tdo, rdo, dc} = 10'b10100010_1_1;      // D2.5 
    11'b0_1100011010 : {tdo, rdo, dc} = 10'b10100011_0_1;      // D3.5 
    11'b0_1101011010 : {tdo, rdo, dc} = 10'b10100100_1_1;      // D4.5 
    11'b0_1010011010 : {tdo, rdo, dc} = 10'b10100101_0_1;      // D5.5 
    11'b0_0110011010 : {tdo, rdo, dc} = 10'b10100110_0_1;      // D6.5 
    11'b0_1110001010 : {tdo, rdo, dc} = 10'b10100111_0_1;      // D7.5 
    11'b0_1110011010 : {tdo, rdo, dc} = 10'b10101000_1_1;      // D8.5 
    11'b0_1001011010 : {tdo, rdo, dc} = 10'b10101001_0_1;      // D9.5 
    11'b0_0101011010 : {tdo, rdo, dc} = 10'b10101010_0_1;      // D10.5
    11'b0_1101001010 : {tdo, rdo, dc} = 10'b10101011_0_1;      // D11.5
    11'b0_0011011010 : {tdo, rdo, dc} = 10'b10101100_0_1;      // D12.5
    11'b0_1011001010 : {tdo, rdo, dc} = 10'b10101101_0_1;      // D13.5
    11'b0_0111001010 : {tdo, rdo, dc} = 10'b10101110_0_1;      // D14.5
    11'b0_0101111010 : {tdo, rdo, dc} = 10'b10101111_1_1;      // D15.5
    11'b0_0110111010 : {tdo, rdo, dc} = 10'b10110000_1_1;      // D16.5
    11'b0_1000111010 : {tdo, rdo, dc} = 10'b10110001_0_1;      // D17.5
    11'b0_0100111010 : {tdo, rdo, dc} = 10'b10110010_0_1;      // D18.5
    11'b0_1100101010 : {tdo, rdo, dc} = 10'b10110011_0_1;      // D19.5
    11'b0_0010111010 : {tdo, rdo, dc} = 10'b10110100_0_1;      // D20.5
    11'b0_1010101010 : {tdo, rdo, dc} = 10'b10110101_0_1;      // D21.5
    11'b0_0110101010 : {tdo, rdo, dc} = 10'b10110110_0_1;      // D22.5
    11'b0_1110101010 : {tdo, rdo, dc} = 10'b10110111_1_1;      // D23.5
    11'b0_1100111010 : {tdo, rdo, dc} = 10'b10111000_1_1;      // D24.5
    11'b0_1001101010 : {tdo, rdo, dc} = 10'b10111001_0_1;      // D25.5
    11'b0_0101101010 : {tdo, rdo, dc} = 10'b10111010_0_1;      // D26.5
    11'b0_1101101010 : {tdo, rdo, dc} = 10'b10111011_1_1;      // D27.5
    11'b0_0011101010 : {tdo, rdo, dc} = 10'b10111100_0_1;      // D28.5
    11'b0_1011101010 : {tdo, rdo, dc} = 10'b10111101_1_1;      // D29.5
    11'b0_0111101010 : {tdo, rdo, dc} = 10'b10111110_1_1;      // D30.5
    11'b0_1010111010 : {tdo, rdo, dc} = 10'b10111111_1_1;      // D31.5

    11'b0_1001110110 : {tdo, rdo, dc} = 10'b11000000_1_1;      // D0.6 
    11'b0_0111010110 : {tdo, rdo, dc} = 10'b11000001_1_1;      // D1.6 
    11'b0_1011010110 : {tdo, rdo, dc} = 10'b11000010_1_1;      // D2.6 
    11'b0_1100010110 : {tdo, rdo, dc} = 10'b11000011_0_1;      // D3.6 
    11'b0_1101010110 : {tdo, rdo, dc} = 10'b11000100_1_1;      // D4.6 
    11'b0_1010010110 : {tdo, rdo, dc} = 10'b11000101_0_1;      // D5.6 
    11'b0_0110010110 : {tdo, rdo, dc} = 10'b11000110_0_1;      // D6.6 
    11'b0_1110000110 : {tdo, rdo, dc} = 10'b11000111_0_1;      // D7.6 
    11'b0_1110010110 : {tdo, rdo, dc} = 10'b11001000_1_1;      // D8.6 
    11'b0_1001010110 : {tdo, rdo, dc} = 10'b11001001_0_1;      // D9.6 
    11'b0_0101010110 : {tdo, rdo, dc} = 10'b11001010_0_1;      // D10.6
    11'b0_1101000110 : {tdo, rdo, dc} = 10'b11001011_0_1;      // D11.6
    11'b0_0011010110 : {tdo, rdo, dc} = 10'b11001100_0_1;      // D12.6
    11'b0_1011000110 : {tdo, rdo, dc} = 10'b11001101_0_1;      // D13.6
    11'b0_0111000110 : {tdo, rdo, dc} = 10'b11001110_0_1;      // D14.6
    11'b0_0101110110 : {tdo, rdo, dc} = 10'b11001111_1_1;      // D15.6
    11'b0_0110110110 : {tdo, rdo, dc} = 10'b11010000_1_1;      // D16.6
    11'b0_1000110110 : {tdo, rdo, dc} = 10'b11010001_0_1;      // D17.6
    11'b0_0100110110 : {tdo, rdo, dc} = 10'b11010010_0_1;      // D18.6
    11'b0_1100100110 : {tdo, rdo, dc} = 10'b11010011_0_1;      // D19.6
    11'b0_0010110110 : {tdo, rdo, dc} = 10'b11010100_0_1;      // D20.6
    11'b0_1010100110 : {tdo, rdo, dc} = 10'b11010101_0_1;      // D21.6
    11'b0_0110100110 : {tdo, rdo, dc} = 10'b11010110_0_1;      // D22.6
    11'b0_1110100110 : {tdo, rdo, dc} = 10'b11010111_1_1;      // D23.6
    11'b0_1100110110 : {tdo, rdo, dc} = 10'b11011000_1_1;      // D24.6
    11'b0_1001100110 : {tdo, rdo, dc} = 10'b11011001_0_1;      // D25.6
    11'b0_0101100110 : {tdo, rdo, dc} = 10'b11011010_0_1;      // D26.6
    11'b0_1101100110 : {tdo, rdo, dc} = 10'b11011011_1_1;      // D27.6
    11'b0_0011100110 : {tdo, rdo, dc} = 10'b11011100_0_1;      // D28.6
    11'b0_1011100110 : {tdo, rdo, dc} = 10'b11011101_1_1;      // D29.6
    11'b0_0111100110 : {tdo, rdo, dc} = 10'b11011110_1_1;      // D30.6
    11'b0_1010110110 : {tdo, rdo, dc} = 10'b11011111_1_1;      // D31.6

    11'b0_1001110001 : {tdo, rdo, dc} = 10'b11100000_0_1;      // D0.7 
    11'b0_0111010001 : {tdo, rdo, dc} = 10'b11100001_0_1;      // D1.7 
    11'b0_1011010001 : {tdo, rdo, dc} = 10'b11100010_0_1;      // D2.7 
    11'b0_1100011110 : {tdo, rdo, dc} = 10'b11100011_1_1;      // D3.7 
    11'b0_1101010001 : {tdo, rdo, dc} = 10'b11100100_0_1;      // D4.7 
    11'b0_1010011110 : {tdo, rdo, dc} = 10'b11100101_1_1;      // D5.7 
    11'b0_0110011110 : {tdo, rdo, dc} = 10'b11100110_1_1;      // D6.7 
    11'b0_1110001110 : {tdo, rdo, dc} = 10'b11100111_1_1;      // D7.7 
    11'b0_1110010001 : {tdo, rdo, dc} = 10'b11101000_0_1;      // D8.7 
    11'b0_1001011110 : {tdo, rdo, dc} = 10'b11101001_1_1;      // D9.7 
    11'b0_0101011110 : {tdo, rdo, dc} = 10'b11101010_1_1;      // D10.7
    11'b0_1101001110 : {tdo, rdo, dc} = 10'b11101011_1_1;      // D11.7
    11'b0_0011011110 : {tdo, rdo, dc} = 10'b11101100_1_1;      // D12.7
    11'b0_1011001110 : {tdo, rdo, dc} = 10'b11101101_1_1;      // D13.7
    11'b0_0111001110 : {tdo, rdo, dc} = 10'b11101110_1_1;      // D14.7
    11'b0_0101110001 : {tdo, rdo, dc} = 10'b11101111_0_1;      // D15.7
    11'b0_0110110001 : {tdo, rdo, dc} = 10'b11110000_0_1;      // D16.7
    11'b0_1000110111 : {tdo, rdo, dc} = 10'b11110001_1_1;      // D17.7
    11'b0_0100110111 : {tdo, rdo, dc} = 10'b11110010_1_1;      // D18.7
    11'b0_1100101110 : {tdo, rdo, dc} = 10'b11110011_1_1;      // D19.7
    11'b0_0010110111 : {tdo, rdo, dc} = 10'b11110100_1_1;      // D20.7
    11'b0_1010101110 : {tdo, rdo, dc} = 10'b11110101_1_1;      // D21.7
    11'b0_0110101110 : {tdo, rdo, dc} = 10'b11110110_1_1;      // D22.7
    11'b0_1110100001 : {tdo, rdo, dc} = 10'b11110111_0_1;      // D23.7
    11'b0_1100110001 : {tdo, rdo, dc} = 10'b11111000_0_1;      // D24.7
    11'b0_1001101110 : {tdo, rdo, dc} = 10'b11111001_1_1;      // D25.7
    11'b0_0101101110 : {tdo, rdo, dc} = 10'b11111010_1_1;      // D26.7
    11'b0_1101100001 : {tdo, rdo, dc} = 10'b11111011_0_1;      // D27.7
    11'b0_0011101110 : {tdo, rdo, dc} = 10'b11111100_1_1;      // D28.7
    11'b0_1011100001 : {tdo, rdo, dc} = 10'b11111101_0_1;      // D29.7
    11'b0_0111100001 : {tdo, rdo, dc} = 10'b11111110_0_1;      // D30.7
    11'b0_1010110001 : {tdo, rdo, dc} = 10'b11111111_0_1;      // D31.7
              
    11'b1_0110001011 : {tdo, rdo, dc} = 10'b00000000_0_1;      // D0.0 
    11'b1_1000101011 : {tdo, rdo, dc} = 10'b00000001_0_1;      // D1.0 
    11'b1_0100101011 : {tdo, rdo, dc} = 10'b00000010_0_1;      // D2.0 
    11'b1_1100010100 : {tdo, rdo, dc} = 10'b00000011_1_1;      // D3.0 
    11'b1_0010101011 : {tdo, rdo, dc} = 10'b00000100_0_1;      // D4.0 
    11'b1_1010010100 : {tdo, rdo, dc} = 10'b00000101_1_1;      // D5.0 
    11'b1_0110010100 : {tdo, rdo, dc} = 10'b00000110_1_1;      // D6.0 
    11'b1_0001110100 : {tdo, rdo, dc} = 10'b00000111_1_1;      // D7.0 
    11'b1_0001101011 : {tdo, rdo, dc} = 10'b00001000_0_1;      // D8.0 
    11'b1_1001010100 : {tdo, rdo, dc} = 10'b00001001_1_1;      // D9.0 
    11'b1_0101010100 : {tdo, rdo, dc} = 10'b00001010_1_1;      // D10.0
    11'b1_1101000100 : {tdo, rdo, dc} = 10'b00001011_1_1;      // D11.0
    11'b1_0011010100 : {tdo, rdo, dc} = 10'b00001100_1_1;      // D12.0
    11'b1_1011000100 : {tdo, rdo, dc} = 10'b00001101_1_1;      // D13.0
    11'b1_0111000100 : {tdo, rdo, dc} = 10'b00001110_1_1;      // D14.0
    11'b1_1010001011 : {tdo, rdo, dc} = 10'b00001111_0_1;      // D15.0
    11'b1_1001001011 : {tdo, rdo, dc} = 10'b00010000_0_1;      // D16.0
    11'b1_1000110100 : {tdo, rdo, dc} = 10'b00010001_1_1;      // D17.0
    11'b1_0100110100 : {tdo, rdo, dc} = 10'b00010010_1_1;      // D18.0
    11'b1_1100100100 : {tdo, rdo, dc} = 10'b00010011_1_1;      // D19.0
    11'b1_0010110100 : {tdo, rdo, dc} = 10'b00010100_1_1;      // D20.0
    11'b1_1010100100 : {tdo, rdo, dc} = 10'b00010101_1_1;      // D21.0
    11'b1_0110100100 : {tdo, rdo, dc} = 10'b00010110_1_1;      // D22.0
    11'b1_0001011011 : {tdo, rdo, dc} = 10'b00010111_0_1;      // D23.0
    11'b1_0011001011 : {tdo, rdo, dc} = 10'b00011000_0_1;      // D24.0
    11'b1_1001100100 : {tdo, rdo, dc} = 10'b00011001_1_1;      // D25.0
    11'b1_0101100100 : {tdo, rdo, dc} = 10'b00011010_1_1;      // D26.0
    11'b1_0010011011 : {tdo, rdo, dc} = 10'b00011011_0_1;      // D27.0
    11'b1_0011100100 : {tdo, rdo, dc} = 10'b00011100_1_1;      // D28.0
    11'b1_0100011011 : {tdo, rdo, dc} = 10'b00011101_0_1;      // D29.0
    11'b1_1000011011 : {tdo, rdo, dc} = 10'b00011110_0_1;      // D30.0
    11'b1_0101001011 : {tdo, rdo, dc} = 10'b00011111_0_1;      // D31.0
              
    11'b1_0110001001 : {tdo, rdo, dc} = 10'b00100000_1_1;      // D0.1 
    11'b1_1000101001 : {tdo, rdo, dc} = 10'b00100001_1_1;      // D1.1 
    11'b1_0100101001 : {tdo, rdo, dc} = 10'b00100010_1_1;      // D2.1 
    11'b1_1100011001 : {tdo, rdo, dc} = 10'b00100011_0_1;      // D3.1 
    11'b1_0010101001 : {tdo, rdo, dc} = 10'b00100100_1_1;      // D4.1 
    11'b1_1010011001 : {tdo, rdo, dc} = 10'b00100101_0_1;      // D5.1 
    11'b1_0110011001 : {tdo, rdo, dc} = 10'b00100110_0_1;      // D6.1 
    11'b1_0001111001 : {tdo, rdo, dc} = 10'b00100111_0_1;      // D7.1 
    11'b1_0001101001 : {tdo, rdo, dc} = 10'b00101000_1_1;      // D8.1 
    11'b1_1001011001 : {tdo, rdo, dc} = 10'b00101001_0_1;      // D9.1 
    11'b1_0101011001 : {tdo, rdo, dc} = 10'b00101010_0_1;      // D10.1
    11'b1_1101001001 : {tdo, rdo, dc} = 10'b00101011_0_1;      // D11.1
    11'b1_0011011001 : {tdo, rdo, dc} = 10'b00101100_0_1;      // D12.1
    11'b1_1011001001 : {tdo, rdo, dc} = 10'b00101101_0_1;      // D13.1
    11'b1_0111001001 : {tdo, rdo, dc} = 10'b00101110_0_1;      // D14.1
    11'b1_1010001001 : {tdo, rdo, dc} = 10'b00101111_1_1;      // D15.1
    11'b1_1001001001 : {tdo, rdo, dc} = 10'b00110000_1_1;      // D16.1
    11'b1_1000111001 : {tdo, rdo, dc} = 10'b00110001_0_1;      // D17.1
    11'b1_0100111001 : {tdo, rdo, dc} = 10'b00110010_0_1;      // D18.1
    11'b1_1100101001 : {tdo, rdo, dc} = 10'b00110011_0_1;      // D19.1
    11'b1_0010111001 : {tdo, rdo, dc} = 10'b00110100_0_1;      // D20.1
    11'b1_1010101001 : {tdo, rdo, dc} = 10'b00110101_0_1;      // D21.1
    11'b1_0110101001 : {tdo, rdo, dc} = 10'b00110110_0_1;      // D22.1
    11'b1_0001011001 : {tdo, rdo, dc} = 10'b00110111_1_1;      // D23.1
    11'b1_0011001001 : {tdo, rdo, dc} = 10'b00111000_1_1;      // D24.1
    11'b1_1001101001 : {tdo, rdo, dc} = 10'b00111001_0_1;      // D25.1
    11'b1_0101101001 : {tdo, rdo, dc} = 10'b00111010_0_1;      // D26.1
    11'b1_0010011001 : {tdo, rdo, dc} = 10'b00111011_1_1;      // D27.1
    11'b1_0011101001 : {tdo, rdo, dc} = 10'b00111100_0_1;      // D28.1
    11'b1_0100011001 : {tdo, rdo, dc} = 10'b00111101_1_1;      // D29.1
    11'b1_1000011001 : {tdo, rdo, dc} = 10'b00111110_1_1;      // D30.1
    11'b1_0101001001 : {tdo, rdo, dc} = 10'b00111111_1_1;      // D31.1
              
    11'b1_0110000101 : {tdo, rdo, dc} = 10'b01000000_1_1;      // D0.2 
    11'b1_1000100101 : {tdo, rdo, dc} = 10'b01000001_1_1;      // D1.2 
    11'b1_0100100101 : {tdo, rdo, dc} = 10'b01000010_1_1;      // D2.2 
    11'b1_1100010101 : {tdo, rdo, dc} = 10'b01000011_0_1;      // D3.2 
    11'b1_0010100101 : {tdo, rdo, dc} = 10'b01000100_1_1;      // D4.2 
    11'b1_1010010101 : {tdo, rdo, dc} = 10'b01000101_0_1;      // D5.2 
    11'b1_0110010101 : {tdo, rdo, dc} = 10'b01000110_0_1;      // D6.2 
    11'b1_0001110101 : {tdo, rdo, dc} = 10'b01000111_0_1;      // D7.2 
    11'b1_0001100101 : {tdo, rdo, dc} = 10'b01001000_1_1;      // D8.2 
    11'b1_1001010101 : {tdo, rdo, dc} = 10'b01001001_0_1;      // D9.2 
    11'b1_0101010101 : {tdo, rdo, dc} = 10'b01001010_0_1;      // D10.2
    11'b1_1101000101 : {tdo, rdo, dc} = 10'b01001011_0_1;      // D11.2
    11'b1_0011010101 : {tdo, rdo, dc} = 10'b01001100_0_1;      // D12.2
    11'b1_1011000101 : {tdo, rdo, dc} = 10'b01001101_0_1;      // D13.2
    11'b1_0111000101 : {tdo, rdo, dc} = 10'b01001110_0_1;      // D14.2
    11'b1_1010000101 : {tdo, rdo, dc} = 10'b01001111_1_1;      // D15.2
    11'b1_1001000101 : {tdo, rdo, dc} = 10'b01010000_1_1;      // D16.2
    11'b1_1000110101 : {tdo, rdo, dc} = 10'b01010001_0_1;      // D17.2
    11'b1_0100110101 : {tdo, rdo, dc} = 10'b01010010_0_1;      // D18.2
    11'b1_1100100101 : {tdo, rdo, dc} = 10'b01010011_0_1;      // D19.2
    11'b1_0010110101 : {tdo, rdo, dc} = 10'b01010100_0_1;      // D20.2
    11'b1_1010100101 : {tdo, rdo, dc} = 10'b01010101_0_1;      // D21.2
    11'b1_0110100101 : {tdo, rdo, dc} = 10'b01010110_0_1;      // D22.2
    11'b1_0001010101 : {tdo, rdo, dc} = 10'b01010111_1_1;      // D23.2
    11'b1_0011000101 : {tdo, rdo, dc} = 10'b01011000_1_1;      // D24.2
    11'b1_1001100101 : {tdo, rdo, dc} = 10'b01011001_0_1;      // D25.2
    11'b1_0101100101 : {tdo, rdo, dc} = 10'b01011010_0_1;      // D26.2
    11'b1_0010010101 : {tdo, rdo, dc} = 10'b01011011_1_1;      // D27.2
    11'b1_0011100101 : {tdo, rdo, dc} = 10'b01011100_0_1;      // D28.2
    11'b1_0100010101 : {tdo, rdo, dc} = 10'b01011101_1_1;      // D29.2
    11'b1_1000010101 : {tdo, rdo, dc} = 10'b01011110_1_1;      // D30.2
    11'b1_0101000101 : {tdo, rdo, dc} = 10'b01011111_1_1;      // D31.2

    11'b1_0110001100 : {tdo, rdo, dc} = 10'b01100000_1_1;      // D0.3 
    11'b1_1000101100 : {tdo, rdo, dc} = 10'b01100001_1_1;      // D1.3 
    11'b1_0100101100 : {tdo, rdo, dc} = 10'b01100010_1_1;      // D2.3 
    11'b1_1100010011 : {tdo, rdo, dc} = 10'b01100011_0_1;      // D3.3 
    11'b1_0010101100 : {tdo, rdo, dc} = 10'b01100100_1_1;      // D4.3 
    11'b1_1010010011 : {tdo, rdo, dc} = 10'b01100101_0_1;      // D5.3 
    11'b1_0110010011 : {tdo, rdo, dc} = 10'b01100110_0_1;      // D6.3 
    11'b1_0001110011 : {tdo, rdo, dc} = 10'b01100111_0_1;      // D7.3 
    11'b1_0001101100 : {tdo, rdo, dc} = 10'b01101000_1_1;      // D8.3 
    11'b1_1001010011 : {tdo, rdo, dc} = 10'b01101001_0_1;      // D9.3 
    11'b1_0101010011 : {tdo, rdo, dc} = 10'b01101010_0_1;      // D10.3
    11'b1_1101000011 : {tdo, rdo, dc} = 10'b01101011_0_1;      // D11.3
    11'b1_0011010011 : {tdo, rdo, dc} = 10'b01101100_0_1;      // D12.3
    11'b1_1011000011 : {tdo, rdo, dc} = 10'b01101101_0_1;      // D13.3
    11'b1_0111000011 : {tdo, rdo, dc} = 10'b01101110_0_1;      // D14.3
    11'b1_1010001100 : {tdo, rdo, dc} = 10'b01101111_1_1;      // D15.3
    11'b1_1001001100 : {tdo, rdo, dc} = 10'b01110000_1_1;      // D16.3
    11'b1_1000110011 : {tdo, rdo, dc} = 10'b01110001_0_1;      // D17.3
    11'b1_0100110011 : {tdo, rdo, dc} = 10'b01110010_0_1;      // D18.3
    11'b1_1100100011 : {tdo, rdo, dc} = 10'b01110011_0_1;      // D19.3
    11'b1_0010110011 : {tdo, rdo, dc} = 10'b01110100_0_1;      // D20.3
    11'b1_1010100011 : {tdo, rdo, dc} = 10'b01110101_0_1;      // D21.3
    11'b1_0110100011 : {tdo, rdo, dc} = 10'b01110110_0_1;      // D22.3
    11'b1_0001011100 : {tdo, rdo, dc} = 10'b01110111_1_1;      // D23.3
    11'b1_0011001100 : {tdo, rdo, dc} = 10'b01111000_1_1;      // D24.3
    11'b1_1001100011 : {tdo, rdo, dc} = 10'b01111001_0_1;      // D25.3
    11'b1_0101100011 : {tdo, rdo, dc} = 10'b01111010_0_1;      // D26.3
    11'b1_0010011100 : {tdo, rdo, dc} = 10'b01111011_1_1;      // D27.3
    11'b1_0011100011 : {tdo, rdo, dc} = 10'b01111100_0_1;      // D28.3
    11'b1_0100011100 : {tdo, rdo, dc} = 10'b01111101_1_1;      // D29.3
    11'b1_1000011100 : {tdo, rdo, dc} = 10'b01111110_1_1;      // D30.3
    11'b1_0101001100 : {tdo, rdo, dc} = 10'b01111111_1_1;      // D31.3
              
    11'b1_0110001101 : {tdo, rdo, dc} = 10'b10000000_0_1;      // D0.4 
    11'b1_1000101101 : {tdo, rdo, dc} = 10'b10000001_0_1;      // D1.4 
    11'b1_0100101101 : {tdo, rdo, dc} = 10'b10000010_0_1;      // D2.4 
    11'b1_1100010010 : {tdo, rdo, dc} = 10'b10000011_1_1;      // D3.4 
    11'b1_0010101101 : {tdo, rdo, dc} = 10'b10000100_0_1;      // D4.4 
    11'b1_1010010010 : {tdo, rdo, dc} = 10'b10000101_1_1;      // D5.4 
    11'b1_0110010010 : {tdo, rdo, dc} = 10'b10000110_1_1;      // D6.4 
    11'b1_0001110010 : {tdo, rdo, dc} = 10'b10000111_1_1;      // D7.4 
    11'b1_0001101101 : {tdo, rdo, dc} = 10'b10001000_0_1;      // D8.4 
    11'b1_1001010010 : {tdo, rdo, dc} = 10'b10001001_1_1;      // D9.4 
    11'b1_0101010010 : {tdo, rdo, dc} = 10'b10001010_1_1;      // D10.4
    11'b1_1101000010 : {tdo, rdo, dc} = 10'b10001011_1_1;      // D11.4
    11'b1_0011010010 : {tdo, rdo, dc} = 10'b10001100_1_1;      // D12.4
    11'b1_1011000010 : {tdo, rdo, dc} = 10'b10001101_1_1;      // D13.4
    11'b1_0111000010 : {tdo, rdo, dc} = 10'b10001110_1_1;      // D14.4
    11'b1_1010001101 : {tdo, rdo, dc} = 10'b10001111_0_1;      // D15.4
    11'b1_1001001101 : {tdo, rdo, dc} = 10'b10010000_0_1;      // D16.4
    11'b1_1000110010 : {tdo, rdo, dc} = 10'b10010001_1_1;      // D17.4
    11'b1_0100110010 : {tdo, rdo, dc} = 10'b10010010_1_1;      // D18.4
    11'b1_1100100010 : {tdo, rdo, dc} = 10'b10010011_1_1;      // D19.4
    11'b1_0010110010 : {tdo, rdo, dc} = 10'b10010100_1_1;      // D20.4
    11'b1_1010100010 : {tdo, rdo, dc} = 10'b10010101_1_1;      // D21.4
    11'b1_0110100010 : {tdo, rdo, dc} = 10'b10010110_1_1;      // D22.4
    11'b1_0001011101 : {tdo, rdo, dc} = 10'b10010111_0_1;      // D23.4
    11'b1_0011001101 : {tdo, rdo, dc} = 10'b10011000_0_1;      // D24.4
    11'b1_1001100010 : {tdo, rdo, dc} = 10'b10011001_1_1;      // D25.4
    11'b1_0101100010 : {tdo, rdo, dc} = 10'b10011010_1_1;      // D26.4
    11'b1_0010011101 : {tdo, rdo, dc} = 10'b10011011_0_1;      // D27.4
    11'b1_0011100010 : {tdo, rdo, dc} = 10'b10011100_1_1;      // D28.4
    11'b1_0100011101 : {tdo, rdo, dc} = 10'b10011101_0_1;      // D29.4
    11'b1_1000011101 : {tdo, rdo, dc} = 10'b10011110_0_1;      // D30.4
    11'b1_0101001101 : {tdo, rdo, dc} = 10'b10011111_0_1;      // D31.4
              
    11'b1_0110001010 : {tdo, rdo, dc} = 10'b10100000_1_1;      // D0.5 
    11'b1_1000101010 : {tdo, rdo, dc} = 10'b10100001_1_1;      // D1.5 
    11'b1_0100101010 : {tdo, rdo, dc} = 10'b10100010_1_1;      // D2.5 
    11'b1_1100011010 : {tdo, rdo, dc} = 10'b10100011_0_1;      // D3.5 
    11'b1_0010101010 : {tdo, rdo, dc} = 10'b10100100_1_1;      // D4.5 
    11'b1_1010011010 : {tdo, rdo, dc} = 10'b10100101_0_1;      // D5.5 
    11'b1_0110011010 : {tdo, rdo, dc} = 10'b10100110_0_1;      // D6.5 
    11'b1_0001111010 : {tdo, rdo, dc} = 10'b10100111_0_1;      // D7.5 
    11'b1_0001101010 : {tdo, rdo, dc} = 10'b10101000_1_1;      // D8.5 
    11'b1_1001011010 : {tdo, rdo, dc} = 10'b10101001_0_1;      // D9.5 
    11'b1_0101011010 : {tdo, rdo, dc} = 10'b10101010_0_1;      // D10.5
    11'b1_1101001010 : {tdo, rdo, dc} = 10'b10101011_0_1;      // D11.5
    11'b1_0011011010 : {tdo, rdo, dc} = 10'b10101100_0_1;      // D12.5
    11'b1_1011001010 : {tdo, rdo, dc} = 10'b10101101_0_1;      // D13.5
    11'b1_0111001010 : {tdo, rdo, dc} = 10'b10101110_0_1;      // D14.5
    11'b1_1010001010 : {tdo, rdo, dc} = 10'b10101111_1_1;      // D15.5
    11'b1_1001001010 : {tdo, rdo, dc} = 10'b10110000_1_1;      // D16.5
    11'b1_1000111010 : {tdo, rdo, dc} = 10'b10110001_0_1;      // D17.5
    11'b1_0100111010 : {tdo, rdo, dc} = 10'b10110010_0_1;      // D18.5
    11'b1_1100101010 : {tdo, rdo, dc} = 10'b10110011_0_1;      // D19.5
    11'b1_0010111010 : {tdo, rdo, dc} = 10'b10110100_0_1;      // D20.5
    11'b1_1010101010 : {tdo, rdo, dc} = 10'b10110101_0_1;      // D21.5
    11'b1_0110101010 : {tdo, rdo, dc} = 10'b10110110_0_1;      // D22.5
    11'b1_0001011010 : {tdo, rdo, dc} = 10'b10110111_1_1;      // D23.5
    11'b1_0011001010 : {tdo, rdo, dc} = 10'b10111000_1_1;      // D24.5
    11'b1_1001101010 : {tdo, rdo, dc} = 10'b10111001_0_1;      // D25.5
    11'b1_0101101010 : {tdo, rdo, dc} = 10'b10111010_0_1;      // D26.5
    11'b1_0010011010 : {tdo, rdo, dc} = 10'b10111011_1_1;      // D27.5
    11'b1_0011101010 : {tdo, rdo, dc} = 10'b10111100_0_1;      // D28.5
    11'b1_0100011010 : {tdo, rdo, dc} = 10'b10111101_1_1;      // D29.5
    11'b1_1000011010 : {tdo, rdo, dc} = 10'b10111110_1_1;      // D30.5
    11'b1_0101001010 : {tdo, rdo, dc} = 10'b10111111_1_1;      // D31.5
              
    11'b1_0110000110 : {tdo, rdo, dc} = 10'b11000000_1_1;      // D0.6 
    11'b1_1000100110 : {tdo, rdo, dc} = 10'b11000001_1_1;      // D1.6 
    11'b1_0100100110 : {tdo, rdo, dc} = 10'b11000010_1_1;      // D2.6 
    11'b1_1100010110 : {tdo, rdo, dc} = 10'b11000011_0_1;      // D3.6 
    11'b1_0010100110 : {tdo, rdo, dc} = 10'b11000100_1_1;      // D4.6 
    11'b1_1010010110 : {tdo, rdo, dc} = 10'b11000101_0_1;      // D5.6 
    11'b1_0110010110 : {tdo, rdo, dc} = 10'b11000110_0_1;      // D6.6 
    11'b1_0001110110 : {tdo, rdo, dc} = 10'b11000111_0_1;      // D7.6 
    11'b1_0001100110 : {tdo, rdo, dc} = 10'b11001000_1_1;      // D8.6 
    11'b1_1001010110 : {tdo, rdo, dc} = 10'b11001001_0_1;      // D9.6 
    11'b1_0101010110 : {tdo, rdo, dc} = 10'b11001010_0_1;      // D10.6
    11'b1_1101000110 : {tdo, rdo, dc} = 10'b11001011_0_1;      // D11.6
    11'b1_0011010110 : {tdo, rdo, dc} = 10'b11001100_0_1;      // D12.6
    11'b1_1011000110 : {tdo, rdo, dc} = 10'b11001101_0_1;      // D13.6
    11'b1_0111000110 : {tdo, rdo, dc} = 10'b11001110_0_1;      // D14.6
    11'b1_1010000110 : {tdo, rdo, dc} = 10'b11001111_1_1;      // D15.6
    11'b1_1001000110 : {tdo, rdo, dc} = 10'b11010000_1_1;      // D16.6
    11'b1_1000110110 : {tdo, rdo, dc} = 10'b11010001_0_1;      // D17.6
    11'b1_0100110110 : {tdo, rdo, dc} = 10'b11010010_0_1;      // D18.6
    11'b1_1100100110 : {tdo, rdo, dc} = 10'b11010011_0_1;      // D19.6
    11'b1_0010110110 : {tdo, rdo, dc} = 10'b11010100_0_1;      // D20.6
    11'b1_1010100110 : {tdo, rdo, dc} = 10'b11010101_0_1;      // D21.6
    11'b1_0110100110 : {tdo, rdo, dc} = 10'b11010110_0_1;      // D22.6
    11'b1_0001010110 : {tdo, rdo, dc} = 10'b11010111_1_1;      // D23.6
    11'b1_0011000110 : {tdo, rdo, dc} = 10'b11011000_1_1;      // D24.6
    11'b1_1001100110 : {tdo, rdo, dc} = 10'b11011001_0_1;      // D25.6
    11'b1_0101100110 : {tdo, rdo, dc} = 10'b11011010_0_1;      // D26.6
    11'b1_0010010110 : {tdo, rdo, dc} = 10'b11011011_1_1;      // D27.6
    11'b1_0011100110 : {tdo, rdo, dc} = 10'b11011100_0_1;      // D28.6
    11'b1_0100010110 : {tdo, rdo, dc} = 10'b11011101_1_1;      // D29.6
    11'b1_1000010110 : {tdo, rdo, dc} = 10'b11011110_1_1;      // D30.6
    11'b1_0101000110 : {tdo, rdo, dc} = 10'b11011111_1_1;      // D31.6
                
    11'b1_0110001110 : {tdo, rdo, dc} = 10'b11100000_0_1;      // D0.7 
    11'b1_1000101110 : {tdo, rdo, dc} = 10'b11100001_0_1;      // D1.7 
    11'b1_0100101110 : {tdo, rdo, dc} = 10'b11100010_0_1;      // D2.7 
    11'b1_1100010001 : {tdo, rdo, dc} = 10'b11100011_1_1;      // D3.7 
    11'b1_0010101110 : {tdo, rdo, dc} = 10'b11100100_0_1;      // D4.7 
    11'b1_1010010001 : {tdo, rdo, dc} = 10'b11100101_1_1;      // D5.7 
    11'b1_0110010001 : {tdo, rdo, dc} = 10'b11100110_1_1;      // D6.7 
    11'b1_0001110001 : {tdo, rdo, dc} = 10'b11100111_1_1;      // D7.7 
    11'b1_0001101110 : {tdo, rdo, dc} = 10'b11101000_0_1;      // D8.7 
    11'b1_1001010001 : {tdo, rdo, dc} = 10'b11101001_1_1;      // D9.7 
    11'b1_0101010001 : {tdo, rdo, dc} = 10'b11101010_1_1;      // D10.7
    11'b1_1101001000 : {tdo, rdo, dc} = 10'b11101011_1_1;      // D11.7
    11'b1_0011010001 : {tdo, rdo, dc} = 10'b11101100_1_1;      // D12.7
    11'b1_1011001000 : {tdo, rdo, dc} = 10'b11101101_1_1;      // D13.7
    11'b1_0111001000 : {tdo, rdo, dc} = 10'b11101110_1_1;      // D14.7
    11'b1_1010001110 : {tdo, rdo, dc} = 10'b11101111_0_1;      // D15.7
    11'b1_1001001110 : {tdo, rdo, dc} = 10'b11110000_0_1;      // D16.7
    11'b1_1000110001 : {tdo, rdo, dc} = 10'b11110001_1_1;      // D17.7
    11'b1_0100110001 : {tdo, rdo, dc} = 10'b11110010_1_1;      // D18.7
    11'b1_1100100001 : {tdo, rdo, dc} = 10'b11110011_1_1;      // D19.7
    11'b1_0010110001 : {tdo, rdo, dc} = 10'b11110100_1_1;      // D20.7
    11'b1_1010100001 : {tdo, rdo, dc} = 10'b11110101_1_1;      // D21.7
    11'b1_0110100001 : {tdo, rdo, dc} = 10'b11110110_1_1;      // D22.7
    11'b1_0001011110 : {tdo, rdo, dc} = 10'b11110111_0_1;      // D23.7
    11'b1_0011001110 : {tdo, rdo, dc} = 10'b11111000_0_1;      // D24.7
    11'b1_1001100001 : {tdo, rdo, dc} = 10'b11111001_1_1;      // D25.7
    11'b1_0101100001 : {tdo, rdo, dc} = 10'b11111010_1_1;      // D26.7
    11'b1_0010011110 : {tdo, rdo, dc} = 10'b11111011_0_1;      // D27.7
    11'b1_0011100001 : {tdo, rdo, dc} = 10'b11111100_1_1;      // D28.7
    11'b1_0100011110 : {tdo, rdo, dc} = 10'b11111101_0_1;      // D29.7
    11'b1_1000011110 : {tdo, rdo, dc} = 10'b11111110_0_1;      // D30.7
    11'b1_0101001110 : {tdo, rdo, dc} = 10'b11111111_0_1;      // D31.7

    11'b0_0011111010 : {tdo, rdo, kc} = 10'b00000000_1_1;      // K28.5, K
    11'b0_1110101000 : {tdo, rdo, kc} = 10'b00000000_0_1;      // K23.7, R
    11'b0_1101101000 : {tdo, rdo, kc} = 10'b00000000_0_1;      // K27.7, S
    11'b0_1011101000 : {tdo, rdo, kc} = 10'b00000000_0_1;      // K29.7, T
    11'b0_0111101000 : {tdo, rdo, kc} = 10'b00000000_0_1;      // K30.7, V

    11'b1_1100000101 : {tdo, rdo, kc} = 10'b00000000_1_1;      // K28.5, K
    11'b1_0001010111 : {tdo, rdo, kc} = 10'b00000000_0_1;      // K23.7, R
    11'b1_0010010111 : {tdo, rdo, kc} = 10'b00000000_0_1;      // K27.7, S
    11'b1_0100010111 : {tdo, rdo, kc} = 10'b00000000_0_1;      // K29.7, T
    11'b1_1000010111 : {tdo, rdo, kc} = 10'b00000000_0_1;      // K30.7, V

    default          : {tdo, rdo, dc, kc} = 11'b00000000_0_0_0;
  endcase
  dcd10bto8b = { rdo^rdi, tdo };  
end
endfunction


// --------------------------------------------------------------------------
// -- Returns running disparity and 10 bit code
function [10:0] enc8bto10b;
   input         disp_in;
   input   [7:0] data_in;
   reg           disp_out;
   reg     [9:0] code;
begin
  case ( {data_in, disp_in} )
    9'b00000000_0 : {code, disp_out} = 11'b1001110100_0;  // 8'h00
    9'b00000001_0 : {code, disp_out} = 11'b0111010100_0; 
    9'b00000010_0 : {code, disp_out} = 11'b1011010100_0; 
    9'b00000011_0 : {code, disp_out} = 11'b1100011011_1; 
    9'b00000100_0 : {code, disp_out} = 11'b1101010100_0; 
    9'b00000101_0 : {code, disp_out} = 11'b1010011011_1; 
    9'b00000110_0 : {code, disp_out} = 11'b0110011011_1; 
    9'b00000111_0 : {code, disp_out} = 11'b1110001011_1; 
    9'b00001000_0 : {code, disp_out} = 11'b1110010100_0; 
    9'b00001001_0 : {code, disp_out} = 11'b1001011011_1; 
    9'b00001010_0 : {code, disp_out} = 11'b0101011011_1; 
    9'b00001011_0 : {code, disp_out} = 11'b1101001011_1; 
    9'b00001100_0 : {code, disp_out} = 11'b0011011011_1; 
    9'b00001101_0 : {code, disp_out} = 11'b1011001011_1; 
    9'b00001110_0 : {code, disp_out} = 11'b0111001011_1; 
    9'b00001111_0 : {code, disp_out} = 11'b0101110100_0; 
    9'b00010000_0 : {code, disp_out} = 11'b0110110100_0; 
    9'b00010001_0 : {code, disp_out} = 11'b1000111011_1; 
    9'b00010010_0 : {code, disp_out} = 11'b0100111011_1; 
    9'b00010011_0 : {code, disp_out} = 11'b1100101011_1; 
    9'b00010100_0 : {code, disp_out} = 11'b0010111011_1; 
    9'b00010101_0 : {code, disp_out} = 11'b1010101011_1; 
    9'b00010110_0 : {code, disp_out} = 11'b0110101011_1; 
    9'b00010111_0 : {code, disp_out} = 11'b1110100100_0; 
    9'b00011000_0 : {code, disp_out} = 11'b1100110100_0; 
    9'b00011001_0 : {code, disp_out} = 11'b1001101011_1; 
    9'b00011010_0 : {code, disp_out} = 11'b0101101011_1; 
    9'b00011011_0 : {code, disp_out} = 11'b1101100100_0; 
    9'b00011100_0 : {code, disp_out} = 11'b0011101011_1; 
    9'b00011101_0 : {code, disp_out} = 11'b1011100100_0; 
    9'b00011110_0 : {code, disp_out} = 11'b0111100100_0; 
    9'b00011111_0 : {code, disp_out} = 11'b1010110100_0; 

    9'b00100000_0 : {code, disp_out} = 11'b1001111001_1;   // 8'h20
    9'b00100001_0 : {code, disp_out} = 11'b0111011001_1; 
    9'b00100010_0 : {code, disp_out} = 11'b1011011001_1; 
    9'b00100011_0 : {code, disp_out} = 11'b1100011001_0; 
    9'b00100100_0 : {code, disp_out} = 11'b1101011001_1; 
    9'b00100101_0 : {code, disp_out} = 11'b1010011001_0; 
    9'b00100110_0 : {code, disp_out} = 11'b0110011001_0; 
    9'b00100111_0 : {code, disp_out} = 11'b1110001001_0; 
    9'b00101000_0 : {code, disp_out} = 11'b1110011001_1; 
    9'b00101001_0 : {code, disp_out} = 11'b1001011001_0; 
    9'b00101010_0 : {code, disp_out} = 11'b0101011001_0; 
    9'b00101011_0 : {code, disp_out} = 11'b1101001001_0; 
    9'b00101100_0 : {code, disp_out} = 11'b0011011001_0; 
    9'b00101101_0 : {code, disp_out} = 11'b1011001001_0; 
    9'b00101110_0 : {code, disp_out} = 11'b0111001001_0; 
    9'b00101111_0 : {code, disp_out} = 11'b0101111001_1; 
    9'b00110000_0 : {code, disp_out} = 11'b0110111001_1; 
    9'b00110001_0 : {code, disp_out} = 11'b1000111001_0; 
    9'b00110010_0 : {code, disp_out} = 11'b0100111001_0; 
    9'b00110011_0 : {code, disp_out} = 11'b1100101001_0; 
    9'b00110100_0 : {code, disp_out} = 11'b0010111001_0; 
    9'b00110101_0 : {code, disp_out} = 11'b1010101001_0; 
    9'b00110110_0 : {code, disp_out} = 11'b0110101001_0; 
    9'b00110111_0 : {code, disp_out} = 11'b1110101001_1; 
    9'b00111000_0 : {code, disp_out} = 11'b1100111001_1; 
    9'b00111001_0 : {code, disp_out} = 11'b1001101001_0; 
    9'b00111010_0 : {code, disp_out} = 11'b0101101001_0; 
    9'b00111011_0 : {code, disp_out} = 11'b1101101001_1; 
    9'b00111100_0 : {code, disp_out} = 11'b0011101001_0; 
    9'b00111101_0 : {code, disp_out} = 11'b1011101001_1; 
    9'b00111110_0 : {code, disp_out} = 11'b0111101001_1; 
    9'b00111111_0 : {code, disp_out} = 11'b1010111001_1; 

    9'b01000000_0 : {code, disp_out} = 11'b1001110101_1;   // 8'h40
    9'b01000001_0 : {code, disp_out} = 11'b0111010101_1; 
    9'b01000010_0 : {code, disp_out} = 11'b1011010101_1; 
    9'b01000011_0 : {code, disp_out} = 11'b1100010101_0; 
    9'b01000100_0 : {code, disp_out} = 11'b1101010101_1; 
    9'b01000101_0 : {code, disp_out} = 11'b1010010101_0; 
    9'b01000110_0 : {code, disp_out} = 11'b0110010101_0; 
    9'b01000111_0 : {code, disp_out} = 11'b1110000101_0; 
    9'b01001000_0 : {code, disp_out} = 11'b1110010101_1; 
    9'b01001001_0 : {code, disp_out} = 11'b1001010101_0; 
    9'b01001010_0 : {code, disp_out} = 11'b0101010101_0; 
    9'b01001011_0 : {code, disp_out} = 11'b1101000101_0; 
    9'b01001100_0 : {code, disp_out} = 11'b0011010101_0; 
    9'b01001101_0 : {code, disp_out} = 11'b1011000101_0; 
    9'b01001110_0 : {code, disp_out} = 11'b0111000101_0; 
    9'b01001111_0 : {code, disp_out} = 11'b0101110101_1; 
    9'b01010000_0 : {code, disp_out} = 11'b0110110101_1; 
    9'b01010001_0 : {code, disp_out} = 11'b1000110101_0; 
    9'b01010010_0 : {code, disp_out} = 11'b0100110101_0; 
    9'b01010011_0 : {code, disp_out} = 11'b1100100101_0; 
    9'b01010100_0 : {code, disp_out} = 11'b0010110101_0; 
    9'b01010101_0 : {code, disp_out} = 11'b1010100101_0; 
    9'b01010110_0 : {code, disp_out} = 11'b0110100101_0; 
    9'b01010111_0 : {code, disp_out} = 11'b1110100101_1; 
    9'b01011000_0 : {code, disp_out} = 11'b1100110101_1; 
    9'b01011001_0 : {code, disp_out} = 11'b1001100101_0; 
    9'b01011010_0 : {code, disp_out} = 11'b0101100101_0; 
    9'b01011011_0 : {code, disp_out} = 11'b1101100101_1; 
    9'b01011100_0 : {code, disp_out} = 11'b0011100101_0; 
    9'b01011101_0 : {code, disp_out} = 11'b1011100101_1; 
    9'b01011110_0 : {code, disp_out} = 11'b0111100101_1; 
    9'b01011111_0 : {code, disp_out} = 11'b1010110101_1; 

    9'b01100000_0 : {code, disp_out} = 11'b1001110011_1;   // 8'h60
    9'b01100001_0 : {code, disp_out} = 11'b0111010011_1; 
    9'b01100010_0 : {code, disp_out} = 11'b1011010011_1; 
    9'b01100011_0 : {code, disp_out} = 11'b1100011100_0; 
    9'b01100100_0 : {code, disp_out} = 11'b1101010011_1; 
    9'b01100101_0 : {code, disp_out} = 11'b1010011100_0; 
    9'b01100110_0 : {code, disp_out} = 11'b0110011100_0; 
    9'b01100111_0 : {code, disp_out} = 11'b1110001100_0; 
    9'b01101000_0 : {code, disp_out} = 11'b1110010011_1; 
    9'b01101001_0 : {code, disp_out} = 11'b1001011100_0; 
    9'b01101010_0 : {code, disp_out} = 11'b0101011100_0; 
    9'b01101011_0 : {code, disp_out} = 11'b1101001100_0; 
    9'b01101100_0 : {code, disp_out} = 11'b0011011100_0; 
    9'b01101101_0 : {code, disp_out} = 11'b1011001100_0; 
    9'b01101110_0 : {code, disp_out} = 11'b0111001100_0; 
    9'b01101111_0 : {code, disp_out} = 11'b0101110011_1; 
    9'b01110000_0 : {code, disp_out} = 11'b0110110011_1; 
    9'b01110001_0 : {code, disp_out} = 11'b1000111100_0; 
    9'b01110010_0 : {code, disp_out} = 11'b0100111100_0; 
    9'b01110011_0 : {code, disp_out} = 11'b1100101100_0; 
    9'b01110100_0 : {code, disp_out} = 11'b0010111100_0; 
    9'b01110101_0 : {code, disp_out} = 11'b1010101100_0; 
    9'b01110110_0 : {code, disp_out} = 11'b0110101100_0; 
    9'b01110111_0 : {code, disp_out} = 11'b1110100011_1; 
    9'b01111000_0 : {code, disp_out} = 11'b1100110011_1; 
    9'b01111001_0 : {code, disp_out} = 11'b1001101100_0; 
    9'b01111010_0 : {code, disp_out} = 11'b0101101100_0; 
    9'b01111011_0 : {code, disp_out} = 11'b1101100011_1; 
    9'b01111100_0 : {code, disp_out} = 11'b0011101100_0; 
    9'b01111101_0 : {code, disp_out} = 11'b1011100011_1; 
    9'b01111110_0 : {code, disp_out} = 11'b0111100011_1; 
    9'b01111111_0 : {code, disp_out} = 11'b1010110011_1; 

    9'b10000000_0 : {code, disp_out} = 11'b1001110010_0;   // 8'h80
    9'b10000001_0 : {code, disp_out} = 11'b0111010010_0; 
    9'b10000010_0 : {code, disp_out} = 11'b1011010010_0; 
    9'b10000011_0 : {code, disp_out} = 11'b1100011101_1; 
    9'b10000100_0 : {code, disp_out} = 11'b1101010010_0; 
    9'b10000101_0 : {code, disp_out} = 11'b1010011101_1; 
    9'b10000110_0 : {code, disp_out} = 11'b0110011101_1; 
    9'b10000111_0 : {code, disp_out} = 11'b1110001101_1; 
    9'b10001000_0 : {code, disp_out} = 11'b1110010010_0; 
    9'b10001001_0 : {code, disp_out} = 11'b1001011101_1; 
    9'b10001010_0 : {code, disp_out} = 11'b0101011101_1; 
    9'b10001011_0 : {code, disp_out} = 11'b1101001101_1; 
    9'b10001100_0 : {code, disp_out} = 11'b0011011101_1; 
    9'b10001101_0 : {code, disp_out} = 11'b1011001101_1; 
    9'b10001110_0 : {code, disp_out} = 11'b0111001101_1; 
    9'b10001111_0 : {code, disp_out} = 11'b0101110010_0; 
    9'b10010000_0 : {code, disp_out} = 11'b0110110010_0; 
    9'b10010001_0 : {code, disp_out} = 11'b1000111101_1; 
    9'b10010010_0 : {code, disp_out} = 11'b0100111101_1; 
    9'b10010011_0 : {code, disp_out} = 11'b1100101101_1; 
    9'b10010100_0 : {code, disp_out} = 11'b0010111101_1; 
    9'b10010101_0 : {code, disp_out} = 11'b1010101101_1; 
    9'b10010110_0 : {code, disp_out} = 11'b0110101101_1; 
    9'b10010111_0 : {code, disp_out} = 11'b1110100010_0; 
    9'b10011000_0 : {code, disp_out} = 11'b1100110010_0; 
    9'b10011001_0 : {code, disp_out} = 11'b1001101101_1; 
    9'b10011010_0 : {code, disp_out} = 11'b0101101101_1; 
    9'b10011011_0 : {code, disp_out} = 11'b1101100010_0; 
    9'b10011100_0 : {code, disp_out} = 11'b0011101101_1; 
    9'b10011101_0 : {code, disp_out} = 11'b1011100010_0; 
    9'b10011110_0 : {code, disp_out} = 11'b0111100010_0; 
    9'b10011111_0 : {code, disp_out} = 11'b1010110010_0; 
 
    9'b10100000_0 : {code, disp_out} = 11'b1001111010_1;   // 8'ha0
    9'b10100001_0 : {code, disp_out} = 11'b0111011010_1; 
    9'b10100010_0 : {code, disp_out} = 11'b1011011010_1; 
    9'b10100011_0 : {code, disp_out} = 11'b1100011010_0; 
    9'b10100100_0 : {code, disp_out} = 11'b1101011010_1; 
    9'b10100101_0 : {code, disp_out} = 11'b1010011010_0; 
    9'b10100110_0 : {code, disp_out} = 11'b0110011010_0; 
    9'b10100111_0 : {code, disp_out} = 11'b1110001010_0; 
    9'b10101000_0 : {code, disp_out} = 11'b1110011010_1; 
    9'b10101001_0 : {code, disp_out} = 11'b1001011010_0; 
    9'b10101010_0 : {code, disp_out} = 11'b0101011010_0; 
    9'b10101011_0 : {code, disp_out} = 11'b1101001010_0; 
    9'b10101100_0 : {code, disp_out} = 11'b0011011010_0; 
    9'b10101101_0 : {code, disp_out} = 11'b1011001010_0; 
    9'b10101110_0 : {code, disp_out} = 11'b0111001010_0; 
    9'b10101111_0 : {code, disp_out} = 11'b0101111010_1; 
    9'b10110000_0 : {code, disp_out} = 11'b0110111010_1; 
    9'b10110001_0 : {code, disp_out} = 11'b1000111010_0; 
    9'b10110010_0 : {code, disp_out} = 11'b0100111010_0; 
    9'b10110011_0 : {code, disp_out} = 11'b1100101010_0; 
    9'b10110100_0 : {code, disp_out} = 11'b0010111010_0; 
    9'b10110101_0 : {code, disp_out} = 11'b1010101010_0; 
    9'b10110110_0 : {code, disp_out} = 11'b0110101010_0; 
    9'b10110111_0 : {code, disp_out} = 11'b1110101010_1; 
    9'b10111000_0 : {code, disp_out} = 11'b1100111010_1; 
    9'b10111001_0 : {code, disp_out} = 11'b1001101010_0; 
    9'b10111010_0 : {code, disp_out} = 11'b0101101010_0; 
    9'b10111011_0 : {code, disp_out} = 11'b1101101010_1; 
    9'b10111100_0 : {code, disp_out} = 11'b0011101010_0; 
    9'b10111101_0 : {code, disp_out} = 11'b1011101010_1; 
    9'b10111110_0 : {code, disp_out} = 11'b0111101010_1; 
    9'b10111111_0 : {code, disp_out} = 11'b1010111010_1; 

    9'b11000000_0 : {code, disp_out} = 11'b1001110110_1;   // 8'hc0
    9'b11000001_0 : {code, disp_out} = 11'b0111010110_1; 
    9'b11000010_0 : {code, disp_out} = 11'b1011010110_1; 
    9'b11000011_0 : {code, disp_out} = 11'b1100010110_0; 
    9'b11000100_0 : {code, disp_out} = 11'b1101010110_1; 
    9'b11000101_0 : {code, disp_out} = 11'b1010010110_0; 
    9'b11000110_0 : {code, disp_out} = 11'b0110010110_0; 
    9'b11000111_0 : {code, disp_out} = 11'b1110000110_0; 
    9'b11001000_0 : {code, disp_out} = 11'b1110010110_1; 
    9'b11001001_0 : {code, disp_out} = 11'b1001010110_0; 
    9'b11001010_0 : {code, disp_out} = 11'b0101010110_0; 
    9'b11001011_0 : {code, disp_out} = 11'b1101000110_0; 
    9'b11001100_0 : {code, disp_out} = 11'b0011010110_0; 
    9'b11001101_0 : {code, disp_out} = 11'b1011000110_0; 
    9'b11001110_0 : {code, disp_out} = 11'b0111000110_0; 
    9'b11001111_0 : {code, disp_out} = 11'b0101110110_1; 
    9'b11010000_0 : {code, disp_out} = 11'b0110110110_1; 
    9'b11010001_0 : {code, disp_out} = 11'b1000110110_0; 
    9'b11010010_0 : {code, disp_out} = 11'b0100110110_0; 
    9'b11010011_0 : {code, disp_out} = 11'b1100100110_0; 
    9'b11010100_0 : {code, disp_out} = 11'b0010110110_0; 
    9'b11010101_0 : {code, disp_out} = 11'b1010100110_0; 
    9'b11010110_0 : {code, disp_out} = 11'b0110100110_0; 
    9'b11010111_0 : {code, disp_out} = 11'b1110100110_1; 
    9'b11011000_0 : {code, disp_out} = 11'b1100110110_1; 
    9'b11011001_0 : {code, disp_out} = 11'b1001100110_0; 
    9'b11011010_0 : {code, disp_out} = 11'b0101100110_0; 
    9'b11011011_0 : {code, disp_out} = 11'b1101100110_1; 
    9'b11011100_0 : {code, disp_out} = 11'b0011100110_0; 
    9'b11011101_0 : {code, disp_out} = 11'b1011100110_1; 
    9'b11011110_0 : {code, disp_out} = 11'b0111100110_1; 
    9'b11011111_0 : {code, disp_out} = 11'b1010110110_1; 

    9'b11100000_0 : {code, disp_out} = 11'b1001110001_0;   // 8'he0
    9'b11100001_0 : {code, disp_out} = 11'b0111010001_0; 
    9'b11100010_0 : {code, disp_out} = 11'b1011010001_0; 
    9'b11100011_0 : {code, disp_out} = 11'b1100011110_1; 
    9'b11100100_0 : {code, disp_out} = 11'b1101010001_0; 
    9'b11100101_0 : {code, disp_out} = 11'b1010011110_1; 
    9'b11100110_0 : {code, disp_out} = 11'b0110011110_1; 
    9'b11100111_0 : {code, disp_out} = 11'b1110001110_1; 
    9'b11101000_0 : {code, disp_out} = 11'b1110010001_0; 
    9'b11101001_0 : {code, disp_out} = 11'b1001011110_1; 
    9'b11101010_0 : {code, disp_out} = 11'b0101011110_1; 
    9'b11101011_0 : {code, disp_out} = 11'b1101001110_1; 
    9'b11101100_0 : {code, disp_out} = 11'b0011011110_1; 
    9'b11101101_0 : {code, disp_out} = 11'b1011001110_1; 
    9'b11101110_0 : {code, disp_out} = 11'b0111001110_1; 
    9'b11101111_0 : {code, disp_out} = 11'b0101110001_0; 
    9'b11110000_0 : {code, disp_out} = 11'b0110110001_0; 
    9'b11110001_0 : {code, disp_out} = 11'b1000110111_1; 
    9'b11110010_0 : {code, disp_out} = 11'b0100110111_1; 
    9'b11110011_0 : {code, disp_out} = 11'b1100101110_1; 
    9'b11110100_0 : {code, disp_out} = 11'b0010110111_1; 
    9'b11110101_0 : {code, disp_out} = 11'b1010101110_1; 
    9'b11110110_0 : {code, disp_out} = 11'b0110101110_1; 
    9'b11110111_0 : {code, disp_out} = 11'b1110100001_0; 
    9'b11111000_0 : {code, disp_out} = 11'b1100110001_0; 
    9'b11111001_0 : {code, disp_out} = 11'b1001101110_1; 
    9'b11111010_0 : {code, disp_out} = 11'b0101101110_1; 
    9'b11111011_0 : {code, disp_out} = 11'b1101100001_0; 
    9'b11111100_0 : {code, disp_out} = 11'b0011101110_1; 
    9'b11111101_0 : {code, disp_out} = 11'b1011100001_0; 
    9'b11111110_0 : {code, disp_out} = 11'b0111100001_0; 
    9'b11111111_0 : {code, disp_out} = 11'b1010110001_0; 

    9'b00000000_1 : {code, disp_out} = 11'b0110001011_0;  // 8'h00
    9'b00000001_1 : {code, disp_out} = 11'b1000101011_0;
    9'b00000010_1 : {code, disp_out} = 11'b0100101011_0;
    9'b00000011_1 : {code, disp_out} = 11'b1100010100_1;    
    9'b00000100_1 : {code, disp_out} = 11'b0010101011_0;
    9'b00000101_1 : {code, disp_out} = 11'b1010010100_1;
    9'b00000110_1 : {code, disp_out} = 11'b0110010100_1;
    9'b00000111_1 : {code, disp_out} = 11'b0001110100_1;
    9'b00001000_1 : {code, disp_out} = 11'b0001101011_0;
    9'b00001001_1 : {code, disp_out} = 11'b1001010100_1;
    9'b00001010_1 : {code, disp_out} = 11'b0101010100_1;
    9'b00001011_1 : {code, disp_out} = 11'b1101000100_1;
    9'b00001100_1 : {code, disp_out} = 11'b0011010100_1;
    9'b00001101_1 : {code, disp_out} = 11'b1011000100_1;
    9'b00001110_1 : {code, disp_out} = 11'b0111000100_1;
    9'b00001111_1 : {code, disp_out} = 11'b1010001011_0;
    9'b00010000_1 : {code, disp_out} = 11'b1001001011_0;
    9'b00010001_1 : {code, disp_out} = 11'b1000110100_1;
    9'b00010010_1 : {code, disp_out} = 11'b0100110100_1;
    9'b00010011_1 : {code, disp_out} = 11'b1100100100_1;
    9'b00010100_1 : {code, disp_out} = 11'b0010110100_1;
    9'b00010101_1 : {code, disp_out} = 11'b1010100100_1;
    9'b00010110_1 : {code, disp_out} = 11'b0110100100_1;
    9'b00010111_1 : {code, disp_out} = 11'b0001011011_0;
    9'b00011000_1 : {code, disp_out} = 11'b0011001011_0;
    9'b00011001_1 : {code, disp_out} = 11'b1001100100_1;
    9'b00011010_1 : {code, disp_out} = 11'b0101100100_1;
    9'b00011011_1 : {code, disp_out} = 11'b0010011011_0;
    9'b00011100_1 : {code, disp_out} = 11'b0011100100_1;
    9'b00011101_1 : {code, disp_out} = 11'b0100011011_0;
    9'b00011110_1 : {code, disp_out} = 11'b1000011011_0;
    9'b00011111_1 : {code, disp_out} = 11'b0101001011_0;

    9'b00100000_1 : {code, disp_out} = 11'b0110001001_1;  // 8'h20
    9'b00100001_1 : {code, disp_out} = 11'b1000101001_1;
    9'b00100010_1 : {code, disp_out} = 11'b0100101001_1;
    9'b00100011_1 : {code, disp_out} = 11'b1100011001_0;
    9'b00100100_1 : {code, disp_out} = 11'b0010101001_1;
    9'b00100101_1 : {code, disp_out} = 11'b1010011001_0;
    9'b00100110_1 : {code, disp_out} = 11'b0110011001_0;
    9'b00100111_1 : {code, disp_out} = 11'b0001111001_0;
    9'b00101000_1 : {code, disp_out} = 11'b0001101001_1;
    9'b00101001_1 : {code, disp_out} = 11'b1001011001_0;
    9'b00101010_1 : {code, disp_out} = 11'b0101011001_0;
    9'b00101011_1 : {code, disp_out} = 11'b1101001001_0;
    9'b00101100_1 : {code, disp_out} = 11'b0011011001_0;
    9'b00101101_1 : {code, disp_out} = 11'b1011001001_0;
    9'b00101110_1 : {code, disp_out} = 11'b0111001001_0;
    9'b00101111_1 : {code, disp_out} = 11'b1010001001_1;
    9'b00110000_1 : {code, disp_out} = 11'b1001001001_1;
    9'b00110001_1 : {code, disp_out} = 11'b1000111001_0;
    9'b00110010_1 : {code, disp_out} = 11'b0100111001_0;
    9'b00110011_1 : {code, disp_out} = 11'b1100101001_0;
    9'b00110100_1 : {code, disp_out} = 11'b0010111001_0;
    9'b00110101_1 : {code, disp_out} = 11'b1010101001_0;
    9'b00110110_1 : {code, disp_out} = 11'b0110101001_0;
    9'b00110111_1 : {code, disp_out} = 11'b0001011001_1;
    9'b00111000_1 : {code, disp_out} = 11'b0011001001_1;
    9'b00111001_1 : {code, disp_out} = 11'b1001101001_0;
    9'b00111010_1 : {code, disp_out} = 11'b0101101001_0;
    9'b00111011_1 : {code, disp_out} = 11'b0010011001_1;
    9'b00111100_1 : {code, disp_out} = 11'b0011101001_0;
    9'b00111101_1 : {code, disp_out} = 11'b0100011001_1;
    9'b00111110_1 : {code, disp_out} = 11'b1000011001_1;
    9'b00111111_1 : {code, disp_out} = 11'b0101001001_1;

    9'b01000000_1 : {code, disp_out} = 11'b0110000101_1;  // 8'h40
    9'b01000001_1 : {code, disp_out} = 11'b1000100101_1;
    9'b01000010_1 : {code, disp_out} = 11'b0100100101_1;
    9'b01000011_1 : {code, disp_out} = 11'b1100010101_0;
    9'b01000100_1 : {code, disp_out} = 11'b0010100101_1;
    9'b01000101_1 : {code, disp_out} = 11'b1010010101_0;
    9'b01000110_1 : {code, disp_out} = 11'b0110010101_0;
    9'b01000111_1 : {code, disp_out} = 11'b0001110101_0;
    9'b01001000_1 : {code, disp_out} = 11'b0001100101_1;
    9'b01001001_1 : {code, disp_out} = 11'b1001010101_0;
    9'b01001010_1 : {code, disp_out} = 11'b0101010101_0;
    9'b01001011_1 : {code, disp_out} = 11'b1101000101_0;
    9'b01001100_1 : {code, disp_out} = 11'b0011010101_0;
    9'b01001101_1 : {code, disp_out} = 11'b1011000101_0;
    9'b01001110_1 : {code, disp_out} = 11'b0111000101_0;
    9'b01001111_1 : {code, disp_out} = 11'b1010000101_1;
    9'b01010000_1 : {code, disp_out} = 11'b1001000101_1;
    9'b01010001_1 : {code, disp_out} = 11'b1000110101_0;
    9'b01010010_1 : {code, disp_out} = 11'b0100110101_0;
    9'b01010011_1 : {code, disp_out} = 11'b1100100101_0;
    9'b01010100_1 : {code, disp_out} = 11'b0010110101_0;
    9'b01010101_1 : {code, disp_out} = 11'b1010100101_0;
    9'b01010110_1 : {code, disp_out} = 11'b0110100101_0;
    9'b01010111_1 : {code, disp_out} = 11'b0001010101_1;
    9'b01011000_1 : {code, disp_out} = 11'b0011000101_1;
    9'b01011001_1 : {code, disp_out} = 11'b1001100101_0;
    9'b01011010_1 : {code, disp_out} = 11'b0101100101_0;
    9'b01011011_1 : {code, disp_out} = 11'b0010010101_1;
    9'b01011100_1 : {code, disp_out} = 11'b0011100101_0;
    9'b01011101_1 : {code, disp_out} = 11'b0100010101_1;
    9'b01011110_1 : {code, disp_out} = 11'b1000010101_1;
    9'b01011111_1 : {code, disp_out} = 11'b0101000101_1;

    9'b01100000_1 : {code, disp_out} = 11'b0110001100_1;  // 8'h60
    9'b01100001_1 : {code, disp_out} = 11'b1000101100_1;
    9'b01100010_1 : {code, disp_out} = 11'b0100101100_1;
    9'b01100011_1 : {code, disp_out} = 11'b1100010011_0;
    9'b01100100_1 : {code, disp_out} = 11'b0010101100_1;
    9'b01100101_1 : {code, disp_out} = 11'b1010010011_0;
    9'b01100110_1 : {code, disp_out} = 11'b0110010011_0;
    9'b01100111_1 : {code, disp_out} = 11'b0001110011_0;
    9'b01101000_1 : {code, disp_out} = 11'b0001101100_1;
    9'b01101001_1 : {code, disp_out} = 11'b1001010011_0;
    9'b01101010_1 : {code, disp_out} = 11'b0101010011_0;
    9'b01101011_1 : {code, disp_out} = 11'b1101000011_0;
    9'b01101100_1 : {code, disp_out} = 11'b0011010011_0;
    9'b01101101_1 : {code, disp_out} = 11'b1011000011_0;
    9'b01101110_1 : {code, disp_out} = 11'b0111000011_0;
    9'b01101111_1 : {code, disp_out} = 11'b1010001100_1;
    9'b01110000_1 : {code, disp_out} = 11'b1001001100_1;
    9'b01110001_1 : {code, disp_out} = 11'b1000110011_0;
    9'b01110010_1 : {code, disp_out} = 11'b0100110011_0;
    9'b01110011_1 : {code, disp_out} = 11'b1100100011_0;
    9'b01110100_1 : {code, disp_out} = 11'b0010110011_0;
    9'b01110101_1 : {code, disp_out} = 11'b1010100011_0;
    9'b01110110_1 : {code, disp_out} = 11'b0110100011_0;
    9'b01110111_1 : {code, disp_out} = 11'b0001011100_1;
    9'b01111000_1 : {code, disp_out} = 11'b0011001100_1;
    9'b01111001_1 : {code, disp_out} = 11'b1001100011_0;
    9'b01111010_1 : {code, disp_out} = 11'b0101100011_0;
    9'b01111011_1 : {code, disp_out} = 11'b0010011100_1;
    9'b01111100_1 : {code, disp_out} = 11'b0011100011_0;
    9'b01111101_1 : {code, disp_out} = 11'b0100011100_1;
    9'b01111110_1 : {code, disp_out} = 11'b1000011100_1;
    9'b01111111_1 : {code, disp_out} = 11'b0101001100_1;

    9'b10000000_1 : {code, disp_out} = 11'b0110001101_0;  // 8'h80
    9'b10000001_1 : {code, disp_out} = 11'b1000101101_0;
    9'b10000010_1 : {code, disp_out} = 11'b0100101101_0;
    9'b10000011_1 : {code, disp_out} = 11'b1100010010_1;
    9'b10000100_1 : {code, disp_out} = 11'b0010101101_0;
    9'b10000101_1 : {code, disp_out} = 11'b1010010010_1;
    9'b10000110_1 : {code, disp_out} = 11'b0110010010_1;
    9'b10000111_1 : {code, disp_out} = 11'b0001110010_1;
    9'b10001000_1 : {code, disp_out} = 11'b0001101101_0;
    9'b10001001_1 : {code, disp_out} = 11'b1001010010_1;
    9'b10001010_1 : {code, disp_out} = 11'b0101010010_1;
    9'b10001011_1 : {code, disp_out} = 11'b1101000010_1;
    9'b10001100_1 : {code, disp_out} = 11'b0011010010_1;
    9'b10001101_1 : {code, disp_out} = 11'b1011000010_1;
    9'b10001110_1 : {code, disp_out} = 11'b0111000010_1;
    9'b10001111_1 : {code, disp_out} = 11'b1010001101_0;
    9'b10010000_1 : {code, disp_out} = 11'b1001001101_0;
    9'b10010001_1 : {code, disp_out} = 11'b1000110010_1;
    9'b10010010_1 : {code, disp_out} = 11'b0100110010_1;
    9'b10010011_1 : {code, disp_out} = 11'b1100100010_1;
    9'b10010100_1 : {code, disp_out} = 11'b0010110010_1;
    9'b10010101_1 : {code, disp_out} = 11'b1010100010_1;
    9'b10010110_1 : {code, disp_out} = 11'b0110100010_1;
    9'b10010111_1 : {code, disp_out} = 11'b0001011101_0;
    9'b10011000_1 : {code, disp_out} = 11'b0011001101_0;
    9'b10011001_1 : {code, disp_out} = 11'b1001100010_1;
    9'b10011010_1 : {code, disp_out} = 11'b0101100010_1;
    9'b10011011_1 : {code, disp_out} = 11'b0010011101_0;
    9'b10011100_1 : {code, disp_out} = 11'b0011100010_1;
    9'b10011101_1 : {code, disp_out} = 11'b0100011101_0;
    9'b10011110_1 : {code, disp_out} = 11'b1000011101_0;
    9'b10011111_1 : {code, disp_out} = 11'b0101001101_0;

    9'b10100000_1 : {code, disp_out} = 11'b0110001010_1;  // 8'ha0
    9'b10100001_1 : {code, disp_out} = 11'b1000101010_1;
    9'b10100010_1 : {code, disp_out} = 11'b0100101010_1;
    9'b10100011_1 : {code, disp_out} = 11'b1100011010_0;
    9'b10100100_1 : {code, disp_out} = 11'b0010101010_1;
    9'b10100101_1 : {code, disp_out} = 11'b1010011010_0;
    9'b10100110_1 : {code, disp_out} = 11'b0110011010_0;
    9'b10100111_1 : {code, disp_out} = 11'b0001111010_0;
    9'b10101000_1 : {code, disp_out} = 11'b0001101010_1;
    9'b10101001_1 : {code, disp_out} = 11'b1001011010_0;
    9'b10101010_1 : {code, disp_out} = 11'b0101011010_0;
    9'b10101011_1 : {code, disp_out} = 11'b1101001010_0;
    9'b10101100_1 : {code, disp_out} = 11'b0011011010_0;
    9'b10101101_1 : {code, disp_out} = 11'b1011001010_0;
    9'b10101110_1 : {code, disp_out} = 11'b0111001010_0;
    9'b10101111_1 : {code, disp_out} = 11'b1010001010_1;
    9'b10110000_1 : {code, disp_out} = 11'b1001001010_1;
    9'b10110001_1 : {code, disp_out} = 11'b1000111010_0;
    9'b10110010_1 : {code, disp_out} = 11'b0100111010_0;
    9'b10110011_1 : {code, disp_out} = 11'b1100101010_0;
    9'b10110100_1 : {code, disp_out} = 11'b0010111010_0;
    9'b10110101_1 : {code, disp_out} = 11'b1010101010_0;
    9'b10110110_1 : {code, disp_out} = 11'b0110101010_0;
    9'b10110111_1 : {code, disp_out} = 11'b0001011010_1;
    9'b10111000_1 : {code, disp_out} = 11'b0011001010_1;
    9'b10111001_1 : {code, disp_out} = 11'b1001101010_0;
    9'b10111010_1 : {code, disp_out} = 11'b0101101010_0;
    9'b10111011_1 : {code, disp_out} = 11'b0010011010_1;
    9'b10111100_1 : {code, disp_out} = 11'b0011101010_0;
    9'b10111101_1 : {code, disp_out} = 11'b0100011010_1;
    9'b10111110_1 : {code, disp_out} = 11'b1000011010_1;
    9'b10111111_1 : {code, disp_out} = 11'b0101001010_1;

    9'b11000000_1 : {code, disp_out} = 11'b0110000110_1;  // 8'hc0
    9'b11000001_1 : {code, disp_out} = 11'b1000100110_1;
    9'b11000010_1 : {code, disp_out} = 11'b0100100110_1;
    9'b11000011_1 : {code, disp_out} = 11'b1100010110_0;
    9'b11000100_1 : {code, disp_out} = 11'b0010100110_1;
    9'b11000101_1 : {code, disp_out} = 11'b1010010110_0;
    9'b11000110_1 : {code, disp_out} = 11'b0110010110_0;
    9'b11000111_1 : {code, disp_out} = 11'b0001110110_0;
    9'b11001000_1 : {code, disp_out} = 11'b0001100110_1;
    9'b11001001_1 : {code, disp_out} = 11'b1001010110_0;
    9'b11001010_1 : {code, disp_out} = 11'b0101010110_0;
    9'b11001011_1 : {code, disp_out} = 11'b1101000110_0;
    9'b11001100_1 : {code, disp_out} = 11'b0011010110_0;
    9'b11001101_1 : {code, disp_out} = 11'b1011000110_0;
    9'b11001110_1 : {code, disp_out} = 11'b0111000110_0;
    9'b11001111_1 : {code, disp_out} = 11'b1010000110_1;
    9'b11010000_1 : {code, disp_out} = 11'b1001000110_1;
    9'b11010001_1 : {code, disp_out} = 11'b1000110110_0;
    9'b11010010_1 : {code, disp_out} = 11'b0100110110_0;
    9'b11010011_1 : {code, disp_out} = 11'b1100100110_0;
    9'b11010100_1 : {code, disp_out} = 11'b0010110110_0;
    9'b11010101_1 : {code, disp_out} = 11'b1010100110_0;
    9'b11010110_1 : {code, disp_out} = 11'b0110100110_0;
    9'b11010111_1 : {code, disp_out} = 11'b0001010110_1;
    9'b11011000_1 : {code, disp_out} = 11'b0011000110_1;
    9'b11011001_1 : {code, disp_out} = 11'b1001100110_0;
    9'b11011010_1 : {code, disp_out} = 11'b0101100110_0;
    9'b11011011_1 : {code, disp_out} = 11'b0010010110_1;
    9'b11011100_1 : {code, disp_out} = 11'b0011100110_0;
    9'b11011101_1 : {code, disp_out} = 11'b0100010110_1;
    9'b11011110_1 : {code, disp_out} = 11'b1000010110_1;
    9'b11011111_1 : {code, disp_out} = 11'b0101000110_1;

    9'b11100000_1 : {code, disp_out} = 11'b0110001110_0;  // 8'he0
    9'b11100001_1 : {code, disp_out} = 11'b1000101110_0;
    9'b11100010_1 : {code, disp_out} = 11'b0100101110_0;
    9'b11100011_1 : {code, disp_out} = 11'b1100010001_1;
    9'b11100100_1 : {code, disp_out} = 11'b0010101110_0;
    9'b11100101_1 : {code, disp_out} = 11'b1010010001_1;
    9'b11100110_1 : {code, disp_out} = 11'b0110010001_1;
    9'b11100111_1 : {code, disp_out} = 11'b0001110001_1;
    9'b11101000_1 : {code, disp_out} = 11'b0001101110_0;
    9'b11101001_1 : {code, disp_out} = 11'b1001010001_1;
    9'b11101010_1 : {code, disp_out} = 11'b0101010001_1;
    9'b11101011_1 : {code, disp_out} = 11'b1101001000_1;
    9'b11101100_1 : {code, disp_out} = 11'b0011010001_1;
    9'b11101101_1 : {code, disp_out} = 11'b1011001000_1;
    9'b11101110_1 : {code, disp_out} = 11'b0111001000_1;
    9'b11101111_1 : {code, disp_out} = 11'b1010001110_0;
    9'b11110000_1 : {code, disp_out} = 11'b1001001110_0;
    9'b11110001_1 : {code, disp_out} = 11'b1000110001_1;
    9'b11110010_1 : {code, disp_out} = 11'b0100110001_1;
    9'b11110011_1 : {code, disp_out} = 11'b1100100001_1;
    9'b11110100_1 : {code, disp_out} = 11'b0010110001_1;
    9'b11110101_1 : {code, disp_out} = 11'b1010100001_1;
    9'b11110110_1 : {code, disp_out} = 11'b0110100001_1;
    9'b11110111_1 : {code, disp_out} = 11'b0001011110_0;
    9'b11111000_1 : {code, disp_out} = 11'b0011001110_0;
    9'b11111001_1 : {code, disp_out} = 11'b1001100001_1;
    9'b11111010_1 : {code, disp_out} = 11'b0101100001_1;
    9'b11111011_1 : {code, disp_out} = 11'b0010011110_0;
    9'b11111100_1 : {code, disp_out} = 11'b0011100001_1;
    9'b11111101_1 : {code, disp_out} = 11'b0100011110_0;
    9'b11111110_1 : {code, disp_out} = 11'b1000011110_0;
    9'b11111111_1 : {code, disp_out} = 11'b0101001110_0;
    default       : {code, disp_out} = 11'b0000000000_0;
  endcase
  enc8bto10b = { (disp_out^disp_in),
                code[0], code[1], code[2], code[3], code[4], 
                code[5], code[6], code[7], code[8], code[9]}; 
end
endfunction
endmodule

// --------------------------------------------------------------------------
// -- Module Definition

module CoreTSE_ahb_tb 
(  
   tx_clko,        // MII Transmit Clock, Output    ( pre-clock tree )
   txceno,         // Transmit Clock Enable, Output ( pre-clock tree )
   rx_clko,        // MII Receive Clock, Output     ( pre-clock tree )
   rxceno,         // Receive Clock Enable, Output  ( pre-clock tree )
   tx_en,          // G/MII Transmit Enable
   txd,            // G/MII Transmit Data
   tx_er,          // G/MII Transmit Error
   mdc,            // MII Management Data Clock
   mdo,            // MII Management Data Output
   mdoen,          // MII Management Data Output Enable
   ahb_hrdata,     // AHB slave read data
   ahb_hresp,      // AHB slave response
   ahb_hreadyo,    // AHB slave ready
   ahb_txhbusreq,  // AHB master bus request
   ahb_rxhbusreq,  // AHB master bus request
   ahb_txhtransm,  // AHB master transaction type
   ahb_rxhtransm,  // AHB master transaction type
   ahb_txhaddrm,   // AHB master transaction address
   ahb_rxhaddrm,   // AHB master transaction address
   ahb_txhwritem,  // AHB master transfer direction
   ahb_rxhwritem,  // AHB master transfer direction
   ahb_txhwdatam,  // AHB master write data bus
   ahb_rxhwdatam,  // AHB master write data bus
   interrupt,      // Host DMA interrupt
   
   tx_clk,         // MII Transmit Clock ( from external source )
   tx_clki,        // MII Transmit Clock, Input ( post clock tree )
   txceni,         // Transmit Clock Enable, Input ( post clock tree )
   rx_clk,         // MII Receive Clock  ( from external source )
   rx_clki,        // MII Receive Clock, Input  ( post clock tree )
   rxceni,         // Receive Clock Enable, Input  ( post clock tree )
   crs,            // MII Carrier Sense
   col,            // MII Collision
   mdi,            // MII Management Data Input
   rx_dv,          // G/MII Receive Data Valid
   rxd,            // G/MII Receive Data
   rx_er,          // G/MII Receive Error
   rstbp,          // Reset Bypass
   ahb_hwdata,     // AHB write data
   ahb_haddr,      // AHB address
   ahb_hsel,       // AHB slave select
   ahb_htrans,     // AHB transaction type
   ahb_hwrite,     // AHB transaction direction
   ahb_txhgrant,   // AHB bus grant
   ahb_rxhgrant,   // AHB bus grant
   ahb_txhrespm,   // AHB response
   ahb_rxhrespm,   // AHB response
   ahb_txhrdatam,  // AHB read data
   ahb_rxhrdatam,  // AHB read data
   ahb_hreadyi,    // AHB ready
   hresetn,        // AHB system reset (active low)
   hclk,            // AHB system clock
   rcg_dut,                                                       // Added 2 extra port for tcg
   tcg_dut,                                                        // Added 2 extra port for rcg
   gtx_clki,                                                      // this clk is input to SGMII RTL
   ptp_clk_i,
   ptp_1hzclk_i,
   pma_rx_clk0,                                                   // same as above(this 2 below clock are phase shifted) 
   pma_rx_clk1,                                                   // same as above  
   phyid,
   anx_state,
   sync
 );

// --------------------------------------------------------------------------
// -- Port Declarations

input   [9:0] tcg_dut;
output  [9:0] rcg_dut;
output gtx_clki;
output ptp_clk_i;
output ptp_1hzclk_i;
output pma_rx_clk0;
output pma_rx_clk1;

input         tx_clko;     // MII Transmit Clock, Output    ( pre-clock tree )
input         txceno;      // Transmit Clock Enable, Output ( pre-clock tree )
input         rx_clko;     // MII Receive Clock, Output     ( pre-clock tree )
input         rxceno;      // Receive Clock Enable, Output  ( pre-clock tree )
input         tx_en;       // G/MII Transmit Enable
input   [7:0] txd;         // G/MII Transmit Data
input         tx_er;       // G/MII Transmit Error
input         mdc;         // MII Management Data Clock
input         mdo;         // MII Management Data Output
input         mdoen;       // MII Management Data Output Enable
input  [31:0] ahb_hrdata;  // AHB slave read data
input   [1:0] ahb_hresp;   // AHB slave response
input         ahb_hreadyo; // AHB slave ready
input         ahb_txhbusreq; // AHB master bus request
input         ahb_rxhbusreq; // AHB master bus request
input   [1:0] ahb_txhtransm; // AHB master transaction type
input   [1:0] ahb_rxhtransm; // AHB master transaction type
input  [31:2] ahb_txhaddrm;  // AHB master transaction address
input  [31:2] ahb_rxhaddrm;  // AHB master transaction address
input         ahb_txhwritem; // AHB master transfer direction
input         ahb_rxhwritem; // AHB master transfer direction
input  [31:0] ahb_txhwdatam; // AHB master write data bus
input  [31:0] ahb_rxhwdatam; // AHB master write data bus
input         interrupt;   // Host DMA interrupt
input  [4:0]  phyid;
input  [9:0]  anx_state;
input  sync;

output        tx_clk;      // MII Transmit Clock ( from external source )
output        tx_clki;     // MII Transmit Clock, Input ( post clock tree )
output        txceni;      // Transmit Clock Enable, Input ( post clock tree )
output        rx_clk;      // MII Receive Clock  ( from external source )
output        rx_clki;     // MII Receive Clock, Input  ( post clock tree )
output        rxceni;      // Receive Clock Enable, Input  ( post clock tree )
output        crs;         // MII Carrier Sense
output        col;         // MII Collision
output        mdi;         // MII Management Data Input
output        rx_dv;       // G/MII Receive Data Valid
output  [7:0] rxd;         // G/MII Receive Data
output        rx_er;       // G/MII Receive Error
output        rstbp;       // Reset Bypass
output [31:0] ahb_hwdata;  // AHB write data
output  [9:2] ahb_haddr;   // AHB address
output        ahb_hsel;    // AHB slave select
output  [1:0] ahb_htrans;  // AHB transaction type
output        ahb_hwrite;  // AHB transaction direction
output        ahb_txhgrant;  // AHB bus grant
output        ahb_rxhgrant;  // AHB bus grant
output  [1:0] ahb_txhrespm;  // AHB response
output  [1:0] ahb_rxhrespm;  // AHB response
output [31:0] ahb_txhrdatam; // AHB read data
output [31:0] ahb_rxhrdatam; // AHB read data
output        ahb_hreadyi; // AHB ready
output        hresetn;     // AHB system reset (active low)
output        hclk;        // AHB system clock

// --------------------------------------------------------------------------
// -- Internal Signal Declarations

reg [9:0]     tcg_out ;   
reg           gtx_clki ;   // Define a GTX clk   
reg           ptp_clk_i ;   // Define a GTX clk   
reg           ptp_1hzclk_i ;   // Define a GTX clk   
reg           pma_rx_clk0;
reg           pma_rx_clk1;
// --------------------------------------------------------------------------
// -- Internal Signal Declarations

reg          test_auto_neg_en;
reg [9:0]     rcg_dut ;   
reg           ftclk;    
reg    [31:0] ftdat;    
reg           ftsof;
reg           fteof;   
reg     [1:0] ftdatnvld; 
reg           ftppgenfcs;
reg           ftppen;     
reg     [1:0] ftpppadmode;
reg           ftcfrm;     
reg           ftrdy;
reg           frclk;
reg           fracpt;
reg           srdrpfrm;
reg           drrd;
reg           miim;

reg           tx_clk;      // MII Transmit Clock ( from external source )
reg           tx_clki;     // MII Transmit Clock, Input ( post clock tree )     // Change reg from wire
reg           txceni;      // Transmit Clock Enable, Input ( post clock tree )
reg           rx_clk;      // MII Receive Clock  ( from external source )
reg           rx_clki;     // MII Receive Clock, Input  ( post clock tree )
reg           rxceni;      // Receive Clock Enable, Input  ( post clock tree )
wire          crs;         // MII Carrier Sense
wire          col;         // MII Collision
reg           mdi;         // MII Management Data Input
reg           rx_dv;       // G/MII Receive Data Valid
reg     [7:0] rxd;         // G/MII Receive Data
reg           rx_er;       // G/MII Receive Error
reg           rstbp;       // Reset Bypass
reg    [31:0] ahb_hwdata;  // AHB write data
reg     [9:2] ahb_haddr;   // AHB address
reg           ahb_hsel;    // AHB slave select
reg     [1:0] ahb_htrans;  // AHB transaction type
reg           ahb_hwrite;  // AHB transaction direction
reg           ahb_txhgrant;  // AHB bus grant
reg           ahb_rxhgrant;  // AHB bus grant
reg     [1:0] ahb_hrespm;  // AHB response
wire   [31:0] ahb_hrdatam;   // AHB read data
reg    [31:0] ahb_hrdatamint;// AHB read data internal
reg    [31:0] rx_ahb_hrdatamint;// AHB read data internal
wire          ahb_hreadyi; // AHB ready
reg           hresetn;     // AHB system reset (active low)
reg           hclk;        // AHB system clock
reg rx_clki_int = 1'b1;


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
// PMA Tx variables
// ------------------------------------------------------------------------
reg    [10:0] pma_tx_mem[0:2047];
integer       pma_tx_ptr, pma_chk_ptr;
reg           disp_in,  disp_out;
reg           d_code, k_code;
reg     [7:0] tx_d;
reg     [9:0] tcgd;
reg           sop, dat, eop;
reg    [10:0] pma_tx_data;
reg           cd1, cd2, cdn;
reg    [15:0] pma_tx_c;
reg     [1:0] pma_tx_frm;
reg     [3:0] pma_tx_pre;
reg           pma_tx_sfd;
reg    [15:0] pma_tx_dat;
reg           pma_tx_err;
reg     [7:0] pma_tx_fls;


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
// PMA Rx variables
// ------------------------------------------------------------------------
reg           exlb;
reg    [10:0] pma_rx_mem[0:2047];
integer       pma_rx_ptr;
reg           even;
reg           rcg_en, rcg_end;
wire          idle_even, idle_odd;
wire          en_even, en_odd;
wire          rcg_enable, clr_rcg_en;
wire   [10:0] pma_rx_mem_data;
wire    [9:0] grcg;

// ==========================================================================
// == MODULE SIGNALS AND DEFINES
// ==========================================================================

parameter     TP = 1;

integer       tx_clkprd;        // MAC transmit clock period    
integer       txcenihigh;       // MAC transmit clock enable high period    
integer       txcenilow;        // MAC transmit clock enable low  period    
integer       rx_clkprd;        // MAC receive  clock period     
integer       rxcenihigh;       // MAC receive clock enable high period    
integer       rxcenilow;        // MAC receive clock enable low period    
integer       hclkprd;          // AHB system clock period 
integer       rxclkprd;         // MAC SGMII receive  clock period    
integer       gtx_clkiprd;      // MAC TBI transmit clock period    
integer       txclkx2prd;       // SGMII bus transmit clock double frequency period    
 
reg           tx_clkrst;        // MAC transmit clock period clock reset
reg           txcenirst;        // MAC transmit clock enable reset
reg           txcenien;         // MAC transmit clock enable enable
reg           rx_clkrst;        // MAC receive clock period  clock reset
reg           rxcenirst;        // MAC receive clock enable reset
reg           rxcenien;         // MAC receive clock enable enable
reg           hclkrst;          // AHB system clock reset
reg           gtx_clkirst;      // MAC TBI transmit clock reset  
reg           txclkx2rst;       // SGMII bus transmit clock double frequency reset
reg           rxclkrst;         // MAC SGMII receive  clock reset
wire           reset;         // MAC SGMII receive  clock reset

reg    [31:0] ahbram [16'h0100:16'hFFFF]; // AHB RAM model
reg           ahbramen;         // AHB RAM enable
reg           ahb_hwritem_reg;  // AHB RAM write register
reg           rx_ahb_hwritem_reg;  // AHB RAM write register
reg    [17:2] ahb_haddrm_reg;   // AHB RAM write address register
reg    [17:2] rx_ahb_haddrm_reg;   // AHB RAM write address register
reg           tx_ahb_hgranten;     // AHB bus grant enable
reg           rx_ahb_hgranten;     // AHB bus grant enable
reg           ahb_hreadyint;    // AHB ready internal




reg           stactv;           // System transmit  process active flag
reg           lractv;           // Link   recieve   process active flag
reg           ltactv;           // Link   transmit  process active flag
reg           sractv;           // System recieve   process active flag
reg           mmactv;           // MII Management recieve process active flag


// ==========================================================================
// == TESTS INVOCATION
// ==========================================================================

// --------------------------------------------------------------------------
// -- Master Test Control
// -- The
// 

assign ahb_txhrespm = 2'b00;
assign ahb_rxhrespm = 2'b00;
initial
begin
   #1 
   resetcore;
   test_anen_en;
   resetcore;
   coretse_sgmii_tg01_test01(1);
   gl.dsplyend;
   $stop;
   $finish;
end

// ==========================================================================
// == TESTS
// ==========================================================================

// ------------------------------------------------------------------------
// Auto-Negotiation Enabled
// TEST SEQUENCE
//1.Initialize by restarting auto-negotiation by writing to register. 
//2.Provide a link of /I/ codes such that the DUT enters the ABILITY_DETECT state. 
//3.Provide a link of /C/ codes with a Config_Reg of zero 
//3a.Provide a link of /C/ codes with Base Page information of a Link Partner.
//4. Verify that Autoneogation was successful. 

task test_anen_en;
reg    [15:0] ii, mgmt_read;
begin
// ------------------------------------------------------------------------
$display(" ---------------------------------------------------------");
$display(" - - - - -TEST CASE AUTO NEGOTITAION ENABLE  - - - - - - ");
$display(" ---------------------------------------------------------");
// ------------------------------------------------------------------------
  test_auto_neg_en = 1'b1;
   initregs;
   mstrwr( { 29'h0000_0001, 2'h0 }, 32'h0000_7201); 
   mstrwr( { 29'h0000_0014, 2'h0 }, { 16'h0AAA, 16'h0555} ); 
  repeat(500)  @ ( posedge pma_rx_clk0 );
  $display("\n Auto-Negotiation intiated by CoreTSE_AHB Module");
  $display("\n%0d: Step 1: Restart Auto Negotiation",$time);
  mgmt_wr( phyid[4:0], 5'h00, 16'h9140 ); // rstphy,anen,fdx,1000
  mgmt_wr( phyid[4:0], 5'h11, 16'h4020 ); // sltmr
  mgmt_wr( phyid[4:0], 5'h00, 16'h1340 ); // anen, rstan,fdx,1000
  mgmt_wr( phyid[4:0], 5'h04, 16'h00A0 ); // anar (NP=0 in base page)

  $display("\n%0d: Step 2: Provide a string of /I/ codes",$time);
  for ( ii = 0; ii < 250; ii = ii + 4 )
  begin
    pma_pkt_wr( ii,       11'h17c ); // /-K28.5+/
    pma_pkt_wr( ii+1,     11'h689 ); // /+D16.2-/
  end
  pma_pkt_send;

  $display("\n%0d: Step 3: Provide a string of /C/ codes followed",$time);
  $display("%0d: by a Base Page.",$time);
  // Config Code Words
  for ( ii = 0; ii < 64; ii = ii + 16 )
  begin
    pma_pkt_wr( ii  ,     11'h17c ); // /-K28.5+/
    pma_pkt_wr( ii+1,     11'h155 ); // /+D21.5+/
    pma_pkt_wr( ii+2,     11'h346 ); // /+D0.0+/
    pma_pkt_wr( ii+3,     11'h346 ); // /+D0.0+/
 pma_pkt_wr( ii+4,     11'h283 ); // /+K28.5-/
    pma_pkt_wr( ii+5,     11'h2ad ); // /-D2.2+/
    pma_pkt_wr( ii+6,     11'h346 ); // /+D0.0+/
    pma_pkt_wr( ii+7,     11'h346 ); // /+D0.0+/

    pma_pkt_wr( ii+8,     11'h283 ); // /+K28.5-/
    pma_pkt_wr( ii+9,     11'h155 ); // /-D21.5-/
    pma_pkt_wr( ii+10,    11'h0b9 ); // /-D0.0-/
    pma_pkt_wr( ii+11,    11'h0b9 ); // /-D0.0-/

    pma_pkt_wr( ii+12,    11'h17c ); // /-K28.5+/
    pma_pkt_wr( ii+13,    11'h292 ); // /+D2.2-/
    pma_pkt_wr( ii+14,    11'h0b9 ); // /-D0.0-/
    pma_pkt_wr( ii+15,    11'h0b9 ); // /-D0.0-/
  end

  for ( ii = 64; ii < 80; ii = ii + 16 )
  begin
    pma_pkt_wr( ii  ,     11'h17c ); // /-K28.5+/
    pma_pkt_wr( ii+1,     11'h155 ); // /+D21.5+/
    pma_pkt_wr( ii+2,     11'h146 ); // /+D0.5-/
    pma_pkt_wr( ii+3,     11'h0ae ); // /-D0.0-/

    pma_pkt_wr( ii+4,     11'h17c ); // /-K28.5+/
    pma_pkt_wr( ii+5,     11'h292 ); // /+D2.2-/
    pma_pkt_wr( ii+6,     11'h179 ); // /-D0.5+/
    pma_pkt_wr( ii+7,     11'h351 ); // /+D0.0+/

    pma_pkt_wr( ii+8,     11'h283 ); // /+K28.5-/
    pma_pkt_wr( ii+9,     11'h155 ); // /-D21.5-/
    pma_pkt_wr( ii+10,    11'h179 ); // /-D0.5+/
    pma_pkt_wr( ii+11,    11'h351 ); // /+D0.0+/

    pma_pkt_wr( ii+12,    11'h283 ); // /+K28.5-/
    pma_pkt_wr( ii+13,    11'h2ad ); // /-D2.2+/
    pma_pkt_wr( ii+14,    11'h146 ); // /+D0.5-/
    pma_pkt_wr( ii+15,    11'h0ae ); // /-D0.0-/
  end


  for ( ii = 80; ii < 176; ii = ii + 16 )
  begin
    pma_pkt_wr( ii  ,     11'h17c ); // /-K28.5+/
    pma_pkt_wr( ii+1,     11'h155 ); // /+D21.5+/
    pma_pkt_wr( ii+2,     11'h146 ); // /+D0.0+/
    pma_pkt_wr( ii+3,     11'h2ae ); // /+D0.0+/

    pma_pkt_wr( ii+4,     11'h283 ); // /+K28.5-/
    pma_pkt_wr( ii+5,     11'h2ad ); // /-D2.2+/
    pma_pkt_wr( ii+6,     11'h146 ); // /+D0.0+/
    pma_pkt_wr( ii+7,     11'h2ae ); // /+D0.0+/

    pma_pkt_wr( ii+8,     11'h283 ); // /+K28.5-/
    pma_pkt_wr( ii+9,     11'h155 ); // /-D21.5-/
    pma_pkt_wr( ii+10,    11'h179 ); // /-D0.0-/
    pma_pkt_wr( ii+11,    11'h291 ); // /-D0.0-/

    pma_pkt_wr( ii+12,    11'h17c ); // /-K28.5+/
    pma_pkt_wr( ii+13,    11'h292 ); // /+D2.2-/
    pma_pkt_wr( ii+14,    11'h179 ); // /-D0.0-/
    pma_pkt_wr( ii+15,    11'h291 ); // /-D0.0-/
  end

  // IDLEs for Completion of Autoneg.
  for ( ii = 176; ii < 450; ii = ii + 4 )
  begin
    pma_pkt_wr( ii,       11'h17c ); // /-K28.5+/
    pma_pkt_wr( ii+1,     11'h689 ); // /+D16.2-/
  end

  pma_pkt_send;
  repeat(50)  @ ( posedge pma_rx_clk0 );

  $display("\n%0d: Step 4: Verifying Auto-neogation status", $time);
  mgmt_rd( phyid[4:0], 5'h01, mgmt_read );
  if ( mgmt_read[5] !== 1'b1 ) begin
    gl.dsplyerr(" ERROR: Auto-neogation did not Complete");
  end
  if ( mgmt_read[5] == 1'b1 )
    $display("\n%0d: PASS: Auto-neogation Completed",$time);

  test_auto_neg_en = 1'b0;
end
endtask

// --------------------------------------------------------------------------
// -- Random and data, IPG, and preamble pattern tests
task coretse_sgmii_tg01_test01;
//// Added new GMII configuration.
  input       fastmode;                // fast test mode
  integer     maxfrmbc;                // Maximum frame byte count
  integer     maxfrmcnt;               // Maximum frame count
  integer     maxclklp;                // Maximum number of different hclk period secnarios
  integer   speed;                   // GMII=2, MII100=1, MII10=0
  reg  [31:0] toploop;
  integer     maxipgbc, minipgbc;     // maximum and minimum IPG byte count 
  integer     maxprebc, minprebc;     // maximum and minimum Preamble byte count 
  reg  [31:0] i, j, k, m, r, s;        // variables
  reg [255:0] atfp,   lrfp,   trfp;    // AHB transmit & link receive  descriptors 
  reg [255:0] arfp,   ltfp,   rrfp;    // AHB receive  & link transmit descriptors 
  reg  [31:0] atfpsd, lrfpsd, trfpsd;  // AHB transmit & link receive  seeds
  reg  [31:0] arfpsd, ltfpsd, rrfpsd;  // AHB receive  & link transmit seeds
  reg  [31:0] atclkdlysd, atclkdly;    // fabric transmit clock delay and seed
  reg  [31:0] arclkdlysd, arclkdly;    // fabric receive  clock delay and seed
  reg  [31:0] tmpvar;                 // Generic variable
  reg  [31:0] stfpsd , srfpsd;                 // MAC transmit & link receive  seeds
  integer     maxfrmc,  maxbc, minbc; // maximum and minimum loop settings
  integer     tg01_test01_mark;
  reg   [7:0] stipgbc,    ltipgbc;    // IPG byte counts
  reg   [7:0] stprebc,    ltprebc;    // Transmit preamble byte counts
  reg         rdsp;                   // running disparity
  begin
    gl.dsplytcmnt(     "This test DMA'a random size and payload data frames through");
    gl.dsplytcmnt(     "Transmit and  then receive paths of the mac ahb.");
    gl.dsplytcmnt(     "This is done for different speeds of the AHB bus which excersizes");
    gl.dsplytcmnt(     "both full and empty conditions of tranasmit and receive FIFO's.");
    atfp = mlat.dflt_dsc; // initialize AHB transmit descriptor
    lrfp = mllr.dflt_dsc; // initialize link receive descriptor
    arfp = mlar.dflt_dsc; // initialize AHB receive descriptor
    ltfp = mllt.dflt_dsc; // initialize link transmit descriptor
    for ( toploop = 0; toploop < 2; toploop = toploop + 1 )
    begin
      clractv;
      begin
        rdsp = 1;
        if (  toploop[1] )
        begin
            @ ( posedge rx_clk );
            gl.dsplystat(  "Link transmitting commas on positive rxclk edge.");
        end
        if ( ~toploop[1] )
        begin
            @ ( negedge rx_clk );
            gl.dsplystat(  "Link transmitting commas on negative rxclk edge.");
        end
        if (  toploop[2] ) gl.dsplystat(  "Link transmitting negative disparity commas.");
        if ( ~toploop[2] ) gl.dsplystat(  "Link transmitting positive disparity commas.");
        while( stactv ) ltidl( toploop[2], rdsp);
      end
      if ( ~fastmode ) begin
        maxfrmbc  = 1518;
        maxfrmcnt = 30;
        maxclklp  = 10;
      end  else begin
        maxfrmbc  = 200;
        maxfrmcnt = 2;
        maxclklp  = 2;
      end

      if ( fastmode ) maxfrmc  = 4; 
      else            maxfrmc  = 20;
      maxbc    = 256; minbc    = 32;
      maxbc    = 256; minbc    = 32; 
      maxipgbc = 24;  minipgbc = 10;
      maxprebc = 9;   minprebc = 5;
      stfpsd   = 3; // lrfpsd = stfpsd; srfpsd = lrfpsd+1; ltfpsd = srfpsd; 

      for ( k=0; k<maxclklp; k=k+1 ) begin
        if ( k == 0 ) begin
           hclkprd   = 1301;  // Fabric receive clock period
           gl.dsplystat("Using 1.3 ns HCLK period. Creates full transmit queues");
           gl.dsplystat("and empty receive queues.");
        end
        if ( k == 1 ) begin
           hclkprd   = 10000;  // Fabric receive clock period
           gl.dsplystat("Using 10 ns HCLK period. Creates full transmit queues");
           gl.dsplystat("and empty receive queues.");
        end
        if ( k == 2 ) begin
           hclkprd   = 30000;  // Fabric receive clock period
           gl.dsplystat("Using 30 ns HCLK period. Creates full transmit queues");
           gl.dsplystat("and empty receive queues.");
        end
        if ( k == 3 ) begin
           hclkprd   = 100000;  // Fabric receive clock period
           gl.dsplystat("Using 100 ns HCLK period. Creates empty transmit queues");
           gl.dsplystat("and full receive queues.");
        end
        if ( k > 3 ) begin
           hclkprd = mlat.randinrange( 10000, 500, atfpsd );
           $display("          STATUS  : Using %d ps HCLK period.", hclkprd);
        end
        for ( speed=2; speed>=0; speed=speed-1 )
        begin
          if ( speed == 2 ) gl.dsplystat(  "Testing GMII speeds.");
          if ( speed == 1 ) gl.dsplystat(  "Testing MII 100 speeds.");
          if ( speed == 0 ) gl.dsplystat(  "Testing MII 10 speeds.");
          resetnholdclks;
          if ( toploop[0] == 0 )
          begin
             if ( speed == 2 ) tx_clkprd = 8000;//  7998;
             if ( speed == 1 ) tx_clkprd = 40000;// 39992;
             if ( speed == 0 ) tx_clkprd = 400000;//399920;
             if ( speed == 2 ) rx_clkprd = 8000;//  7998;
             if ( speed == 1 ) rx_clkprd = 40000;// 39992;
             if ( speed == 0 ) rx_clkprd = 400000;//399920;
          end
          if ( toploop[0] == 1 )
          begin
             if ( speed == 2 ) tx_clkprd = 8000;//  8002;
             if ( speed == 1 ) tx_clkprd = 40000;// 40008;
             if ( speed == 0 ) tx_clkprd = 400000;//400080;
             if ( speed == 2 ) rx_clkprd = 8000;//  7998;
             if ( speed == 1 ) rx_clkprd = 40000;// 39992;
             if ( speed == 0 ) rx_clkprd = 400000;//399920;
          end
  
          enableclks;
          clractv;
          resetcore;      
          initregs;
          begin
          end  
          if ( speed == 1 ) mstrwr( {30'h0E,2'h0}, 32'h02000000 ); // IFCR set M-SGMII speed to 100 Mb/s
          if ( speed == 0 ) mstrwr( {30'h0E,2'h0}, 32'h00000000 ); // IFCR set M-SGMII speed to 100 Mb/s
          if ( speed != 2 ) mstrwr( {30'h01,2'h0}, 32'h00007101 ); // set full duplex and nibble mode in MAC2 reg   
          repeat(30) @ ( posedge mdc );
          stactv = 0;
          mstrwr( { 29'h0000_0001, 2'h0 }, {20'h00007,speed[3:0],8'b01} ); // Configuring for GMII, no FCS, no pad, full duplex
          atfpsd = k;
          lrfpsd = atfpsd;
          ltfpsd = k+1;
          arfpsd = ltfpsd;                
      
          // synchronize and wait for autoneg bypass to occur
          repeat( 61 )  ltidl(rdsp, rdsp); // syncronize state machine
          repeat( 239 ) ltidl(rdsp, rdsp); // wait for autoneg bypass to occur
          clractv;

          @ ( posedge hclk )
          fork
            //AHB transmit
            //TX Path
            begin
            mstrwr(    32'h0000_0184,   32'h0000_0400 );  // DMA tx descriptor byte address
            mstrwr(    32'h0000_0180,   32'h0000_0001 );  // Enable DMA
            for ( i=0; i< (maxfrmcnt/2); i=i+1 )
            begin
              atfpsd        = $random(atfpsd);
              atfp[191:176] = mlat.randinrange( maxfrmbc, 18, atfpsd ); // set random length
              atfpsd        = $random(atfpsd);
              atfp[199:192] = atfpsd[7:0];                          // set random payload seed
              slvrddesc( 32'h0000_0400, { 32'h0000_1000,            // frame start address
                                          {16'h0000, atfp[191:176] },  // Not empty and a x byte frame
                                          32'h0000_040C });         // Next descriptor start address
              slvrdfrm(  32'h0000_1000,   32'h0000_0400,            // frame data and descriptor address
                                          atfp           );         // build frame descriptor
              atfpsd        = $random(atfpsd);
              atfp[191:176] = mlat.randinrange( maxfrmbc, 18, atfpsd ); // set random length
              atfpsd        = $random(atfpsd);
              atfp[199:192] = atfpsd[7:0];                          // set random payload seed
              slvrddesc( 32'h0000_040C, { 32'h0000_1800,            // frame start address
                                          {16'h0000, atfp[191:176] },  // Not empty and a x byte frame
                                          32'h0000_0400 });         // Next descriptor start address
              slvrdfrm(  32'h0000_1800,   32'h0000_040C,            // frame data and descriptor address
                                          atfp           );         // build frame descriptor
            end
              slvrddesc( 32'h0000_0400, { 32'h0000_1000,               // frame start address
                                        32'h8000_0000,               // Empty and a 0 byte frame
                                        32'h0000_040C });            // Next descriptor start address
              repeat(100)begin
                @(posedge hclk);
              end                            
              $display("          STATUS  : AHB Transmit Completed");
            end

            begin // Link Recieve
              lractv = 1;
              synctx( tmpvar[9:0] );  // sync to comma
              $display("          STATUS  : LINK RX Sync TX Completed");
              for (k=0; k < maxfrmcnt; k=k+1 )
              begin
                lrfp          = mllr.dflt_dsc; // initialize Link receive descriptor
                lrfpsd        = $random(lrfpsd);
                lrfp[191:176] = mllr.randinrange( maxfrmbc, 18, lrfpsd ); // set random length
                lrfpsd        = $random(lrfpsd);
                lrfp[199:192] = lrfpsd[7:0];     // set random payload seed
                lrfrm_sgmii( lrfp, {8'd7, {2'b00,speed[1:0]}} ); // receive frame from MAC
                $display("          STATUS  : Link received frame %0d with %0d bytes ", (k+1), lrfp[191:176] );
              end
              lractv = 0;
            end
            begin
              while( lractv ) ltidl(rdsp, rdsp);
            end
          join
              repeat(100)begin
                @(posedge hclk);
              end                            
          fork
            //RX Path
            begin // Link Transmit
              for ( m=0; m< maxfrmcnt; m=m+1 )
              begin
                ltfp          = mllt.dflt_dsc; // initialize Link transmit descriptor
                ltfpsd        = $random(ltfpsd);
                ltfp[191:176] = mllt.randinrange(maxfrmbc /*maxbc*/ , 18 /*minbc*/, ltfpsd ); // set random length
                ltfpsd        = $random(ltfpsd);
                ltfp[199:192] = ltfpsd[7:0];   // set random payload seed
                ltipgbc       = mllt.randinrange( maxipgbc, minipgbc,  ltfpsd ); // set random IPG byte count
                ltprebc       = mllt.randinrange( maxprebc, minprebc,  ltfpsd ); // set random preamble byte count
                ltfrm_sgmii( ltfp, {3'h0, rdsp, speed[3:0], ltprebc, ltipgbc}, rdsp );
              end
            end

            begin
              sractv = 1;
              mstrwr(    32'h0000_0190,   32'h0000_0600  ); // DMA rx descriptor byte address
              mstrwr(    32'h0000_018C,   32'h0000_0001  ); // Enable DMA
              for ( i=0; i<(maxfrmcnt/2); i=i+1 )
              begin
                arfpsd        = $random(arfpsd);
                arfp[191:176] = mlar.randinrange( maxfrmbc, 18, arfpsd ); // set random length
                 
                arfpsd        = $random(arfpsd);
                arfp[199:192] = arfpsd[7:0];                  // set random payload seed
                rxslvrddesc( 32'h0000_0600, { 32'h0000_C000,    // frame start address
                                            32'h8000_0000,    // empty frame flag
                                            32'h0000_060C }); // Next descriptor start address
                slvwrfrm(  32'h0000_C000,   32'h0000_0600,    // frame data and descriptor address
                                            arfp           ); // build frame descriptor
                $display("          STATUS  : AHB  received %d byte frame", arfp[191:176]);
                arfpsd        = $random(arfpsd);
                arfp[191:176] = mlar.randinrange( maxfrmbc, 18, arfpsd ); // set random length
                arfpsd        = $random(arfpsd);
                arfp[199:192] = arfpsd[7:0];                          // set random payload seed
                rxslvrddesc( 32'h0000_060C, { 32'h0000_C800,    // frame start address
                                            32'h8000_0000,    // empty frame flag
                                            32'h0000_0600 }); // Next descriptor start address
                slvwrfrm(  32'h0000_C800,   32'h0000_060C,    // frame data and descriptor address
                                            arfp           ); // build frame descriptor
                $display("          STATUS  : AHB  received %d byte frame", arfp[191:176]);
              end
              sractv = 0;
            end
          join 
        end
      end
    end
  end
 endtask

// ==========================================================================
// == LIBRARY INSTANTIATIONS
// ==========================================================================

gl gl();     // Generic Library instatiations
ml mlat();   // MAC library for AHB transmit
ml mllr();   // MAC library for link receive
ml mllt();   // MAC library for link transmit
ml mlar();   // MAC library for AHB receive

/// =========================================================================
// == MISCELANEOUS
// ==========================================================================
                                                                           
// --------------------------------------------------------------------------
// -- Signal Initialization

initial
begin
   tx_clk         = 1'b0;  
   txceni         = 1'b1;
   rx_clk         = 1'b0;  
   rxceni         = 1'b1;
   mdi            = 1'b0;
   rx_dv          = 1'b0;
   rxd[7:0]       = 8'h0;
   rx_er          = 1'b0;
   rstbp          = 1'b0;
   ahb_hwdata     = 32'h0;     
   ahb_haddr      = 8'h0;      
   ahb_hsel       = 1'b0;       
   ahb_htrans     = 2'b00;     
   ahb_hwrite     = 1'b0;     
   ahb_txhgrant     = 1'b0;     
   ahb_rxhgrant     = 1'b0;     
   ahb_hrespm     = 2'b00;      
   ahb_hrdatamint = 32'h0;     
   rx_ahb_hrdatamint = 32'h0;     
   hresetn        = 1'b1;    
   hclk           = 1'b1;       

end

// --------------------------------------------------------------------------
// -- Variable Initialization

initial
begin
   tx_clkrst       = 1'b0;   // MAC transmit clock reset
   tx_clkprd       = 8000;   // MAC transmit clock period    
   txcenirst       = 1'b0;   // MAC transmit clock reset
   txcenien        = 1'b0;   // MAC transmit clock enable
   txcenihigh      = 40000;  // MAC transmit clock enable high period
   txcenilow       = 360000; // MAC transmit clock enable low period
   rx_clkrst       = 1'b0;   // MAC receive  clock reset
   rx_clkprd       = 8000;   // MAC receive  clock period     
   rxcenirst       = 1'b0;   // MAC receive  clock reset
   rxcenien        = 1'b0;   // MAC receive  clock enable
   rxcenihigh      = 40000;  // MAC receive  clock enable high period
   rxcenilow       = 360000; // MAC receive  clock enable low period
   hclkprd         = 10000;  // Fabric receive clock period      
   hclkrst         = 0;      // Fabric receive clock reset
   ahbramen        = 1'b0;   // AHB RAM enable
   ahb_hwritem_reg = 1'b0;   // AHB RAM write register
   rx_ahb_hwritem_reg = 1'b0;   // AHB RAM write register
   ahb_haddrm_reg  = 16'h0;  // AHB RAM write address register
   rx_ahb_haddrm_reg  = 16'h0;  // AHB RAM write address register
   tx_ahb_hgranten    = 1'b1;   // AHB bus grant enable
   rx_ahb_hgranten    = 1'b1;   // AHB bus grant enable
   ahb_hreadyint   = 1'b1;   // AHB ready internal
   rxclkprd         = 1600; // SGMII recieve  clock period    
   txclkx2prd       =  800; // SGMII bus transmit clock double frequency    
   gtx_clkiprd      = 10*txclkx2prd; // MAC TBI transmit clock period    

  test_auto_neg_en = 1'b0;
  drrd = 1'b0; 
  exlb = 1'b0; 
  miim = 1'b0; 
  pma_tx_frm = 2'h0;
  pma_tx_pre = 4'h0;
  pma_tx_sfd = 1'b0;
  pma_tx_dat = 16'h0;
  pma_tx_err = 1'b0;
  pma_tx_fls = 8'h0;
end

// --------------------------------------------------------------------------
// -- Logic

assign crs = tx_en | rx_dv;
//assign rx_clki = rx_clki_int;
assign col = tx_en & rx_dv;

assign ahb_hreadyi = ahb_hreadyo & ahb_hreadyint;

always @ ( posedge hclk )
begin
   ahb_txhgrant <= #1 ( ahb_txhbusreq & tx_ahb_hgranten );
end

always @ ( posedge hclk )
begin
   ahb_rxhgrant <= #1 ( ahb_rxhbusreq & rx_ahb_hgranten );
end

// Read AHB RAM
always @ ( posedge hclk )
begin
   if ( ahbramen & ahb_hreadyint )
   begin 
      ahb_hrdatamint <= #1 ahbram[ahb_txhaddrm[17:2]];
   end
end

// Read AHB RAM
always @ ( posedge hclk )
begin
   if ( ahbramen & ahb_hreadyint )
   begin 
      rx_ahb_hrdatamint <= #1 ahbram[ahb_rxhaddrm[17:2]];
   end
end



assign ahb_txhrdatam =   {32{ ahb_hreadyint}} & ahb_hrdatamint     | {32{~ahb_hreadyint}} & 32'hXXXX_XXXX;
assign ahb_rxhrdatam =   {32{ ahb_hreadyint}} & rx_ahb_hrdatamint  | {32{~ahb_hreadyint}} & 32'hXXXX_XXXX;

always @ ( posedge hclk )
begin
   ahb_hwritem_reg <= #1 ahb_txhwritem & ( ahb_txhtransm != 2'b00 );
end


always @ ( posedge hclk )
begin
   rx_ahb_hwritem_reg <= #1 ahb_rxhwritem & ( ahb_rxhtransm != 2'b00 );
end


always @ ( posedge hclk )
begin
   ahb_haddrm_reg  <= #1 ahb_txhaddrm[17:2];
end

always @ ( posedge hclk )
begin
   rx_ahb_haddrm_reg  <= #1 ahb_rxhaddrm[17:2];
end

// Write AHB RAM
always @ ( posedge hclk )
begin
   if ( ahb_hwritem_reg )
   begin
      ahbram[ahb_haddrm_reg[17:2]] <= #1 ahb_txhwdatam;
   end
end


// Write AHB RAM
always @ ( posedge hclk )
begin
   if ( rx_ahb_hwritem_reg )
   begin
      ahbram[rx_ahb_haddrm_reg[17:2]] <= #1 ahb_rxhwdatam;
   end
end



// --------------------------------------------------------------------------
// -- Clocks

always 
begin
   while ( tx_clkrst ) #1;
   tx_clk = #(tx_clkprd/2) 1'b0;
   tx_clk = #(tx_clkprd/2) 1'b1;
end

always
begin
  // tx_clkprd is equal to 8000(decimal).
   tx_clki = #(tx_clkprd/2) 1'b0 ;
   tx_clki = #(tx_clkprd/2) 1'b1 ;
end

always
begin
 gtx_clki = #(gtx_clkiprd/2) 1'b0 ; 
 gtx_clki = #(gtx_clkiprd/2) 1'b1 ; 
end

always
begin
 pma_rx_clk0 = #(gtx_clkiprd) 1'b0 ; 
 pma_rx_clk0 = #(gtx_clkiprd) 1'b1 ;
end

always
begin
 pma_rx_clk1 = #(gtx_clkiprd) 1'b1 ; 
 pma_rx_clk1 = #(gtx_clkiprd) 1'b0 ;
end

//assign tx_clki = tx_clk;

always 
begin
   if ( txcenirst )
   begin
      while ( txcenirst ) #1;
      #(3*TP);
   end
   txceni = #txcenihigh ~txcenien;
   txceni = #txcenilow  1'b1;
end

always 
begin
   while ( rx_clkrst ) #1;
   rx_clk = #(rx_clkprd/2) 1'b0;
   rx_clk = #(rx_clkprd/2) 1'b1;
end

always 
begin
   while ( rx_clkrst ) #1;
   rx_clki = #(rx_clkprd/2) 1'b0;
   rx_clki = #(rx_clkprd/2) 1'b1;
end


`ifdef PTP_CLK_125_MHZ
always
begin
  ptp_clk_i = #(4000) 1'b0;
  ptp_clk_i = #(4000) 1'b1;
end

`elsif PTP_CLK_250_MHZ
always
begin
  ptp_clk_i = #(2000) 1'b0;
  ptp_clk_i = #(2000) 1'b1;
end
`endif
always
begin
 ptp_1hzclk_i = #(100) 1'b0;
 ptp_1hzclk_i = #(100) 1'b1;
end



always
begin
  // tx_clkprd is equal to 8000(decimal).
  #4000 rx_clki_int = ~rx_clki_int ;
end

always 
begin
   if ( rxcenirst )
   begin
      while ( rxcenirst ) #1;
      #(3*TP);
   end
   rxceni = #rxcenihigh ~rxcenien;
   rxceni = #rxcenilow  1'b1;
end

always 
begin
   while ( hclkrst ) #1;
   hclk = #(hclkprd/2)  1'b0;
   hclk = #(hclkprd/2)  1'b1;
end

// ------------------------------------------------------------------------
// --- PMA Receive Logic
// ------------------------------------------------------------------------
always @ ( posedge pma_rx_clk1 or posedge pma_rx_clk0)
begin
  if      ( reset )                even <= #TP 1'b1;
  else                            even <= #TP ~even;
end
// ------------------------------------------------------------------------
//  rcg_en :: Receive Code Group Enable ( set in task: pma_pkt_send )
// ------------------------------------------------------------------------
always @ ( posedge pma_rx_clk1 or posedge pma_rx_clk0 or posedge reset )
begin
       if ( reset )                rcg_en <= #TP 1'b0;
  else if ( clr_rcg_en )          rcg_en <= #TP 1'b0;

  rcg_end <= #TP rcg_en;
end

// ------------------------------------------------------------------------
//  pma_rx_ptr :: Packet Data Pointer
// ------------------------------------------------------------------------
always @ ( posedge pma_rx_clk1 or posedge pma_rx_clk0 or posedge reset )
begin
       if (  reset )               pma_rx_ptr <= #TP 0;
  else if ( ~rcg_en )             pma_rx_ptr <= #TP 0;
  else if (  ( en_even & ~miim )
          |  rcg_enable )         pma_rx_ptr <= #TP pma_rx_ptr + 1;
end

// ------------------------------------------------------------------------
//  build "states" to control rcg mux
// ------------------------------------------------------------------------
assign idle_even  = ~rcg_en &  even;
assign idle_odd   = ~rcg_en & ~even;
assign en_even    =  rcg_en &  even & ~rcg_end; // rising edge and even
assign en_odd     =  rcg_en & ~even & ~rcg_end; // rising edge and odd
assign rcg_enable =  rcg_en         &  rcg_end;

//  watch for end of packet marker to clear rds enable
assign clr_rcg_en =  rcg_enable & pma_rx_mem_data[10];

//  get contents of packet memory
assign pma_rx_mem_data = pma_rx_mem[pma_rx_ptr];

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
//  grcg[9:0] :: Receive Code Group
// ------------------------------------------------------------------------
assign grcg = { 10 { ~exlb & ~miim &  idle_even        } } & 10'h17c
            | { 10 { ~exlb & ~miim &  idle_odd &  drrd } } & 10'h2b6
            | { 10 { ~exlb & ~miim &  idle_odd & ~drrd } } & 10'h289
            | { 10 { ~exlb & ~miim &  en_even          } } & pma_rx_mem_data[9:0]
            | { 10 { ~exlb & ~miim &  en_odd   &  drrd } } & 10'h2b6
            | { 10 { ~exlb & ~miim &  en_odd   & ~drrd } } & 10'h289
            | { 10 { ~exlb & ~miim &  rcg_enable       } } & pma_rx_mem_data[9:0]

            | { 10 { ~exlb &  miim &  rcg_enable       } } & pma_rx_mem_data[9:0]
            | { 10 { ~exlb &  miim & ~rcg_enable       } } & 10'h000
            | { 10 {  exlb                             } } & tcg_dut[9:0];

// ------------------------------------------------------------------------
//  rcg[9:0] :: Receive Code Group
// ------------------------------------------------------------------------
always @ ( posedge pma_rx_clk1 or posedge pma_rx_clk0 )
begin
             if(test_auto_neg_en == 1) 
               rcg_dut[9:0] <= #TP grcg[9:0];
end    

// --------------------------------------------------------------------------
// -- Reset mac ahb
assign reset = ~hresetn;
task resetcore;
begin                                                             
   repeat(2)  @(posedge hclk );
   repeat(2)  @(posedge tx_clk );
   repeat(2)  @(posedge rx_clk ) #1;
   gl.dsplystat("Hard reseting mac ahb.");
   hresetn    = 1'b1;
   repeat(2)  @(posedge hclk );
   repeat(2)  @(posedge tx_clk );
   repeat(2)  @(posedge rx_clk ) #1;
   hresetn    = 1'b0;
   repeat(2)  @(posedge hclk );
   repeat(2)  @(posedge tx_clk );
   repeat(2)  @(posedge rx_clk ) #1;
   hresetn    = 1'b1;
   repeat(10) @(posedge tx_clk );
   repeat(10) @(posedge rx_clk );
   repeat(10) @(posedge hclk )  #1;
end                           
endtask
// ------------------------------------------------------------------------
// task: mgmt_wr
//
// performs a MII Mgmt Write Cycle
task mgmt_wr;
input [4:0]  phyadr, regadr;
input [15:0] control;
begin
 mstrwr( {8'h0A,2'h0}, {19'h0,phyid[4:0],3'b0,regadr} );
 mstrwr( {8'h0B,2'h0}, {16'h0,control} );
 repeat(100)  @ ( posedge mdc );

end
endtask

// ------------------------------------------------------------------------
// task: mgmt_rd
//
// performs a MII Mgmt Read Cycle
task mgmt_rd;
input [4:0]  phyadr, regadr;
output [15:0] status;
begin
 mstrwr( {8'h0A,2'h0}, {19'h0,phyid[4:0],3'b0,regadr} );
 mstrwr( {8'h09,2'h0}, {30'h0,1'b1} );
 repeat(100)  @ ( posedge mdc );
 mstrrd( 8'h0C,status);
end
endtask


// ------------------------------------------------------------------------
// task: pma_pkt_wr
//
// writes a location of the packet memory
task pma_pkt_wr;
input  [15:0] addr;
input  [10:0] value;
begin
  pma_rx_mem[addr] = value;
end
endtask


// task: pma_pkt_send
// sends packet contained in pma_rx_mem array
task pma_pkt_send;
begin
  @( pma_rx_clk0 ) #1;
  if ( rcg_en )
  begin
    $display( "%m ERROR: Rx packet already in progress." );
    $stop;
  end
  rcg_en = 1'b1;
  @( pma_rx_clk0 );
  @( negedge rcg_en ); // don't return from task until packet complete
end
endtask

// --------------------------------------------------------------------------
// -- AHB master write to M-AHBE                                            ///// AHB SLAVE na register AHB MASTER thi config karaviya 6e
task mstrwr;
   input [31:0] adx;             // Frame discriptor
   input [31:0] idat;            // Interface descriptor
begin
   while ( ~ahb_hreadyo ) @ ( posedge hclk | ahb_txhgrant | ahb_rxhgrant) #1;
   ahb_hsel   = 1'b1;
   ahb_htrans = 2'b10; // nonseq
   ahb_haddr  = adx[31:2];
   ahb_hwrite = 1'b1;
   @ ( posedge hclk ) #1;
   ahb_hsel   = 1'b0;
   ahb_haddr  = 30'h0000_0000;
   ahb_hwdata = idat;
   @ ( posedge hclk )
   while ( ~ahb_hreadyo ) @ ( posedge hclk );
   if ( ahb_hresp !== 2'b00 ) // not equal to okay
      gl.dsplycmperr( "ahb_hrespm", 2'b00, ahb_hresp ); 
end
endtask

// --------------------------------------------------------------------------
// -- AHB read from M-AHBE
task mstrrd;
   input [31:0] adx;             // Frame discriptor
   output [31:0] idat;            // Interface descriptor
begin
   while ( ~ahb_hreadyo ) @ ( posedge hclk | ahb_txhgrant | ahb_rxhgrant) #1;
   ahb_hsel   = 1'b1;
   ahb_htrans = 2'b10; // nonseq
   ahb_haddr  = adx[31:2];
   ahb_hwrite = 1'b0;
   @ ( posedge hclk ) #1;
   while ( ~ahb_hreadyo ) @ ( posedge hclk );
   #1;
   ahb_hsel   = 1'b0;
   ahb_haddr  = 30'h0000_0000;
   idat = ahb_hrdata;
end
endtask

// --------------------------------------------------------------------------
// -- Initialize fif registers to baseline
task initregs;
begin
   gl.dsplystat("mac ahb registers set to baseline functionality.");
   mstrwr( { 29'h0000_0000, 2'h0 }, 32'h0000_0005 ); // MAC1   
   mstrwr( { 29'h0000_0001, 2'h0 }, 32'h0000_7000 ); // MAC2   
   mstrwr( { 29'h0000_0002, 2'h0 }, 32'h4060_5060 ); // IPGT   
   mstrwr( { 29'h0000_0003, 2'h0 }, 32'h00a1_f037 ); // HFDP
   mstrwr( { 29'h0000_0004, 2'h0 }, 32'h0000_0600 ); // MAXF
   mstrwr( { 29'h0000_0010, 2'h0 }, 32'hA5A4_A3A2 ); // SA0
   mstrwr( { 29'h0000_0011, 2'h0 }, 32'hA1A0_0000 ); // SA1
   mstrwr( { 29'h0000_0012, 2'h0 }, { 16'h00, 8'hFF, 8'h0 } ); // AMCXFIF cfg 0
   mstrwr( { 29'h0000_0015, 2'h0 }, { 16'd1664, 16'hFFFF } );  // AMCXFIF cfg 3
end
endtask

// --------------------------------------------------------------------------
// -- M-AHBE reading descriptor from slave (RAM)          // ae task ae data ram ma data read kariyo
task slvrddesc;
   input   [31:0] descadx;           // Frame discriptor RAM address
   input   [95:0] descdat;           // RAM data
   integer        slvrddesc_prb;     // slvrddesc task probe
begin
   while ( ~ahb_txhbusreq )                             @ ( posedge hclk );
   while ( ~((ahb_txhtransm == 2'h2 ) & ~ahb_txhwritem) ) @ ( posedge hclk );
   #1;
   ahb_hrdatamint = descdat[95:64];
   @ ( posedge hclk );
   #1;
   ahb_hrdatamint = descdat[63:32];
   @ ( posedge hclk );
   #1;
   ahb_hrdatamint = descdat[31:0];
end
endtask


// --------------------------------------------------------------------------
// -- M-AHBE reading descriptor from slave (RAM)          // ae task ae data ram ma data read kariyo
task rxslvrddesc;
   input   [31:0] descadx;           // Frame discriptor RAM address
   input   [95:0] descdat;           // RAM data
   integer        slvrddesc_prb;     // slvrddesc task probe
begin
   while ( ~ahb_rxhbusreq )                             @ ( posedge hclk );
   while ( ~((ahb_rxhtransm == 2'h2 ) & ~ahb_rxhwritem) ) @ ( posedge hclk );
   #1;
   rx_ahb_hrdatamint = descdat[95:64];
   @ ( posedge hclk );
   #1;
   rx_ahb_hrdatamint = descdat[63:32];
   @ ( posedge hclk );
   #1;
   rx_ahb_hrdatamint = descdat[31:0];
end
endtask


// --------------------------------------------------------------------------
// -- M-AHBE reading frame from slave (RAM)             ///  ae task ae data ne ram mathi read karsh
task slvrdfrm;
   input   [31:0] frmadx;            // Frame data RAM address
   input   [31:0] dscadx;            // Frame descriptor RAM address
   input  [255:0] bldfrmdesc;        // build frame descriptor
   integer        curbc;             // Current byte count transmitted
   integer        trmbc;             // Terminal byte count transmitted
   integer        slvrdfrm_prb;      // slvrdfrm task probe
begin
   trmbc = mlat.bld_frm(bldfrmdesc);
   @ ( posedge hclk );
   while ( ~ahb_txhbusreq )                             @ ( posedge hclk );
   while ( ~(( ahb_txhtransm == 2'h2 ) & ~ahb_txhwritem & ( frmadx[31:2] == ahb_txhaddrm )) )
      @ ( posedge hclk );
   curbc = 0;
   while ( curbc < trmbc )
   begin
      # 1;                                            
      ahb_hrdatamint <= { mlat.bld_frm_mem[curbc+3], 
                          mlat.bld_frm_mem[curbc+2], 
                          mlat.bld_frm_mem[curbc+1], 
                          mlat.bld_frm_mem[curbc]    };
      curbc    = curbc + 4;
      @ ( posedge hclk );
   end
   if ( ~ahb_txhwritem ) 
      gl.dsplycmperr( "ahb_hwritem", 1'b1, ahb_txhwritem ); 
   if ( ahb_txhaddrm  !== ( dscadx[31:2] + 1'b1 )) 
      gl.dsplycmperr( "ahb_haddrm", ( dscadx[31:2] + 1'b1 ), ahb_txhaddrm ); 
end
endtask

// --------------------------------------------------------------------------
// -- M-AHBE write frame to slave (RAM)
task slvwrfrm;
   input   [31:0] frmadx;            // Frame data RAM address
   input   [31:0] dscadx;            // Frame descriptor RAM address
   input  [255:0] bldfrmdesc;        // build frame descriptor
   integer        curbc;             // Current byte count transmitted
   integer        trmbc;             // Terminal byte count transmitted
   reg     [31:0] hwdata_exp;
   integer        slvwrfrm_prb;      // slvwrfrm task probe
begin
   trmbc = mlar.bld_frm(bldfrmdesc);
   @ ( posedge hclk );
   while ( ~ahb_rxhbusreq ) @ ( posedge hclk );
   while ( ~((ahb_rxhtransm == 2'h2 ) & ahb_rxhwritem & ( frmadx[31:2]     == ahb_rxhaddrm ) ) ) 
      @ ( posedge hclk );
   @ ( posedge hclk );
   while ( ~((ahb_rxhtransm == 2'h3 ) & ahb_rxhwritem & ( (frmadx[31:2]+1) == ahb_rxhaddrm ) ) ) 
      @ ( posedge hclk );
   curbc = 0;
   while ( curbc < trmbc )
   begin
      hwdata_exp = { mlar.bld_frm_mem[curbc+3], 
                     mlar.bld_frm_mem[curbc+2], 
                     mlar.bld_frm_mem[curbc+1], 
                     mlar.bld_frm_mem[curbc]    };
      if ( ((curbc + 4 ) > trmbc ) & (( trmbc % 4 ) == 1 ) )
      begin
         if ( ahb_rxhwdatam[ 7:0] !== hwdata_exp[ 7:0] )
            gl.dsplycmperr( "ahb_hwdatam", { 24'hXXXXXX, hwdata_exp[7:0]  }, ahb_rxhwdatam );
      end
      else if ( (( curbc + 4 ) > trmbc )  & (( trmbc % 4 ) == 2 ) )
      begin
         if ( ahb_rxhwdatam[15:0] !== hwdata_exp[15:0] )
            gl.dsplycmperr( "ahb_hwdatam", { 16'hXXXX,   hwdata_exp[15:0] }, ahb_rxhwdatam );
      end
      else if ( (( curbc + 4 ) > trmbc )  & (( trmbc % 4 ) == 3 ) )
      begin
         if ( ahb_rxhwdatam[23:0] !== hwdata_exp[23:0] )
            gl.dsplycmperr( "ahb_hwdatam", { 8'hXX,      hwdata_exp[23:0] }, ahb_rxhwdatam );
      end
      else if ( ahb_rxhwdatam[31:0] !== hwdata_exp[31:0] )begin
         gl.dsplycmperr( "ahb_hwdatam",               hwdata_exp[31:0]  , ahb_rxhwdatam );
       end
      curbc = curbc + 14'h0004;
      @ ( posedge hclk );
      if ( (curbc > trmbc ) & ( ahb_rxhwdatam[31:0] !== trmbc ) )     
         gl.dsplycmperr( "RX descriptor byte cont", trmbc, ahb_rxhwdatam );
   end
end
endtask

// ------------------------------------------------------------------------
/////// -- Link receive frame from MAC and compare using input discriptor
task lrfrm_sgmii;
   input  [255:0] dsc;               // Frame discriptor
   input   [23:0] ifdsc;             // Interface descriptor
   integer        curbc;             // Current byte count transmitted
   integer        trmbc;             // Terminal byte count transmitted
   integer        ram_value ;        // LOcal variable for a comparision
   integer        speed;             // 2=GMII, 1=MII, 0=MII
   integer        rptcnt;            // data repeat count
   integer        i;                 
   reg            txerr;             // Transmit error
   reg            rdsp;     
   reg    [31:0]  tmpvar;            
   reg     [9:0]  tcg;            
begin
   // ifdsc format / signal assignment 
   speed = ifdsc[3:0];
   rptcnt = 1;
   if ( speed == 1 ) rptcnt = 10;     
   if ( speed == 0 ) rptcnt = 100;     
   // Was frame truncated
   txerr = ( dsc[191:176] > dsc[231:216] );
   // load mlst.bld_frm_mem array, and add preamble to total byte count
   trmbc = mllr.bld_frm(dsc);

   // wait for start of packet
   desertx( tcg ); 
   while ( tcg !== 10'h05b ) desertx( tcg );

   // Check preamble
   tmpvar[8] = 0;
   for ( i=0; (tmpvar[7:0] !== 8'hd5); i=i+1 )
   begin
      desertx( tcg );
      tmpvar = mllr.dcd10bto8b( tmpvar[8], tcg );

         if (( tmpvar[7:0] !== 8'h55 ) & ( tmpvar[7:0] !== 8'hD5 ))begin
         gl.dsplycmperr( "tcg", 8'h55, tmpvar[7:0] ); end
   end
   if (( i != (7*rptcnt)-1 ) & ( i != (7*rptcnt) ))
       gl.dsplyerr("IPG incorrect number of bytes");

   // Check SFD
   repeat( rptcnt-1 )
   begin
      desertx( tcg );
      tmpvar = mllr.dcd10bto8b( tmpvar[8], tcg );
      if ( tmpvar[7:0] !== 8'hD5 ) 
         gl.dsplycmperr( "tcg", 8'hD5, tmpvar[7:0] );
   end
   // Check frame data
   for ( curbc=0; curbc<trmbc; curbc=curbc+1 )
   begin
      repeat( rptcnt )
      begin 
         desertx( tcg );
         tmpvar = mllr.dcd10bto8b( tmpvar[8], tcg );
         if ( tmpvar[7:0] !== mllr.bld_frm_mem[curbc] ) begin 
             gl.dsplycmperr( "tcg",  tmpvar[7:0], mllr.bld_frm_mem[curbc] );
          end   
       end
   end
   // Check /T/ /R/
   if ( tmpvar[8] == 1 )
   begin
      desertx( tcg );
      if ( tcg !== 10'h3a2 ) gl.dsplycmperr( "tcg",  10'h3a2, tcg );
      desertx( tcg );
      if ( tcg !== 10'h3a8 ) gl.dsplycmperr( "tcg",  10'h3a8, tcg );
   end
   else // if ( tmpvar[8] == 1 )
   begin
      desertx( tcg );
      if ( tcg !== 10'h05d ) gl.dsplycmperr( "tcg",  10'h05d, tcg );
      desertx( tcg );
      if ( tcg !== 10'h057 ) gl.dsplycmperr( "tcg",  10'h057, tcg );
   end
end
endtask
/////
/////// --------------------------------------------------------------------------
/////// -- Link transmit frame to MSGMII using input discriptor
task ltfrm_sgmii;
   input  [255:0] dsc;      // Frame descriptor
   input   [23:0] ifdsc;    // Interface descriptor
   output         rdsp;     // running disparity
   reg      [9:0] rcg;      // receive code group internal variable
   reg            rdsp;     // Running disparity internal variable
   reg            rdsp_tmp; // Running disparity internal temp variable    
   integer        speed;    // 2=GMIIpackets, 1=MII100packets, 0=MII10packets
   integer        prelen;   // preamble length byte offset
   integer        sopdly;   // Start of preamble byte delay
   integer        curbc;    // Current byte count transmitted
   integer        trmbc;    // Terminal byte count transmitted
   integer        rptcnt;   // data repeat count
   reg    [31:0]  tmpvar;            
begin
   // ifdsc format / signal assignment 
   rdsp      = ifdsc[20];
   speed     = ifdsc[19:16]; // always TBI
   prelen    = ifdsc[15:8]; 
   sopdly    = ifdsc[7:0];
   rptcnt    = 1;
   if ( speed == 1 ) rptcnt = 10;     
   if ( speed == 0 ) rptcnt = 100;     
   // create packet and assign terminal byte count
   trmbc     = mllt.bld_frm(dsc);
   #(rxclkprd/8);
   begin 
      repeat( ((sopdly[7:0]*rptcnt)-2)/2 ) // minus /t/ & /r/ & div 2 for idle pairs
      begin
         if ( rdsp == 1 )
         begin
            { rdsp, rcg } = { ~rdsp, 10'h283 };
            serrcg( rcg );
            { rdsp, rcg } = {  rdsp, 10'h1a5 };
            serrcg( rcg );
         end                             
         else
         begin                            
            { rdsp, rcg } = { ~rdsp, 10'h17c };
            serrcg( rcg );
            { rdsp, rcg } = { ~rdsp, 10'h289 };
            serrcg( rcg );
         end
      end
      if ( rdsp )
      begin
         { rdsp, rcg } = {  rdsp, 10'h3a4 }; // /S/
         serrcg( rcg );
      end
      else
      begin
         { rdsp, rcg } = {  rdsp, 10'h05b }; // /S/
         serrcg( rcg );
         repeat (rptcnt-1)
         begin
            { rdsp, rcg } = mllt.enc8bto10b( rdsp, 8'h55 );
            serrcg( rcg );
         end
      end
      repeat( prelen - 1 )  // minus /S/
      begin 
         repeat (rptcnt)
         begin
            { rdsp, rcg } = mllt.enc8bto10b( rdsp, 8'h55 );
            serrcg( rcg );
         end
      end
      repeat (rptcnt)
      begin
         { rdsp, rcg } = mllt.enc8bto10b( rdsp, 8'hd5 );
         serrcg( rcg );
      end
      for ( curbc=0; curbc<trmbc; curbc=curbc+1 )
      begin
         repeat (rptcnt)
         begin
            tmpvar   = mllt.bld_frm_mem[curbc];
            rdsp_tmp = rdsp;
            { rdsp, rcg } =  mllt.enc8bto10b( rdsp, mllt.bld_frm_mem[curbc] );
            serrcg( rcg );
         end
      end
      if ( rdsp == 1 )
      begin
         { rdsp, rcg } = { rdsp, 10'h3a2 }; // /T/
         serrcg( rcg );
         { rdsp, rcg } = { rdsp, 10'h3a8 }; // /R/
         serrcg( rcg );
         tmpvar = trmbc + prelen + 1;
         if (( tmpvar[0] ) & ( rptcnt == 1 ))
         begin
            #(rxclkprd/8);
            { rdsp, rcg } = { rdsp, 10'h3a8 }; // /R/
            serrcg( rcg );
         end
      end
      else
      begin
         { rdsp, rcg } = { rdsp, 10'h05d }; // /T/
         serrcg( rcg );
         { rdsp, rcg } = { rdsp, 10'h057 }; // /R/
         serrcg( rcg );
         tmpvar = trmbc + prelen + 1;
         if (( tmpvar[0] ) & ( rptcnt == 1 ))
         begin
            #(rxclkprd/8);
            { rdsp, rcg } = { rdsp, 10'h057 }; // /R/
            serrcg( rcg );
         end
      end
   end //if ( link_mode == 2 ) TBI Mode
end
endtask
/////
/////// --------------------------------------------------------------------------
/////// -- Serialize rcg
task serrcg;
   input  [9:0] rcg;
   integer      i;
begin
     @(posedge gtx_clki );
     rcg_dut = rcg;
end
endtask
/////// -- Clear all active flags
task clractv;
begin
   stactv       = 1'b0;  // System  transmit  process active flag
   lractv       = 1'b0;  // Link recieve   process active flag
   ltactv       = 1'b0;  // Link transmit  process active flag
   sractv       = 1'b0;  // System  recieve   process active flag
   mmactv       = 1'b0;  // MII Management process active flag
end
endtask
/////// --------------------------------------------------------------------------
/////// -- Desserialize tx
task desertx;
   output  [9:0] tcg;
   integer       i;
begin            
   @(posedge gtx_clki );// tcg[i] = tx;
   tcg = tcg_dut ;
end
endtask
///// 
/////// --------------------------------------------------------------------------
/////// -- Synchronize to comma on tx
task synctx;
   output  [9:0] tcg;
   integer       i;
begin
   tcg = 10'bXXXXXXXXXX;
   while ( (tcg[6:0] !== 7'h03) & (tcg[6:0] !== 7'h7C))
   begin
      @( tx_clk );// tcg[9:0] = { tx, tcg[9:1] };
     tcg = tcg_dut ;
    end
end
endtask
/////// --------------------------------------------------------------------------
/////// -- Link transmit idles
task ltidl;
   input          rdspi;     // Running disparity  input
   output         rdspo;     // Running disparity  ouput
   reg            rdsp;      // Running disparity  internal variable
   reg      [9:0] rcg;       // receive code group internal variable
begin
   rdsp = rdspi;
   begin                                                           
      { rdsp, rcg } = { ~rdsp, 10'h17c };
      serrcg( rcg);
      { rdsp, rcg } = { ~rdsp, 10'h289 };
      serrcg( rcg);
   end
   rdspo = rdsp;
end
endtask

///// 
// --------------------------------------------------------------------------
// -- Reset and hold clocks
task resetnholdclks;
begin                                                             
   hclkrst          = 1'b1;
   tx_clkrst        = 1'b1;
   gtx_clkirst      = 1'b1;
   txclkx2rst       = 1'b1;
   rxclkrst         = 1'b1;
   fork
      #hclkprd;          
      #tx_clkprd;        
      #gtx_clkiprd;      
      #txclkx2prd;         
      #rxclkprd;         
   join
end
endtask
/////
// --------------------------------------------------------------------------
// -- Enable clocks
task enableclks;
begin                                                             
   hclkrst          = 1'b0;
   tx_clkrst        = 1'b0;
   gtx_clkirst      = 1'b0;
   txclkx2rst       = 1'b0;
   rxclkrst         = 1'b0;
end
endtask


endmodule
