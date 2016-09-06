% function test
% 
% SystemStates = ['x','y'];
% SystemInputs = ['u'];
% SystemParameters = ['d'];
% Simulation = 0;
% LaplacianMatrix = LinearLaplacianGenerator(4)
% WriterSys1(SystemStates,SystemInputs,SystemParameters,Simulation,LaplacianMatrix)
% 
% end
% 
% function WriterSys1(SystemStates,SystemInputs,SystemParameters,Simulation,LaplacianMatrix)

function WriterSys(SystemStates,SystemInputs,SystemParameters,Simulation,LaplacianMatrix)

fid = fopen('PreProcessedSys.m','w');

NumberOfAgents  = size(LaplacianMatrix,1);
Counter = 1;

fprintf(fid, '%% System Parameters: %s\n\n',SystemParameters);

fprintf(fid, 'global ');

for SystemParametersCounter = 1:length(SystemParameters)
    
    fprintf(fid, '%s ',SystemParameters(SystemParametersCounter));
    
end

fprintf(fid, '\n\n%% Writing System States: %s\n\n',SystemStates);

for SystemStatesCounter = 1:length(SystemStates)
    
    for AgentsCounter=1:NumberOfAgents
        
        if Simulation == 0
            
            fprintf(fid, '%s%s = sdpvar(1);\n', SystemStates(SystemStatesCounter),num2str(AgentsCounter));
            
        else
            
            fprintf(fid, '%s%s = states(%s);\n', SystemStates(SystemStatesCounter),num2str(AgentsCounter),num2str(Counter));
            Counter = Counter + 1;
            
        end
        
    end
    
    fprintf(fid, '\n');
    
end

fprintf(fid, '\n%% Writing System Inputs: %s\n\n',SystemInputs);
Counter = 1;

for SystemInputsCounter = 1:length(SystemInputs)
    
    for AgentsCounter=1:NumberOfAgents
        
        if Simulation == 0
            
            fprintf(fid, '%s%s = sdpvar(1);\n', SystemInputs(SystemInputsCounter),num2str(AgentsCounter));
            
        else
            
            fprintf(fid, '%s%s = inputs(%s);\n', SystemInputs(SystemInputsCounter),num2str(AgentsCounter),num2str(Counter));
            Counter = Counter + 1;
            
        end
        
    end
    
    fprintf(fid, '\n');
    
end

if Simulation == 0
    
    fprintf(fid, '\n%% Definition of the Variables q and inputs \n\n');
    
    for AgentsCounter=1:NumberOfAgents
        
        fprintf(fid, 'q%s = [', num2str(AgentsCounter));
        
        for SystemStatesCounter = 1:length(SystemStates)
            
            fprintf(fid, '%s%s', SystemStates(SystemStatesCounter),num2str(AgentsCounter));
            
            if SystemStatesCounter == length(SystemStates)
                
                fprintf(fid, '];\n');
                
            else
                
                fprintf(fid, '; ');
                
            end
            
        end
        
        fprintf(fid, 'input%s = [', num2str(AgentsCounter));
        
        for SystemInputsCounter = 1:length(SystemInputs)
            
            fprintf(fid, '%s%s', SystemInputs(SystemInputsCounter),num2str(AgentsCounter));
            
            if SystemInputsCounter == length(SystemInputs)
                
                fprintf(fid, '];\n\n');
                
            else
                
                fprintf(fid, '; ');
                
            end
            
        end
        
    end
    
    fprintf(fid, 'q = [');
    
    for AgentsCounter=1:NumberOfAgents
        
        fprintf(fid, 'q%s', num2str(AgentsCounter));
        
        if AgentsCounter == NumberOfAgents
            
            fprintf(fid, '];\n\n');
            
        else
            
            fprintf(fid, '; ');
            
        end
        
    end
    
    fprintf(fid, 'InputVector = [');
    
    for AgentsCounter=1:NumberOfAgents
        
        fprintf(fid, 'input%s', num2str(AgentsCounter));
        
        if AgentsCounter == NumberOfAgents
            
            fprintf(fid, '];\n\n');
            
        else
            
            fprintf(fid, '; ');
            
        end
        
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% Write System Here                                                       %
%                                                                         %
% Based on [Zheng and Wu, J. Guid., Contr., and Dyn, 2009] Equation (20)

fprintf(fid, '\n%% Writing System Equations \n\n');

for SystemStatesCounter = 1:length(SystemStates)
    
    for AgentsCounter=1:NumberOfAgents
        
        fprintf(fid, '%s%sdot = ', SystemStates(SystemStatesCounter),num2str(AgentsCounter));
        
        if SystemStatesCounter == 1
            
            fprintf(fid, '-%s%s - %s%s^3 + %s%s^2 -%s*(',SystemStates(1),num2str(AgentsCounter),SystemStates(1),num2str(AgentsCounter),SystemStates(2),num2str(AgentsCounter),SystemParameters(1));
            
            for AgentsCounter2 = 1:NumberOfAgents
                
                if LaplacianMatrix(AgentsCounter,AgentsCounter2) < 0
                    
                    fprintf(fid, '%s*%s%s^3', num2str(LaplacianMatrix(AgentsCounter,AgentsCounter2)),SystemStates(1),num2str(AgentsCounter2));
                    
                else
                    
                    fprintf(fid, '+%s*%s%s^3', num2str(LaplacianMatrix(AgentsCounter,AgentsCounter2)),SystemStates(1),num2str(AgentsCounter2));
                    
                end
                
                if AgentsCounter2 == NumberOfAgents
                    
                    fprintf(fid, ');\n');
                    
                else
                    
                    fprintf(fid, ' ');
                    
                end
                
            end
            
        else
            
            fprintf(fid, '%s%s;\n',SystemInputs(1),num2str(AgentsCounter));
            
        end
        
    end
    
    fprintf(fid, '\n');
    
end

% end                                                                     %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if Simulation == 0
    
    fprintf(fid, '\n%% Writing Vector Fields and Jacobian Matrices \n\n');
    
    for AgentsCounter = 1:NumberOfAgents
        
        fprintf(fid, 'f%s = [', num2str(AgentsCounter));
        
        for SystemStatesCounter = 1:length(SystemStates)
            
            fprintf(fid, '%s%sdot', SystemStates(SystemStatesCounter),num2str(AgentsCounter));
            
            if SystemStatesCounter == length(SystemStates)
                
                fprintf(fid, '];\n');
                
            else
                
                fprintf(fid, '; ');
                
            end
            
        end
        
        for NeighborCounter = 1:NumberOfAgents
            
            if LaplacianMatrix(AgentsCounter,NeighborCounter) ~= 0
                
                fprintf(fid, 'A%s%s = jacobian(f%s,q%s);\n', num2str(AgentsCounter),num2str(NeighborCounter),num2str(AgentsCounter),num2str(NeighborCounter));
                
            end
        
        end
        
        fprintf(fid, 'B%s  = jacobian(f%s,input%s);\n', num2str(AgentsCounter),num2str(AgentsCounter),num2str(AgentsCounter));
        fprintf(fid, '\n');
        
    end
    
    fprintf(fid, 'f = [');
    for AgentsCounter = 1:NumberOfAgents
        fprintf(fid, 'f%s;', num2str(AgentsCounter));
    end
    fprintf(fid, '];\n');
    
    fprintf(fid, 'A = jacobian(f,q);\n');
    fprintf(fid, 'B = jacobian(f,InputVector);\n');

    
end

fclose(fid);

end