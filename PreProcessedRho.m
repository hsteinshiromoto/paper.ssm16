% NumberOfAgents = 3,
% NumberOfStates = 3,


% Starting Agent 1
[Rhop1,Rhoc1,Rhov1] = polynomial([q1;q2;],2,0);


% Starting Agent 2
[Rhop2,Rhoc2,Rhov2] = polynomial([q1;q2;q3;],2,0);


% Starting Agent 3
[Rhop3,Rhoc3,Rhov3] = polynomial([q2;q3;],2,0);

% Writing the Matrix R
R = blkdiag(Rhop1, Rhop2, Rhop3);

% Writing Vector Rhoc
Rhoc = [Rhoc1; Rhoc2; Rhoc3];
