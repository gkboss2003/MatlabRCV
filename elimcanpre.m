function[adjustedvotes] = elimcanpre(olddata,elim)


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