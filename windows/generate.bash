#!/usr/bin/env bash

trap exit SIGINT

GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

echo "${CYAN}Checking environment...${RESET}"
if ! (command -v "winget.exe" > /dev/null 2>&1); then
  echo "${RED}\"winget.exe\" not found!${RESET}"
  echo "Please run in WSL environment."
  exit 1
fi
echo "${GREEN}Done!${RESET}"

echo -e "\n${CYAN}Generating winget package list...${RESET}"
required_packages=##required_packages##

if [ ! -f package_ignore_list ]; then
  touch package_ignore_list
fi
if [ ! -f package_winget_map ]; then
  touch package_winget_map
fi

function write_to_map() {
  echo "${GREEN}Winget package \"$1\" was chosen for \"$2\".${RESET}"
  echo "$1,$2" >> package_winget_map
}

for package_name in "${required_packages[@]}"; do
  echo -e "\n${YELLOW}Processing package: \"$package_name\"${RESET}"

  if grep -q "^$package_name$" package_ignore_list; then
    echo "${CYAN}Skipping \"$package_name\" because it's in the ignore list.${RESET}"
    continue
  fi

  if grep -q "^$package_name," package_winget_map; then
    echo "${CYAN}Skipping \"$package_name\" because it's already mapped.${RESET}"
    continue
  fi

  declare -A found_packages

  mapfile -t results < <(winget.exe search "$package_name" | awk 'NR>2 {
    name = ""; id = "";
    for (i=1; i<=NF; i++) {
      if ($i ~ /^[A-Za-z0-9.-]+\.[A-Za-z0-9.-]+$/) {
        id = $i;
        break;
      }
      name = (name == "" ? $i : name " "$i);
    }
    if (name && id) print name "|" id;
  }')

  for result in "${results[@]}"; do
    IFS="|" read -r name id <<< "$result"
    found_packages["$id"]=$name
  done

  if [ ${#found_packages[@]} -eq 0 ]; then
    echo "${RED}No Winget package found for \"$package_name\".${RESET}"
    echo "Adding to ignore list..."
    echo "$package_name" >> package_ignore_list
  elif [ ${#found_packages[@]} -eq 1 ]; then
    for found_id in "${!found_packages[@]}"; do
      echo "${GREEN}Only one package found for \"$package_name\". Selecting automatically.${RESET}"
      write_to_map "$package_name" "${found_packages[$found_id]}"
      break
    done
  else
    echo "${YELLOW}Multiple packages found for \"$package_name\".${RESET}"

    page_size=9
    package_list=()
    for id in "${!found_packages[@]}"; do
      package_list+=("${found_packages[$id]} ($id)")
    done

    filtered_list=("${package_list[@]}")
    total_packages=${#filtered_list[@]}
    page=0

    while true; do
      start=$((page * page_size))
      end=$((start + page_size))
      if [ $end -gt "$total_packages" ]; then
        end=$total_packages
      fi

      echo -e "\n${CYAN}Select a package for \"$package_name\":${RESET}"
      for ((i = start; i < end; i++)); do
        echo "${GREEN}$((i - start + 1)). ${filtered_list[i]}${RESET}"
      done

      echo -e "\n${YELLOW}Options:${RESET}"
      if ((end < total_packages)); then echo "${CYAN}n.${RESET} Next page"; fi
      if ((page > 0)); then echo "${CYAN}p.${RESET} Previous page"; fi
      echo "${CYAN}s.${RESET} Search (by name or ID)"
      echo "${CYAN}i.${RESET} Ignore this package"

      read -rp "Enter choice: " choice

      if [[ $choice =~ ^[0-9]+$ ]] && (( choice > 0 && choice <= end - start )); then
        selected_index=$((start + choice - 1))
        selected_entry="${filtered_list[$selected_index]}"
        selected_id="${selected_entry##*(}"
        selected_id="${selected_id%)}"
        write_to_map "$package_name" "$selected_id"
        break
      elif [[ $choice == "n" ]] && (( end < total_packages )); then
        ((page++))
      elif [[ $choice == "p" ]] && (( page > 0 )); then
        ((page--))
      elif [[ $choice == "s" ]]; then
        read -rp "Enter search keyword (name or ID): " filter_term
        filter_term_lower=$(echo "$filter_term" | tr '[:upper:]' '[:lower:]')
        filtered_list=()
        for entry in "${package_list[@]}"; do
          entry_lower=$(echo "$entry" | tr '[:upper:]' '[:lower:]')
          if [[ "$entry_lower" == *"$filter_term_lower"* ]]; then
            filtered_list+=("$entry")
          fi
        done
        total_packages=${#filtered_list[@]}
        page=0
      elif [[ $choice == "i" ]]; then
        echo "${RED}Adding \"$package_name\" to ignore list...${RESET}"
        echo "$package_name" >> package_ignore_list
        break
      else
        echo "${RED}Invalid choice. Please try again.${RESET}"
      fi
    done
  fi
  unset found_packages
  echo "${CYAN}---------------------------------------------${RESET}"
done

echo "${GREEN}All packages processed.${RESET}"
