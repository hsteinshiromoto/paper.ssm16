function caller
clear all
close all
clc
warning off

global Simulation SystemStates SystemInputs 
global SystemParameters d

Simulation   = 0;
SystemStates = ['x','y','z'];
SystemInputs = ['u'];
SystemParameters = ['d'];
d = 1e-2;
lambda = 1;
Option       = 'General';

NumberOfAgents = 3

fname = sprintf('Diary%s%dAgents',Option,NumberOfAgents);
diary(fname)
diary on

if NumberOfAgents > 5 && strcmp(Option,'Diagonal') + strcmp(Option,'Neighbor') == 0
    
    disp('This option requires lots of RAM memory for more than 5 agents.')
    disp('Chose Option = Diagonal or Neighbor to run with more than 5 agents or')
    return
    
end

if NumberOfAgents > 256 && strcmp(Option,'Neighbor')
    disp('This option requires lots of RAM memory for more than 256 agents.')
    disp('Chose Option = Diagonal and run it with more than 256 agents or')
    return
end

if NumberOfAgents > 512 && strcmp(Option,'Diagonal')
    disp('This option requires lots of RAM memory for more than 512 agents.')
    return
end

LaplacianMatrix = LinearLaplacianGenerator(NumberOfAgents);
LMIOptimisation(LaplacianMatrix,Option,lambda)

diary off

pause(60)

end

function LMIOptimisation(LaplacianMatrix,Option,lambda)

global Simulation SystemStates SystemInputs SystemParameters

WriterSys(SystemStates,SystemInputs,SystemParameters,Simulation,LaplacianMatrix)
PreProcessedSys

Wdegree = 2;
ScalingFactor = 1;
WriterW(SystemStates,LaplacianMatrix,Wdegree,ScalingFactor)
PreProcessedW

Rhodegree = 2;
WriterRho(SystemStates,LaplacianMatrix,Rhodegree)
PreProcessedRho

WriterMI(SystemStates,LaplacianMatrix,ScalingFactor,lambda)
PreProcessedMI

Constraints = [WConstraints;MIConstraints];
checkset(Constraints)
coefList = [Wc;Rhoc];
options = sdpsettings('solver','mosek','verbose',1);
tic
[sol, q, Q, res] = solvesos(Constraints,[],options,coefList);
SolverTime = toc;

Precision = 1e-3;
AnalysisW(SystemStates,LaplacianMatrix,Precision)
PostProcessedW

AnalysisY(SystemInputs,LaplacianMatrix,Precision)
PostProcessedY

NumberOfAgents = size(LaplacianMatrix,1);
fname = sprintf('Output%s%dAgents',Option,NumberOfAgents);
save(fname)
end