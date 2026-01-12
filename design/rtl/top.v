//Modulo principal

module top
#(
    parameter NBin      = 8, //Bits de la entrada
    parameter NBFin     = 5, //Bits fraccionarios de la entrada
    parameter NBout     = 8, //Bits de la salida
    parameter NBFout    = 5, //Bits fraccionarios de la salida
    parameter Ncoeff    = 9, //Numero de coeficientes
    parameter NBcoeff   = 7, //Bits de los coeficientes
    parameter NBFcoeff  = 5  //Bits fraccionarios de los coeficientes
)
(
    input                      clkA,
    input                      reset,
    input signed  [NBin-1  :0] x,
    output signed [NBout-1 :0] y 
);

wire        [Ncoeff*NBcoeff -1 :0] coeff;
wire                               d;
wire signed [NBin           -1 :0] xROM;
wire signed [NBin           -1 :0] xAux;
reg signed  [NBin           -1 :0] x_r;

always @(posedge clkA) begin
    x_r <= x;
end

//Instancia de FIR
FIR_t
#(
    .NBin     (NBin     ),
    .NBFin    (NBFin    ),
    .NBout    (NBout    ),
    .NBFout   (NBFout   ),
    .NBcoeff  (NBcoeff  ),
    .NBFcoeff (NBFcoeff )
) u_FIR(
    .clk    (clkA  ),
    .reset  (reset ),
    .x      (x     ),
    .coeff  (coeff ),
    .y(y)
);

assign d = (y[NBout-1] || y == {NBout{1'b0}}) ? 1'b0 : 1'b1; // Decision tomada

//Instancia de LMS
LMS
#(
    .NBx   (NBin    ),
    .NBFx  (NBFin   ),
    .NBy   (NBout   ),
    .NBFy  (NBFout  ),
    .NBw   (NBcoeff ),
    .NBFw  (NBFcoeff)
) u_LMS(
    .clkA    (clkA  ),
    .reset   (reset   ), 
    .y       (y     ),
    .d       (d     ),
    .x       (x_r     ),
    .coeff   (coeff )
);

endmodule
