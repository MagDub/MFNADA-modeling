function hf = NumHessianYtest(f,x0,varargin)
    
disp('in hessian')

    % Compute Hessian using numerical approximation.
    
    epsilon = 1e-7; % delta
    l_x0=length(x0); % length of x0;
    
    for i=1:l_x0
        x1 = x0;
        x1(i) = x0(i) - epsilon; 
        df1 = NumJacob(f, x1,varargin{:});
        
        x2 = x0;
        x2(i) = x0(i) + epsilon ;
        df2 = NumJacob(f, x2,varargin{:});
                 
        d2f = (df2-df1) / (2*epsilon);
        
        hf(i,:) = d2f';
    end
    
    disp(hf)
    disp(det(hf))
    
end

function df=NumJacob(f,x0,varargin)
    
    
    epsilon = 1e-8; % delta
    l_x0=length(x0); % length of x0;
    f0=feval(f,x0,varargin{:}); % caclulate f0
    
    for i=1:l_x0
        dx = [ zeros(i-1,1); epsilon; zeros(l_x0-i,1)];
        df(:,i) = ( feval(f,x0+dx',varargin{:}) - f0)/epsilon;
    end
end