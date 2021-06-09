Copyright (c) 2021, 9mpd
All rights reserved.

This source code is licensed under the MIT license found in the
LICENSE file in the root directory of this source tree.

%% Convergence of a conditionally convergent series at a desired value.
%% Also calculating the time of execution.

 clear  % Clearing Matlab Workspace for good execution of the program.
 clc  % Clearing Matlab Command Window for same reason.
 
 % Title of the program.
 fprintf("\n\t\t\t<strong>A PROGRAM TO CONVERGE A CONDITIONALLY</strong>");
 fprintf("\n\t\t\t<strong>CONVERGENT SERIES AT A DESIRED VALUE.</strong>");
 
 % Examples of conditionally convergent series.
 syms f(x) g(x)
 f(x) = (-1)^(x+1)/x;  % x = 1 to infinity.
 g(x) = (-1)^x/log(x);  % x = 2 to infinity.
 
 % Vector to contain 1st 20 terms of the rearranged series.
 R_Series = zeros(1,20);
 % Vector to contain S1,S2,...,S20 of the rearranged series.
 S_R_Series = zeros(1,20);
 
 % Asking user to select a function from the examples.
 fprintf("\n\nWhich of these two functions you would like to opt?");
 fprintf("\n1. %s",f(x));  % Option 1
 fprintf("\n2. %s",g(x));  % Option 2
 Opt = input("\nEntry : ");  % Taking input the selected function.
 
 % Asking user for a specific number where he/she wants
 % to converge the selected series.
 Sum = input("\nEnter the desired value : ");
 
 figure;  % Setting figure.
 xline(0);  % Setting X-axis.
 yline(0);  % Setting Y-axis.
 P1 = yline(Sum);  % Plotting a line y = Sum.
 hold on;  % Hold-on, to plot the other plots on the same figure.
 % Naming the plot.
 title('\color{red}Rearrangement of Conditionally Convergent Series');  
 
 % Setting variables needed for this program.
 S = 0;  % Current Sum 
 SS = 0; % Sum tracker, used for plotting the graph.
 y = 1;  % Incrementer to select next positive term of original series.
 z = 1;  % Incrementer to select next negative term of original series.
 p = 1;  % Incrementer for rearranged series.
 
 tstart = tic; % Starting the timer.
 % Checking whether the Sum is within the allowed precision,0.0001, or not.
 while (S < (Sum - 0.0001) || S > (Sum + 0.0001))
     % Checking, current sum is less than the desired sum or not.
     if (S < Sum)  
         switch Opt  % Checking which function user selected.
             case 1 
                 % Adding positive terms of rearranged series, if selected.
                 S = S + (subs(f,x,y) + abs(subs(f,x,y)))/2;
                 if (p <= 20) 
                    % First 20 terms in reaaranged series.
                    R_Series(p) = (subs(f,x,y) + abs(subs(f,x,y)))/2; 
                 end
             case 2 
                 % Adding positive terms of rearranged series, if selected.
                 S = S + (subs(g,x,y+1) + abs(subs(g,x,y+1)))/2;
                 if (p <= 20)
                    % First 20 terms in reaaranged series.
                    R_Series(p) = (subs(g,x,y) + abs(subs(g,x,y)))/2; 
                 end
             otherwise  
                 fprintf('<strong>Wrong input.</strong>');
                 fprintf('</strong>Choose 1 or 2.</strong>');
         end
         % Checking whether the next new term is included 
         % in the rearranged series or not.
         if (S ~= SS)  
             P2 = plot(p,S,'b.');  % Plotting the point (N,Sum to N terms).
             p = p + 1;  % Incrementing p to next term in rearranged series.
             SS = S;  
         end
         y = y + 1;  % Incrementing y to next positive term in original series.
     elseif (S > Sum)  % Checking, current sum is less than the desired sum or not.
         switch Opt  % Checking which function user selected.
             case 1 
                 % Adding negative terms of rearranged series 1, if selected.
                 S = S + (subs(f,x,z) - abs(subs(f,x,z)))/2;
                 if (p <= 20) 
                    % First 20 terms in reaaranged series.
                    R_Series(p) = (subs(f,x,z) - abs(subs(f,x,z)))/2; 
                 end
             case 2  
                 % Adding negative terms of rearranged series 2, if selected.
                 S = S + (subs(g,x,z+1) - abs(subs(g,x,z+1)))/2;
                 if (p <= 20) 
                    % First 20 terms in reaaranged series.
                    R_Series(p) = (subs(f,x,z) - abs(subs(f,x,z)))/2; 
                 end
             otherwise
                 disp('<strong>Wrong input.</strong>');
                 disp('<strong>Choose 1 or 2.</strong>');
         end
         % Checking whether the next new term is included 
         % in the rearranged series or not.
         if (S ~= SS)
             P3 = plot(p,S,"r."); % Plotting the point (N,Sum to N terms).
             p = p + 1; % Incrementing p to next term in rearranged series.
             SS = S;
         end
         z = z + 1; % Incrementing z to next negative term in original series.
     end
 end
 Tend = toc(tstart); % Stopping the timer.
 lgd = legend([P1 P2 P3],{'Desired Value','Positive Terms','Negative Terms'});
 set(lgd,'fontsize',8,'TextColor','blue'); 
 rect = [0.7, 0.15, 0.05, 0.15];
 set(lgd, 'Position', rect);
 xlabel('No. of Terms');  % Labelling X-axis.
 xh = get(gca,'xlabel');
 u = get(xh,'position');
 u(2) = 1.05*u(2); 
 set(xh,'position',u);
 ylabel('Partial Sum of Rearranged Series');  % Labelling Y-axis.
 yh = get(gca,'ylabel');
 v = get(yh,'position');
 v(2) = 1.05*v(2);
 set(yh,'position',v);
 hold off;
 fprintf('\n')
 
 S_R_Series(1) = R_Series(1);  % S1 = A1.
 for i=2:20
     % Sn = S(n-1) + An
     S_R_Series(i) = S_R_Series(i-1) + R_Series(i); 
 end
 
 R_Series  % Printing first 20 terms of rearranged series.
 S_R_Series  % Printing S1,S2,...,S20 of rearranged series.
 
