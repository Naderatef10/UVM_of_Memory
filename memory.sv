module memory 
#(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter DEPTH      = 16
)
(
  input                       clk,
  input                       rst_n,
  input                       en,
  input                       wr,
  input      [ADDR_WIDTH-1:0] addr,
  input      [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out,
  output reg                  valid_out

);
  
  reg [DATA_WIDTH-1:0] MEM [DEPTH];

  integer i;
  
  // Write to the memory
  always @(posedge clk,negedge rst_n) begin

    if (!rst_n) begin 

      for (i = 0; i < DEPTH;i = i + 1) begin
        
        MEM[i] <= 0;

      end

      valid_out <= 0;

    end

    else if (en && wr) begin
      
      MEM[addr] <= data_in;
      valid_out <= 0;

    end

    else if (en && !wr) begin
      
      data_out  <= MEM[addr];
      valid_out <= 1;

    end

  end 
  
  
endmodule