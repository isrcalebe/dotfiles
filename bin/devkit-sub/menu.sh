if [ $# -eq 0 ]; then
	SUB=$(gum choose "Update" "Install" "Uninstall" "Quit" --height 10 --header "" | tr '[:upper:]' '[:lower:]')
else
	SUB=$1
fi

[ -n "$SUB" ] && [ "$SUB" != "quit" ] && source "$DEVKIT_PATH/bin/omakub-sub/$SUB.sh"
