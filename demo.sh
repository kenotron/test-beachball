#!/bin/bash

. demo-magic.sh

pei "echo \"this is a demo of beachball\""

pei "git clone git@github.com:kenotron/test-beachball.git"

pei "cd test-beachball"

pei "yarn"

pei "echo \"look at the packages folder\""

pei "ls packages"

pei "echo \"look at package a's version\""

pei "jq \".version\" packages/a/package.json"

pei "echo \"`date`\" > packages/a/newfile.txt"

pei "git add ."

pei "git commit -m \"It's a new change!\""

pei "echo \"doing a beachball check at this point should FAIL\""

pei "yarn beachball check"

pei "echo \"we need to create a change file\""

pei "echo \"check out the new change file\""

pei "cat change/*.json"

pei "echo \"I have a local npm registry running, let's do a publish!\""

pei "yarn beachball publish --registry http://localhost:4873 --yes"

pei "npm info a --registry http://localhost:4873"

pei "jq \".version\" packages/a/package.json"

pei "head -14 packages/a/CHANGELOG.md"
