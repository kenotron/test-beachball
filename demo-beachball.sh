#!/bin/bash

## This is a "walk thru version"

. demo-magic.sh

WORKING_DIR=test-beachball

if [ -d "$WORKING_DIR" ]; then rm -Rf $WORKING_DIR; fi

pe "git clone git@github.com:kenotron/test-beachball.git      # first, let's git clone the demo repo"

pei "cd test-beachball"
pei "yarn"

pe "ls packages     # what's inside packages?"

pe "jq \".version\" packages/a/package.json     # let's see what version is a"

pe "echo \"`date`\" > packages/a/newfile.txt     # making some change in package a"

pe "git checkout -b modify-a     # let's create a \"feature branch\""

pe "git add . && git commit -m \"It's a new change!\"     # commit the change, note the comment"

pe "gh pr create --fill --web    # this creates a new PR (opens browser) but it should *fail* on beachball check"

pe "yarn beachball change    # creates a new change file"
pe "cat change/*.json"

pe "git push    # let's push to github again to see it succeed"

pe "echo \"with a local npm registry running, let's do a publish!\""

pei "git checkout master && git pull    # let's try publishing to a local npm registry"

pe "yarn beachball publish --registry http://localhost:4873 --yes"

pei "git pull    # do a git pull to update things"

pe "npm info a --registry http://localhost:4873"

pe "jq \".version\" packages/a/package.json     # this should be updated!"

pe "head -14 packages/a/CHANGELOG.md     # an entry should also have been written in CHANGELOG.md"
