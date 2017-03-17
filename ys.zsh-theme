# Clean, simple, compatible and meaningful.

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[blue]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$terminfo[bold]$fg[green]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$terminfo[bold]$fg[magenta]%}x"
YS_VCS_PROMPT_CLEAN=" %{$terminfo[bold]$fg[green]%}o"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}$terminfo[bold]git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$YS_VCS_PROMPT_DIRTY"
		else
			echo -n "$YS_VCS_PROMPT_CLEAN"
		fi
		echo -n "$YS_VCS_PROMPT_SUFFIX"
	fi
}

local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"

# Prompt format:
#
# PRIVILEGES USER @ MACHINE in DIRECTORY on git:BRANCH STATE [TIME] C:LAST_EXIT_CODE
# $ COMMAND
#
# For example:
#
# % ys @ ys-mbp in ~/.oh-my-zsh on git:master x [21:47:42] C:0
# $
PROMPT="
%{$fg[blue]%}#%{$reset_color%} \
%(#,%{$bg[cyan]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[green]%}%n) \
%{$fg[blue]%}@ \
%{$fg[cyan]%}%m%{$reset_color%} \
%{$fg[blue]%}in \
%{$fg[yellow]%}%~%{$reset_color%}\
${hg_info}\
${git_info}\
 \
%{$fg[blue]%}[%*] $exit_code
%{$terminfo[bold]$fg[red]%}➔ %{$reset_color%}"
