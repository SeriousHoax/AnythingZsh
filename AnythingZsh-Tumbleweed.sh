#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Step 1: Remove existing .antidote folder if it exists
echo -e "${GREEN}Removing existing .antidote folder if it exists...${NC}"
rm -rf ${ZDOTDIR:-$HOME}/.antidote

# Step 2: Clone antidote repository
echo -e "${GREEN}Cloning antidote repository...${NC}"
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-$HOME}/.antidote

# Step 3: Clone AnythingZsh repository with sparse checkout
echo -e "${GREEN}Cloning AnythingZsh repository with sparse checkout...${NC}"
git clone --depth 1 --filter=blob:none --sparse https://github.com/SeriousHoax/AnythingZsh.git ~/openSUSE\ Tumbleweed

# Step 4: Navigate into the cloned repo
cd ~/openSUSE\ Tumbleweed

# Step 5: Set sparse-checkout to download only the openSUSE Tumbleweed folder
echo -e "${GREEN}Setting sparse-checkout to only download the openSUSE Tumbleweed folder...${NC}"
git sparse-checkout init --cone
git sparse-checkout set "openSUSE Tumbleweed"

# Step 6: Copy the contents of the openSUSE Tumbleweed folder to home directory
echo -e "${GREEN}Copying contents of openSUSE Tumbleweed folder to home directory...${NC}"
cp -rT "openSUSE Tumbleweed" ~/

# Step 7: Navigate back to home and remove the downloaded folder
cd ~
echo -e "${GREEN}Removing the downloaded openSUSE Tumbleweed folder...${NC}"
rm -rf ~/openSUSE\ Tumbleweed

# Final Step: Done
echo -e "${GREEN}Done.${NC}"