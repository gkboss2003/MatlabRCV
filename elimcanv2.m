function[adjustedvotes,elim] = elimcanv2(olddata,results)

sorted = sort(results);
for i=1:size(sorted,2)
    if sorted(1,i) > 0
        low = sorted(1,i);
        break
    end
end

i=1;
found = 0;
while found == 0
    if results(1,i) == low
        elim = i;
        found = 1;
    else
        i = i+1;
    end
end

adjustedvotes = olddata;

for i=1:size(olddata,1)
    for j=1:size(olddata,2)
        if olddata(i,j) == elim
            for k=j:size(adjustedvotes,2)-1
                adjustedvotes(i,k) = adjustedvotes(i,k+1);
            end
            adjustedvotes(i,end) = 0;
        end
    end
end
