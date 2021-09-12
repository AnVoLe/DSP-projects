This program is run in MATLAB simulink to provide the idea how the gradient descent algorithm works.
The source signals are generated from signal builder block, and I use the zero-oder hold block to set the sampling time for the process. 
This algorithm can be used to estimate channel gains (AGC) in wirelesss communication systems.

The diagram of the algorithm in Simulink:

![image](https://user-images.githubusercontent.com/42914736/132999950-4fedf833-047d-4064-9937-9a8b1e97c041.png)

The scope shows the source signal with different fading and the desired signal(control each sample to 1):

![image](https://user-images.githubusercontent.com/42914736/132999969-cf35e678-710e-472f-a339-8c10b3531dca.png)

