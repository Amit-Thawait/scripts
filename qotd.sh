#!/bin/bash

function rand {
    number=$RANDOM
    range=${1}
    let "number %= ${range}"
    echo $number
}

randomizer=$(rand 4)

declare -x server=("qotd.nngn.net" "qotd.atheistwisdom.net" "ota.iambic.com" "alpha.mike-r.com" "electricbiscuit.org")

declare -A server_ports
server_ports["qotd.nngn.net"]=17
server_ports["qotd.atheistwisdom.net"]=17
server_ports["ota.iambic.com"]=17
server_ports["alpha.mike-r.com"]=17
server_ports["electricbiscuit.org"]=17

server_name=${server[$randomizer]}
port=${server_ports[$server_name]}

telnet $server_name $port
