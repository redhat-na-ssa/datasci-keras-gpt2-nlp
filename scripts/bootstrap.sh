#!/bin/bash
# shellcheck disable=SC2015,SC1091,SC2119,SC2120
set -e

################# standard init #################

check_shell(){
  [ -n "$BASH_VERSION" ] && return
  echo "Please verify you are running in bash shell"
  sleep 10
}

check_git_root(){
  if [ -d .git ] && [ -d scripts ]; then
    GIT_ROOT=$(pwd)
    export GIT_ROOT
    echo "GIT_ROOT: ${GIT_ROOT}"
  else
    echo "Please run this script from the root of the git repo"
    exit
  fi
}

get_script_path(){
  SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
  echo "SCRIPT_DIR: ${SCRIPT_DIR}"
}


check_shell
check_git_root
get_script_path


is_sourced() {
  if [ -n "$ZSH_VERSION" ]; then
      case $ZSH_EVAL_CONTEXT in *:file:*) return 0;; esac
  else  # Add additional POSIX-compatible shell names here, if needed.
      case ${0##*/} in dash|-dash|bash|-bash|ksh|-ksh|sh|-sh) return 0;; esac
  fi
  return 1  # NOT sourced.
}

################# misc fucntions ################

ocp_check_login(){
  oc cluster-info | head -n1
  oc whoami || exit 1
  echo
}

ocp_check_info(){
  ocp_check_login

  echo "NAMESPACE: $(oc project -q)"
  sleep "${SLEEP_SECONDS:-8}"
}

apply_firmly(){
  if [ ! -f "${1}/kustomization.yaml" ]; then
    echo "Please provide a dir with \"kustomization.yaml\""
    return 1
  fi

  until_true oc apply -k "${1}" 2>/dev/null
}

until_true(){
  echo "Running:" "${@}"
  until "${@}" 1>&2
  do
    echo "again..."
    sleep 20
  done

  echo "[OK]"
}

check_cluster_version(){
  OCP_VERSION=$(oc version | sed -n '/Server Version: / s/Server Version: //p')
  AVOID_VERSIONS=()
  TESTED_VERSIONS=("4.12.12" "4.12.33" "4.13.13")

  echo "Current OCP version: ${OCP_VERSION}"
  echo "Tested OCP version(s): ${TESTED_VERSIONS[*]}"
  echo ""

  # shellcheck disable=SC2076
  if [[ " ${AVOID_VERSIONS[*]} " =~ " ${OCP_VERSION} " ]]; then
    echo "OCP version ${OCP_VERSION} is known to have issues with this demo"
    echo ""
    echo 'Recommend: "oc adm upgrade --to-latest=true"'
    echo ""
  fi
}

################ demo functions ################


usage(){
echo "
You can run individual functions!

example:
  setup_demo
  delete_demo
"
}

setup_demo(){
  check_cluster_version
  apply_firmly prereqs
  usage
}

delete_demo(){
  echo "WARNING: This will remove operators and other compoents!"
  echo "WARNING: Manually clean up on a cluster that is not a vanillia install"
  echo "Hit <CTRL> + c to abort"
  sleep "${SLEEP_SECONDS:-8}"

  oc delete --wait -k prereqs/03-namespaces
  oc delete --wait -k prereqs/02-autoscale
  oc delete --wait -k prereqs/01-operator-configs
  oc delete --wait -k prereqs/00-operators
}

is_sourced && check_shell && return

ocp_check_login

setup_demo
