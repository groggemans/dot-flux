##############################################################################
# @file ellipsis.sh
# @date Dec, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

# Minimal ellipsis version
ELLIPSIS_VERSION_DEP='1.9.4'

# Package dependencies (informational/not used!)
ELLIPSIS_PKG_DEPS=''

##############################################################################

pkg.install(){
    : # No action
}

##############################################################################

pkg.link() {
    # Link package into ~/.flux
    mkdir -p "$ELLIPSIS_HOME/.flux"
    fs.link_file "$PKG_PATH" "$ELLIPSIS_HOME/.config/flux"

    mkdir -p "$ELLIPSIS_HOME/.config/autostart"
    fs.link_file "$PKG_PATH/flux.desktop" "$ELLIPSIS_HOME/.config/autostart/flux.desktop"
}

##############################################################################

pkg.init() {
    env_append_path "$PKG_PATH/bin"
}

##############################################################################

pkg.pull() {
    # Use improved update strategy
    git remote update 2>&1 > /dev/null
    if git.is_behind; then
        pkg.unlink
        git.pull
        pkg.link
    fi
}

##############################################################################

pkg.unlink() {
    # Remove config autostart link
    rm "$ELLIPSIS_HOME/.config/flux"
    rm "$ELLIPSIS_HOME/.config/autostart/flux.desktop"

    # Remove all links in the home folder
    hooks.unlink
}

##############################################################################

pkg.uninstall() {
    : # No action
}

##############################################################################
