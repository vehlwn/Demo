set -o errexit

CAPTURE_MODE="$1"
set -o nounset

SAVE_DIR=~/tmp
mkdir --verbose -p -- "$SAVE_DIR"

NAME="Screenshot_$(date +%F_%H-%M-%S.%N).png"
SAVE_PATH="$SAVE_DIR/$NAME"
MESSAGE=""

case "$CAPTURE_MODE" in
    entire | "")
        import -window root "$SAVE_PATH"
        MESSAGE="Entire screen captured to '$SAVE_PATH'"
        ;;

   active)
        import -frame -window "$(xdotool getactivewindow)" "$SAVE_PATH"
        MESSAGE="Active window captured to '$SAVE_PATH'"
        ;;

   rect)
        import "$SAVE_PATH"
        MESSAGE="Rectangular area captured to '$SAVE_PATH'"
        ;;

    *)
        echo Unknown mode: $CAPTURE_MODE
        exit 1
esac

notify-send --expire-time 2000 "$MESSAGE"
xclip -selection clipboard -target "$(xdg-mime query filetype "$SAVE_PATH")" "$SAVE_PATH"
