
module	VGA_Controller (	 // 800x480 
//input 				iZOOM_MODE_SW
     input	    [9:0]	iRed,
     input	    [9:0]	iGreen,
     input	    [9:0]	iBlue,
     input				   iCLK,
     input				   iRST_N,
     output	reg			oRequest,
     output	reg	[9:0]	oVGA_R,
     output	reg	[9:0]	oVGA_G,
     output	reg	[9:0]	oVGA_B,
     output	reg			oVGA_H_SYNC,
     output	reg			oVGA_V_SYNC,
     output	reg			oVGA_SYNC,
     output	reg		   oVGA_BLANK,
     output	reg	[12:0]H_Cont,
     output	reg	[12:0]V_Cont
						
						);

 `include "VGA_Param.h"

//=============================================================================
// REG/WIRE declarations
//=============================================================================
wire		[9:0]	mVGA_R;
wire		[9:0]	mVGA_G;
wire		[9:0]	mVGA_B;
reg				mVGA_H_SYNC;
reg				mVGA_V_SYNC;
wire				mVGA_SYNC;
wire				mVGA_BLANK;
wire	[12:0]	v_mask;


//=============================================================================
// Structural coding
//=============================================================================

assign v_mask = 13'd0;

////////////////////////////////////////////////////////

assign	mVGA_BLANK	=	mVGA_H_SYNC & mVGA_V_SYNC;
assign	mVGA_SYNC	=	1'b0;

assign	mVGA_R	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START+v_mask 	&& V_Cont<Y_START+V_SYNC_ACT )
						?	iRed	:	0;
assign	mVGA_G	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START+v_mask 	&& V_Cont<Y_START+V_SYNC_ACT )
						?	iGreen	:	0;
assign	mVGA_B	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START+v_mask 	&& V_Cont<Y_START+V_SYNC_ACT )
						?	iBlue	:	0;

always@(posedge iCLK or negedge iRST_N)
	begin
		if (!iRST_N)
			begin
				oVGA_R <= 0;
				oVGA_G <= 0;
                oVGA_B <= 0;
				oVGA_BLANK <= 0;
				oVGA_SYNC <= 0;
				oVGA_H_SYNC <= 0;
				oVGA_V_SYNC <= 0; 
			end
		else
			begin
				oVGA_R <= mVGA_R;
				oVGA_G <= mVGA_G;
                oVGA_B <= mVGA_B;
				oVGA_BLANK <= mVGA_BLANK;
				oVGA_SYNC <= mVGA_SYNC;
				oVGA_H_SYNC <= mVGA_H_SYNC;
				oVGA_V_SYNC <= mVGA_V_SYNC;				
			end               
	end

//	Pixel LUT Address Generator
wire [7:0]SH_L ; 
//SH sl( .result(SH_L ));
assign SH_L  = 4 ; 

always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	oRequest	<=	0;
	else
	begin
		if(	H_Cont>=X_START-SH_L && H_Cont< X_START+H_SYNC_ACT - SH_L &&
			   V_Cont>=Y_START && V_Cont< Y_START + V_SYNC_ACT )
		oRequest	<=	1;
		else
		oRequest	<=	0;
	end
end

//	H_Sync Generator, Ref. 25.175 MHz Clock
always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		H_Cont		<=	0;
		mVGA_H_SYNC	<=	0;
	end
	else
	begin
		//	H_Sync Counter
		if( H_Cont < H_SYNC_TOTAL )
		H_Cont	<=	H_Cont+1;
		else
		H_Cont	<=	0;
		//	H_Sync Generator
		if( H_Cont < H_SYNC_CYC )
		mVGA_H_SYNC	<=	0;
		else
		mVGA_H_SYNC	<=	1;
	end
end

//	V_Sync Generator, Ref. H_Sync
always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		V_Cont		<=	0;
		mVGA_V_SYNC	<=	0;
	end
	else
	begin
		//	When H_Sync Re-start
		if(H_Cont==0)
		begin
			//	V_Sync Counter
			if( V_Cont < V_SYNC_TOTAL )
			V_Cont	 <=	V_Cont+1;
			else
			V_Cont	<=	0;
			//	V_Sync Generator
			if(	V_Cont < V_SYNC_CYC )
			mVGA_V_SYNC	<=	0;
			else
			mVGA_V_SYNC	<=	1;
		end
	end
end

endmodule
