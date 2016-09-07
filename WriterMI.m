%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% File: WriterMI                                                          %
% Git Branch: Master                                                      %
% Author: H. Stein Shiromoto                                              %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function test
% 
% SystemStates = ['x','y','z'];
% ScalingFactor = 1e-2;
% lambda = 2;
% LaplacianMatrix = LinearLaplacianGenerator(3)
% WriterMI1(SystemStates,LaplacianMatrix,ScalingFactor,lambda)
% 
% end
% 
% function WriterMI1(SystemStates,LaplacianMatrix,ScalingFactor,lambda)

function WriterMI(SystemStates,LaplacianMatrix,ScalingFactor,lambda)

fid = fopen('PreProcessedMI.m','w');

NumberOfAgents = size(LaplacianMatrix,1);
NumberOfStates = length(SystemStates);

fprintf(fid, 'MI = -DW + A*W + transpose(A*W) - R*B*transpose(B) + 2*%f*W;\n\n',lambda);

fprintf(fid, 'MIConstraints = [');
    
        
fprintf(fid, 'sos(-MI(1:3,1:3) + %f*eye(size(MI(1:3,1:3)))); ',ScalingFactor);
fprintf(fid, 'sos(-MI(4:6,4:6) + %f*eye(size(MI(4:6,4:6)))); ',ScalingFactor);
fprintf(fid, 'sos(-MI(7:9,7:9) + %f*eye(size(MI(7:9,7:9)))); ',ScalingFactor);
       
fprintf(fid, 'sos(MI(1:3,1:3) - MI(1:3,4:6));');

fprintf(fid, 'sos(MI(4:6,4:6) - MI(4:6,1:3));');
fprintf(fid, 'sos(MI(4:6,4:6) - MI(4:6,7:9));');

fprintf(fid, 'sos(MI(7:9,7:9) - MI(7:9,4:6));');
fprintf(fid, '];');  


fclose(fid);

end