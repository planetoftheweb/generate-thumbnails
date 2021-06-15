#!/bin/bash

# Checks out each of your branches 
# copies the current version of 
# certain files to each branch

echo "==================================="

npm i -g @squoosh/cli

git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"

args_folder="${folder}"
args_width="${width}"

if [ "$push" = "true" ];
then
  args_width="true"
else
  args_push="false"
fi

args_[width]="${push}"

# Look for filesnames than end in jpg, but are not thumbnails
filenames=`find ./$args_folder/*.jpg ! -name '*_tn*'`

# Go through each file and remove files of they  already have thumbnails
for item in ${filenames[@]}
do
  [ -f ${item%.*}_tn.jpg ] && filenames=( "${filenames[@]/$item}" )
done

# Check out a new branch
if [ "$args_action" = "PUSH" ];
then
  git checkout -b thumbnails
fi

# Create the thumbnails
squoosh-cli $filenames -d ./$args_folder -s '_tn' --resize '{"enabled":true,"width":${args_width},"method":"lanczos3","fitMethod":"contain","premultiply":true,"linearRGB":true}' --mozjpeg '{"quality":75,"baseline":false,"arithmetic":false,"progressive":true,"optimize_coding":true,"smoothing":0,"color_space":3,"quant_table":3,"trellis_multipass":false,"trellis_opt_zero":false,"trellis_opt_table":false,"trellis_loops":1,"auto_subsample":true,"chroma_subsample":2,"separate_chroma_quality":false,"chroma_quality":75}'

# push the branch to the repository origin
if [ "$args_action" = "PUSH" ];
then
  git add -A && git commit -m "Generated Thumbnails"
  git push --set-upstream origin thumbnails
  git checkout main
  git branch -d thumbnails
fi

