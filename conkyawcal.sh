#!/bin/bash
gcalcli/gcalcli --calendar 'AW Rota' --nocolor agenda "$(date -d "-8 hours")" "$(date -d "+24 days")" | cut -c 1-3,5- --output-delimiter='${goto 67}' | cut -c 1-16,18- --output-delimiter='${goto 47}' | cut -c 1-28,40- --output-delimiter='${goto 99}' | awk 'NF' | head -10
