#!/bin/bash

while read oldrev newrev refname; do
  # R10K
  if [[ $refname =~ 'refs/heads/' ]]; then
    branch=$(git rev-parse --symbolic --abbrev-ref $refname)
    if [[ $newrev = '0000000000000000000000000000000000000000' ]]; then
      echo "r10k removing $branch environment"
      cssh --use-all-a-records r10k -l r10k --action r10k deploy environment $branch
    else
      files=$(git diff-tree -r --name-only --no-commit-id ${oldrev}..${newrev})
      if grep -q 'Puppetfile' <<<"$files"; then
        echo "r10k updating $branch environment and modules"
        cssh --use-all-a-records r10k -l r10k --action r10k deploy environment $branch -p
      else
        echo "r10k updating $branch environment"
        cssh --use-all-a-records r10k -l r10k --action r10k deploy environment $branch
      fi
    fi
  else
    echo "r10k skipping $refname"
  fi
done
