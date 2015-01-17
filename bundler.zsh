# zeesh bundler

# bundler help

bundler_help() {
	zeesh_message "zeesh bundler help"
	printf "\nUsage:
    zeesh_bunder [-option] [arguments]

Options:
    -h              Prints this message.
    -b, --bundle    Bundle name.
    -t, --theme     Your desired theme.
    -p, --plugins   Your desired plugins.
    -l, --libs      Loads libs form that bundle.

Other details:
    The first option that should be called is -b (--bundle).
    If you pass 'random' as an argument to the theme option, it'll select a random theme from that bundle.
    The libs option doesn't take any arguments.
    The plugins option takes a string as an argument.
    Put a * in plugins option to load everything.\n"
}

# loads themes

load_themes() {
	zeesh_debug "setting theme"

	if [[ $1 == "random" ]]; then
		zeesh_debug "using random theme"
		themes=($BUNDLE/themes/*.zsh-theme)
		local n=${#themes[@]}
		n=$RANDOM%$n+1
		local rand_theme=$themes[$n]
		zeesh_debug "$themes[$n]"
		zeesh_message "$BUNDLE:t - loaded random theme $rand_theme"
		source "$rand_theme"
	else
		if [[ ! -z $1 ]] && [[ -e "$BUNDLE/themes/$1.zsh-theme" ]]; then
			zeesh_debug "file $1.zsh-theme found"
			source "$BUNDLE/themes/$1.zsh-theme"
			zeesh_message "$BUNDLE:t - loaded theme $1"
		else
			zeesh_warning "$BUNDLE:t - theme $1 not found, using default values"
			PROMPT="%~ > "
		fi
	fi
}

# loads plugins

load_plugins() {
	zeesh_debug "loading plugins"
	plugins=("${(ps: :)${1}}") 
    
	if [[ ${#plugins[@]} > 0 ]]; then
		for plugin in $plugins; do
		zeesh_debug "loading plugin $plugin"
			if [[ -f "$BUNDLE/plugins/$plugin/$plugin.plugin.zsh" || -f "$BUNDLE/plugins/$plugin/_$plugin" ]]; then
				fpath=($BUNDLE/plugins/$plugin $fpath)
				if [[ -f "$BUNDLE/plugins/$plugin/$plugin.plugin.zsh" ]]; then
					source $BUNDLE/plugins/$plugin/$plugin.plugin.zsh
				fi
			else
				zeesh_warning "$BUNDLE:t - $plugin isn't zeesh/oh-my-zshell compatable or wasn't found"
			fi
		done
			zeesh_message "$BUNDLE:t - plugins loaded"
	else
		zeesh_warning "$BUNDLE:t - no plugins found"
	fi
}

# loads functions

load_libs() {
	zeesh_debug "loading libs"
	libs=($BUNDLE/lib/*.zsh)

	if [[ ${#libs[@]} > 0 ]]; then
		for lib in $libs; do
			zeesh_debug "loading lib $lib:t"
			source $lib
		done
			zeesh_message "$BUNDLE:t - libs loaded"
	else
		zeesh_warning "$BUNDLE:t - no libs found"
	fi
}

#starts the bundler

zeesh_bundler() {

	args=("$@")

	zeesh_debug "$args[*]"

	[[ -z "$args[*]" ]] && zeesh_error "zeesh_bundler -h for help"
	
	for ((n=1; n<${#args}+1; n++)); do
		zeesh_debug "$args[$n]"
		case $args[$n] in
			-h)
				bundler_help
				return 110
				;;
			--bundle|-b) # sets the bundle directory
				if [[ -d "$ROOT_DIR/bundles/$args[$n+1]" ]]; then
					BUNDLE="$ROOT_DIR/bundles/$args[$n+1]"
				else
					zeesh_error "bundle $args[$n+1] not found"
					return 111
				fi
				;;
			--theme|-t) # sets the theme
				load_themes $args[$n+1]
				;;
			--plugins|-p)	# loads the plugins
				load_plugins $args[$n+1]
				;;
			--libs|-l)	# loads the libs
				load_libs
				;;
		esac	
	done
}
