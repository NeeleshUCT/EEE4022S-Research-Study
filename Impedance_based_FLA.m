close all;
clc;

R= 0.01273; %total resistance of transmission line
X= 0.0009337; %total inductance of transmission line
a1=0.0687272995167014; %magnitude of voltage at Bus A
b1=3.0283015865; % voltage phase at Bus A
a2= 116.796470240478; %current magnitude at Bus A
b2=-1.514305255; %current phase at Bus A
a3=0.0485136066923109; %magnitude of voltage at Bus B
b3= 3.0143372072; % voltage phase at Bus B
a4=82.4450931939621; %current magnitude at Bus B
b4=  -1.528290578; %current phase at Bus B
c1= R*a2-X*b2; %coefficient
c2= R*b2 +X*a2; %coefficient
c3= R*a4- X*b4; %coefficient
c4= R*b4 +X*a4; %coefficient
a= -c3*a1-c4*b1-c1*a3-c2*b3+c1*c3+c2*c4;
b= c4*a1-c3*b1-c2*a3+c1*b3+c2*c3-c1*c4;
c= c2*a1-c1*b1-c4*a3+c3*b3;
del= zeros(30,1);%synchronization angle at k iteration
del1= zeros (31, 1); %synchronization angle at k+1 iteration

del1 (1) = 0;
for i= 1:30
del(i)= del1(i);
f1= b*cos (del (i)) +a*sin (del (i)) +c;
f2= a*cos (del (i))-b*sin (del (i));
del1 (i+1) =del (i)-(f1/f2);
diff= abs(del1(i+1)-del(i));
m1=(a1*sin(del1(i+1))+b1*cos(del1(i+1))-b3+c4)/(c1*sin(del1(i+1))+c2*cos(del1(i+1))+c4);
%fault distance in percentage from Bus B.
end
