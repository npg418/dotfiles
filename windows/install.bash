#!/usr/bin/env bash

trap exit SIGINT

GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

echo -e "${CYAN}Installing winget packages...${RESET}\n"

package_list=$(cut -d ',' -f2 package_winget_map | tr '\n' ' ')
winget.exe install "$package_list"

echo -e "\n${GREEN}Done!${RESET}"

echo -e "\n${CYAN}Copying config files...${RESET}"


