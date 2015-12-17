#!/usr/bin/env bash

# author: Vincent Dowling
# email: vdowlin@us.ibm.com
#
# usage: bin/install.sh
# description: Install dependencies to run


configure_python () {
    # Does python exist and is it of the proper version?
    if [ ! -x "$(which python)" ]; then
        echo "[unix] python is not installed. Please install python"
        echo "[unix] Exiting with status code 1"
        exit 1
    fi
    PYTHON_VALID=$(python -c "import sys; vi = sys.version_info; valid = 'VALID' if vi.major == 2 and vi.minor >= 7 else 'NOT';print valid")
    if [ "$PYTHON_VALID" != "VALID" ]; then
        echo "[unix] Python is not the proper version. Please update python to version 2.7"
        echo "[unix] Exiting with status code 1"
        exit 1
    fi

    # Does pip exist and is it the right version?
    if [ ! -x "$(which pip)" ]; then
        echo "[unix] pip is not installed. Please install python"
        echo "[unix] Exiting with status code 1"
        exit 1
    fi
    PIP_VALID=$(python -c "import pip, re;m = re.match('^([0-9]{1})[.][0-9]{1}[.][0-9]{1}$', pip.__version__);major = int(m.group(1)) if m else 0;valid = 'VALID' if major >= 6 else 'NOT_VALID'; print valid")
    if [ "$PIP_VALID" != "VALID" ]; then
        echo "[unix] pip is not of the proper version. Please update pip to version 6 or higher"
        echo "[unix] Exiting with status code 1"
        exit 1
    fi
}

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
