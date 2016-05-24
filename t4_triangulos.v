module Calcula(
  input [10:0]PUX,
  input [10:0]PUY,
  input [10:0]PDX,
  input [10:0]PDY,
  input [10:0]PTX,
  input [10:0]PTY,
  output Exit);
  wire signed [23:0] Mod_1;
  wire signed [23:0] Mod_2;

  assign Mod_1 = (PUX -PTX) * (PDY -PTY);
  assign Mod_2 = (PDX -PTX) * (PUY -PTY);
  
  assign Exit = Mod_1 < Mod_2;

endmodule

module Triangle(
	  input [10:0] PointTotX,
	  input [10:0] PointTotY,
	  input [10:0]PUX,
	  input [10:0]PUY,
	  input [10:0]PDX,
	  input [10:0]PDY,
	  input [10:0]PTX,
	  input [10:0]PTY,
	  output result
	);
	wire Ex1, Ex2, Ex3; 
	
	Calcula E1(PointTotX, PointTotY,PUX,PUY,PDX,PDY, Ex1);
	Calcula E2(PointTotX, PointTotY,PDX,PDY,PTX,PTY, Ex2);
	Calcula E3(PointTotX, PointTotY,PTX,PTY,PUX,PUY, Ex3);
	
	assign result = Ex1 == Ex2 & Ex2 == Ex3;
endmodule


module Test;
	integer Write;
	reg [10:0]X_1;
	reg [10:0]X_2;
	reg [10:0]X_3;
	reg [10:0]Y_1;
	reg [10:0]Y_2;
	reg [10:0]Y_3;
	reg [10:0]PointX;
	reg [10:0]PointY;
	reg CLK;
	reg rst;
	
	Triangle A(PointX,PointY,X_1,Y_1,X_2,Y_2,X_3,Y_3,Exit);
	
	initial begin
		Write = $fopen("result.txt", "w");
		$dumpvars(0, A);
			#0;
				X_1 <=0;
				Y_1 <=0;
				X_2 <=10;
				Y_2 <=0;
				X_3 <=0;
				Y_3 <=10;
				PointX <=3;
				PointY <=3;
			#5;
				$fdisplay(Write, "%d", Exit);
			#6;
				X_1 <=15;
				Y_1 <=15;
				X_2 <=30;
				Y_2 <=0;
				X_3 <=15;
				Y_3 <=0;
				PointX <=3;
				PointY <=3;
			#9;
				$fdisplay(Write, "%d", Exit);
			#10;
		$finish;
	end
endmodule