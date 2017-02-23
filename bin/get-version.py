#!/usr/bin/env python

import argparse
import os.path
import plistlib
import sys

import pprint

def parse_args(argv):
    if argv is None:
        argv = sys.argv[1:]

    parser = argparse.ArgumentParser(description="Reads SPM-compatible version from Info.plist")
    parser.add_argument("app_bundle", help="App bundle")
    return parser.parse_args(argv)

def main(argv=None):
    options = parse_args(argv)

    info_plist_name = os.path.join(options.app_bundle,
                                   "Contents",
                                   "Info.plist")
    info_plist = plistlib.readPlist(info_plist_name)
    version = info_plist["CFBundleShortVersionString"]

    # take the first 3 elements (drop the remaining)
    parts = version.split(".")[:3]

    # if there are fewer than 3 elements, tack on "0"s
    while len(parts) < 3:
        parts.append("0")

    # combine with "."s
    print ".".join(parts)

if __name__ == "__main__":
    sys.exit(main())
