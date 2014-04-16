/*	Scan Risk Hardware module
 *
 *
 *
 *
 */
 
module ScanRisk(	input logic 			clk,
						input logic 			reset,
						input logic [2:0]		numberOfIntrument,
						input logic [15:0]	PriceScanRange,
						input logic [7:0]		pos0,
						input logic [7:0]		pos1,
						input logic [7:0]		pos2,
						input logic [7:0]		pos3,
						input logic [7:0]		pos4,
						input logic [7:0]		pos5,
						input logic [7:0]		pos6,
						input logic [7:0]		pos7,
//						input logic [7:0]		pos8,
//						input logic [7:0]		pos9,
//						input logic [7:0]		pos10,
//						input logic [7:0]		pos11,
//						input logic [7:0]		pos12,
//						input logic [7:0]		pos13,
//						input logic [7:0]		pos14,
//						input logic [7:0]		pos15,
						
						output logic [31:0]	scanningRisk
);


//		logic 			instrument;
//		logic	[15:0]	position;
//		logic [7:0]		maturity;
//		logic	[15:0]	price;
		logic [15:0]	netPos;
		logic [23:0]	temp[15:0];
		logic [31:0]	rowLoss[15:0];
		logic [31:0]	level1[7:0];
		logic [31:0]	level2[3:0];
		logic [31:0]	level3[1:0];
		logic				flag0, flag1, flag2, flag3, flag4, flag5, flag6, flag7, flag8, flag9, flag10, flag11, flag12, flag13, flag14;
		
	//	assign scanningRisk = rowLoss[15];
		
		always_comb  begin 
				netPos <= (((pos0+ pos1)+ (pos2+ pos3))+ ((pos4+ pos5)+ (pos6+ pos7)));				
				temp[0] <= 0;
				temp[1] <= 0;
				temp[2] <= 8'd33*PriceScanRange;
				temp[3] <= 8'd33*PriceScanRange;
				temp[4] <= 8'sh5f*PriceScanRange;
				temp[5] <= 8'sh5f*PriceScanRange;
				temp[6] <= 8'd66*PriceScanRange;
				temp[7] <= 8'd66*PriceScanRange;
				temp[8] <= 8'shae*PriceScanRange;
				temp[9] <= 8'shae*PriceScanRange;
				temp[10] <= 8'd100*PriceScanRange;
				temp[11] <= 8'd100*PriceScanRange;
				temp[12] <= 8'sh9c*PriceScanRange;
				temp[13] <= 8'sh9c*PriceScanRange;
				temp[14] <= 8'd105*PriceScanRange;
				temp[15] <= -8'd105*PriceScanRange;
//				for (int i = 0; i < 16; i++)
//				rowLoss[i] <= temp[i] * netPos;//Multiple of 100
				rowLoss[0] <= 0;//temp[0] [23:3] *netPos;
				rowLoss[1] <= 0;//temp[1] [23:3] *netPos;
				rowLoss[2] <= temp[2]  *netPos;
				rowLoss[3] <= temp[3]  *netPos;
				rowLoss[4] <= temp[4]  *netPos;
				rowLoss[5] <= temp[5]  *netPos;
				rowLoss[6] <= temp[6]  *netPos;
				rowLoss[7] <= temp[7]  *netPos;
				rowLoss[8] <= temp[8]  *netPos;
				rowLoss[9] <= temp[9]  *netPos;
				rowLoss[10] <= temp[10]*netPos;
				rowLoss[11] <= temp[11]*netPos;
				rowLoss[12] <= temp[12]*netPos;
				rowLoss[13] <= temp[13]*netPos;
				rowLoss[14] <= temp[14]*netPos;
				rowLoss[15] <= temp[15]*netPos;
		end
		
		compare comp0 (.dataa(rowLoss[0]), .datab(rowLoss[1]), .ageb(flag0));
		compare comp1 (.dataa(rowLoss[2]), .datab(rowLoss[3]), .ageb(flag1));
		compare comp2 (.dataa(rowLoss[4]), .datab(rowLoss[5]), .ageb(flag2));
		compare comp3 (.dataa(rowLoss[6]), .datab(rowLoss[7]), .ageb(flag3));
		compare comp4 (.dataa(rowLoss[8]), .datab(rowLoss[9]), .ageb(flag4));
		compare comp5 (.dataa(rowLoss[10]), .datab(rowLoss[11]), .ageb(flag5));
		compare comp6 (.dataa(rowLoss[12]), .datab(rowLoss[13]), .ageb(flag6));
		compare comp7 (.dataa(rowLoss[14]), .datab(rowLoss[15]), .ageb(flag7));
		
		assign level1[0] = flag0 ? rowLoss[0] : rowLoss[1]; 
		assign level1[1] = flag1 ? rowLoss[2] : rowLoss[3]; 
		assign level1[2] = flag2 ? rowLoss[4] : rowLoss[5]; 
		assign level1[3] = flag3 ? rowLoss[6] : rowLoss[7]; 
		assign level1[4] = flag4 ? rowLoss[8] : rowLoss[9]; 
		assign level1[5] = flag5 ? rowLoss[10] : rowLoss[11]; 
		assign level1[6] = flag6 ? rowLoss[12] : rowLoss[13]; 
		assign level1[7] = flag7 ? rowLoss[14] : rowLoss[15];
		
