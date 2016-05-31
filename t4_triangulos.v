module sign(
    input [11:0]PTX,
    input [11:0]PTY,
    input [11:0]PUX,
    input [11:0]PUY,
    input [11:0]PDX,
    input [11:0]PDY,
    output Saida
);

module Calcula(
  input [10:0]PUX,
  input [10:0]PUY,
  input [10:0]PDX,
  input [10:0]PDY,
  input [10:0]PTX,
  input [10:0]PTY,
  output Saida);

wire signed [11:0] a1;
wire signed [11:0] a2;
wire signed [11:0] a3;
wire signed [11:0] a4;

wire signed [23:0] m1;
wire signed [23:0] m2;

  assign a1 = PTX - PDX;
  assign a2 = PUY - PDY;
  assign a3 = PUX - PDX;
  assign a4 = PTY - PDY;

  assign m1 = a1 * a2;
  assign m2 = a3 * a4;

  assign Saida = m1 < m2;
endmodule
module triangulo(
  input [11:0] PTX,
  input [11:0] PTY,
  input [11:0] PUX,
  input [11:0] PUY,
  input [11:0] PDX,
  input [11:0] PDY,
  input [11:0] p3x,
  input [11:0] p3y,
  output saida
);


wire P1, P2, P3;

sign Pt1(PTX, PTY, PUX, PUY, PDX, PDY, P1);
sign Pt2(PTX, PTY, PDX, PDY, p3x, p3y, P2);
sign Pt3(PTX, PTY, p3x, p3y, PUX, PUY, P3);

assign saida = P1 == P2 & P2 == P3;

endmodule

module executa;

integer data_file;
integer write_file;
integer valor;

reg signed [11:0] PTX;
reg signed [11:0] PTY;
reg signed [11:0] PUX;
reg signed [11:0] PUY;
reg signed [11:0] PDX;
reg signed [11:0] PDY;
reg signed [11:0] p3x;
reg signed [11:0] p3y;
wire saida;
reg state = 0;
triangulo T(PTX, PTY, PUX, PUY, PDX, PDY, p3x, p3y, saida);

initial begin
  data_file = $fopen("entrada.txt", "r");
  write_file = $fopen("saida_verilog.txt", "w");
  if (data_file == 0) begin
    $display("ERRO!! Nao foi possivel abrir arquivo para leitura");
    $finish;
  end else begin
    $display("Arquivo para leitura aberto!");
  end
  if (write_file == 0) begin
    $display("ERRO!! Nao foi possivel abrir arquivo para escrita");
    $finish;
  end else begin
    $display("Arquivo para escrita aberto!");
  end
end

always #2 begin
  if (!$feof(data_file)) begin
	  if (state != 0)begin

	    $fdisplay(write_file, "%d%d %d %d %d %d %d %d = %d",
	      PTX, PTY, PUX, PUY, PDX, PDY, p3x, p3y, saida);

	    valor = $fscanf(data_file, "%d %d %d %d %d %d %d %d\n",
	      PTX, PTY, PUX, PUY, PDX, PDY, p3x, p3y);
	  end else begin
		valor = $fscanf(data_file, "%d %d %d %d %d %d %d %d\n",
	      PTX, PTY, PUX, PUY, PDX, PDY, p3x, p3y);
		state = 1;
  	end
  end
  else begin
    $finish;
  end
end

endmodule
