PROMPT="%{$fg[blue]%}%c%{$reset_color%} $(git_prompt_info)%{$fg_bold[red]%}:%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX="{"
ZSH_THEME_GIT_PROMPT_SUFFIX="} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} dirty%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} clean%{$reset_color%}"
