# Matrix_Vector_Multiplier
parameterized matrix multiplier 

matrix vector multiplier is a complex and mostly used operation in machine learning, for the high perfomance we are using FPGA for Matrix_Vector_Multiplier.



this is the template of matrix.
we are trying to do the whole multiplication with in one clock,
it will consume lot of resourse.
for an example 8x8 matrix needs

• Multipliers : 𝑅 × 𝐶 = 64

• Adders : 1/4 𝐶 log2 𝐶 + 1 × 𝑅 = 56

• Latency : 1 + log2 𝐶 = 4



each cell is K[r][c] * X[c] , then we are perfroming tree adding (adding parallel) which is better than acumulation adding.

we are defing the adder tree like this.


![image](https://github.com/CroosJJSE/Matrix_Vector_Multiplier/assets/141708783/5afc7653-2855-4612-b945-5fab58ac4e23)



check the code the for the comment for explaination.

lets start with the 3x3 matrix 

![IMG_8036](https://github.com/CroosJJSE/Matrix_Vector_Multiplier/assets/141708783/d648987b-138c-4db1-895e-7c8e385bd1cc)

here is the simulation result
![image](https://github.com/CroosJJSE/Matrix_Vector_Multiplier/assets/141708783/152028b4-2fea-4dfb-b035-c6e990162697)



we can easily recognize the tree adder in 2x2 matrix

![image](https://github.com/CroosJJSE/Matrix_Vector_Multiplier/assets/141708783/be08baeb-5279-4bc3-a425-18b4e3b00a00)



3x3 schematic

![image](https://github.com/CroosJJSE/Matrix_Vector_Multiplier/assets/141708783/35e9d13f-49d8-4109-994c-28f2d9a22b46)


closeup 
![image](https://github.com/CroosJJSE/Matrix_Vector_Multiplier/assets/141708783/4ff259c3-a07f-4084-8a67-092d35b0fc1e)


simplified view

![IMG_8037](https://github.com/CroosJJSE/Matrix_Vector_Multiplier/assets/141708783/5caca96f-b91e-4a7a-99ef-30a927187dc8)
