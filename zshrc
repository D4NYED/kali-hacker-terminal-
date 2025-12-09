###############################################################
#                  KALI HACKER TERMINAL by D4NYED
#        Configuración profesional para pentesters & OSINT
#        Twitter/X: @D4nYeD | GitHub: https://github.com/D4NYED
###############################################################

# --------------------------
# Powerlevel10k instant prompt
# Keep this near the top of the file for fastest startup.
# --------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --------------------------
# Basic env
# --------------------------
export LANG=en_US.UTF-8
export TERM=xterm-256color
export EDITOR="${EDITOR:-nano}"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# --------------------------
# Oh-My-Zsh & theme
# --------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Only source Oh-My-Zsh if it exists (safe startup)
if [ -d "$ZSH" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# Source Powerlevel10k configuration if present
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --------------------------
# Plugins (light & useful)
# --------------------------
# Keep this list small to avoid slow startup
plugins=(
  git
  sudo
  history-substring-search
  extract
)

# Safe source for autosuggestions & highlighting (some distros place them differently)
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# --------------------------
# Helpful shell options
# --------------------------
export HISTSIZE=10000
export SAVEHIST=10000
setopt append_history       # append to history (don't overwrite)
setopt share_history        # share history across terminals
setopt autocd               # cd without typing cd
setopt nocaseglob           # case-insensitive globbing
setopt interactivecomments  # allow comments in interactive shell

# --------------------------
# Banner — optional & tasteful
# --------------------------
if [ -t 1 ]; then
cat <<'EOF'

██╗  ██╗ █████╗ ██╗  ██╗██╗███████╗██████╗ 
██║ ██╔╝██╔══██╗██║ ██╔╝██║██╔════╝██╔══██╗
█████╔╝ ███████║█████╔╝ ██║█████╗  ██████╔╝
██╔═██╗ ██╔══██║██╔═██╗ ██║██╔══╝  ██╔══██╗
██║  ██╗██║  ██║██║  ██╗██║███████╗██║  ██║
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝

       ❗ TERMINAL OPTIMIZADA PARA PENTESTING ❗
       🔥 By D4NYED — Twitter/X: @D4nYeD
EOF
fi

# --------------------------
# ALIASES — organizados por uso
# --------------------------

## Navegación
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias c="clear"
alias ll='ls -lah --color=auto'

## Búsqueda / utilidades
alias g="grep --color=auto -nRi"
alias finder='find . -type f -name'
alias hist='history | grep'

## Sistema / red
alias ipinfo="ip a"
alias myip="curl -s ifconfig.me"
alias ports="sudo netstat -tulpn | grep LISTEN"
alias psg='ps aux | grep -v grep | grep'

## Recon / escaneo
alias scan="nmap -sC -sV -oN scan.txt"
alias fullscan='nmap -p- -sC -sV --min-rate 5000'
alias rust="rustscan -a"

## Servidor rápido
alias serve='python3 -m http.server 8080'

## Pentesting / herramientas
alias msf='msfconsole'
alias gob='gobuster dir -u'
alias ff='ffuf -u'

## Git shortcuts
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"

## Misc
alias reload='source ~/.zshrc'
alias rights="find . -perm -u=s -type f 2>/dev/null"

# --------------------------
# FUNCIONES PRO — Pentesting helpers
# --------------------------

# listen <port>  -> netcat listener (reverse shells)
listen() {
  if [ -z "$1" ]; then
    echo "Usage: listen <port>"
    return 1
  fi
  nc -lvnp "$1"
}

# servep <port>  -> lightweight HTTP server (default 8000)
servep() {
  python3 -m http.server "${1:-8000}"
}

# suid -> search suid binaries (possible escalation vectors)
suid() {
  sudo find / -perm -4000 -type f 2>/dev/null
}

# b64d <string> -> decode base64
b64d() {
  if [ -z "$1" ]; then
    echo "Usage: b64d <base64-string>"
    return 1
  fi
  echo "$1" | base64 -d
}

# hydra20 <target> <service> -> template hydra run (requires users.txt + rockyou.txt)
hydra20() {
  if [ $# -lt 2 ]; then
    echo "Usage: hydra20 <target> <service>"
    return 1
  fi
  hydra -L users.txt -P rockyou.txt "$1" "$2" -V -t 20
}

# chmodcalc <file> -> show perms and octal
chmodcalc() {
  if [ -z "$1" ]; then
    echo "Usage: chmodcalc <file>"
    return 1
  fi
  stat -c "%A %a" "$1"
}

# mkcd <dir> -> mkdir -p && cd
mkcd() {
  mkdir -p -- "$1" && cd -P -- "$1"
}

# extract <file> -> universal extraction helper
extract() {
  if [ -z "$1" ]; then
    echo "Usage: extract <file>"
    return 1
  fi
  case "$1" in
    *.tar.bz2)   tar xjf "$1"    ;;
    *.tar.gz)    tar xzf "$1"    ;;
    *.tar.xz)    tar xJf "$1"    ;;
    *.tar)       tar xf "$1"     ;;
    *.tgz)       tar xzf "$1"    ;;
    *.zip)       unzip "$1"      ;;
    *.rar)       unrar x "$1"    ;;
    *.7z)        7z x "$1"       ;;
    *.gz)        gunzip "$1"     ;;
    *) echo "extract: formato no soportado: $1" ;;
  esac
}

# tldr alias if available
if command -v tldr >/dev/null 2>&1; then
  alias tldr='tldr'
fi

# fzf support if installed
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
fi

# --------------------------
# Final tweaks
# --------------------------
# Make command completion snappier and avoid duplicates
zstyle ':completion:*' menu select
setopt no_beep

# Keep history sane and shared
export HISTFILE=~/.zsh_history

# Helpful reminder for first run
if [ -z "$POWERLEVEL9K_CONFIGURED" ] && [ -f ~/.p10k.zsh ]; then
  # nothing — p10k will handle it
  :
fi

# --------------------------
# End of file
# --------------------------
# Reload config: `source ~/.zshrc` or `exec zsh`
