function[adjustedvotes,elim] = elimcanv2(olddata,results)

sorted = sort(results);

for i=1:size(sorted,2)
    if sorted(1,i) > 0
        low(1) = sorted(1,i);
        tick = i+1;
        counter = 2;
        while true
            if sum(sorted(1,1:tick)) < sorted(1,tick+1)
                low(counter) = sorted(1,tick);
            else
                break
            end
            counter = counter + 1;
            tick = tick + 1;
        end
        break
    end
end

elim = zeros(1,size(low,2));

for i=1:size(low,2)
    for k=1:size(results,2)
        if low(1,i) == results(1,k)
            elim(i) = k;
            break
        end
    end
end

adjustedvotes = olddata;
for a=1:size(elim,2)
    for i=1:size(olddata,1)
        for j=1:size(olddata,2)
            if olddata(i,j) == elim(a)
                for k=j:size(adjustedvotes,2)-1
                    adjustedvotes(i,k) = adjustedvotes(i,k+1);
                end
                adjustedvotes(i,end) = 0;
            end
        end
    end
end

