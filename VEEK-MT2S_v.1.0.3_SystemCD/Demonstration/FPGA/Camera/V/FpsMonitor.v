module FpsMonitor(
	input					clk50,
	input     			vs,
	input     			resetn , 
	// output frame pixel data
	output reg [7:0]		fps,
	output wire [6:0]		hex_fps_h,
	output wire [6:0]		hex_fps_l
	
);


parameter  ONE_SEC = 27'd49999999;

reg [3:0]  fps_h;
reg [3:0]  fps_l;

reg [7:0]  rfps;
reg [3:0]  rfps_l;
reg [3:0]  rfps_h;

reg [26:0] sec_cnt;
reg        pre_vs;
reg      one_sec_mask;

//assign one_sec_mask =  ( sec_cnt >= ONE_SEC )?1:0;

//-----
always @( negedge resetn    or   posedge clk50) 
  if (!resetn ) begin 
         sec_cnt<=0; 
end 
else 
  if( sec_cnt <  ONE_SEC )  sec_cnt <= sec_cnt + 1 ;
   else  sec_cnt <= 0;
 
 
 //---- 
always @( negedge resetn    or   posedge clk50) 
if (!resetn )  begin 
  		 rfps   <= 0;
		 rfps_h <= 0;
		 rfps_l <= 0;
		 fps    <= 0;
		 fps_h  <= 0;
		 fps_l  <= 0;		 
       pre_vs <= vs; 
end 
else 
begin 
     
	  if (  sec_cnt == 0 ) begin		 
    { fps  ,  rfps  }<= { rfps  ,8'h0} ;
    { fps_h,  rfps_h}<= { rfps_h,4'h0} ;
    { fps_l,  rfps_l}<= { rfps_l,4'h0} ; 		 
	  end
	  
	  else  begin 
	    pre_vs  <=  vs;
	    if  ({pre_vs,vs} == 2'b01) begin
		     rfps <= rfps + 1;
		  
		    if(rfps_l >= 4'h9) begin
			  rfps_l <= 4'h0;
			  rfps_h <=  rfps_h + 1;
		  end
		  else rfps_l <= rfps_l + 1;
	    end
	end 	 
	  
end
  
assign hex_fps_h = (fps_h == 4'd0)?7'h40: //0
                   (fps_h == 4'd1)?7'h79: //1
				   	 (fps_h == 4'd2)?7'h24: //2
                   (fps_h == 4'd3)?7'h30: //3
				   	 (fps_h == 4'd4)?7'h19: //4        
				    	 (fps_h == 4'd5)?7'h12: //5
					    (fps_h == 4'd6)?7'h02: //6
					    (fps_h == 4'd7)?7'h78: //7
					    (fps_h == 4'd8)?7'h00: //8
                                   7'h10; //9
											  
assign hex_fps_l = (fps_l == 4'd0)?7'h40: //0
                   (fps_l == 4'd1)?7'h79: //1
				   	 (fps_l == 4'd2)?7'h24: //2
                   (fps_l == 4'd3)?7'h30: //3
				   	 (fps_l == 4'd4)?7'h19: //4        
				    	 (fps_l == 4'd5)?7'h12: //5
					    (fps_l == 4'd6)?7'h02: //6
					    (fps_l == 4'd7)?7'h78: //7
					    (fps_l == 4'd8)?7'h00: //8
                                   7'h10; //9
endmodule

