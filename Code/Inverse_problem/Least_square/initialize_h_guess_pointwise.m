function [h_guess] = initialize_h_guess_pointwise(hgrid, xgrid, dx)
% This function creats an initial guess for the depths over the discrete
% grid. It currently just guesses a linear profile from the beach to
% boundary condition.

n = length(xgrid);

ind = find(~hgrid, 1);

xi = xgrid(ind);

    slope = -hgrid(1)/xi;
    h_guess = zeros(n, 1);
    h_guess(1) = hgrid(1);
     
    h_asst=zeros(n,1);
    h_asst(1) = hgrid(1);% for test
    
%     h_or=randn(100);
%     h_1=h_or(h_or<1);
%     h_2=h_1(h_1>-1);
%     h_new=h_2()
    
    h_rand = randi([0 1],n);
    
%     for i = 1:n
%         h_rand(i) = h_rand(i)/10;
%     end
    
    for i = 2:ind
        %%% linear guess
        h_guess(i) = h_guess(i-1) + slope*dx;% original
        %h_guess(i)=sin(h_guess(i-1));
        
%         h_asst(i)=h_asst(i-1)+slope*dx;
%         h_diff=abs(h_asst(i)-hgrid(i));
%         h_guess(i)=h_asst(i)+h_rand(i)*h_diff;
    end 
    for i = ind+1:n
        h_guess(i) = 0;
    end 
    %h_guess(2:ind)=h_guess(2:ind)+0.5*randn(length(hgrid(2:ind)),1);
end 