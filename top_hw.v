
// top.v


`timescale 1 ps / 1 ps
module top_hw ( 
                input  wire         refclk_clk,                //     refclk.clk
                output wire         hip_serial_tx_out0,        //           .tx_out0
                output wire         hip_serial_tx_out1,        //           .tx_out1
                output wire         hip_serial_tx_out2,        // hip_serial.tx_out2
                output wire         hip_serial_tx_out3,        //           .tx_out3
                output wire         hip_serial_tx_out4,        //           .tx_out4
                output wire         hip_serial_tx_out5,        //           .tx_out5
                output wire         hip_serial_tx_out6,        // hip_serial.tx_out6
                output wire         hip_serial_tx_out7,        //           .tx_out7
                input  wire         hip_serial_rx_in0,         //           .rx_in0
                input  wire         hip_serial_rx_in1,         //           .rx_in1
                input  wire         hip_serial_rx_in2,         //           .rx_in2
                input  wire         hip_serial_rx_in3,         //           .rx_in3
                input  wire         hip_serial_rx_in4,         //           .rx_in4
                input  wire         hip_serial_rx_in5,         //           .rx_in5
                input  wire         hip_serial_rx_in6,         //           .rx_in6
                input  wire         hip_serial_rx_in7,         //           .rx_in7
                input  wire         perstn           ,
					 output wire         led_o            ,
					 output wire			dk_alive_led     
					 
					 	 
        );

parameter D = 2;
//======================================================================================

wire    clk_125m;
wire    clk_200m;
wire    clk_250m;
wire    clk_333m;
wire    clk_500m;
wire    pll_locked;

wire    sys_clk;
wire    sys_rst_n;


		  
pll_125m   u_pll_125m (
	
	.refclk    (core_clkout  ),		  
	.rst       (~perstn      ),
	.locked    (pll_locked   ),
	.outclk_0  (clk_125m     ),
	.outclk_1  (clk_200m     ),
	.outclk_2  (clk_250m     ),
	.outclk_3  (clk_333m     ),
	.outclk_4  (clk_500m     )
	
);			  
		  
assign   sys_clk    =   clk_200m;

assign   sys_rst_n  =   pll_locked;


//=======================================================================================

wire [31:0]  hip_ctrl_test_in;          
assign hip_ctrl_test_in[31:0]  =  32'h188;

	wire core_clkout;
	reg [23:0] cnt;
	
	always @(posedge sys_clk or negedge perstn) begin
		if(perstn == 0) begin
			cnt <= 24'h0;
		end
		else begin
			cnt <= cnt + 1;
		end
	end
	
assign dk_alive_led = cnt[23];

//====================================================================
 
	 
wire    [15:0]     s1_0_ram_raddr;
wire               s1_0_ram_rden;
wire    [31:0]     s1_0_ram_rdat;


wire    [15:0]     s1_1_ram_raddr;
wire               s1_1_ram_rden;
wire    [31:0]     s1_1_ram_rdat;

wire    [15:0]     s1_2_ram_raddr;
wire               s1_2_ram_rden;
wire    [31:0]     s1_2_ram_rdat;


wire    [15:0]     s1_3_ram_raddr;
wire               s1_3_ram_rden;
wire    [31:0]     s1_3_ram_rdat;
//--------------------------------------

wire    [14:0]     s2_ram_waddr;
wire               s2_ram_wen;
wire    [127:0]    s2_ram_wdat;


wire    [14:0]     s3_ram_waddr;
wire               s3_ram_wen;
wire    [127:0]    s3_ram_wdat;

//--------------------------------------

wire               rd_master_write;
wire    [13:0]     rd_master_address;    	


wire               rd_master_write_1;
wire    [13:0]     rd_master_address_1; 

wire               rd_master_write_2;
wire    [13:0]     rd_master_address_2;    	


wire               rd_master_write_3;
wire    [13:0]     rd_master_address_3; 

//--------------------------------------

wire               wr_master_read;
wire    [14:0]     wr_master_address;   

wire               wr_master_read_1;
wire    [14:0]     wr_master_address_1; 

//--------------------------------------

wire	             start_read_en_0;        //core_clk
wire	             a_start_read_en_0;      //sys_clk

wire	             start_read_en_1;        //core_clk
wire	             a_start_read_en_1;      //sys_clk

wire	             start_read_en_2;        //core_clk
wire	             a_start_read_en_2;      //sys_clk

wire	             start_read_en_3;        //core_clk
wire	             a_start_read_en_3;      //sys_clk

//--------------------------------------

wire               get_data_done_0;        //sys_clk
wire               a_get_data_done_0;      //core_clk     

wire               get_data_done_1;        //sys_clk
wire               a_get_data_done_1;      //core_clk   

wire               get_data_done_2;        //sys_clk
wire               a_get_data_done_2;      //core_clk     

wire               get_data_done_3;        //sys_clk
wire               a_get_data_done_3;      //core_clk 

//--------------------------------------

wire               send_data_done;       //sys_clk
wire               a_send_data_done;     //core_clk


wire               send_data_done_1;       //sys_clk
wire               a_send_data_done_1;     //core_clk

//--------------------------------------

wire               send_data_mem_free;   //core_clk
wire               a_send_data_mem_free; //sys_clk

wire               send_data_mem_free_1;   //core_clk
wire               a_send_data_mem_free_1; //sys_clk

//--------------------------------------

wire               matrix_enable_0;

wire               matrix_enable_1;

wire               matrix_enable_2;

wire               matrix_enable_3;
//--------------------------------------	 	

wire               pkt_sop0;
wire               pkt_eop0;
wire               pkt_vld0;
wire    [31:0]     pkt_dat0;

wire               pkt_sop1;
wire               pkt_eop1;
wire               pkt_vld1;
wire    [31:0]     pkt_dat1;			

wire               pkt_sop2;
wire               pkt_eop2;
wire               pkt_vld2;
wire    [31:0]     pkt_dat2;

wire               pkt_sop3;
wire               pkt_eop3;
wire               pkt_vld3;
wire    [31:0]     pkt_dat3;	

//--------------------------------------	






wire	    ddr_success;
wire		ddr_fail;
wire    	ddr_ready;



	input		amm_read_0;


	input		amm_write_0;
	input	[24:0]	amm_address_0;

	input	[575:0]	amm_writedata_0;




wire		    ddr_read_vld;
wire	[575:0]	ddr_rdat;



			 
//===================================================================

	
top top (
             .refclk_clk                                          (refclk_clk                     ),
				 .core_clk_out_clk			                           (core_clkout                    ),
             .hip_ctrl_test_in                                    (hip_ctrl_test_in               ),
             .hip_serial_tx_out0                                  (hip_serial_tx_out0             ),
             .hip_serial_tx_out1                                  (hip_serial_tx_out1             ),
             .hip_serial_tx_out2                                  (hip_serial_tx_out2             ),
             .hip_serial_tx_out3                                  (hip_serial_tx_out3             ),
             .hip_serial_tx_out4                                  (hip_serial_tx_out4             ),
             .hip_serial_tx_out5                                  (hip_serial_tx_out5             ),
             .hip_serial_tx_out6                                  (hip_serial_tx_out6             ),
             .hip_serial_tx_out7                                  (hip_serial_tx_out7             ),
             .hip_serial_rx_in0                                   (hip_serial_rx_in0              ),
             .hip_serial_rx_in1                                   (hip_serial_rx_in1              ),
             .hip_serial_rx_in2                                   (hip_serial_rx_in2              ),
             .hip_serial_rx_in3                                   (hip_serial_rx_in3              ),
             .hip_serial_rx_in4                                   (hip_serial_rx_in4              ),
             .hip_serial_rx_in5                                   (hip_serial_rx_in5              ),
             .hip_serial_rx_in6                                   (hip_serial_rx_in6              ),
             .hip_serial_rx_in7                                   (hip_serial_rx_in7              ),
             .pcie_rstn_npor                                      (perstn                         ), 
             .pcie_rstn_pin_perst                                 (perstn                         ),
	          .hip_ctrl_simu_mode_pipe                             (                               ),				 
	          //
	          .get_cpu_operation_0_conduit_end_start_read_en       (start_read_en                  ),
				 .get_cpu_operation_0_conduit_end_start_read_en_1     (start_read_en_1                ),
//	          .get_cpu_operation_0_conduit_end_start_read_en_2     (start_read_en_2                ),
//				 .get_cpu_operation_0_conduit_end_start_read_en_3     (start_read_en_3                ),


			    // 
				 .get_cpu_operation_0_conduit_end_get_data_done       (a_get_data_done                ),
		       .get_cpu_operation_0_conduit_end_get_data_done_1     (a_get_data_done_1              ),				 
				 .get_cpu_operation_0_conduit_end_get_data_done_2       (a_get_data_done_2              ),
		       .get_cpu_operation_0_conduit_end_get_data_done_3     (a_get_data_done_3              ),	



	//
				 .get_cpu_operation_0_conduit_end_send_data_done      (a_send_data_done               ),
             .get_cpu_operation_0_conduit_end_send_data_done_1    (a_send_data_done_1                             ), 			 

				 .get_cpu_operation_0_conduit_end_send_data_mem_free  (send_data_mem_free             ),   
		       .get_cpu_operation_0_conduit_end_send_data_mem_free_1(send_data_mem_free_1                               ), 
             //                   
		       .get_cpu_operation_0_dma_rd_master_sig_address       (rd_master_address              ),  
		       .get_cpu_operation_0_dma_rd_master_sig_write         (rd_master_write                ),
				 //
				 .get_cpu_operation_0_dma_rd_master_sig_1_address     (rd_master_address_1            ),
		       .get_cpu_operation_0_dma_rd_master_sig_1_write       (rd_master_write_1              ), 
			 //
				 .get_cpu_operation_0_dma_rd_master_sig_2_address     (rd_master_address_2            ),
		       .get_cpu_operation_0_dma_rd_master_sig_2_write       (rd_master_write_2              ),				
			 //
				 .get_cpu_operation_0_dma_rd_master_sig_3_address     (rd_master_address_3            ),
		       .get_cpu_operation_0_dma_rd_master_sig_3_write       (rd_master_write_3              ),			
		
	



	//
		       .get_cpu_operation_0_dma_wr_master_sig_read          (wr_master_read                 ),
		       .get_cpu_operation_0_dma_wr_master_sig_address       (wr_master_address              ),
		       //
		       .get_cpu_operation_0_dma_wr_master_sig_1_read        (wr_master_read_1                              ),
		       .get_cpu_operation_0_dma_wr_master_sig_1_address     (wr_master_address_1                              ),                                    			 
				 //






             .pcie_a10_hip_0_dma_rd_master_write_test             (rd_master_write                ),
	          .pcie_a10_hip_0_dma_rd_master_address_test           (rd_master_address              ),  	
             //
             .pcie_a10_hip_0_dma_rd_master_write_test_1           (rd_master_write_1              ),
	          .pcie_a10_hip_0_dma_rd_master_address_test_1  		   (rd_master_address_1            ),			 
				 //
             .pcie_a10_hip_0_dma_rd_master_write_test_2           (rd_master_write_2              ),
	          .pcie_a10_hip_0_dma_rd_master_address_test_2         (rd_master_address_2            ),  	
             //
             .pcie_a10_hip_0_dma_rd_master_write_test_3           (rd_master_write_3              ),
	          .pcie_a10_hip_0_dma_rd_master_address_test_3  		   (rd_master_address_3            ),	         
			
		
	
             .pcie_a10_hip_0_dma_wr_master_address_test           (wr_master_address              ),  
	          .pcie_a10_hip_0_dma_wr_master_read_test	            (wr_master_read                 ),


             .pcie_a10_hip_0_dma_wr_master_address_test_1           (wr_master_address_1            ),  
	          .pcie_a10_hip_0_dma_wr_master_read_test_1	            (wr_master_read_1                 ),	
				 
		       //		 	
		       .ram_s_1_0_read_port_rdclock                         (sys_clk                        ), 						
			    .ram_s_1_0_read_port_rden                            (s1_0_ram_rden                  ),                               
		       .ram_s_1_0_read_port_q                               (s1_0_ram_rdat                  ),                  
		       .ram_s_1_0_read_port_rdaddress                       (s1_0_ram_raddr                 ),
		       //
             .ram_s_1_1_read_port_rdclock                         (sys_clk                        ),
				 .ram_s_1_1_read_port_rden                            (s1_1_ram_rden                  ),                                                                   
		       .ram_s_1_1_read_port_q                               (s1_1_ram_rdat                  ),                                      
		       .ram_s_1_1_read_port_rdaddress  				         (s1_1_ram_raddr                 ), 
				 //
		       .ram_s_1_2_read_port_rdclock                         (sys_clk                        ), 						
			    .ram_s_1_2_read_port_rden                            (s1_2_ram_rden                  ),                               
		       .ram_s_1_2_read_port_q                               (s1_2_ram_rdat                  ),                  
		       .ram_s_1_2_read_port_rdaddress                       (s1_2_ram_raddr                 ),
		       //
             .ram_s_1_3_read_port_rdclock                         (sys_clk                        ),
				 .ram_s_1_3_read_port_rden                            (s1_3_ram_rden                  ),                                                                   
		       .ram_s_1_3_read_port_q                               (s1_3_ram_rdat                  ),                                      
		       .ram_s_1_3_read_port_rdaddress  				         (s1_3_ram_raddr                 ), 				 
				 
				 //
		       .onchip_memory2_2_clk2_clk                           (sys_clk                        ),                         
		       .onchip_memory2_2_reset2_reset                       (~sys_rst_n                     ),               
		       .onchip_memory2_2_s2_address                         (s2_ram_waddr                   ),                        
		       .onchip_memory2_2_s2_chipselect                      (s2_ram_wen                     ),                   
		       .onchip_memory2_2_s2_clken                           (1'b1                           ),                          
		       .onchip_memory2_2_s2_write                           (s2_ram_wen                     ),                
		       .onchip_memory2_2_s2_readdata                        (                               ),                      
		       .onchip_memory2_2_s2_writedata                       (s2_ram_wdat                    ),                      
		       .onchip_memory2_2_s2_byteenable                      (16'hffff                       ),  

		       .onchip_memory2_3_clk2_clk                           (sys_clk                        ),                         
		       .onchip_memory2_3_reset2_reset                       (~sys_rst_n                     ),               
		       .onchip_memory2_3_s2_address                         (s3_ram_waddr                   ),                        
		       .onchip_memory2_3_s2_chipselect                      (s3_ram_wen                     ),                   
		       .onchip_memory2_3_s2_clken                           (1'b1                           ),                          
		       .onchip_memory2_3_s2_write                           (s3_ram_wen                     ),                
		       .onchip_memory2_3_s2_readdata                        (                               ),                      
		       .onchip_memory2_3_s2_writedata                       (s3_ram_wdat                    ),                      
		       .onchip_memory2_3_s2_byteenable                      (16'hffff                       ) 				 
				 
				 
	   );

//============================================================================




syn_ddrclk_2_coreclk u0 (
    .ddr4_clk              (ddr4_clk            ),
    .ddr4_rst_n            (ddr4_rst_n          ),
    //
    .sys_clk               (sys_clk             ),
    .sys_rst_n             (sys_rst_n           ),
    //                     
    .signal_a_in           (get_data_done_0     ),
    .signal_a_out          (a_get_data_done_0   ),
    //                     
    .signal_b_in           (get_data_done_1     ),
    .signal_b_out          (a_get_data_done_1   ),
    //                     
    .signal_c_in           (                    ),
    .signal_c_out          (                    ),
    //                     
    .signal_d_in           (                    ),
    .signal_d_out          (                    )
);



syn_coreclk_2_ddrclk u1 (
    .ddr4_clk              (ddr4_clk            ),
    .ddr4_rst_n            (ddr4_rst_n          ),
    //
    .sys_clk               (sys_clk             ),
    .sys_rst_n             (sys_rst_n           ),
    //                     
    .signal_a_in           (start_read_en_0     ),
    .signal_a_out          (a_start_read_en_0   ),
    //                     
    .signal_b_in           (start_read_en_1     ),
    .signal_b_out          (a_start_read_en_1   ),
    //                     
    .signal_c_in           (                    ),
    .signal_c_out          (                    ),
    //                     
    .signal_d_in           (                    ),
    .signal_d_out          (                    )
);



//=======================================================================================

ddr4_core  u_ddr4_core (



	.emif_usr_reset_n     (ddr4_rst_n),
	.emif_usr_clk         (ddr4_clk),
	//
	.global_reset_n       (sys_rst_n),
	.pll_ref_clk          (sys_clk),
    //	
	input		    oct_rzqin;
	output	[0:0]	mem_ck;
	output	[0:0]	mem_ck_n;
	output	[16:0]	mem_a;
	output	[0:0]	mem_act_n;
	output	[1:0]	mem_ba;
	output	[0:0]	mem_bg;
	output	[0:0]	mem_cke;
	output	[0:0]	mem_cs_n;
	output	[0:0]	mem_odt;
	output	[0:0]	mem_reset_n;
	output	[0:0]	mem_par;
	input	[0:0]	mem_alert_n;
	inout	[8:0]	mem_dqs;
	inout	[8:0]	mem_dqs_n;
	inout	[71:0]	mem_dq;
	inout	[8:0]	mem_dbi_n;
	//
	.local_cal_success    (ddr_success),
	.local_cal_fail       (ddr_fail),
    //
	.amm_burstcount_0     (7'd1),
	.amm_byteenable_0     (72'hffffffffffffffffff),
    //

	.amm_ready_0          (ddr_ready),

	input		amm_read_0;
	input		amm_write_0;
	input	[24:0]	amm_address_0;
	input	[575:0]	amm_writedata_0;
	
	.amm_readdatavalid_0      (ddr_read_vld),
	.amm_readdata_0           (ddr_rdat)
);



ddr4_ctl u_ddr4_ctl(

    .sys_clk                  (sys_clk               ),
    .sys_rst_n                (sys_rst_n             ),

    .ddr4_clk                 (ddr4_clk              ),
    .ddr4_rst_n               (ddr4_rst_n            ),

    .start_read_pcie_data_0   (a_start_read_en_0     ),
    .start_read_pcie_data_1   (a_start_read_en_1     ),

    .get_data_done_0          (get_data_done_0       ),
    .get_data_done_1          (get_data_done_1       ),

output              pcie_ram_ren_0;
output    [13:0]    pcie_ram_raddr_0;
input     [127:0]   pcie_ram_rdat_0;

output              pcie_ram_ren_1;
output    [13:0]    pcie_ram_raddr_1;
input     [127:0]   pcie_ram_rdat_1;

input               ddr4_ready;
output              ddr4_ren;
input               ddr4_read_val;
input     [511:0]   ddr4_read_data;
output              ddr4_wen;
output    [24:0]    ddr4_addr;     
output    [511:0]   ddr4_wdat;

);	
	


pkt_analysis_top u_pkt_analysis_top(
    .sys_clk                  (sys_clk               ),
    .sys_rst_n                (sys_rst_n             ),

    .ddr4_clk                 (ddr4_clk              ),
    .ddr4_rst_n               (ddr4_rst_n            ),

    .ddr4_rdat_vld            (ddr_read_vld          ),
    .ddr4_rdat                (ddr_rdat              ),

input   wire            matrix_enable_0,
input   wire            matrix_enable_1,
input   wire            matrix_enable_2,
input   wire            matrix_enable_3,
input   wire            matrix_enable_4,
input   wire            matrix_enable_5,
input   wire            matrix_enable_6,
input   wire            matrix_enable_7,
input   wire            matrix_enable_8,
input   wire            matrix_enable_9,
input   wire            matrix_enable_a,
input   wire            matrix_enable_b,
input   wire            matrix_enable_c,
input   wire            matrix_enable_d,
input   wire            matrix_enable_e,
input   wire            matrix_enable_f,

output  wire            pcie_ram_free,

output  wire            pkt_data_0,
output  wire            pkt_sop_0, 
output  wire            pkt_eop_0, 
output  wire            pkt_vld_0, 
   
output  wire            pkt_data_1,
output  wire            pkt_sop_1, 
output  wire            pkt_eop_1, 
output  wire            pkt_vld_1, 

output  wire            pkt_data_2,
output  wire            pkt_sop_2, 
output  wire            pkt_eop_2, 
output  wire            pkt_vld_2, 

output  wire            pkt_data_3,
output  wire            pkt_sop_3, 
output  wire            pkt_eop_3, 
output  wire            pkt_vld_3,    

output  wire            pkt_data_4,
output  wire            pkt_sop_4, 
output  wire            pkt_eop_4, 
output  wire            pkt_vld_4, 
   
output  wire            pkt_data_5,
output  wire            pkt_sop_5, 
output  wire            pkt_eop_5, 
output  wire            pkt_vld_5, 

output  wire            pkt_data_6,
output  wire            pkt_sop_6, 
output  wire            pkt_eop_6, 
output  wire            pkt_vld_6, 

output  wire            pkt_data_7,
output  wire            pkt_sop_7, 
output  wire            pkt_eop_7, 
output  wire            pkt_vld_7,

output  wire            pkt_data_8,
output  wire            pkt_sop_8, 
output  wire            pkt_eop_8, 
output  wire            pkt_vld_8, 
   
output  wire            pkt_data_9,
output  wire            pkt_sop_9, 
output  wire            pkt_eop_9, 
output  wire            pkt_vld_9, 

output  wire            pkt_data_a,
output  wire            pkt_sop_a, 
output  wire            pkt_eop_a, 
output  wire            pkt_vld_a, 

output  wire            pkt_data_b,
output  wire            pkt_sop_b, 
output  wire            pkt_eop_b, 
output  wire            pkt_vld_b,

output  wire            pkt_data_c,
output  wire            pkt_sop_c, 
output  wire            pkt_eop_c, 
output  wire            pkt_vld_c, 
   
output  wire            pkt_data_d,
output  wire            pkt_sop_d, 
output  wire            pkt_eop_d, 
output  wire            pkt_vld_d, 

output  wire            pkt_data_e,
output  wire            pkt_sop_e, 
output  wire            pkt_eop_e, 
output  wire            pkt_vld_e, 

output  wire            pkt_data_f,
output  wire            pkt_sop_f, 
output  wire            pkt_eop_f, 
output  wire            pkt_vld_f

	
	
	
	
endmodule

