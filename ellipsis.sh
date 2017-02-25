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
    if [ "$ELLIPSIS_INIT" != '1' ]; then
        log.fail "Unmet dependency 'Ellipsis-init'"
        return 1
    fi
}

##############################################################################

pkg.link() {
    # Link rc file
    fs.link_file taskrc

    # Link package into ~/.config/task
    mkdir -p "$ELLIPSIS_HOME/.config"
    fs.link_file "$PKG_PATH" "$ELLIPSIS_HOME/.config/task"
}

##############################################################################

pkg.init() {
    . "$PKG_PATH/functions.sh"
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
    # Remove config dir
    rm "$ELLIPSIS_HOME/.config/task"

    # Remove all links in the home folder
    hooks.unlink
}

##############################################################################

pkg.uninstall() {
    : # No action
}

##############################################################################
