# zeesh bundler

# loads themes

load_themes() {
        zeesh_debug "setting theme"

        if [[ $1 == "random" ]]; then
                zeesh_debug "using random theme"
                local themes=($BUNDLE/themes/*.zsh-theme)
                local n=${#themes[@]}
                ((n=(RANDOM%n)+1))
                local rand_theme=$themes[$n]
                source $rand_theme
                zeesh_message "$BUNDLE:t - loaded random theme $rand_theme"
        else
                if [[ ! -z $1 ]] && [[ -e "$BUNDLE/themes/$1.zsh-theme" ]]; then
                        zeesh_debug "file $1.zsh-theme found"
                        source "$BUNDLE/themes/$1.zsh-theme"
                        zeesh_message "$BUNDLE:t - loaded theme $1"
                else
                        zeesh_warning "$BUNDLE:t - theme $1 not found, using default values"
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
                                zeesh_warning "$BUNDLE:t - $plugin isn't zeesh/oh-my-zshell compatable"
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

	# sets the bundle dir

	BUNDLE="$ROOT_DIR/bundles/$1"

	# checks for exceptions

	if [[ ! -d $BUNDLE ]]; then
		zeesh_error "bundle $BUNDLE:t not found"
		return 110
	fi

        if [[ ! -d "$BUNDLE/lib" ]]; then
                zeesh_error "configs folder not found in bundle $BUNDLE:t (broken bundle?)"
                return 111
        fi

        if [[ ! -d "$BUNDLE/plugins" ]]; then
                zeesh_error "plugins folder not found in bundle $BUNDLE:t (broken bundle?)"
                return 112
        fi

        if [[ ! -d "$BUNDLE/themes" ]]; then
                zeesh_error "themes folder not found in bundle $BUNDLE:t (broken bundle?)"
                return 113
        fi

	zeesh_message "loading bundle $BUNDLE:t"

	# loads everything

	load_libs

	if [[ -z "$2" ]]; then
                zeesh_warning "plugins from this bundle won't be loaded"     
	else
		load_plugins $2
	fi

	if [[ -z "$3" ]]; then
		zeesh_warning "a theme from this bundle won't be loaded"
	else
		load_themes $3
	fi
}
