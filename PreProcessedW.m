% Creation of W1 and DW1
[Wp111,Wc111,Wv111] = polynomial([x1;y1],2,0);
[Wp112,Wc112,Wv112] = polynomial([x1;y1],2,0);
[Wp113,Wc113,Wv113] = polynomial([x1;y1],2,0);
[Wp122,Wc122,Wv122] = polynomial([x1;y1],2,0);
[Wp123,Wc123,Wv123] = polynomial([x1;y1],2,0);
[Wp133,Wc133,Wv133] = polynomial([x1;y1],2,0);
% Creation of W1
W1 = [Wp111, Wp112, Wp113;
      Wp112, Wp122, Wp123;
      Wp113, Wp123, Wp133];

Wc1 = [Wc111;Wc112;Wc113;Wc122;Wc123;Wc133];
Wp1 = [Wp111;Wp112;Wp113;Wp122;Wp123;Wp133];

% Creation of DW1
DWTemp = jacobian(Wp1,q1);
DW1 = [DWTemp(1,:)*f1/2, DWTemp(2,:)*f1,   DWTemp(3,:)*f1;
       0,                DWTemp(4,:)*f1/2, DWTemp(5,:)*f1;
       0,                0,                DWTemp(6,:)*f1/2];
DW1 = DW1 + transpose(DW1);


% Creation of W2 and DW2
[Wp211,Wc211,Wv211] = polynomial([x2;y2],2,0);
[Wp212,Wc212,Wv212] = polynomial([x2;y2],2,0);
[Wp213,Wc213,Wv213] = polynomial([x2;y2],2,0);
[Wp222,Wc222,Wv222] = polynomial([x2;y2],2,0);
[Wp223,Wc223,Wv223] = polynomial([x2;y2],2,0);
[Wp233,Wc233,Wv233] = polynomial([x2;y2],2,0);
% Creation of W2
W2 = [Wp211, Wp212, Wp213;
      Wp212, Wp222, Wp223;
      Wp213, Wp223, Wp233];

Wc2 = [Wc211;Wc212;Wc213;Wc222;Wc223;Wc233];
Wp2 = [Wp211;Wp212;Wp213;Wp222;Wp223;Wp233];

% Creation of DW2
DWTemp = jacobian(Wp2,q2);
DW2 = [DWTemp(1,:)*f2/2, DWTemp(2,:)*f2,   DWTemp(3,:)*f2;
       0,                DWTemp(4,:)*f2/2, DWTemp(5,:)*f2;
       0,                0,                DWTemp(6,:)*f2/2];
DW2 = DW2 + transpose(DW2);


% Creation of W3 and DW3
[Wp311,Wc311,Wv311] = polynomial([x3;y3],2,0);
[Wp312,Wc312,Wv312] = polynomial([x3;y3],2,0);
[Wp313,Wc313,Wv313] = polynomial([x3;y3],2,0);
[Wp322,Wc322,Wv322] = polynomial([x3;y3],2,0);
[Wp323,Wc323,Wv323] = polynomial([x3;y3],2,0);
[Wp333,Wc333,Wv333] = polynomial([x3;y3],2,0);
% Creation of W3
W3 = [Wp311, Wp312, Wp313;
      Wp312, Wp322, Wp323;
      Wp313, Wp323, Wp333];

Wc3 = [Wc311;Wc312;Wc313;Wc322;Wc323;Wc333];
Wp3 = [Wp311;Wp312;Wp313;Wp322;Wp323;Wp333];

% Creation of DW3
DWTemp = jacobian(Wp3,q3);
DW3 = [DWTemp(1,:)*f3/2, DWTemp(2,:)*f3,   DWTemp(3,:)*f3;
       0,                DWTemp(4,:)*f3/2, DWTemp(5,:)*f3;
       0,                0,                DWTemp(6,:)*f3/2];
DW3 = DW3 + transpose(DW3);


W = blkdiag(W1,W2,W3);
WConstraints = [sos(W1-eye(3)*0.000000);sos(W2-eye(3)*0.000000);sos(W3-eye(3)*0.000000)];
DW = blkdiag(DW1,DW2,DW3);
Wc = [Wc1;Wc2;Wc3];
