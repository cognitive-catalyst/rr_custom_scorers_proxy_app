#!/usr/bin/env bash

# author: Vincent Dowling
# email: vdowlin@us.ibm.com
#
# usage: bin/install.sh
# description: Install dependencies to run


file_exists () {
    local FILE=$1
    if [ ! -e $FILE ]; then
        echo "[unix] file=$FILE does not exist. Exiting with status code 1"
        exit 1
    fi
}


directory_exists () {
    local DIR_NAME=$1
    if [ ! -d "$DIR_NAME" ]; then
        echo "[unix] directory=$DIR_NAME does not exist. Exiting with status code 1"
        exit 1
    fi
}

set -e
LIB_DIRECTORY=lib
RR_SCORERS_WHEEL=$LIB_DIRECTORY/rr_scorers-1.0-py2-none-any.whl
file_exists $RR_SCORERS_WHEEL
echo "[unix] Installing wheel=$RR_SCORERS_WHEEL..."
pip install $RR_SCORERS_WHEEL
echo "[unix] Installing requirements from requirements.txt..."
pip install -r requirements.txt
echo "[unix] Installing spacy..."
pip install --upgrade spacy
python -m spacy.en.download all
python bin/validate_dependencies.py
echo "[unix] Dependencies installed successfully!"
echo "[unix] Exiting with status code 0"
exit 0
