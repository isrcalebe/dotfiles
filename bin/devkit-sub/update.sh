CHOICES=(
	"DevKit        Update DevKit itself and run any migrations"
	"LazyGit       TUI for Git"
	"LazyDocker    TUI for Docker"
	"Neovim        Text editor that runs in the terminal"
	"Zellij        Adds panes, tabs, and sessions to the terminal"
	"<< Back       "
)

CHOICE=$(gum choose "${CHOICES[@]}" --height 10 --header "Update manually-managed applications")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
	# Don't update anything
	echo ""
else
	INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

	case "$INSTALLER" in
	"omakub") INSTALLER_FILE="$DEVKIT_PATH/bin/devkit-sub/migrate.sh" ;;
	"localsend") INSTALLER_FILE="$DEVKIT_PATH/install/desktop/app-localsend.sh" ;;
	"ollama") INSTALLER_FILE="$DEVKIT_PATH/install/terminal/optional/app-ollama.sh" ;;
	*) INSTALLER_FILE="$DEVKIT_PATH/install/terminal/app-$INSTALLER.sh" ;;
	esac

	source "$INSTALLER_FILE" && gum spin --spinner globe --title "Update completed!" -- sleep 3
fi

clear
source "$DEVKIT_PATH/bin/devkit"