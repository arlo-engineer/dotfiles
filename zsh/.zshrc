# Gitタブ補完の設定
fpath=(
  ${HOME}/.zsh/completions
  ${fpath}
)
autoload -Uz compinit
compinit

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/a.yoshikawa/.lmstudio/bin"
# End of LM Studio CLI section


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# nvm自動切り替え設定
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"
  
  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    
    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc


alias cc="claude"
export PATH="$HOME/.local/bin:$PATH"
