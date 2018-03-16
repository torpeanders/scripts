#!/bin/bash

# Start a watch on your source directory before compiling your code/project.
# When the compilation is done, hit enter and get a list of the chS files 
# accessed during the build. I use this to get a cscope.files with only the
# relevant files for my linux/u-boot builds

WATCHED_DIR=$1
OUTFILE=$2

echo "Watching directory: $WATCHED_DIR"
inotifywait -r -m -e access "$WATCHED_DIR" --format "%w%f" > $OUTFILE.tmp &
INWJOB=$!
read -p "Press [Enter] key when done watching..."
kill $INWJOB
sort -u $OUTFILE.tmp | grep -aE '\.([ch](pp)?|S)$' | grep -v '/_build' > $OUTFILE

