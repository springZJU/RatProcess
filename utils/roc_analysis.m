function result = roc_analysis(A, B, Thr)
    % Calculate ROC curves for each column of A and B
    [x,y,~,auc] = perfcurve([A;B],[ones(size(A,1),1);zeros(size(B,1),1)],1);
    
    % Calculate AUC vector C
    C = zeros(size(A,2),1);
    for i = 1:size(A,2)
        C(i) = auc(i);
    end
    
    % Fit Gaussian distribution to C
    [mu,sigma] = normfit(C);
    
    % Evaluate Gaussian CDF at threshold Thr
    result = normcdf(Thr,mu,sigma);
end