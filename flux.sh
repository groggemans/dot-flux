#!/usr/bin/env bash

if [ -f ~/.config/flux/flux.conf ]; then
    source ~/.config/flux/flux.conf
elif [ -f ~/.flux.conf ]; then
    source ~/.flux.conf
elif [ -f ~/.flux ]; then
    source ~/.flux
fi

OPTIONS="${OPTIONS:-}"

add_option() {
    flag="$1"
    option="$2"

    if [ -n "$option" ]; then
        OPTIONS="$OPTIONS $flag $option"
    fi
}

add_option '-z' "$ZIPCODE"
add_option '-l' "$LATITUDE"
add_option '-g' "$LONGITUDE"
add_option '-k' "$COLORTEMP"
add_option '-r' "$USERANDR"

~/.config/flux/bin/xflux $OPTIONS
