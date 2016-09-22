

% Writing System States: xyz

x1 = sdpvar(1);
x2 = sdpvar(1);
x3 = sdpvar(1);

y1 = sdpvar(1);
y2 = sdpvar(1);
y3 = sdpvar(1);

z1 = sdpvar(1);
z2 = sdpvar(1);
z3 = sdpvar(1);


% Writing System Inputs: u

u1 = sdpvar(1);
u2 = sdpvar(1);
u3 = sdpvar(1);


% Definition of the Variables q and inputs 

q1 = [x1; y1; z1];
input1 = [u1];

q2 = [x2; y2; z2];
input2 = [u2];

q3 = [x3; y3; z3];
input3 = [u3];

q = [q1; q2; q3];

InputVector = [input1; input2; input3];


% Writing System Equations 

x1dot = -x1 + z1 - 1.000000e-03*(+1*x1 -1*x2 +0*x3);
x2dot = -x2 + z2 - 1.000000e-03*(-1*x1 +2*x2 -1*x3);
x3dot = -x3 + z3 - 1.000000e-03*(+0*x1 -1*x2 +1*x3);

y1dot = x1.^2 - y1 -2*x1*z1 + z1;
y2dot = x2.^2 - y2 -2*x2*z2 + z2;
y3dot = x3.^2 - y3 -2*x3*z3 + z3;

z1dot = -y1 + u1;
z2dot = -y2 + u2;
z3dot = -y3 + u3;


% Writing Vector Fields and Jacobian Matrices 

f1 = [x1dot; y1dot; z1dot];
A11 = jacobian(f1,q1);
A12 = jacobian(f1,q2);
B1  = jacobian(f1,input1);

f2 = [x2dot; y2dot; z2dot];
A21 = jacobian(f2,q1);
A22 = jacobian(f2,q2);
A23 = jacobian(f2,q3);
B2  = jacobian(f2,input2);

f3 = [x3dot; y3dot; z3dot];
A32 = jacobian(f3,q2);
A33 = jacobian(f3,q3);
B3  = jacobian(f3,input3);

f = [f1;f2;f3;];
A = jacobian(f,q);
B = jacobian(f,InputVector);
