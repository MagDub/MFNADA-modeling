#!/bin/bash

#$ -N cv12
#$ -e /data/mdubois/logs/
#$ -o /data/mdubois/logs/
#$ -t 72000-78125
#$ -S /bin/sh

# where to find basic custom functions
# where to find scripts for this job
model_path=/home/mdubois/scripts/28_02_modeling

# Run Matlab
# matlab_command="addpath('$model_path');global jobId;jobId=$SGE_TASK_ID;"
matlab_command="addpath('$model_path');sim_refit_thompson_3param_noveltybonus_parhor($SGE_TASK_ID);"
/share/apps/matlab -nojvm -nodesktop -nosplash -nodisplay -singleCompThread -r $matlab_command