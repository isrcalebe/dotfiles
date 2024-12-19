ohai_section_begin "optional apps"

if [[ -v DEVKIT_FIRST_RUN_OPTIONAL_APPS ]]; then
	apps=$DEVKIT_FIRST_RUN_OPTIONAL_APPS

	if [[ -n "$apps" ]]; then
		for app in $apps; do
			source "$DEVKIT_PATH/install/desktop/optional/app-${app,,}.sh"
		done
	fi
fi

ohai_section_end "optional apps"
