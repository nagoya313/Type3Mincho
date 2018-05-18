#!/bin/bash

CMDNAME=`basename $0`

usage_exit() {
  echo "Usage: $CMDNAME [-c]" 1>&2
  exit 1
}

while getopts ncCh OPT
do
  case $OPT in
    n) SKIP_NAME="TRUE" ;;
    c) SKIP_CMAP="TRUE" ;;
    C) SKIP_CFF="TRUE" ;;
    h)  usage_exit ;;
    \?) usage_exit ;;
  esac
done

if [ ! -e name.org.xml ]; then
  ttx -o name.org.xml -t name SourceHanSerif-Regular.otf
else
  echo "skip generate name.org.xml"
fi

if [ ! -e cmap.org.xml ]; then
  ttx -o cmap.org.xml -t cmap SourceHanSerif-Regular.otf
else
  echo "skip generate cmap.org.xml"
fi

if [ ! -e cff.org.xml ]; then
  ttx -o cff.org.xml -t "CFF " SourceHanSerif-Regular.otf
else
  echo "skip generate cff.org.xml"
fi

if [ "$SKIP_CMAP" != "TRUE" ]; then
  ruby cmap.rb
fi

if [ "$SKIP_CFF" != "TRUE" ]; then
  ttx -o cff.diff.xml -t "CFF " ../font_work/Type3Mincho-Regular.otf
  ruby cff.rb
fi

ttx -o name.otf -m SourceHanSerif-Regular.otf name.new.xml
ttx -o cmap.otf -m name.otf cmap.new.xml
ttx -o Type3Mincho.otf -m cmap.otf cff.new.xml
