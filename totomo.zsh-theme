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
PROMPT='${current_time} ${user_host}:${current_dir}${prompt_symbol} ${color_magenta}$(git_prompt_info)${color_reset}
${ret_status}${color_reset} '

# Git 配置
ZSH_THEME_GIT_PROMPT_PREFIX="git:(${color_red}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${color_reset}"
ZSH_THEME_GIT_PROMPT_DIRTY="${color_magenta}) ${color_yellow}✗${color_reset}"
ZSH_THEME_GIT_PROMPT_CLEAN="${color_magenta})${color_reset}"
