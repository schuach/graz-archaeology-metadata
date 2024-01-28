#!/usr/bin/env sh

for file in data/*.xml
do
    saxon-xslt -s:"$file" xslt/mbox2lido.xsl > data/output/"$(basename $file)"
done
