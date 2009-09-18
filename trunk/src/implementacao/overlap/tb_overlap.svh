`timescale 1ns / 1ns

module tb_overlap();
`include "converter.sv"
`include "overlap.v"

//Variáveis de controle
reg reset;
reg load;
reg action;

reg clock;
initial begin clock = 1'b0;
forever #200  clock = !clock;
end

//Valores para o modelo de referência
converter conv = new("conv");

integer bus_0, bus_1, bus_2, bus_3;

integer pcm1_0 = 0, pcm1_1 = 0, pcm1_2 = 0, pcm1_3 = 0;
integer pcm2_0 = 0, pcm2_1 = 0, pcm2_2 = 0, pcm2_3 = 0;


//valores de entrada
wire [63:0] dataBusIn;
reg [63:0] dataBusTemp;
bit [63:0] dataBusOut;

bit [15:0] out0;
bit [15:0] out1;
bit [15:0] out2;
bit [15:0] out3;


//valores usados para comparação de resultados
integer pcm_out_0, pcm_out_1, pcm_out_2, pcm_out_3;

bit [15:0] pcm_ref_0, pcm_ref_1, pcm_ref_2, pcm_ref_3;

reg loadedFirst;

integer i;

//instância do overlap
overlap over(clock, reset, load, action, dataBusIn, dataBusOut);


//o que eh isso?
//assign dataBus = action?64'bz:dataBusTemp;
assign dataBusIn = dataBusTemp;

always @(posedge clock) begin
  
  /****************Modelo de Referência*******************/
  if(action)begin
    pcm_ref_0 = pcm1_0 + pcm2_0;
   
    pcm_ref_1 = pcm1_1 + pcm2_1;
   
    pcm_ref_2 = pcm1_2 + pcm2_2;
   
    pcm_ref_3 = pcm1_3 + pcm2_3;
    
    if(~load) begin
      loadedFirst = 0;
    end;
  end
  else begin
    pcm_ref_0 = 16'bz;
    
    pcm_ref_1 = 16'bz;
    
    pcm_ref_2 = 16'bz;
    
    pcm_ref_3 = 16'bz;
    
  end

  if(load)begin
    if(loadedFirst == 0) begin
      pcm1_0 = bus_0;
      pcm1_1 = bus_1;
      pcm1_2 = bus_2;
      pcm1_3 = bus_3;   

      pcm2_0 = 0;
      pcm2_1 = 0;
      pcm2_2 = 0;
      pcm2_3 = 0;
      
      loadedFirst = 1;   
    end
    else begin
      pcm2_0 = bus_0;
      pcm2_1 = bus_1;
      pcm2_2 = bus_2;
      pcm2_3 = bus_3;
      
      loadedFirst = 0;
    end
  end

  /****************Modelo de Referência*******************/
 
 
  /***********************RESULTADOS**********************/
  for(i=0; i < 16; i++) begin
		out0[i] = dataBusOut[i];
		out1[i] = dataBusOut[16 + i];
		out2[i] = dataBusOut[32 + i];
		out3[i] = dataBusOut[48 + i];
  end
  
  pcm_out_0 = conv.binToDec(out0);
 
  pcm_out_1 = conv.binToDec(out1);
 
  pcm_out_2 = conv.binToDec(out2);
 
  pcm_out_3 = conv.binToDec(out3);
  /*********************RESULTADOS************************/
 
 
 
  /***************MOSTRA RESULTADOS***********************/
  $display("\n");
  $display("Resultados Obtidos para action=%d, load=%d", action, load);
  
  $display("valores 0: refMod = %d e overlap = %d", pcm_ref_0, pcm_out_0);
  $display("valores 1: refMod = %d e overlap = %d", pcm_ref_1, pcm_out_1);
  $display("valores 2: refMod = %d e overlap = %d", pcm_ref_2, pcm_out_2);
  $display("valores 3: refMod = %d e overlap = %d", pcm_ref_3, pcm_out_3);
  
  /***************MOSTRA RESULTADOS***********************/
  
  
  
  
  /******************Gera Valores**********************/
  //gera valores
  bus_0 = $random %65536;
  bus_1 = $random %65536;
  bus_2 = $random %65536;
  bus_3 = $random %65536;

 
  $display("valor bus_3 %d, valor bus_2 %d, valor bus_1 %d, valor bus_0 %d",
				bus_3, bus_2, bus_1, bus_0);
 
  //converte valores para binário e acopla eles para a entrada
  dataBusTemp = {conv.decToBin(bus_3), conv.decToBin(bus_2), conv.decToBin(bus_1), conv.decToBin(bus_0)};
  
  //dataBusIn = action?64'bz:dataBusTemp;
  $display("valor dataBusIn %b", dataBusIn);
 
  //carregar os dados primeiro
 
  action = $random %2;
  //action = 0;
  load = $random %2;
  //load = 1;
  
  reset = 0;
  
  /******************Gera Valores**********************/
  
  
end

endmodule