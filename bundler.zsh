# zeesh bundler

# bundler help

bundler_help() {
	zeesh_message "zeesh bundler help"
	printf "Usage:
    zeesh_bunder [-option] [arguments]

Options:
    -h              Prints this message.
    -b, --bundle    Bundle name.
    -t, --theme     Your desired theme.
    -p, --plugins   Your desired plugins.
    -c, --configs   Loads configs form that bundle.

Other details:
    If you pass 'random' as an argument to the theme option, it'll select a random theme from that bundle.
    The configs option doesn't take any arguments.
    The plugins option takes a string as an argument.
    Give all as an argument in the plugins option to load everything."
}

# initializes a custom bundle

load_custom_bundle() {
	source $BUNDLE/init.zsh
	init_custom_bundle $BUNDLE $1 $2 $3
	unset -f init_custom_bundle
}

# loads themes

load_themes() {
	zeesh_debug "setting theme"

	if [[ "$1" == "random" ]]; then
		zeesh_debug "using random theme"
		themes=($BUNDLE/$2/*.zsh-theme)
		local n=${#themes[@]}
		n=$RANDOM%$n+1
		local rand_theme=$themes[$n]
		zeesh_message "$BUNDLE:t - loaded random theme $rand_theme"
		source "$rand_theme"
	else
		if [[ ! -z $1 && -e "$BUNDLE/$2/$1.zsh-theme" ]]; then
			zeesh_debug "file $1.zsh-theme found"
			source "$BUNDLE/$2/$1.zsh-theme"
			zeesh_message "$BUNDLE:t - loaded theme $1"
		else
			zeesh_warning "$BUNDLE:t - theme $1 not found."
		fi
	fi
}

# loads plugins

load_plugins() {
	zeesh_debug "loading plugins"
	
	if [[ "$1" != "all" ]]; then
		plugins=("${(ps: :)${1}}") 
   	else
		plugins=($BUNDLE/$2/*)
	fi
 
	if [[ ${#plugins[@]} > 0 ]]; then
		for plugin in $plugins; do
		plugin="$plugin:t"
		zeesh_debug "loading plugin $plugin"
			if [[ -f "$BUNDLE/$2/$plugin/$plugin.plugin.zsh" || -f "$BUNDLE/$2/$plugin/_$plugin" ]]; then
				fpath=($BUNDLE/$2/$plugin $fpath)
				if [[ -f "$BUNDLE/$2/$plugin/$plugin.plugin.zsh" ]]; then
					source "$BUNDLE/$2/$plugin/$plugin.plugin.zsh"
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

# loads configs

load_configs() {
	zeesh_debug "loading configs"
	libs=($BUNDLE/$1/*.zsh)

	if [[ ${#libs[@]} > 0 ]]; then
		for lib in $libs; do
			zeesh_debug "loading lib $lib:t"
			source "$lib"
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

	[[ -z "$args[*]" ]] && bundler_help
	[[ -z "$libs" ]] || libs=""
    [[ -z "$plugins" ]] || plugins=""
    [[ -z "$theme" ]] || theme=""
	
	for ((n=1; n<${#args}+1; n++)); do
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
				theme=$args[$n+1]
				;;
			--plugins|-p)	# loads the plugins
				plugins=$args[$n+1]
				;;
			--configs|-c)	# loads the libs
				configs="true"
				;;
		esac	
	done

	zeesh_debug "$plugins"
	zeesh_debug "$theme"

	if [[ -e "$BUNDLE/init.zsh" ]]; then
		zeesh_debug "init at bundle $BUNDLE:t found"
		load_custom_bundle $confgis $plugins $theme
	else
		zeesh_debug "using default settings"
		[[ -z "$libs" ]] || load_configs configs
		[[ -z "$plugins" ]] || load_plugins $plugins plugins
		[[ -z "$theme" ]] || load_themes $theme themes
	fi
}
