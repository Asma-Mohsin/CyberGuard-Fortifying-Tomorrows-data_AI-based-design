module user_project_wrapper (user_clock2,
    vccd1,
    vccd2,
    vdda1,
    vdda2,
    vssa1,
    vssa2,
    vssd1,
    vssd2,
    wb_clk_i,
    wb_rst_i,
    wbs_ack_o,
    wbs_cyc_i,
    wbs_stb_i,
    wbs_we_i,
    analog_io,
    io_in,
    io_oeb,
    io_out,
    la_data_in,
    la_data_out,
    la_oenb,
    user_irq,
    wbs_adr_i,
    wbs_dat_i,
    wbs_dat_o,
    wbs_sel_i);
 input user_clock2;
 input vccd1;
 input vccd2;
 input vdda1;
 input vdda2;
 input vssa1;
 input vssa2;
 input vssd1;
 input vssd2;
 input wb_clk_i;
 input wb_rst_i;
 output wbs_ack_o;
 input wbs_cyc_i;
 input wbs_stb_i;
 input wbs_we_i;
 inout [28:0] analog_io;
 input [37:0] io_in;
 output [37:0] io_oeb;
 output [37:0] io_out;
 input [127:0] la_data_in;
 output [127:0] la_data_out;
 input [127:0] la_oenb;
 output [2:0] user_irq;
 input [31:0] wbs_adr_i;
 input [31:0] wbs_dat_i;
 output [31:0] wbs_dat_o;
 input [3:0] wbs_sel_i;


 MemoryWriteMonitor cyber (.alertValid(io_out[19]),
    .blockData(io_out[20]),
    .clk(wb_clk_i),
    .rst(wb_rst_i),
    .unauthorizedWriteAlert(io_out[8]),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .io_ieb({io_oeb[30],
    io_oeb[29],
    io_oeb[28],
    io_oeb[27],
    io_oeb[26],
    io_oeb[25],
    io_oeb[24],
    io_oeb[23],
    io_oeb[22],
    io_oeb[21]}),
    .io_oeb({io_oeb[20],
    io_oeb[19],
    io_oeb[18],
    io_oeb[17],
    io_oeb[16],
    io_oeb[15],
    io_oeb[14],
    io_oeb[13],
    io_oeb[12],
    io_oeb[11],
    io_oeb[10],
    io_oeb[9],
    io_oeb[8]}),
    .unauthorizedModuleID({io_out[10],
    io_out[9]}),
    .unauthorizedWriteAddress({io_out[14],
    io_out[13],
    io_out[12],
    io_out[11]}),
    .unauthorizedWriteData({io_out[18],
    io_out[17],
    io_out[16],
    io_out[15]}),
    .writeAddress({io_in[24],
    io_in[23],
    io_in[22],
    io_in[21]}),
    .writeData({io_in[28],
    io_in[27],
    io_in[26],
    io_in[25]}),
    .writeModuleID({io_in[30],
    io_in[29]}));
endmodule
