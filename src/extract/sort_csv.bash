#!/bin/bash

sed -E '
s/monday/wd0/
s/tuesday/wd1/
s/wednesday/wd2/
s/thursday/wd3/
s/friday/wd4/
s/saturday/wd5/
s/sunday/wd6/
' $@ | sort --field-separator="," --key=1,1 --key=2n,2n --key=3n,3n | sed -E '
s/wd0/monday/
s/wd1/tuesday/
s/wd2/wednesday/
s/wd3/thursday/
s/wd4/friday/
s/wd5/saturday/
s/wd6/sunday/
'
