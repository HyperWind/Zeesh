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
    If you pass \"random\" as an argument to the theme option, it'll select a random theme from that bundle.
    The configs option doesn't take any arguments.
    The plugins option takes a string as an argument.
    Give \"all\" as an argument to the plugins option to load all the plugins from that bundle."
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
		themes=($BUNDLE/$2/*.zsh-theme)
		local n=${#themes[@]}
		n=$RANDOM%$n+1
		local rand_theme=$themes[$n]
		zeesh_message "$BUNDLE:t - loaded random theme $rand_theme"
		source "$rand_theme"
	else
		if [[ ! -z $1 && -e "$BUNDLE/$2/$1.zsh-theme" ]]; then
			source "$BUNDLE/$2/$1.zsh-theme"
			zeesh_debug "$BUNDLE:t - loaded theme $1"
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
			zeesh_debug "$BUNDLE:t - plugins loaded"
	else
		zeesh_warning "$BUNDLE:t - no plugins found"
	fi
}

# loads configs

load_configs() {
	zeesh_debug "loading configs"
	configs=($BUNDLE/$1/*.zsh)

	if [[ ${#configs[@]} > 0 ]]; then
		for config in $configs; do
			zeesh_debug "loading lib $config:t"
			source "$config"
		done
			zeesh_debug "$BUNDLE:t - configs loaded"
	else
		zeesh_warning "$BUNDLE:t - no configs found"
	fi
}

#starts the bundler

zbn() {
	args=("$@")
	zeesh_debug "$args[*]"

	[[ -z "$args[*]" ]] && bundler_help
	[[ $configs != 0 ]] && configs=0
	[[ $plugins != 0 ]] && plugins=0
	[[ $theme != 0 ]] && theme=0
	
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
			--configs|-c)	# loads the configs
				configs=1
				;;
		esac	
	done

	if [[ -e "$BUNDLE/init.zsh" ]]; then
		zeesh_debug "init at bundle $BUNDLE:t found"
		load_custom_bundle $configs $plugins $theme
	else
		zeesh_debug "using default settings"
		[[ $configs == 0 ]] || load_configs configs
		[[ $plugins == 0 ]] || load_plugins $plugins plugins
		[[ $theme == 0 ]] || load_themes $theme themes
	fi
}
