#!/bin/bash

#$ -N cv15
#$ -e /data/mdubois/logs/
#$ -o /data/mdubois/logs/
#$ -t 1-65
#$ -S /bin/sh

# where to find basic custom functions
# where to find scripts for this job
model_path=/home/mdubois/scripts/MFnada/MFNADA-Modeling/cv_heuristics/holly

# Run Matlab
# matlab_command="addpath('$model_path');global jobId;jobId=$SGE_TASK_ID;"
matlab_command="addpath('$model_path');HOLLY_main_15($SGE_TASK_ID);"
/share/apps/matlab -nojvm -nodesktop -nosplash -nodisplay -singleCompThread -r $matlab_command
