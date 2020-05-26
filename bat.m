function  [bestfit,BestPositions,fmin,Convergence_curve]=bat(N,Max_iter,lb,ub,dim)
Fmax=[5 60 3.5 0.000075];                 %maximum frequency
Fmin=[0 0 0 0];                 %minimum frequency
A=rand(N,1);            %loudness for each BAT
r=rand(N,1);            %pulse emission rate for each BAT
alpha=0.5;              %constant for loudness update
gamma=0.5;              %constant for emission rate update
ro=0.001;                 %initial pulse emission rate

% Initializing arrays
F=zeros(N,1);           % Frequency
v=zeros(N,dim);           % Velocities
% Initialize the population
x=initializationBat(N,Max_iter,dim,ub,lb);
Convergence_curve=zeros(1,Max_iter);
%calculate the initial solution for initial positions

for ii=1:N
    fitness(ii)=FOB(x(ii,:));
end

[fmin,index]=min(fitness);          %find the initial best fitness value,
bestsol=x(index,:);                 %find the initial best solution for best fitness value
%%
iter=1;              % start the loop counter
while iter<=Max_iter                                         %start the loop for iterations
    for ii=1:size(x)                                            
        for j=1:4
            F(ii,j)=Fmin(j)+(Fmax(j)-Fmin(j))*rand;              %randomly chose the frequency
            v(ii,j)=v(ii,j)+(x(ii,j)-bestsol(j))*F(ii,j);
            x(ii,j)=x(ii,j)+v(ii,j);                             %update the velocity
        end
        %update the BAT position
        %         x(ii,:)=round(x(ii,:));
        % Apply simple bounds/limits
        Flag4up=x(ii,:)>ub;
        Flag4low=x(ii,:)<lb;
        x(ii,:)=(x(ii,:).*(~(Flag4up+Flag4low)))+ub.*Flag4up+lb.*Flag4low;
        %check the condition with r
        if rand>r(ii)
            % The factor 0.001 limits the step sizes of random walks
            %               x(ii,:)=bestsol+0.001*randn(1,dim);
            eps=-1+(1-(-1))*rand;
            x(ii,:)=bestsol+eps*mean(A);
        end
        fitnessnew=FOB(x(ii,:));  % calculate the objective function
        % Update if the solution improves, or not too loud
        if (fitnessnew<=fitness(ii)) && (rand<A(ii)) ,
            
            fitness(ii)=fitnessnew;
            A(ii)=alpha*A(ii);
            r(ii)=ro*(1-exp(-gamma*iter));
        end
        if fitnessnew<=fmin,
            bestsol=x(ii,:);
            fmin=fitnessnew;
        end
        
    end
    Convergence_curve(iter)=  fmin;
    
    iter=iter+1;                                  % update the while loop counter
end
%
[bestfit]=(fmin)
BestPositions=bestsol

end
