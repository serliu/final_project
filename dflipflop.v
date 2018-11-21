module dflipflop(d, clk, clr, pr, ena, q);
    input d, clk, ena, clr, pr;


    output q;
    reg q;
	 reg lo;

    initial
    begin
        q = 1'b0;
    end

    always @(posedge clk) begin
        if (q == 1'bx) begin
            q <= 1'b0;
        end else if (clr) begin
            q <= 1'b0;
				
        end else if (ena) begin
            q <= d;
        end
    end
endmodule
