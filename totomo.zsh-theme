local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
local current_time="%{$fg[white]%}[%{$fg[blue]%}%T%{$fg[white]%}]%{$reset_color%}"
PROMPT='${ret_status}%{$fg_bold[green]%}%p%b$current_time%(!.%F{red}.%F{cyan})%n%f@%F{yellow}%M%f:%{$(pwd|grep --color=always /)%${#PWD}G%}%f%(!.%F{red}.)%F{white}%#%f%{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
