#!/bin/bash

cd ./BOF/Kerberoast/SOURCE
make
cd .. # ./BOF/Kerberoast/
mkdir artifacts
mv *.o ./artifacts/
echo
pwd
ls -l
echo
VERSION=$(git describe --tags --abbrev=0)
cat extension.json | jq ".version |= \"$VERSION\"" > ./artifacts/extension.json
cd artifacts # ./BOF/Kerberoast/artifacts/
echo
pwd
ls -l
echo

MANIFEST=$(cat ./artifacts/extension.json | base64 -w 0)
COMMAND_NAME=$(cat ./artifacts/extension.json | jq -r .command_name)
tar -czvf ../../../packages/$COMMAND_NAME.tar.gz .
cd ../../../packages
echo
pwd
ls -l
bash -c "echo \"\" | ~/minisign -s ~/minisign.key -S -m ./$COMMAND_NAME.tar.gz -t \"$MANIFEST\" -x $COMMAND_NAME.minisig"