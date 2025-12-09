# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sudo history-substring-search extract)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ===========================
#        A L I A S  
#        H A C K E R
# ===========================

###############
# 🔹 Navegación rápida
###############
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias c="clear"

###############
# 🔹 Listados y búsqueda
###############
alias ll="ls -lah --color=auto"
alias g="grep --color=auto -nRi"
alias finder='find . -type f -name'

###############
# 🔹 Información del sistema
###############
alias ipinfo="ip a"
alias myip="curl -s ifconfig.me"
alias rights="find . -perm -u=s -type f 2>/dev/null"

###############
# 🔹 Procesos y red
###############
alias ports="sudo netstat -tulpn | grep LISTEN"
alias psg='ps aux | grep -v grep | grep'

###############
# 🔹 Nmap / Recon
###############
alias scan="nmap -sC -sV -oN scan.txt"
alias fullscan='nmap -p- -sC -sV --min-rate 5000'
alias rust="rustscan -a"

###############
# 🔹 Servidor rápido
###############
alias serve='python3 -m http.server 8080'

###############
# 🔹 Metasploit
###############
alias msf='msfconsole'

###############
# 🔹 Pentesting Web
###############
alias gob='gobuster dir -u'
alias ff='ffuf -u'

###############
# 🔹 Git rápido
###############
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"

###############
# 🔹 Utilidades
###############
alias reload='source ~/.zshrc'
alias hist='history | grep'


###############
Funciones PRO de Hacker
###############

# Escuchar un puerto con netcat
function listen() {
    nc -lvnp "$1"
}

# Mini servidor HTTP para exfiltrar / transferir archivos
function serve() {
    python3 -m http.server "${1:-8000}"
}

# Buscar binarios SUID (escalada de privilegios)
function suid() {
    find / -perm -4000 -type f 2>/dev/null
}

# Decodificar Base64 rápido
function b64d() {
    echo "$1" | base64 -d
}

# Hydra rápido con 20 threads
function hydra20() {
    hydra -L users.txt -P rockyou.txt "$1" "$2" -V -t 20
}

# Ver permisos en modo octal (chmod helper)
function chmodcalc() {
    stat -c "%A %a" "$1"
}

# ===========================
#  S H O R T C U T S  &  T O O L S
# ===========================
# mkcd: mkdir && cd
mkcd() {
  mkdir -p -- "$1" && cd -P -- "$1"
}

# extract: utilidad universal de extracción
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

# tldr: if installed
if command -v tldr >/dev/null 2>&1; then
  alias tldr='tldr'
fi

# fzf: fuzzy finder (if installed)
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
fi

# Prompt niceties
export HISTSIZE=10000
export SAVEHIST=10000
setopt append_history autocd share_history

# Finish
# Reload with: source ~/.zshrc or exec zsh
