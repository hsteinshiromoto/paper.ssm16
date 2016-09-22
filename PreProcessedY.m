% NumberOfAgents = 3,
% NumberOfInputs = 1,
% NumberOfStates = 3,

% No Option Defined: Option = General


% Starting Agent 1

% Writing Line 1
[Yp111,Yc111,Yv111] = polynomial(q,2.000000,0);
[Yp112,Yc112,Yv112] = polynomial(q,2.000000,0);
[Yp113,Yc113,Yv113] = polynomial(q,2.000000,0);
[Yp114,Yc114,Yv114] = polynomial(q,2.000000,0);
[Yp115,Yc115,Yv115] = polynomial(q,2.000000,0);
[Yp116,Yc116,Yv116] = polynomial(q,2.000000,0);
[Yp117,Yc117,Yv117] = polynomial(q,2.000000,0);
[Yp118,Yc118,Yv118] = polynomial(q,2.000000,0);
[Yp119,Yc119,Yv119] = polynomial(q,2.000000,0);


% Starting Agent 2

% Writing Line 1
[Yp211,Yc211,Yv211] = polynomial(q,2.000000,0);
[Yp212,Yc212,Yv212] = polynomial(q,2.000000,0);
[Yp213,Yc213,Yv213] = polynomial(q,2.000000,0);
[Yp214,Yc214,Yv214] = polynomial(q,2.000000,0);
[Yp215,Yc215,Yv215] = polynomial(q,2.000000,0);
[Yp216,Yc216,Yv216] = polynomial(q,2.000000,0);
[Yp217,Yc217,Yv217] = polynomial(q,2.000000,0);
[Yp218,Yc218,Yv218] = polynomial(q,2.000000,0);
[Yp219,Yc219,Yv219] = polynomial(q,2.000000,0);


% Starting Agent 3

% Writing Line 1
[Yp311,Yc311,Yv311] = polynomial(q,2.000000,0);
[Yp312,Yc312,Yv312] = polynomial(q,2.000000,0);
[Yp313,Yc313,Yv313] = polynomial(q,2.000000,0);
[Yp314,Yc314,Yv314] = polynomial(q,2.000000,0);
[Yp315,Yc315,Yv315] = polynomial(q,2.000000,0);
[Yp316,Yc316,Yv316] = polynomial(q,2.000000,0);
[Yp317,Yc317,Yv317] = polynomial(q,2.000000,0);
[Yp318,Yc318,Yv318] = polynomial(q,2.000000,0);
[Yp319,Yc319,Yv319] = polynomial(q,2.000000,0);

% Writing Vector Yc
Yc = [Yc111; Yc112; Yc113; Yc114; Yc115; Yc116; Yc117; Yc118; Yc119;
      Yc211; Yc212; Yc213; Yc214; Yc215; Yc216; Yc217; Yc218; Yc219;
      Yc311; Yc312; Yc313; Yc314; Yc315; Yc316; Yc317; Yc318; Yc319;
      ];

% Writing Matrix Y
Y = [Yp111, Yp112, Yp113, Yp114, Yp115, Yp116, Yp117, Yp118, Yp119;
     Yp211, Yp212, Yp213, Yp214, Yp215, Yp216, Yp217, Yp218, Yp219;
     Yp311, Yp312, Yp313, Yp314, Yp315, Yp316, Yp317, Yp318, Yp319;
     ];
