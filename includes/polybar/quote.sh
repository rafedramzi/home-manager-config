#!/bin/bash

FILE=~/.config/polybar/quotes.txt
MOD=$(cat $FILE | wc -l)
RANDNUM=$(date +"%s")
LN=$(((RANDNUM % MOD) + 1))
awk 'NR=='$LN'{printf "%s", $0}' $FILE
#awk 'NR=='$LN'{print, $0}' ~/.config/polybar/quotes.txt
