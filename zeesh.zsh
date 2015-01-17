# main zeesh file

# represents the verbosity of debugging/developer options, warnings and errors.
# 1 - Only crutial errors;
# 2 - Errors, warnings and zeesh messanges; (RECOMMENDED)
# 3 - Debugging and developer options;

[[ -z "$ZEESH_VERBOSITY" ]] && readonly ZEESH_VERBOSITY=2 # default 2.

# Logging and Error/Warning issuing 

zeesh_error() {
	[[ $ZEESH_VERBOSITY -gt 0 ]] && printf "\e[1;31m[ ERROR ]\e[0m $1. \n" 1>&2
}

zeesh_warning() {
	[[ $ZEESH_VERBOSITY -gt 1 ]] && printf "\e[1;33m[ WARNING ]\e[0m $1. \n" 1>&2
}

zeesh_debug() {
	[[ $ZEESH_VERBOSITY -gt 2 ]] && printf "\e[1;36m[ DEBUG ]\e[0m $1. \n" 1>&2
}

zeesh_message() {
	[[ $ZEESH_VERBOSITY -gt 1 ]] && printf "\e[1;32m[ Zeesh ]\e[0m $1. \n" 1>&2
}

# initialising Zeesh

zeesh_init() {
	
	# checks if $1 isn't empty

	if [[ -z "$1" ]]; then
		zeesh_error "no root specified"
		return 109
	fi
	
	export readonly ROOT_DIR=$1

	zeesh_message "loading zeesh in $ROOT_DIR"	
	[[ "$ROOT_DIR" != "$HOME/.zeesh" ]] && zeesh_warning "it's advised that you set up $HOME/.zeesh as your zeesh root"
	
	typeset -Ag zsh_themes

	# loading and running compinit

	autoload -U compinit
	compinit -id "/tmp/.zcompdump"
	
	# starting externals
	
	source "$ROOT_DIR/bundler.zsh"

	[[ -e "$ROOT_DIR/autoexec.zsh" ]] && source "$ROOT_DIR/autoexec.zsh"

	zeesh_message "welcome to zeesh"
	printf "\n"

	wait
}
