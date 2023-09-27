module matvec_mul #(
    parameter R=8, C=8, W_X=8, W_K=8,      // R: # of rows, C: # of columns, W_X: bitwidth of x, W_K: bitwidth of k
    localparam DEPTH = $clog2(C),           // depth of adder tree = log2(C)
    W_M = W_X + W_K,                        // bitwidth of multiplication result
    W_Y = W_M + DEPTH                       // bitwidth of y = W_M + DEPTH 
    )( 
        input logic clk,
        input logic signed [R-1:0][C-1:0][W_K-1:0] k,           // k: weight matrix R rows and C columns with W_K bitwidth
        input logic signed [C-1:0][W_X-1:0] x,                  // x: input vector with C columns and W_X bitwidth
        output logic signed [R-1:0][W_Y-1:0] y                  // y: output vector with R rows and W_Y bitwidth
        );

    logic signed [W_Y-1:0] tree [DEPTH+1][R][C];                 // adder tree
    
    genvar r, c, d, a;                                          // generate variables r is row, c is column, d is depth, a is address
    for (r=0; r<R; r=r+1) begin
        for (c=0; c<C; c=c+1)
            always_ff @(posedge clk)                                // register after each mul
                tree[0][r][c] <= k[r][c] * x[c];                     // tree[0] is the first level of adder tree, multiply k and x
                                                        


    for (d=0; d<DEPTH; d=d+1)                                                   // depth of adder tree
        for (a=0; a<C/2**(d+1); a=a+1)
            always_ff @(posedge clk)                                            // register after each add
            tree [d+1][r][a] <= tree [d][r][2*a] + tree[d][r][2*a+1]; 

    assign y[r] = tree[DEPTH][r][0];

    end

endmodule
