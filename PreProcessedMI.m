MI = -DW + A*W + transpose(A*W) - B*R*transpose(B) + 2*0.500000*W;

block1 = -MI(1:6,1:6);
 block1(4:6,4:6) = block1(4:6,4:6)/2; 

block2 = -MI(4:9,4:9);
 block2(4:6,4:6) = block2(4:6,4:6)/2; 

MIConstraints = [sos(block1);sos(block2);];

