#!/usr/bin/env bash

# set -x
set -euo pipefail
E_BADARGS=85

if [ "$#" -ne 1 ]
then
    echo "Usage $(basename $0) path-to-package"
    exit $E_BADARGS
fi

path_to_package="$1"
cd "$path_to_package"

name="$(basename $(pwd))"
hub create "SwiftScripting/$name"
git push -u origin master
git push origin --tags
