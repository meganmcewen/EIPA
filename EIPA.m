%constants
L = 50; %size of matrix in x (nx)
W = 50; %size of matrix in y (ny)
iter = 500; %number of iterations
V0 = 2; %initial velocity

%create initial matrices
G = sparse(L*W,L*W);
F = zeros(L*W,1);

%generate G matrix
for x = 1:L
    for y = 1:W
        
    %mapping equation
    n = y + (x-1) * W;

    %local mapping
    nxm = y+(x-2)*W;
    nxp = y+(x)*W;
    nym = (y-1)+(x-1)*W;
    nyp = (y+1)+(x-1)*W;

        if(x ==1)
            G(n,n) = 1;
            F(n) = 1;
        elseif (x==L)
            G(n,n) = 1;
            F(n) = 1;
        elseif (y ==1)
            G(n,n) = 1;
        elseif(y ==W)
            G(n,n) = 1;
        %elseif(y>10&y<20&x<20&x>10) %include this to see how changing G
                                     %matrix affects results
            %G(n,n) = -2;
        else
           G(n,nxm) = 1;
           G(n,n) = -4;
           G(n,nxp) = 1;
           G(n,nym) = 1;
           G(n,nyp) = 1;
        end
    end
end

 V = G\F;

% %populate V matrix solution
 for (x = 1:L)
     for (y = 1:W)
         n = y + (x-1) * W;
         VMatrix(x,y) = V(n);
     end
 end

[E,D] = eigs(G,9,'SM');
Evals = diag(D);

%plots
%plot G
figure(10)
spy(G);

%plot eigenvalues
figure(11)
plot(Evals);

%plot eigenvectors
figure(12)
surf(VMatrix);

%get remapped values and plot all 9 solutions
n = 1;
while n < 10
for (x = 1:L)
    for y = 1:W
        M(x,y) = E(y+((x-1)*W),n);
    end
end
figure(n)
surf(M);
n = n+1;
end
