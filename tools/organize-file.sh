#!/bin/bash - 
#===============================================================================
#
#          FILE: organize-file.sh
# 
#         USAGE: ./organize-file.sh 
# 
#   DESCRIPTION: sort files to it's own directory.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: jiajun (), 
#  ORGANIZATION: 
#       CREATED: 2014年08月13日 18:31
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

cd ~/Downloads

mv *.pdf ~/Documents
