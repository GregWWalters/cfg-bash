export BASH_SILENCE_DEPRECATION_WARNING=1
# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

if [ -z "$XDG_CONFIG_HOME" ]; then
	XDG_CONFIG_HOME="${HOME}/.config"
fi

# Set config dir
sh_config="${XDG_CONFIG_HOME}/sh"
bash_config="${XDG_CONFIG_HOME}/bash"

# load profile
# profile loads environment variables, path, aliases, functions, and sets the
# prompt
[ -f "$HOME/.profile" ] && source "$HOME/.profile"

# Force bash to ignore carriage return (\r) characters
# used in Windows line separators.
(set -o igncr) 2>/dev/null && set -o igncr;

# History Options
## Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
## Ignore some controlling instructions
### HISTIGNORE is a colon-delimited list of patterns which should be excluded.
### The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well

# iTerm2 Shell Integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Git
# Load git completion if present
[ -f "${bash_config}/git-completion.bash" ] && source "${bash_config}/git-completion.bash"
# Use git-prompt if found
if [ -f "${HOME}/.config/git/git-prompt.sh" ]; then
	source "${HOME}/.config/git/git-prompt.sh"
	PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
	#export PS1="\n\[\e[00;36m\]\u@\h:\[\e[0m\]\[\e[00;32m\]\w\[\e[0m\]\[\e[00;36m\] \D{%Y-%m-%d} \A\[\e[0m\]\n\$(__git_ps1 " (%s)")\[\e[1;37m\]\$\[\e[0m\] "
else
	export PS1="\n\[\e[00;36m\]\u@\h:\[\e[0m\]\[\e[00;32m\]\w\[\e[0m\]\[\e[00;36m\] \D{%Y-%m-%d} \A\[\e[0m\]\n\[\e[1;37m\]\$\[\e[0m\] "
fi

## Codefresh CLI completion
codefresh_config="${HOME}/.config/codefresh"
if [ -d "$codefresh_config" -a -s "${codefresh_config}/completion.bash" ]; then
	source "${codefresh_config}/completion.zsh"
fi

# Load nvm (Node Version Manager)
if [ -z ${NVM_DIR+x} ]; then
	# This loads nvm bash_completion
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
	# Only load NVM when needed so not to slow down shell startup
	function nvm {
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
		nvm "$@"
	}
fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/greg/.npm/_npx/14940/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /Users/greg/.npm/_npx/14940/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/greg/.npm/_npx/14940/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /Users/greg/.npm/_npx/14940/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/greg/.npm/_npx/14940/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . /Users/greg/.npm/_npx/14940/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash

# vim:ft=bash
