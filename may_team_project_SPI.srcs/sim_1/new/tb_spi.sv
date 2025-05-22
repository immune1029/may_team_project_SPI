`timescale 1ns / 1ps

module tb_master ();

    logic       clk;
    logic       reset;

    logic       cpol;
    logic       cpha;
    logic       start;
    logic [7:0] rx_data;
    logic [7:0] tx_data;
    logic       done;
    logic       ready;

    logic       SCLK;
    logic       MOSI;
    logic       MISO;
    logic       SS;

    SPI_Master dut (.*);

    SPI_Slave slave_dut(.*);

    always #5 clk = ~clk;

    //assign MISO = MOSI;

    initial begin
        clk   = 0;
        reset = 1;
        #10;
        reset = 0;

        repeat (3) @(posedge clk);
        SS = 1;
        @(posedge clk);
        tx_data = 8'h80; // 8'b10000000 (write [7]번이 1이므로, 주소값은 0번지에 data를 보내고고)
        start   = 1; cpol = 0; cpha = 0; SS = 0;
        @(posedge clk);
        start = 0;
        wait (done == 1);
        @(posedge clk);

        repeat (3) @(posedge clk);
        @(posedge clk);
        tx_data = 8'h10;
        start   = 1; cpol = 0; cpha = 0; SS = 0;
        @(posedge clk);
        start = 0;
        wait (done == 1);
        @(posedge clk);

        repeat (3) @(posedge clk);
        @(posedge clk);
        tx_data = 8'h20;
        start   = 1; cpol = 0; cpha = 0; SS = 0;
        @(posedge clk);
        start = 0;
        wait (done == 1);
        @(posedge clk);

        repeat (3) @(posedge clk);
        @(posedge clk);
        tx_data = 8'h30;
        start   = 1; cpol = 0; cpha = 0; SS = 0;
        @(posedge clk);
        start = 0;
        wait (done == 1);
        @(posedge clk);

        repeat (3) @(posedge clk);
        @(posedge clk);
        tx_data = 8'h40;
        start   = 1; cpol = 0; cpha = 0; SS = 0;
        @(posedge clk);
        start = 0;
        wait (done == 1);
        @(posedge clk);

        SS = 1;

        repeat(5) @(posedge clk);
        SS = 0;
        @(posedge clk);
        tx_data = 8'b00000000; start = 1; cpol = 0; cpha = 0; // tx_data[7] = 0 : 주소값을 읽겠다
        @(posedge clk);
        start = 0;
        wait (done == 1);
        
        for(int i=0; i < 4; i++)begin
            @(posedge clk);
            start = 1;
            @(posedge clk);
            start = 0;
            wait (done == 1);
            @(posedge clk);
        end
        
        SS = 1;

        #200 $finish;
    end
endmodule
