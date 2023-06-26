clc;
clear;
candidates = input("How many candidates receieved votes? -> ");
maxcan = input("How many candidates can a voter vote for? -> ");
while maxcan > candidates
    disp("Cannot be more than the total number of candidates")
    maxcan = input("How many candidates can a voter vote for? -> ");
end
xlfile = input("What is the name of your excel file? -> ",'s');
xlrange = input("What range is your data located? " + ...
    "Votes will only be counted from the range you select ->  ",'s');
xlfile = append(xlfile,'.csv');
dataold = readtable(xlfile,"Range",xlrange);
startdata = table2array(dataold);
originalcolumns = size(startdata,2);

for i=1:size(startdata,1)
    for j=1:size(startdata,2)
        if isnan(startdata(i,j))
            startdata(i,j) = 0;
        end
    end
end

% begin data validation

% check for valid candidates(can.) ie. can. 6 receiving votes in a 5 can.
% election

if size(startdata,2) > maxcan
    error('Some voters may have voted for too many candidates\nPlease ensure you have selected the correcet range\nDo not select any empty rows!','A1')
end

for i=1:size(startdata,1)
    for j=1:size(startdata,2)
        if startdata(i,j) > candidates
            disp(i)
            error("An invalid candidate has received a vote\nPlease ensure all votes are at or below the max # of candidates",'A1')
        end
    end
end

% checks for multiple votes cast for same candidate by single voter, cleans
% if so
dupecount = 0;

for k=1:size(startdata,1)
    tick = 1;
    elimpos = 0;
    for i=2:maxcan
        for j=1:tick
            if startdata(k,i) == startdata(k,j)
                elimpos = i;
                dupecount = dupecount + 1;
                break
            end
        end
        if elimpos > 0
            break
        end
        tick = tick + 1;
    end
    if elimpos > 0
        for i=elimpos:maxcan
            startdata(k,i) = 0;
        end
    end
end
fprintf("%g voters voted for the same candidate more than once\n",dupecount)

% checks for gaps in votes ie. [1 3 0 5 3] and fixes
gapcount = 0;
for i=1:size(startdata,1)
    for j=1:maxcan
        if startdata(i,j) == 0 && sum(startdata(i,j+1:end)) > 0
            for k=j:(size(startdata,2)-1)
                startdata(i,k) = startdata(i,k+1);
            end
            startdata(i,end) = 0;
            gapcount = gapcount + 1;
        end
    end
end
fprintf("There were %g gaps that were fixed\n",gapcount)

% end data validation

% allows for eliminating a candidate before the election
eliming = true;
while eliming == true 
    preelim = input("Candidate to eliminate before tabulation (0 for none) -> ");
    if preelim > 0
        startdata = elimcanpre(startdata,preelim);
        fprintf("Candidate %g eliminated\n",preelim)
    elseif preelim == 0
        eliming = false;
    end
end

% Begins tabulation
winner = 0;
ongoingdata = startdata;
roundnum = 1;
results = zeros(candidates,candidates);
majcounter = zeros(candidates,1);

while winner == 0
    roundelim = 0;
    [roundresults,roundmajority,winner] = votingcalculation(ongoingdata,candidates);
    results(roundnum,:) = roundresults;
    majcounter(roundnum,1) = roundmajority;
    if winner > 0
        break
    end
    fprintf("\n\nRound %g calculated\n",roundnum)
    fprintf("Round %g majority was %g\n",roundnum,roundmajority)
    [newdata,roundelim] = elimcanv2(ongoingdata,roundresults);
    if size(roundelim,2) > 1
        fprintf("Multiple candidates were eliminated in round %g\n",roundnum)
        fprintf("Candidate %g was eliminated\n",roundelim)
        disp("Results are displayed below")
    else
        fprintf("Candidate %g was eliminated in round %g, results are displayed below\n",roundelim,roundnum)
    end
    disp(roundresults)
    ongoingdata = newdata;
    roundnum = roundnum + 1;
end
fprintf("Candidate %g has won the election in round %g\n",winner,roundnum)
fprintf("The majority was %g\n",roundmajority)
disp(roundresults)
disp("Total results are displayed below")
disp(results(1:roundnum,:));












