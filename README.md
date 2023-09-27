# Matrix_Vector_Multiplier
parameterized matrix multiplier 

matrix vector multiplier is a complex and mostly used operation in machine learning, for the high perfomance we are using FPGA for Matrix_Vector_Multiplier.

![image](https://github.com/CroosJJSE/Matrix_Vector_Multiplier/assets/141708783/4253d7f2-5bb9-4d49-aed2-4018918a8452)

this is the template of matrix.
we are trying to do the whole multiplication with in one clock,
it will consume lot of resourse.
for an example 8x8 matrix needs

• Multipliers : 𝑅 × 𝐶 = 64

• Adders : 1/4 𝐶 log2 𝐶 + 1 × 𝑅 = 56

• Latency : 1 + log2 𝐶 = 4


![image](https://github.com/CroosJJSE/Matrix_Vector_Multiplier/assets/141708783/9f2d6999-fd04-45ca-94cc-97e0c15972bc)

each cell is K[r][c] * X[c] , then we are perfroming tree adding (adding parallel) which is better than acumulation adding.

we are defing the adder tree like this.

![image](https://github.com/CroosJJSE/Matrix_Vector_Multiplier/assets/141708783/3e97e7cd-99ed-4dde-8cf7-db55c2dde6a5)


check the code the for the comment.
