#!/bin/bash

#$ -N cv5
#$ -e /data/mdubois/logs/
#$ -o /data/mdubois/logs/
#$ -t 501-560
#$ -S /bin/sh

# where to find basic custom functions
# where to find scripts for this job
model_path=/home/mdubois/scripts/28_02_modeling

# Run Matlab
# matlab_command="addpath('$model_path');global jobId;jobId=$SGE_TASK_ID;"
matlab_command="addpath('$model_path');cv_mod3_hybrid_4param_nov_both_2Hor_1w_2eta_1Q0($SGE_TASK_ID);"
/share/apps/matlab -nojvm -nodesktop -nosplash -nodisplay -singleCompThread -r $matlab_command