#!/bin/bash

function cdWin () {
    win_path="$1"
#    echo win_path: $win_path
    partition=${win_path:0:1}
#    echo partition: $partition
    body=${win_path:3}
    body=${body//\\/\/}
#    echo body: $body
    unix_path="/$partition/$body"
#    echo unix_path: $unix_path
    cd "$unix_path"
}
cdWin "$1"
