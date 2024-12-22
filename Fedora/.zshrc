## .zshrc

# Welcome message
echo -e "\e[32mHello, Good Sir!\e[0m\n\e[33mI am at your service\e[0m"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# Initialize plugins statically with ~/.zsh_plugins.txt
antidote load

# Prompt

autoload -Uz promptinit && promptinit && prompt powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set separate alias file
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi
