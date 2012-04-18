# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="aussiegeek"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx autojump brew cloudapp github pip svn django python ssh-agent)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:/Users/marca/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin

# https://github.com/utahta/pythonbrew
[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc

PROMPT='$fg_bold[blue][ $fg[red]%t $fg_bold[blue]] $fg_bold[blue] [ $fg[red]%n@%m:%~$(git_prompt_info) $fg[yellow]$(svn_prompt_info)$fg[yellow]$(rvm_prompt_info)$fg_bold[blue] ]$reset_color
 $ '

# http://marc-abramowitz.com/archives/2011/11/11/fix-the-oh-my-zsh-esc-annoyance/
bindkey '\e.' insert-last-word
