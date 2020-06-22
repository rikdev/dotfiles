#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Includes
[[ -f /usr/share/doc/pkgfile/command-not-found.bash ]] \
	&& source /usr/share/doc/pkgfile/command-not-found.bash

[[ -f /usr/share/git/completion/git-completion.bash ]] && \
	source /usr/share/git/completion/git-completion.bash

# Prompt
__print_exit_status() {
	local -r STATUS="$?"
	local -r FORMAT="$1"

	[[ "${STATUS}" != 0 ]] && printf "${FORMAT}" "${STATUS}"
}

__print_jobs_number() {
	local -r FORMAT="$1"
	local -r RUNNING_JOBS_NUMBER="$(jobs -rp | wc -l)"
	local -r STOPPED_JOBS_NUMBER="$(jobs -sp | wc -l)"
	local -r JOBS_NUMBER="$((RUNNING_JOBS_NUMBER+STOPPED_JOBS_NUMBER))"

	[[ "${JOBS_NUMBER}" != 0 ]] && printf "${FORMAT}" "${JOBS_NUMBER}"
}

if [[ "${TERM}" != 'dumb' ]]; then
	readonly EXIT_STATUS_COLOR='\[\e[0;91m\]'
	readonly JOBS_COLOR='\[\e[0;35m\]'
	readonly HOSTNAME_COLOR='\[\e[0;37m\]'
	readonly WORKING_DIRECTORY_COLOR='\[\e[0;94m\]'
	readonly RESET_COLOR='\[\e[0m\]'

	if [[ "${EUID}" == "0" ]]; then
		readonly USERNAME_COLOR='\[\e[0;91m\]'
		readonly TAIL_COLOR='\[\e[0;91m\]'
	else
		readonly USERNAME_COLOR='\[\e[0;32m\]'
		readonly TAIL_COLOR='\[\e[0;37m\]'
	fi

	readonly WINDOW_TITLE='\[\e]2;\u@\h:\w - \s\a\]'
else
	readonly EXIT_STATUS_COLOR=
	readonly JOBS_COLOR=
	readonly HOSTNAME_COLOR=
	readonly WORKING_DIRECTORY_COLOR=
	readonly RESET_COLOR=
	readonly USERNAME_COLOR=
	readonly TAIL_COLOR=
	readonly WINDOW_TITLE=
fi

PS1="${WINDOW_TITLE}\
${EXIT_STATUS_COLOR}\$(__print_exit_status '%s ')${RESET_COLOR}\
${JOBS_COLOR}\$(__print_jobs_number 'j%s ')${RESET_COLOR}\
${USERNAME_COLOR}\\u${RESET_COLOR}\
@${HOSTNAME_COLOR}\\h${RESET_COLOR}\
:${WORKING_DIRECTORY_COLOR}\\w${RESET_COLOR}\
${TAIL_COLOR}\\$ ${RESET_COLOR}"

# Shell options
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s autocd globstar

# Aliases
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias pacman='pacman --color=auto'
alias ip='ip --color=auto'

# Binds
# Mimic Zsh run-help ability
bind '"\eh": "\C-a\eb\ed\C-y\e#man \C-y\C-m\C-p\C-p\C-a\C-d\C-e"'
