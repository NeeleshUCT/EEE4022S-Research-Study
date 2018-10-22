% DESIGN AND TESTING OF SMART FAULT LOCATION ALGORITHMS FOR SMART********
%                   TRANSMISSION AND DISTRIBUTION GRIDS

% ************************ BSc Electrical Engineering *******************

% ************************* Ramseebaluck Neelesh ************************
% *************************       RMSNEE002      ************************
% ************************* University of Cape Town *********************


% Traveling wave based fault location algorithm using DWT for 'feature
% extraction'. The time taken for the waves to reach terminals A and B are
% recorded. To get the time, DWT is applied to the modal current at each
% terminals and the time at which the first peak of frequency occurs is
% recorded. db5 is used as the mother wavelet for the DWT.

format long
% FOR TERMINAL A
% Extracting the modal current signal and the individual phsae current signals 
% from Simulink simulations
% Storing the discrete values in a Nx1 vector form where N is the number of
% samples 
I_A = Imodal(:,2);
I1_A = Ia_TA(:,2);
I2_A = Ib_TA(:,2);
I3_A = Ic_TA(:,2);
len_A = length(I_A);

% Computing the single-level discrete wavelet transform (DWT) of the 
% the above vector signals  using the using db5 mother wavelet
% where, cA1_A means the coefficients of theapproximations
% (in vector form)of 
% the signal at terminal A,and cD1_A means the coefficient of the
% details(in vector form)
% of the signal at terminal A
[cA1_A,cD1_A] = dwt(I_A,'db5');
[cA1a_A,cD1a_A] = dwt(I1_A,'db5');         % approx and details of phase a
[cA1b_A,cD1b_A] = dwt(I2_A,'db5');         % approx and details of phase b
[cA1c_A,cD1c_A] = dwt(I3_A,'db5');         % approx and details of phase c

% one-dimensional wavelet analysis
% computing the 1-step reconstructed detail coefficients of vector cD1_A
D1_A = upcoef('d',cD1_A,'db5',1,len_A);

ampl_A = abs(D1_A);
mag_A = ampl_A(:,1);            %magnitude of the detail components
peak_A = max(mag_A);            %highest detail component amplitude

%% Code to detect the peak in frequency of the samples
peak_count = 0;               % variable storing the number of peaks
for k = 2: length(D1_A)-1
    % The conditions used to find the peaks 
    if ((ampl_A(k) > ampl_A(k-1))&& (ampl_A(k) > ampl_A(k+1))&& (ampl_A(k)) >0.01)
        %k
        %disp('Prominent peak found');
        peak_count = peak_count +1;
        %storing the samples at which the peaks occurred in an array
        for i = (1:peak_count)
            array_k(peak_count) = k;
        end
    end
end
%%
% Finding the sample value of the first peak in the peak array
peak_A = find(ampl_A == ampl_A(array_k(1)));
% Getting the time at which the first peak occurred
true_time_A = tout(peak_A,1);
% time_A = vpa(true_time_A);
% figure
% plot(D1,'ro');

