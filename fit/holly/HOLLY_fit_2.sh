#!/bin/bash

#$ -N fit2
#$ -e /data/mdubois/logs/
#$ -o /data/mdubois/logs/
#$ -t 501-560
#$ -S /bin/sh

# where to find basic custom functions
# where to find scripts for this job
model_path=/home/mdubois/scripts/MFnada/MFNADA-Modeling/fit/holly

# Run Matlab
# matlab_command="addpath('$model_path');global jobId;jobId=$SGE_TASK_ID;"
matlab_command="addpath('$model_path');main_Holly2($SGE_TASK_ID);"
/share/apps/matlab -nojvm -nodesktop -nosplash -nodisplay -singleCompThread -r $matlab_command
