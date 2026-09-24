# Totomo Theme v2 — 统一版
# 取两边优点：VM2 的代码结构 + 本机的布局风格

local color_reset="%{$reset_color%}"
local color_green="%{$fg_bold[green]%}"
local color_red="%{$fg_bold[red]%}"
local color_blue="%{$fg_bold[blue]%}"
local color_white="%{$fg_bold[white]%}"
local color_cyan="%{$fg_bold[cyan]%}"
local color_yellow="%{$fg_bold[yellow]%}"
local color_magenta="%{$fg_bold[magenta]%}"

# 上一条命令状态（绿=成功，红=失败），用在第二行输入提示
local ret_status="%(?:${color_green}❯:${color_red}❯)"

# 时间（magenta，与 cyan 用户名区分）
local current_time="${color_white}[${color_magenta}%T${color_white}]${color_reset}"

# 用户@短主机名（%m 而非 %M，更紧凑）
local user_host="%(!.${color_red}.${color_cyan})%n${color_reset}@${color_yellow}%m${color_reset}"

# 目录
local current_dir="${color_green}%~${color_reset}"

# 权限符号
local prompt_symbol="%(!.${color_red}#.${color_white}$)${color_reset}"

# 第一行：[时间] user@host:目录$ git信息
# 第二行：❯ 状态指示 + 输入
#
# The first line is printed by a precmd hook; PROMPT itself is one line.
# zsh redraws a multi-line PROMPT on every terminal resize by moving the
# cursor up the number of rows the prompt occupied when it was last drawn,
# then clearing to the end of the screen. A terminal that reflows text on
# resize (tmux) has already re-wrapped that first line at the new width, so
# the cursor lands one row too high and the last line of the previous
# command's output is erased. A one-line PROMPT never moves the cursor up.
# The leading %E clears the row first: PROMPT_SP has just padded it with
# spaces to the full width, and a reflowing terminal would otherwise turn
# that padding into an extra blank row when the window is narrowed.
_totomo_info_line() {
  print -P -- "%E${current_time} ${user_host}:${current_dir}${prompt_symbol} ${color_magenta}$(git_prompt_info)${color_reset}"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _totomo_info_line

# oh-my-zsh's asynchronous git_prompt_info only fills its cache for prompts
# whose text contains $(git_prompt_info); the git information here is printed
# from precmd, so use the synchronous implementation when it exists.
if (( $+functions[_omz_git_prompt_info] )); then
  git_prompt_info() { _omz_git_prompt_info }
fi

PROMPT='${ret_status}${color_reset} '

# Ctrl-L: clear the screen, then reprint the first line above the prompt.
_totomo_clear_screen() {
  zle -I
  print -n -- "${terminfo[clear]}"
  _totomo_info_line
}
zle -N _totomo_clear_screen
bindkey '^L' _totomo_clear_screen

# Git 配置
ZSH_THEME_GIT_PROMPT_PREFIX="git:(${color_red}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${color_reset}"
ZSH_THEME_GIT_PROMPT_DIRTY="${color_magenta}) ${color_yellow}✗${color_reset}"
ZSH_THEME_GIT_PROMPT_CLEAN="${color_magenta})${color_reset}"
