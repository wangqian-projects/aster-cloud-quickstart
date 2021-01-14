#!/bin/bash
# fileName: host-append.sh
# verion: 1.0.0.RELEASE
# author:wangqian
# append host config
# env: windows
# C:\Windows\System32\drivers\etc\hosts

hostFile="C:\\Windows\\System32\\drivers\\etc\\hosts"
echo "$hostFile"
cat host.txt
echo "  " >> $hostFile
echo "  " >> $hostFile
echo "# host-update.sh $(date +%Y-%m-%d\ %H:%M:%S)" >> $hostFile
cat host.txt >> $hostFile