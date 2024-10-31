
module spi_master #(parameter DATA_WIDTH = 16, parameter CHIP_SELECT_SIZE = 1, parameter SPEED_TRANSFER = 1_000_000, parameter SIZE_BUS_SPI = 1) (
	//common 
	input  logic                            clk,            // Clock
	input  logic                            clk_en,         // Clock Enable
	input  logic                            rst_n,          // Asynchronous reset active low
	
	//parallel bus
	input  logic [DATA_WIDTH - 1 : 0]       data_in,        // DATA GET FROM THE DEVICE FOR TRANSMISSION OVER SPI
	output logic [DATA_WIDTH - 1 : 0]       data_out,       // DATA SENT TO THE DEVICE
	input  logic                            valid_data_in,  // CONFIRMATION VALIDITY OF data_in 
	output logic                            valid_data_out, // CONFIRMATION VALIDITY for data_out
	output logic                            ready,          // module is ready get new command|data|other information

	//SPI line
	output logic                            clk_en,         // clock to SPI_SLAVE
	output logic [SIZE_BUS_SPI - 1 : 0]     mosi,           // DATA FOR TRANSFER MASTER INTO SLAVE
	input  logic [SIZE_BUS_SPI - 1 : 0]     miso,           // DATA FOR TRANSFER SLAVE INTO MASTER
	output logic [CHIP_SELECT_SIZE - 1 : 0] chip_select     // SELECT FROM SLAVE DEVICE, BECOME WILL BE WORK WITH MASTER

);

logic [] state;


always @(posedge clk or negedge rst_n) begin : proc_state
	if(~rst_n) begin
		state <= 0;
		valid_data_out <= 0;
		valid_data_out <= 0;
		ready          <= 0;
		clk_en         <= 0;
		mosi           <= 0;
		chip_select    <= 0;
	end else if(clk_en) begin
		case (state)
		0:
		begin
			data_out
			valid_data_out <= 0;
			ready          <= 0;
			clk_en         <= 0;
			mosi           <= 0;
			chip_select    <= 0;
		end


		default : state <= state;

	endcase
	end
end



endmodule : spi_master