#!/bin/bash
git branch -m master main || { echo -n "Could not rename branch"; exit 1;}
git push -u origin main || { echo -n "Could not push branch: 'main'"; exit 1;}
git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main || { echo -n "Could not link head to branch: 'main'"; exit 1;}

echo -n "Please go to GitHub and change the default branch in your repo's settings."
echo -n "Ready to apply changes? ([Y]es/[n]o)"
read isReady

if [[ "${isReady,,}" == "y" || "${isReady,,}" == "yes" ]] 
then
  git push origin --delete master || { echo -n "Could not delete branch: 'master'"; exit 1; }
  echo -n "Successfully changed default branch to 'main'."
else
  echo -n "Must update default branch on GitHub to continue."
fi 
