module trab2(
	input clock_50,
	output [0:7]LEDG
);
	reg[31:0] c = 0;
	reg light_on = 1;

	assign  LEDG[0]= ~ light_on;

	always @(posedge clock_50) begin
			c <= c+1;
		if (cont == 50000000) begin
			light_on  = ~light_on;
			c <= 0;
		end
	end
endmodule
