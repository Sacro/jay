#!/usr/bin/bash

if [ ! -d nvm ]; then
    export NVM_DIR="${PWD}/nvm" && (
        git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
        cd "$NVM_DIR"
        git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    ) && \. "$NVM_DIR/nvm.sh"
    nvm install node
fi

NODE_PATH=./$(ls -d nvm/versions/node/*/bin | tail -1)
export PATH=${PATH}:${NODE_PATH}

mkdir node
npm i --package-lock-only --force --prefix node
nvm use --delete-prefix v19.2.0

npm install mapshaper --prefix node
npm audit fix --force --prefix node
npm audit fix --prefix node
