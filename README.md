# MatlabRCV
This is a MATLAB Script and associated functions that can be used to tabulate the result of a ranked choice election. 

This script allows for any number of candidates greater than 2, as well as a maximum number of candidates a voter can vote for.

Your voter data should be a .csv file with only 1 sheet. All the data should be an integer. This may require you to convert your
source data to be similar to that found in the sample "RandomVotes.CSV" file in this repository. This script and all its functions
should be located in the same directory as your voter data to function properly.

If you find anything you'd like me to add, please submit a feature request
Same goes for bugs, please let me know!

This script handles ballots per Maine's Ranked Choice Voting legislation. Details can be found [here](https://www.maine.gov/sos/cec/elec/upcoming/pdf/250c535-2018-230-complete.pdf)

The only thing it does not handle at the moment is Two Consecutive Skipped rankings, this is currently being worked on. 
