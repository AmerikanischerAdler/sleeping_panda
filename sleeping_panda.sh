#!/bin/bash

#Safety
set -euo pipefail
IFS=$'\n\t'

# Foreground colors
RED="$(printf '\033[31m')"  
GREEN="$(printf '\033[32m')"  
YELLOW="$(printf '\033[33m')"  
BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  
CYAN="$(printf '\033[36m')"  
WHITE="$(printf '\033[37m')" 
BLACK="$(printf '\033[30m')"

# Background colors
REDBG="$(printf '\033[41m')"  
GREENBG="$(printf '\033[42m')"  
YELLOWBG="$(printf '\033[43m')"  
BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  
CYANBG="$(printf '\033[46m')"
WHITEBG="$(printf '\033[47m')" 
BLACKBG="$(printf '\033[40m')"
RESETBG="$(printf '\e[0m\n')"

# Script termination
exit_on_signal_SIGINT() {
    { printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Interrupted." 2>&1; reset_color; }
    exit 0
}

exit_on_signal_SIGTERM() {
    { printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Terminated." 2>&1; reset_color; }
    exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

reset_color() {
    tput sgr0
    tput op
    return
}

# Dependencies Installation
dep_install() {
    # install brew, poppler
    echo "Installing Dependencies..."
    echo ""
    sleep 1
    echo "Installing Brew..."
    echo ""

    if [ $(brew help 2> /dev/null | wc -l) > 0 ]; then 
        echo "Brew already Installed"
        sleep 1
    else
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Brew Installed"
        sleep 1
    fi

    echo ""
    echo "Installing poppler..."
    brew install poppler
    sleep 1

    echo ""
    echo "All Dependencies successfully Installed!"
    sleep 1
    echo ""
    echo "Firing up Sleeping Panda..."
    sleep 2

}

# Banners
banner() {
    clear
    cat << EOF
        ${WHITE} 
        ${CYAN} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ${CYAN} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣄⡀⠀⠀⠀⠀
        ${CYAN} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⠀⠀
        ${CYAN} ⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠻⠿⠿⢿⣿⣿⣿⣷⡄
        ${CYAN} ⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣯⡉⢹⣷⡶⢀⣼⡿⠋⣠⣿⣿⣿⣿⣿⣿
        ${CYAN} ⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⠟⠛⠻⣿⠋⠀⠀⢹⣿⠏⠰⢿⡟⠀⠿⣿⠀⠼⠟⣿⣿⣿⣿⣿⡏
        ${CYAN}    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣧⣤⣴⣿⣧⣄⣠⣼⣿⣿⣶⣾⣿⣶⣶⣿⣶⣶⣶⣿⣿⣿⡿⠋⠀
        ${CYAN} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠈⠉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠛⠉⠀⠀⠀
        ${CYAN} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡟⠛⠛⠛⠿⠿⠿⠿⠿⠿⠿⠛⠛⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀
        ${CYAN} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ${WHITE} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣰⣿⣶⣤⣬⡁⠀⠀⠀⣀⣠⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ${WHITE} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⣠⣤⣶⣶⣦⣤⡀⢀⣠⣤⣶⡶⠾⠿⠛⠙⠉⠛⠛⠛⠻⠶⣾⣿⣿⣿⣿⣿⣷⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ${WHITE} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⣿⣿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ${WHITE} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ${WHITE} ⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ${WHITE} ⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ${WHITE} ⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⢀⣾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ${WHITE}    ⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣶⡀⠀⢀⣠⣿⠇⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣤⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣶⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ${WHITE}    ⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⢻⡟⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀
        ${WHITE}    ⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⣿⠃⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⡿⠿⠿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀
        ${WHITE}    ⠀⠀⠀⠀⠀⠀⠈⣻⡿⠋⠀⠀⠀⠀⠀⢰⣿⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣭⣭⣽⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⢻⣇⠀⠀⠀⠀⠀⠀
        ${WHITE}    ⠀⠀⠀⠀⠀⠀⢸⡿⠁⠀⠀⠀⠀⠀⠀⠈⣿⡀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⣤⣤⣴⣶⡆⠈⠙⠻⠿⣿⡿⠟⠃⠀⣿⡇⠀⠀⠀⠀⠀
        ${WHITE}    ⠀⠀⠀⠀⠀⠀⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⢹⣧⠀⠀⠀⠀⠀⠀⠈⠻⢿⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠉⠛⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠇⠀⠀⠀⠀⠀
        ${WHITE}    ⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣦⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⡏⠀⠀⠀⠀⠀⠀
        ${WHITE}    ⢀⣴⣿⣿⣷⣶⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣶⣤⣤⣤⣤⣤⣤⣤⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⣿⣄⡀⠀⠀⠀⠀⠀
        ${WHITE}    ⢸⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀
        ${WHITE}    ⠘⢿⣿⣿⣿⣿⣿⣿⣷⣤⣤⣤⣤⣤⣤⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⣀⣀⣤⣤⣴⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀
        ${WHITE}    ⠀⠀⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠙⠛⠛⠛⠻⠛⠛⠛⠛⠋⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀
        ${WHITE} 
        ${CYAN}   ______ _                    _                ______                 _
        ${CYAN}  / _____) |                  (_)              (_____ \               | |
        ${CYAN} ( (____ | | _____ _____ ____  _ ____   ____    _____) )____ ____   __| |_____
        ${CYAN}  \____ \| || ___ | ___ |  _ \| |  _ \ / _  |  |  ____(____ |  _ \ / _  (____ |
        ${CYAN}  _____) ) || ____| ____| |_| | | | | ( (_| |  | |    / ___ | | | ( (_| / ___ |
        ${CYAN} (______/ \_)_____)_____)  __/|_|_| |_|\___ |  |_|    \_____|_| |_|\____\_____|
        ${CYAN}                        |_|           (_____|
        ${WHITE}                                                [ ${WHITE}PDF to AudioBook Converter ${WHITE}]
        ${WHITE} 
EOF
}

small_banner() {
    clear
    cat << EOF
        ${WHITE} 
        ${CYAN} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀
        ${CYAN} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀
        ${CYAN} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⡿⣿⠟⢿⡯⣿⢫⡗⣴⣿⣿⡇
        ${CYAN} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⣶⣾⣦⣾⣷⣿⣶⣷⣾⠿⠋⠀
        ${CYAN} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⡉⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀
        ${WHITE} ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣤⣄⣠⠤⠴⠞⠓⠶⠤⣶⣶⣶⡄⠀⠀⠀⠀⠀
        ${WHITE} ⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⡟⠀⠀⠀⠀⠀
        ${WHITE} ⠀⠀⠀⠀⠀⠀⠀⠀⡻⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⠀⠀⠀⠀⠀
        ${WHITE} ⠀⠀⢠⣾⣿⣶⡤⢴⠁⠀⠀⣠⣴⣶⣦⣄⠀⠀⠀⢠⣾⣿⣿⡄⠀⠀⠀⠀
        ${WHITE} ⠀⠀⠘⣿⠋⠁⠀⣿⠀⠀⢸⣿⣿⣟⣻⣿⠇⠀⠀⠘⢿⣯⣽⣿⣆⠀⠀⠀
        ${WHITE} ⠀⠀⢰⠃⠀⠀⠀⢹⠀⠀⠀⠻⠿⠿⠿⠋⠀⠀⠻⠛⠀⠉⠉⠁⣸⠀⠀⠀
        ${WHITE} ⣤⣶⣼⡀⠀⠀⠀⣼⣿⣷⣶⣤⣤⣤⣤⡀⠀⠀⠀⠀⠀⠀⣀⣴⣧⡀⠀⠀
        ${WHITE} ⠻⠿⠿⠷⠤⠤⠤⠿⠿⠿⠿⠿⠿⠿⠿⣇⠤⠤⠤⠴⠶⠿⠿⠿⠿⠁⠀⠀
        ${WHITE}     [ ${CYAN}Sleeping Panda ${WHITE}]
        ${WHITE} 
EOF
}

converter() {
    small_banner

    read -p "Please enter the absolute path to your desired file for conversion: " old_file 
    echo ""
    read -p "Please enter the desired name for your new file: " new_file 
    echo ""

    # convert pdf to txt
    if [ -f $old_file ]; then
        pdftotext -layout $old_file $new_file 
        echo "Your new Textfile has been created!"
        echo ""
        sleep 1
    else
        echo "$old_file does not exist. Please try again."
        sleep 2
        converter
    fi

    # To convert just a single range of pages within the document:
    #pdftotext -layout -f M -l N source.pdf target.txt 
    # [where M is the first page and N is the last one to be converted.]

    read -p "Would you like to hear your new AudioBook? (y/n) " ans 
    echo ""
    if [ $ans == "y" ]; then 
        echo "Playing..."
        cat $new_file | say
    elif [ $ans == "n" ]; then
        echo "Okay, returning to Main Menu..."
        sleep 1
        main
    else
        echo "$ans is not an option. Returning to Main Menu..."
        sleep 1
        main
    fi

}

player() {
    small_banner

    # play audio from txtfile
    read -p "Would you like to hear a Textfile as an AudioBook? (y/n) " ans 
    echo ""
    if [ $ans == "y" ]; then 
        read -p "Please enter the absolute path to the file you would like to read: " read_file
        echo ""
        sleep 1
        echo "Playing..."
        cat $read_file | say
    elif [ $ans == "n" ]; then
        echo "Okay, returning to Main Menu..."
        sleep 1
        main
    else
        echo "$ans is not an option."
        sleep 1
        player
    fi

}

branch_menu() {
    echo "Please select an option: "
    cat << EOF
        ${WHITE}
        ${WHITE}[${CYAN}1${WHITE}]${CYAN} PDF to TXT Converter
        ${WHITE}
        ${WHITE}[${CYAN}2${WHITE}]${CYAN} AudioPlayer
        ${WHITE}
EOF
    
    read -p ": " opt
    if [ $opt == "1" ]; then
        converter
    elif [ $opt == "2" ]; then
        player
    else
        echo "$opt is not an option."
        sleep 1
        main
    fi

}

main() {
    dep_install
    banner
    sleep 1
    branch_menu
}

main

