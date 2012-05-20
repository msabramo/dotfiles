OS=$(uname)
ACCOUNT=$(whoami)
DOMAIN=$(hostname)
DOMAIN=$(expr "$DOMAIN" : "[^.]*\.\(.*\)")
HOST=$(hostname -s)
HOSTFULL=$(hostname)
YAHOO_INC_EMAIL="${ACCOUNT}@yahoo-inc.com"

# enviroment and functions
for i in /usr/local/etc/bash_completion.d/yinst_completion ~/.bash_env ~/.bash_alias ~/.bash_function ~/.bash_completion ~/.fff ~/bin/cdargs-bash.sh; do
  if [ -f $i ]; then
    source $i
  fi
done

if [ "$TERM" = "screen" -a -f ~/.x11_display ]; then
    export DISPLAY=$(cat ~/.x11_display)
else
    if [ ! -z "$DISPLAY" ]; then
        echo $DISPLAY > ~/.x11_display
    fi
fi

