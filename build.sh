#!/bin/bash

set -Eu

cd $(dirname $0)

function test () {
  for file in `ls data/`; do
    dir=`pwd`/data
    local all_line_cnt=`cat ${dir}/${file} | grep -c ^`
    echo "file: ${file}, word count: ${all_line_cnt}" 

    local ng_line=`cat ${dir}/${file} | grep -n -v ".\+"$'\t'".\+"$'\t'".\+"`
    if [ `echo -n "${ng_line}" | grep -c ^` -eq 0 ]; then
      echo "  test ok"
    else
      local ng_line_cnt=`echo "${ng_line}" | grep -c ^`
      echo "  test failed. ng: ${ng_line_cnt}"
      echo "[detail]"
      echo "${ng_line}"
    fi
  done
}

function build () {
  cat data/*.tsv > starwing-ime-dictionary.txt
}

test
build
