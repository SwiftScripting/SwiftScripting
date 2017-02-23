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
info_plist="$path_to_app/Contents/Info.plist"
app_version=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$info_plist")

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

cat << EOF > "Package.swift"
import PackageDescription

let package = Package(
    name: "$package_name"
)

EOF

git init
git add .
git commit -am "Generated interface for $path_to_app $app_version"
git tag "$app_version"
