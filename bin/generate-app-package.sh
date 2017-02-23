#!/usr/bin/env bash

# set -x
set -euo pipefail
E_BADARGS=85

if [ "$#" -ne 2 ]
then
    echo "Usage $(basename $0) path-to-app package-name"
    exit $E_BADARGS
fi

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
path_to_app="$1"
package_name="$2"

package_dir="build/$package_name"
app_version=$("$script_dir/get-version.py" "$path_to_app")

echo "Generating Swift interface for $path_to_app $app_version"

mkdir -p "$package_dir"
cd "$package_dir"
swift package init --type library

rm -rf "Tests"
cd "Sources"

sdef "$path_to_app" > "$package_name.sdef"
sdp -fh --basename "$package_name" "$package_name.sdef"
"$script_dir/sbhc.py" "$package_name.h"

rm "$package_name.h"
rm "$package_name.sdef"

cd ".."

swift build

git init
git add .
git commit -am "Generated interface for $path_to_app $app_version"
git tag "$app_version"
