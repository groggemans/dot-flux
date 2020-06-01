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
    mkdir -p "$ELLIPSIS_HOME/.config"
    fs.link_file "$PKG_PATH" "$ELLIPSIS_HOME/.config/flux"
    fs.link_file "$PKG_PATH/bin/flux" "$ELLIPSIS_HOME/.bin/flux"
    fs.link_file "$PKG_PATH/bin/xflux" "$ELLIPSIS_HOME/.bin/xflux"

    mkdir -p "$ELLIPSIS_HOME/.config/autostart"
    fs.link_file "$PKG_PATH/flux.desktop" "$ELLIPSIS_HOME/.config/autostart/flux.desktop"
}

##############################################################################

pkg.pull() {
    # Use improved update strategy
    git remote update > /dev/null 2>&1
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
    rm "$ELLIPSIS_HOME/.bin/flux"
    rm "$ELLIPSIS_HOME/.bin/xflux"

    # Remove all links in the home folder
    hooks.unlink
}

##############################################################################

pkg.uninstall() {
    : # No action
}

##############################################################################
