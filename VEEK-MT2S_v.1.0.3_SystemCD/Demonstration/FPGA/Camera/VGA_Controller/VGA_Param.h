////640x480
//
////	Horizontal Parameter	( Pixel )
//parameter	H_SYNC_CYC	=	96+6;
//parameter	H_SYNC_BACK	=	48-6;//4848;
//parameter	H_SYNC_ACT	=	640;	
//parameter	H_SYNC_FRONT=	16;
//parameter	H_SYNC_TOTAL=	800;
//
////	Virtical Parameter		( Line )
////parameter	V_SYNC_CYC	=	2;
////parameter	V_SYNC_BACK	=	33;
//
//parameter	V_SYNC_CYC	=	2+2;
//parameter	V_SYNC_BACK	=	33-2;
//
//parameter	V_SYNC_ACT	=	480;	
//parameter	V_SYNC_FRONT=	10;
//parameter	V_SYNC_TOTAL=	525;
////	Start Offset
//parameter	X_START		=	H_SYNC_CYC+H_SYNC_BACK;
//parameter	Y_START		=	V_SYNC_CYC+V_SYNC_BACK;





//800x480 
//	Horizontal Parameter	( Pixel )

parameter	H_SYNC_ACT	=	800;	

parameter	H_SYNC_FRONT=	170 +44;//210
parameter	H_SYNC_CYC	=	40 ;// 1;
parameter	H_SYNC_BACK	=	2  ; //
parameter	H_SYNC_TOTAL=	H_SYNC_CYC +  H_SYNC_BACK +H_SYNC_FRONT +H_SYNC_ACT ;//   1056;

//	Virtical Parameter		( Line )

parameter	V_SYNC_ACT	=	480;

parameter	V_SYNC_CYC	=	5;
parameter	V_SYNC_BACK	=	19;	
parameter	V_SYNC_FRONT=	22;

parameter	V_SYNC_TOTAL=	V_SYNC_CYC +  V_SYNC_BACK +V_SYNC_FRONT +V_SYNC_ACT ;//526;
//	Start Offset
parameter	X_START		=	H_SYNC_CYC+H_SYNC_BACK;
parameter	Y_START		=	V_SYNC_CYC+V_SYNC_BACK;

