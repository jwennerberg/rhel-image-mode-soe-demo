#PS1="\[\e[33m\][\h:\W]\\$\[\e[m\] "
#PS1="\[\e[32m\](dev)\[\e[33m\][\h:\W]\\$\[\e[m\] "
PS1="\[\e[32m\]($(sudo bootc status --format json | jq .status.booted.image.image.image | sed -r 's/.*\/(.*)\"/\1/' 2>/dev/null))\[\e[33m\][\h:\W]\\$\[\e[m\] "
