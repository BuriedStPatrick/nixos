export XDG_CONFIG_HOME=${HOME}/.config
export HISTFILE=~/.histfile
export HISTSIZE=1000
export HISTFILESIZE=9999
export SAVEHIST=1000
# Auto change directory. If directory is entered without any arguments, assumes it can be CD'ed into.
unsetopt beep
zstyle :compinstall filename "${HOME}/.zshrc"

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

# Set zsh input to emacs mode (normally default behavior, but setting EDITOR=vim changes the input mode to vi for some reason)
bindkey -e

# Ensure 'delete' key actually delete char instead of printing ~
bindkey -M emacs "^[[3~" delete-char

# 'ctrl+delete' deletes the next word
bindkey -M emacs '^[[3;5~' kill-word

# 'ctrl+backspace' (and 'ctrl+h' for some reason??) deletes the previous word
bindkey -M emacs '^H' backward-kill-word

# 'Home' goes to beginning of line
bindkey -M emacs '^[[H' beginning-of-line

# 'End' goes to end of line
bindkey -M emacs '^[[F' end-of-line

# CTRL+RIGHT forward word
bindkey "^[[1;5C" forward-word

# CTRL+LEFT backward word
bindkey "^[[1;5D" backward-word

# Cycle through history based on characters already typed on the line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M emacs "^[[A" up-line-or-beginning-search
bindkey -M emacs "^[[B" down-line-or-beginning-search

export ZSH_CONFIG_DIR="${HOME}/.config/zsh"

# Plugins
for zsh_plugin in $(ls "${ZSH_CONFIG_DIR}/plugins")
do
  source "${ZSH_CONFIG_DIR}/plugins/${zsh_plugin}";
done

# Init scripts
for zsh_init in $(ls "${ZSH_CONFIG_DIR}/init")
do
  source "${ZSH_CONFIG_DIR}/init/${zsh_init}";
done

# Aliases
alias ll='exa -lah'
alias tree='depth=${TREE_DEPTH:-2}; exa --tree --level ${depth}'

# Custom scripts
export PATH=${PATH}:${HOME}/scripts

# RUST - Cargo binaries
export PATH=${HOME}/.cargo/bin:${PATH}

# Add yarn global binary to PATH
export PATH=${HOME}/.yarn/bin:${PATH}

# Hobby cluster
alias hobbyk9s="KUBECONFIG=${HOME}/.kube/hobby/kubeconfig.yaml k9s"
alias hobby="export KUBECONFIG=${HOME}/.kube/hobby/kubeconfig.yaml"

# .NET
alias restore='dotnet restore --interactive --force-evaluate'
alias clean_bin="find . -type d -name bin -exec rm -rf {} \;"
alias clean_obj="find . -type d -name obj -exec rm -rf {} \;"
alias dotnetman="docker run -v ${DOTNET_ROOT}:/home/bun/.dotnet -u $(id -u):bun dotnetman"

unsetopt append_history
setopt share_history autocd nomatch notify

# Development shortcuts
export PATH="${HOME}/.local/share/JetBrains/Toolbox/scripts:${PATH}"
dev() {
   rider $1 >/dev/null 1>/dev/null 2>/dev/null & disown
}

if command -v pyenv 2>&1 >/dev/null; then
  export PATH="${HOME}/.pyenv/bin:${PATH}"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# Bun.sh
if command -v bun 2>&1 >/dev/null; then
  export PATH="${HOME}/.bun/bin:${PATH}"
fi

# CUDA stuff
export PATH="/opt/cuda/bin:${PATH}"
export LD_LIBRARY_PATH=/opt/cuda/lib64

# VSCodium
if command -v vscodium 2>&1 >/dev/null; then
  alias code='/usr/bin/codium --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland'
fi

# Podman testcontainers support
start_test_container_support() {
  podman system service --time=0 &
}

# Kubectl plugins (krew)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

if [ -e /home/patrick/.nix-profile/etc/profile.d/nix.sh ]; then . /home/patrick/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
