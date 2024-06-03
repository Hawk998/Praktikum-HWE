`include "projectGlobalParam.v"

module complex_mult_top_tb;

integer current_Imag_value,
        current_real_value, 
        inputfile_real,
        inputfile_imag,
        outputfile_real,
        outputfile_imag, 
        file_read_status,
        file_read_status_imag,
        entry_count,
        MAX_ENTRIES;

reg                         clk;
reg                         rst;
reg signed [7:0]            real_i, imag_i;
reg         signed  [31:0]  delta_index_i;
reg                         valid_i;

wire signed  [7:0]  real_o, imag_o;
wire                valid_o;

complex_mult_top DUT(
    .clk            (clk),
    .rst            (rst),
    .real_i         (real_i),
    .imag_i         (imag_i),
    .delta_index_i  (delta_index_i),
    .valid_i        (valid_i),
    
    .real_o         (real_o),
    .imag_o         (imag_o),
    .valid_o        (valid_o)
);

always
    #5 clk = !clk;
    
initial begin
    outputfile_real     = $fopen("output_real.dat");
    outputfile_imag     = $fopen("output_imag.dat");
    inputfile_real      = $fopen("voyager_signal_low_IF_real", "r");
    inputfile_imag      = $fopen("voyager_signal_low_IF_imag", "r");

    clk         = 0;
    rst         = `RST_VAL;
    real_i      = 11;
    imag_i      = -5;
    delta_index_i = -32'b00_11111010_0000000000000000000000; // 1024/4.096=250
    valid_i     = 0;
    MAX_ENTRIES = 100;
    

    #100
    rst = !(`RST_VAL);

    // Read imag file until EOF or until MAX_ENTRIES is reached
    while (!$feof(inputfile_imag) && !$feof(inputfile_real) && entry_count < MAX_ENTRIES) begin
        #10
        file_read_status_imag = $fscanf(inputfile_imag, "%d\n", current_Imag_value);
        file_read_status = $fscanf(inputfile_real, "%d\n", current_real_value);
        if (file_read_status_imag == 1 && file_read_status == 1) begin
            imag_i = current_Imag_value;
            real_i = current_real_value;
            valid_i = 1'b1;
            entry_count = entry_count + 1;
        end else begin
            $fclose(inputfile_imag);
            $fclose(inputfile_real);
            $stop;
        end
        #10
        valid_i = 1'b0;
    end
    
    // Close the files after reading the required entries
    $fclose(inputfile_imag);
    $fclose(inputfile_real);
end

always @ (posedge clk) begin
    #1
    if (!(`RST_VAL)) begin
        $display("Time: %0t | real_i: %d, imag_i: %d, valid_i: %b", 
                 $time, real_i, imag_i, valid_i);
        if(valid_o) begin
            $fwrite(outputfile_real, "%d\n", real_o);
            $fwrite(outputfile_imag, "%d\n", imag_o);
        end
    end
end

endmodule

