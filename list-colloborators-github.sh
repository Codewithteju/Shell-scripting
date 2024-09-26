#!/bin/bash
#
#
################
# About: This script is used to get colloborators info from GitHub repo
# Author: Somesh Teja Yerramsetty
# Version : V1
# Date: Sep 26, 2024
# Contact: someshteja.yerramsetty@gmail.com
################


# Function to help users in running script
function helper {
        expected_cmd_args=2
        if [ $# -ne $expected_cmd_args ];
        then
                echo "Please provide ${expected_cmd_args} cmd_arguments "
                exit 1
        fi
}

# Exit Running script if the user didn't provide required arguments
helper "$@"

# GitHub API URL

API_URL="https://api.github.com"

# Github Username and personal access token
USERNAME=$username
TOKEN=$token 

# User and Repository Information
REPO_OWNER=$1
REPO_REPOSITORY=$2


# Function to form API request for GitHub

function form_api_request {
	local endpoint="$1"
	local url="${API_URL}/${endpoint}"

	curl -s -u "${USERNAME}:${TOKEN}" "${url}"
}

# Function to list colloborators

function list_colloborators {
	
	local endpoint="repos/${REPO_OWNER}/${REPO_REPOSITORY}/colloborators"
	colloborators="$(form_api_request "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

	if [[ -z "$colloborators" ]];
	then
		echo "No Colloborators with read access found for ${REPO_OWNER}/${REPO_REPOSITORY}."
	else
		echo "Colloborators with read access to ${REPO_OWNER}/${REPO_REPOSITORY}."
	fi
	
}

echo "Listing Colloborators with read access to ${REPO_OWNER}/${REPO_REPOSITORY}..."

list_colloborators