//		always_comb begin
//			if (flag0) 
//				level1[0] = rowLoss[0];
//			else	
//				level1[0] = rowLoss[1];
//			if (flag1) 
//				level1[1] = rowLoss[2];
//			else	
//				level1[1] = rowLoss[3];	
//			if (flag2) 
//				level1[2] = rowLoss[4];
//			else	
//				level1[2] = rowLoss[5];	
//			if (flag3) 
//				level1[3] = rowLoss[6];
//			else	
//				level1[3] = rowLoss[7];	
//			if (flag4) 
//				level1[4] = rowLoss[8];
//			else	
//				level1[4] = rowLoss[9];	
//			if (flag5) 
//				level1[5] = rowLoss[10];
//			else	
//				level1[5] = rowLoss[11];	
//			if (flag6) 
//				level1[6]= rowLoss[12];
//			else	
//				level1[6] = rowLoss[13];	
//			if (flag7) 
//				level1[7] = rowLoss[14];
//			else	
//				level1[7] = rowLoss[15];
//		end
		
		compare comp8 (.dataa(level1[0]), .datab(level1[1]), .ageb(flag8));
		compare comp9 (.dataa(level1[2]), .datab(level1[3]), .ageb(flag9));
		compare comp10 (.dataa(level1[4]), .datab(level1[5]), .ageb(flag10));
		compare comp11 (.dataa(level1[6]), .datab(level1[7]), .ageb(flag11));
		
		assign level2[0] = flag8 ? level1[0] : level1[1]; 
		assign level2[1] = flag9 ? level1[2] : level1[3];		 
		assign level2[2] = flag10 ? level1[4] : level1[5]; 
		assign level2[3] = flag11 ? level1[6] : level1[7];
//		always_comb begin
//			if (flag8)
//				level2[0] = level1[0];
//			else
//				level2[0] = level1[1];
//			if (flag9)
//				level2[1] = level1[2];
//			else
//				level2[1] = level1[3];
//			if (flag10)
//				level2[2] = level1[4];
//			else
//				level2[2] = level1[5];
//			if (flag11)
//				level2[3] = level1[6];
//			else
//				level2[3] = level1[7];
//		end
		
		compare comp12 (.dataa(level2[0]), .datab(level2[1]), .ageb(flag12));
		compare comp13 (.dataa(level2[2]), .datab(level2[3]), .ageb(flag13));
		
		assign level3[0] = flag12 ? level2[0] : level2[1]; 
		assign level3[1] = flag13 ? level2[2] : level2[3];
//		always_comb begin
//			if (flag12)
//				level3[0] = level2[0];
//			else	
//				level3[0] = level2[1];
//			if (flag13)
//				level3[1] = level2[2];
//			else	
//				level3[1] = level2[3];
//		end
		
		compare comp14 (.dataa(level3[0]), .datab(level3[1]), .ageb(flag14));
		
//		assign scanningRisk = flag14 ? level3[0] : level3[1]; 
		
		always_comb begin
			if ( netPos == 16'b0 )
				scanningRisk = 32'b0;
			else if (flag14)
				scanningRisk = level3[0];
			else	
				scanningRisk = level3[1];
		end
		
endmodule