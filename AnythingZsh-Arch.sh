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
git clone --depth 1 --filter=blob:none --sparse https://github.com/SeriousHoax/AnythingZsh.git ~/ArchDownload

# Step 4: Navigate into the cloned repo
cd ~/ArchDownload

# Step 5: Set sparse-checkout to download only the Arch folder
echo -e "${GREEN}Setting sparse-checkout to only download the Arch folder...${NC}"
git sparse-checkout init --cone
git sparse-checkout set Arch

# Step 6: Copy the contents of the Arch folder to home directory
echo -e "${GREEN}Copying contents of Arch folder to home directory...${NC}"
cp -rT Arch ~/

# Step 7: Navigate back to home and remove the downloaded folder
cd ~
echo -e "${GREEN}Removing the downloaded Arch folder...${NC}"
rm -rf ~/ArchDownload

# Step 8: Downloading and Installing MesloLGS Nerd Fonts
echo -e "${GREEN}Downloading and installing MesloLGS Nerd Fonts...${NC}"

# Define new font URLs and destination
FONT_URLS=(
  "https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Regular.ttf"
  "https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Bold.ttf"
  "https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Italic.ttf"
  "https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Bold%20Italic.ttf"
)
FONT_DEST_DIR="$HOME/nerd-fonts"
SYSTEM_FONT_DIR="/usr/share/fonts/TTF"

# Create temporary font directory in home
mkdir -p $FONT_DEST_DIR

# Download each font
for FONT_URL in "${FONT_URLS[@]}"; do
  wget -q $FONT_URL -P $FONT_DEST_DIR
done

# Create system font directory if it doesn't exist
sudo mkdir -p $SYSTEM_FONT_DIR

# Move fonts to the system font directory
sudo mv $FONT_DEST_DIR/* $SYSTEM_FONT_DIR/

# Update font cache
echo -e "${GREEN}Updating font cache...${NC}"
sudo fc-cache -fv

# Remove temporary font directory
echo -e "${GREEN}Cleaning up downloaded font files...${NC}"
rm -rf $FONT_DEST_DIR

# Final Step: Done
echo -e "${GREEN}Done.${NC}"