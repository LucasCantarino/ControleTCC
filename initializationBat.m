% This function initialize the first population of search agents
function x=initializationBat(N,Max_iter,dim,ub,lb)

Boundary_no= size(ub,2); % numnber of boundaries

% If the boundaries of all variables are equal and user enter a signle
% number for both ub and lb
if Boundary_no==1
    x=rand(N,dim).*(ub-lb)+lb;
end

% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:dim
        ub_i=ub(i);
        lb_i=lb(i);
        x(:,i)=rand(N,1).*(ub_i-lb_i)+lb_i;
end

% x = [261.2903 6015 3.6276 6.3695e-04;
%      261.2903 6015 3.6276 6.3695e-04;
%      261.2903 6015 3.6276 6.3695e-04;
%      261.2903 6015 3.6276 6.3695e-04;
%      261.2903 6015 3.6276 6.3695e-04;
%      261.2903 6015 3.6276 6.3695e-04;
%      261.2903 6015 3.6276 6.3695e-04;
%      261.2903 6015 3.6276 6.3695e-04;
%      261.2903 6015 3.6276 6.3695e-04;
%      261.2903 6015 3.6276 6.3695e-04];
                                                                                                      
end