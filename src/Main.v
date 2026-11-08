module trafficWithPed (
	input clock, input reset_btn, input pedestrian_btn, input enable_sw,
	output LED1_S1_green, output LED2_S2_green, output LED3_S3_green, output LED4_ped_green, 
	output [7:0] seg, output [7:0] an, output LED1_S1_red, output LED2_S2_red, output LED3_S3_red, output LED4_ped_red
);

	wire clk_1Hz;                
	wire pedestrian_pulse;       
	wire s1_g, s2_g, s3_g, ped_g;
	wire[3:0] D0, D2, D4, D6;
	assign enable = clk_1Hz & enable_sw;

	onehz clock_div (clock, reset_btn, enable_sw, clk_1Hz);
	dff dff1 (clock, clk_1Hz, pedestrian_btn, 1, ped_out);
	traffic traffics (clock, reset_btn, enable, ped_out, s1_g, s2_g, s3_g, ped_g, D0, D2, D4, D6);
	DISP7SEG display (clock, D0, 0, D2, 0, D4, 0, D6, 0, text_mode, slow, med, fast, error, seg, an);

	assign LED1_S1_green = s1_g;
	assign LED2_S2_green = s2_g;
	assign LED3_S3_green = s3_g;
	assign LED4_ped_green = ped_g;

	assign LED1_S1_red = ~s1_g;
	assign LED2_S2_red = ~s2_g;
	assign LED3_S3_red = ~s3_g;
	assign LED4_ped_red = ~ped_g;

endmodule
