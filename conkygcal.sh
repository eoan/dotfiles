#!/bin/bash
gcalcli/gcalcli --calendar aj --calendar ah21@st-andrews.ac.uk --calendar 'Holidays in United Kingdom' --nocolor agenda "$(date)" "$(date -d "+60 days")" | cut -c 1-3,5- --output-delimiter='${goto 67}' | cut -c 1-16,18- --output-delimiter='${goto 47}' | cut -c 1-28,31- --output-delimiter='${goto 99}' | cut -c 1-45,48- --output-delimiter='${goto 160}' | awk 'NF' | head -10
