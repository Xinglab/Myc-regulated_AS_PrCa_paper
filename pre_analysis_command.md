This is the custom script for converting and filtering rMATS output. The output of this step was used as PEGASAS input in the paper.

###Step1. Read rMATS turbo JC output and generate PSI matrix with coverage filtering###
python generatePSIMatrix.py JC_list.txt events_list.txt sample_list.txt -o test

###Step2. PSI matrix filtering by PSI values, delta PSI, and missing values.(std filtering is disabled)###
python filterSplicingMatrix.py cov10.splcing.merged_matrix.test.txt 0.95

