OPTIONAL_APPS=("Spotify" "Discord" "OBS Studio" "Steam" "VirtualBox" "Windows")
DEFAULT_OPTIONAL_APPS='Discord,Spotify'
export DEVKIT_FIRST_RUN_OPTIONAL_APPS=$(gum choose "${OPTIONAL_APPS[@]}" --no-limit --selected $DEFAULT_OPTIONAL_APPS --height 7 --header "Select optional apps" | tr ' ' '-')

AVAILABLE_LANGUAGES=("Node.js" "Go" ".NET" "PHP" "Python" "Elixir" "Rust" "Java")
SELECTED_LANGUAGES="Rust","Node.js"
export DEVKIT_FIRST_RUN_LANGUAGES=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --selected "$SELECTED_LANGUAGES" --height 10 --header "Select programming languages")

AVAILABLE_DBS=("MySQL" "Redis" "PostgreSQL")
SELECTED_DBS="PostgreSQL"
export DEVKIT_FIRST_RUN_DBS=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --selected "$SELECTED_DBS" --height 5 --header "Select databases (runs in Docker)")
