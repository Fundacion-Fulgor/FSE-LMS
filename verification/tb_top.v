`timescale 1ns/1ps

module tb_top();

    parameter NBin      = 8;
    parameter NBFin     = 5;
    parameter NBout     = 8;
    parameter NBFout    = 5;
    parameter Ncoeff    = 9;
    parameter NBcoeff   = 7;
    parameter NBFcoeff  = 5;

    
    parameter TAM_MEM   = 100000;
    
    reg                 clkA;
    reg                 reset;
    reg  [NBin-1    :0] x;
    wire [NBout-1   :0] y;
    //wire [NBout-1   :0] y_aux; //Para guardar los datos de salida

    top
    #(
        .NBin       (NBin    ),
        .NBFin      (NBFin   ),
        .NBout      (NBout   ),
        .NBFout     (NBFout  ),
        .Ncoeff     (Ncoeff  ),
        .NBcoeff    (NBcoeff ),
        .NBFcoeff   (NBFcoeff)
    ) u_top(
        .clkA   (clkA   ), 
        .reset  (reset  ),
        .x      (x      ),
        .y      (y      )
    );

    always #5 clkA = ~clkA;

    reg [NBin-1 :0] entrada [0:TAM_MEM-1];
    //integer i;
    integer j;
    real aux;
    //integer file;
    initial begin
        $display("");
        $display("Simulation Started");
        $readmemh("ENTRADA.hex", entrada);

        //file = $fopen("resultados.txt", "w"); // modo "w" = escritura
        //if (file == 0) begin
        //    $display("ERROR: No se pudo abrir el archivo.");
        //    $finish;
        //end

        clkA = 1;
        reset = 0;
        x = 0;
        #100 reset = 1;
        #10;
        //for (i=0;i<40000;i=i+1) begin
        //  aux = $sin(2.0*3.1415926*i/25000.0*1000.0)*(2**NBFin);
        //   if(aux > 127.0)
	    //        x = 8'h7F;
        //   else
	    //        x = aux;
        //  #10;
        //end
        //!

        for (j=0; j<(TAM_MEM); j=j+1) begin
            x = entrada[j];
            //$fwrite(file, "%0h\n", y); // Descomentar si quiero escribir la salida en el archivo
            #10;
        end
        $display("Simulation Finished");
        $display("");

        #1000; // tiempo simulado arbitrario
        //$fclose(file);

        $finish;       
    end
 
endmodule