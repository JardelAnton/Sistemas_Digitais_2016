module pisca (
	input clk,
	output led
);
	reg x;
	assign led = x;

	always @(posedge clk) begin
		case(x)
			0: begin
				x <= 1'b1;
				end
			default: begin
				x <= 1'b0;
				end
		endcase
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
