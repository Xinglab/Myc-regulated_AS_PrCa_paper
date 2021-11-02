This is the example commands for custom scripts used to convert and filter rMATS output for PEGSASA.

#### Step1. Read rMATS turbo JC output and generate PSI matrix with coverage filtering
python generatePSIMatrix.py JC_list.txt events_list.txt sample_list.txt -o test

#### Step2. PSI matrix filtering by PSI values, delta PSI, and missing values.(std filtering is disabled)###
python filterSplicingMatrix.py cov10.splcing.merged_matrix.test.txt 0.95

