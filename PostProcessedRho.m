VerifiedR11 = clean(replace(R(1,1), coefList, double(coefList)), 0.001);
R11 = sdisplay(VerifiedR11);

clear VerifiedR11;
VerifiedR12 = clean(replace(R(1,2), coefList, double(coefList)), 0.001);
R12 = sdisplay(VerifiedR12);

clear VerifiedR12;
VerifiedR13 = clean(replace(R(1,3), coefList, double(coefList)), 0.001);
R13 = sdisplay(VerifiedR13);

clear VerifiedR13;
VerifiedR21 = clean(replace(R(2,1), coefList, double(coefList)), 0.001);
R21 = sdisplay(VerifiedR21);

clear VerifiedR21;
VerifiedR22 = clean(replace(R(2,2), coefList, double(coefList)), 0.001);
R22 = sdisplay(VerifiedR22);

clear VerifiedR22;
VerifiedR23 = clean(replace(R(2,3), coefList, double(coefList)), 0.001);
R23 = sdisplay(VerifiedR23);

clear VerifiedR23;
VerifiedR31 = clean(replace(R(3,1), coefList, double(coefList)), 0.001);
R31 = sdisplay(VerifiedR31);

clear VerifiedR31;
VerifiedR32 = clean(replace(R(3,2), coefList, double(coefList)), 0.001);
R32 = sdisplay(VerifiedR32);

clear VerifiedR32;
VerifiedR33 = clean(replace(R(3,3), coefList, double(coefList)), 0.001);
R33 = sdisplay(VerifiedR33);

clear VerifiedR33;
R = [R11, R12, R13;
     R21, R22, R23;
     R31, R32, R33];
