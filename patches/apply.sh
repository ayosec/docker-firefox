#!/bin/bash

set -euo pipefail

if [ $# -ne 1 ]
then
  echo "Usage: $0 firefox-path"
  exit 1
fi

OMNIJAR="$1/browser/omni.ja"
WORKDIR=$(mktemp -d)
SOURCE=$(realpath "$(dirname "$0")")

# Extract omni.ja in WORKDIR and apply our patches
cd "$WORKDIR"
bsdtar -xf "$OMNIJAR"

for PATCH in "$SOURCE"/*.diff
do
  patch -p1 < "$PATCH"
done

# Repack the omni.ja file
mv -n "$OMNIJAR" "${OMNIJAR}.orig"
zip -0 -q -r -X -D "$OMNIJAR" .

rm -r "$WORKDIR"
