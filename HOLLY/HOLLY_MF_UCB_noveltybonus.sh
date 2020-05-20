#!/bin/bash

#$ -N MF_UCB_noveltybonus
#$ -e /data/mdubois/logs/
#$ -o /data/mdubois/logs/
#$ -t 1-625
#$ -S /bin/sh

# where to find basic custom functions
# where to find scripts for this job
model_path=/home/mdubois/scripts/28_02_modeling

# Run Matlab
# matlab_command="addpath('$model_path');global jobId;jobId=$SGE_TASK_ID;"
matlab_command="addpath('$model_path');sim_refit_UCB_3param_noveltybonus($SGE_TASK_ID);"
/share/apps/matlab -nojvm -nodesktop -nosplash -nodisplay -singleCompThread -r $matlab_command