function [results,majority,winner] = votingcalculation(votedata,candidates)
roundvotes = 0;
% roundvotes = size(votedata,1);
for i=1:size(votedata,1)
    if votedata(i,1) >0
        roundvotes = roundvotes+1;
    end
end

results = zeros(1,candidates);

if roundvotes/2 == round(roundvotes/2)
    majority = roundvotes/2 + 1;
%     disp("Hi")
else
    majority = roundvotes/2 + 0.5;
%     disp("wrong")
end

for i=1:size(votedata,1)
    if votedata(i,1) > 0
    results(1,votedata(i,1)) = results(1,votedata(i,1)) + 1;
    end
end


winner = 0;
for i=1:candidates
    if results(1,i) >= majority
        winner = i;
    end
end

end