% one-dimensional wavelet analysis
% computing the 1-step reconstructed detail coefficients of vector
% corresponding to each phase
%Phase A
D1a = upcoef('d',cD1a_A,'db5',1,len_A);
%Phase B
D1b = upcoef('d',cD1b_A,'db5',1,len_A);
%Phase C
D1c = upcoef('d',cD1c_A,'db5',1,len_A);
%{
%% Plotting the relevant graphs
% detail coefficients of the individual phases 
figure('Name','Level 1 details for each phase at Terminal A')
subplot(3,1,1);
plot(tout,D1a,'b');
title('phase A');
xlabel('time(s)');
ylabel('d1');
grid on;

subplot(3,1,2);
plot(tout,D1b,'g');
title('phase B');
xlabel('time(s)');
ylabel('d1');
grid on;

subplot(3,1,3);
plot(tout,D1c, 'm');
title('phase C');
xlabel('time(s)');
ylabel('d1');
grid on;

%Plotting the DWT of the modal current at Terminal A
figure('Name','Terminal A')
subplot(3,1,1);
plot(tout,I_A);
title('Modal Current at terminal A');
xlabel('time(s)');
ylabel('current(A)');
grid on;
% Plotting the detail coefficients of the modal current
subplot(3,1,2);
plot(tout,D1_A);
title('db5 details');
xlabel('time(s)');
ylabel('d1');
grid on;
% Plotting the magnitude of the reconstructed detail coefficients
subplot(3,1,3);
plot(tout,mag_A);
title('Magnitude');
xlabel('time(s)');
ylabel('d1');
grid on;
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FOR TERMINAL B
% Extracting the modal current signal and the individual phase current signals 
% from Simulink simulations
% Storing the discrete values in a Nx1 vector form where N is the number of
% samples 
I_B= Imodal_B(:,2);
I1_B= Ia_TB(:,2);
I2_B= Ib_TB(:,2);
I3_B= Ic_TB(:,2);
len_B = length(I_B);

% Computing the single-level discrete wavelet transform (DWT) of the 
% the above vector signals  using the using db5 mother wavelet
% where, cA1_B means the coefficient of the approximations(in vector form) of 
% the signal at terminal B,and cD1_B means the coefficient of the
% details(in vector form)
% of the signal at terminal B
[cA1_B,cD1_B]   =  dwt(I_B,'db5');           
[cA1a_B,cD1a_B] = dwt(I1_B,'db5');         % approx and details of phase a 
[cA1b_B,cD1b_B] = dwt(I2_B,'db5');         % approx and details of phase b 
[cA1c_B,cD1c_B] = dwt(I3_B,'db5');         % approx and details of phase c 


% one-dimensional wavelet analysis
% computing the 1-step reconstructed detail coefficients of vector cD1_B
D1_B = upcoef('d',cD1_B,'db5',1,len_B);

ampl_B = abs(D1_B);
mag_B = ampl_B(:,1); %magnitude of the detail components
peak_B = max(mag_B);%highest detail component amplitude


%% Code to detect the peak in frequency of the samples
peak_count_B = 0;              % variable storing the number of peaks
for j = 2: length(D1_B)-1
    % The conditions used to find the peaks 
    if ((ampl_B(j) > ampl_B(j-1))&& (ampl_B(j) > ampl_B(j+1))&& (ampl_B(j)) > 0.01)
        %j
        %disp('Prominent peak found');
        peak_count_B = peak_count_B +1;
        %storing the samples at which the peaks occurred in an array
        for ii = (1:peak_count_B)
            array_j(peak_count_B) = j;
        end
    end
end
%%
% Finding the sample value of the first peak in the peak array
peak_B = find(ampl_B == ampl_B(array_j(1)));
% Getting the time at which the first peak occurred
true_time_B = tout(peak_B,1);               

%Phase A
D1a_B = upcoef('d',cD1a_B,'db5',1,len_B);

%Phase B
D1b_B = upcoef('d',cD1b_B,'db5',1,len_B);

%Phase C
D1c_B = upcoef('d',cD1c_B,'db5',1,len_B);
%{
%% Plotting the relevant graphs
% detail coefficients of the individual phases 
figure('Name','Level 1 details for each phase at Terminal B')
subplot(3,1,1);
plot(tout,D1a_B, 'b');
title('phase A');
xlabel('time(s)');
ylabel('d1');
grid on;

subplot(3,1,2);
plot(tout,D1b_B,'g');
title('phase B');
xlabel('time(s)');
ylabel('d1');
grid on;

subplot(3,1,3);
plot(tout,D1c_B, 'm');
title('phase C');
xlabel('time(s)');
ylabel('d1');
grid on;

%Plotting the DWT of the modal current at Terminal B 
figure('Name','Terminal B')
subplot(3,1,1);
plot(tout,I_B);
title('DWT of the modal current from terminal B');
xlabel('time(s)');
ylabel('current(A)');
grid on;
% Plotting the detail coefficients of the modal current
subplot(3,1,2);
plot(tout,D1_B);
title('db5 details');
xlabel('time(s)');
ylabel('d5');
grid on;
% Plotting the magnitude of the reconstructed detail coefficients
subplot(3,1,3);
plot(tout,mag_B);
title('Magnitude');
xlabel('time(s)');
ylabel('d5');
grid on;
%}
%% Calculation of the distance to the fault with respect to Terminal B
format short g
speed = 2.899*10^5;                 % speed of propagation of the wave
time_TA = round(true_time_A,6);     % restricting the time value to 6 decimal places
time_TB = round(true_time_B,6);     


diff = time_TB -time_TA;            % time difference
prod = speed * diff;
subtract = 80 - prod;
distance = subtract/2;              % distance of the fault wrt terminal A

diff1 = time_TB -time_TA;            % time difference
prod1 = speed * diff1;
subtract1 = 80 + prod1;
distance1 = subtract1/2;              % distance of the fault wrt terminal A
fprintf('The distance of the fault is at %4.2f km from Terminal A',distance);
fprintf('\n');
fprintf('The distance of the fault is at %4.2f km from Terminal B',distance1);
time_TA
time_TB
