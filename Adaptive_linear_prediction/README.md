This program implements LMS, RLS, BLSM, and FBLSM algorithms for adaptive linear prediction. The comparison of those algorithms are provided. 
![comparision](https://user-images.githubusercontent.com/42914736/138956213-42474959-9bde-41b6-a8da-6429f8fcf1c8.jpg)

The LMS, RLS, BLSM are adopted in time domain, so it is easy to program.   
The FBLSM algorithm: We need to calculate linear convultions to find output filters and update weights, but it consumes time to do in time domain. Thanks to the fast computation of FFT algorithm, we can find the output filters and update weights much faster. However, FFT is equivalent to circular convolution in time domain, not linear convolution. So we need a method to convert cirular convolution to linear convolution. That's why we need the overlap-save FFT-based method. 
The process of FBLSM algorithm is shown here: (Diagram from the book: Behrouz Farhang Boroujeny adaptive filters theory and applications wiley 2013, page 251.
) 
![image](https://user-images.githubusercontent.com/42914736/138956989-49d20f43-d0ce-4945-9b92-21ac0d4c4e52.png)

Code flow:  
![image](https://user-images.githubusercontent.com/42914736/138961792-2515a578-688b-4c02-8999-10b6f4832acc.png)

Example:  
![image](https://user-images.githubusercontent.com/42914736/138961886-39c38962-6066-44ba-addb-33103c902aa5.png)

