module pisca (
	input clk,
	output led
);
	reg x;
	assign led = x;

	always @(posedge clk) begin
		x <= ~x;
	end
endmodule

module teste;
	reg clk;
	wire led;

	always #2 clk = ~clk;
	pisca p(clk, led);

	initial begin
		$dumpvars(0, p);
		#0
		clk <= 1'b0;
		#500;
		$finish;
	end
endmodule
