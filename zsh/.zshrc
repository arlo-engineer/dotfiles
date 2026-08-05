# Gitタブ補完の設定
fpath=(
  ${HOME}/.zsh/completion
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

# ~/dev/personal 配下では gh を個人アカウント(arlo-engineer)で実行する。
# GH_TOKEN を常時 export せず gh 実行時のみ注入することで、他プロセスへのトークン漏れと
# cd ごとの keyring アクセスを避ける
_gh_is_personal_dir() {
  # :A でシンボリックリンクを解決する。この .zshrc 自体が ~/dev/personal/dotfiles への
  # リンクのため、$PWD の論理パスと実体が食い違うケースが実際に起こる
  local personal_root="${HOME:A}/dev/personal"
  [[ "${PWD:A}" == "$personal_root" || "${PWD:A}" == "$personal_root"/* ]]
}

gh() {
  if _gh_is_personal_dir; then
    GH_TOKEN="$(command gh auth token --user arlo-engineer)" command gh "$@"
  else
    command gh "$@"
  fi
}

