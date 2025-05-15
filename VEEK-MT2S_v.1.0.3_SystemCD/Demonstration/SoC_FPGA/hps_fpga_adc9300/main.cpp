// ============================================================================
// Copyright (c) 2013 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//  
//  
//                     web: http://www.terasic.com/  
//                     email: support@terasic.com
//
// ============================================================================

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"
#include "adc9300.h"



int main() {

	ADC9300 light;
	uint8_t ID;
	bool bSuccess;
	uint16_t value;
	
	printf("adc9300 demo\r\n");
	
	if (!light.IsReady()){
		printf("driver is not ready!\r\n");
	}else{
		bSuccess = light.Set_PowerSwitch(true);
		if (!bSuccess)
			printf("Failed to power on light sensor chip.\r\n");
		
		if (bSuccess)	
		bSuccess = light.Get_ID(&ID);
		if (bSuccess)
			printf("ADC9300 chip id: %02xh\r\n", ID);
		else	
			printf("failed to get chip id\r\n");
			
		while(bSuccess){
			bSuccess = light.Get_ADCData0( &value);
			
			if (bSuccess){
				printf("light0 = % 4d\n", value);
				
				bSuccess = light.Get_ADCData1( &value);
				if (bSuccess)
					printf("light1 = % 4d\n", value);
			}		
			
			usleep(50000);
				
		} // while
	}
	

	return 0;

}
