#!/usr/bin/env bash

# author: Vincent Dowling
# email: vdowlin@us.ibm.com
# since: 11/20/15
#
# usage: run.sh <path_to_service_cfg_file> <path_to_feature_config_file>
# description: Run the custom feature server

source_config_file () {
    local CFG_FILE=$1
    variable_exists "CONFIG_FILE" $CFG_FILE
    file_exists $CFG_FILE
    source $CFG_FILE
    variable_exists "SOLR_CLUSTER_ID" $SOLR_CLUSTER_ID
    variable_exists "SOLR_COLLECTION_NAME" $SOLR_COLLECTION_NAME
    variable_exists "RETRIEVE_AND_RANK_BASE_URL" $RETRIEVE_AND_RANK_BASE_URL
    variable_exists "RETRIEVE_AND_RANK_USERNAME" $RETRIEVE_AND_RANK_USERNAME
    variable_exists "RETRIEVE_AND_RANK_PASSWORD" $RETRIEVE_AND_RANK_PASSWORD
}


variable_exists () {
    local VARIABLE_NAME=$1
    local VARIABLE=$2
    if [ ! -n "$VARIABLE_NAME" ]; then
        echo "[unix] No variable name passed in..."
    fi
    if [ ! -n "$VARIABLE" ]; then
        echo "[unix] variable=$VARIABLE_NAME does not exist. Exiting with status code 1"
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


# Run the server
echo "[unix] script run.sh started..."
CONFIG_DIRECTORY="config"
ANSWER_DIRECTORY="answers"
directory_exists $CONFIG_DIRECTORY
directory_exists $ANSWER_DIRECTORY
SERVICE_CONFIG_FILE=$1
FEATURE_CONFIG_FILE=$2
echo "[unix] Source configuration_file=$SERVICE_CONFIG_FILE..."
source_config_file $SERVICE_CONFIG_FILE
file_exists $FEATURE_CONFIG_FILE
echo "[unix] Running server ..."
python server.py --host=0.0.0.0 --port=9216 --feature-json-file=$FEATURE_CONFIG_FILE \
    --cluster-id=$SOLR_CLUSTER_ID --collection-name=$SOLR_COLLECTION_NAME --answer-directory=$ANSWER_DIRECTORY \
    --service-url=$RETRIEVE_AND_RANK_BASE_URL --service-username=$RETRIEVE_AND_RANK_USERNAME --service-password=$RETRIEVE_AND_RANK_PASSWORD \
    --debug
