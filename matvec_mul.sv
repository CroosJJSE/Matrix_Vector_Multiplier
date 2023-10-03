module matvec_mul #(
    parameter R=8, C=8, W_X=8, W_K=8,      // R: # of rows, C: # of columns, W_X: bitwidth of x, W_K: bitwidth of k
    localparam DEPTH = $clog2(C),           // depth of adder tree = log2(C)
    W_M = W_X + W_K,                        // bitwidth of multiplication result
    W_Y = W_M + DEPTH                       // bitwidth of y = W_M + DEPTH 
    )( 
        input logic clk,cen,
        input logic signed [R-1:0][C-1:0][W_K-1:0] k,           // k: weight matrix R rows and C columns with W_K bitwidth
        input logic signed [C-1:0][W_X-1:0] x,                  // x: input vector with C columns and W_X bitwidth
        output logic signed [R-1:0][W_Y-1:0] y                  // y: output vector with R rows and W_Y bitwidth
        );

    //padding
    localparam c_pad = 2**$clog2(C) ; // c_pad: # of columns after padding
    // adder tree
    logic [W_Y:0] tree [R][DEPTH+1][c_pad]; //R trees. Width is set to max width. Unconnected wires & vectors will be dropped by the synthesizer.
    wire signed     [c_pad-1:0][W_X-1:0] x_pad={'0,x}; // x_pad: padded input vector with c_pad columns and W_X bitwidth
    wire signed [R-1:0][c_pad-1:0][W_K-1:0] k_pad; // k_pad: padded weight matrix R rows and c_pad columns with W_K bitwidth

    genvar r,c,d,a; // r: row, c: column, d: depth, a: adder
    for (r=0;r<R;r=r+1) begin
        assign k_pad[r]={'0,k[r]}; // k_pad: padded weight matrix R rows and c_pad columns with W_K bitwidth

        for (c =0 ;c<c_pad ; c=c+1 )
            always_ff @( posedge clk ) // register after each mul
            if (cen) tree[r][0][c] <= $signed(k_pad[r][c]) * $signed(x_pad[c]); // tree: R trees. Width is set to max width. Unconnected wires & vectors will be dropped by the synthesizer.
            
        for (d=0; d<DEPTH; d=d+1)
            for (a=0; a<c_pad/2**(d+1); a=a+1)    // a: adder
            always_ff @(posedge clk) // register after each add
            if (cen) tree [r][d+1][a] <= tree [r][d][2*a] + tree [r][d][2*a+1];        // tree: R trees. Width is set to max width. Unconnected wires & vectors will be dropped by the synthesizer.
            
                    
            assign y[r] = tree [r][DEPTH][0];


        end
   


endmodule
