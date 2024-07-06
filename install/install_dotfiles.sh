#!/usr/bin/env zsh

# Installing all the dotfiles in this repo
# Won't install any dpkgs or other software
set -e

# This is the absolute path to this repo's root directory
DOTFILES="$(realpath ${0:A:h}/..)"

# Doing this now so that env is all set up properly when we install things
source $DOTFILES/zsh/zshrc.symlink

info () {
    printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
    printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ''
    exit
}

link_file () {
    local src=$1 dst=$2

    local overwrite= backup= skip=
    local action=

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
    then
        if [[ "$overwrite_all" == "false" ]] && [[ "$backup_all" == "false" ]] && [[ "$skip_all" == "false" ]]
        then
            local currentSrc="$(readlink $dst)"

            if [[ "$currentSrc" == "$src" ]]
            then
                skip=true;
            else

                echo "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
                [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
                read -k 1 action

                case "$action" in
                  o )
                    overwrite=true;;
                  O )
                    overwrite_all=true;;
                  b )
                    backup=true;;
                  B )
                    backup_all=true;;
                  s )
                    skip=true;;
                  S )
                    skip_all=true;;
                  * )
                    ;;
                esac
            fi
        fi

        overwrite=${overwrite:-$overwrite_all}
        backup=${backup:-$backup_all}
        skip=${skip:-$skip_all}

        if [[ "$overwrite" == "true" ]]
        then
            rm -rf "$dst"
            success "removed $dst"
        fi

        if [[ "$backup" == "true" ]]
        then
            mv "$dst" "${dst}.backup"
            success "moved $dst to ${dst}.backup"
        fi

        if [[ "$skip" == "true" ]]
        then
            success "skipped $src"
        fi
    fi

    if [[ "$skip" != "true" ]]  # "false" or empty
    then
        ln -s "$1" "$2"
        success "linked $1 to $2"
    fi
}

info "Installing ${DOTFILES}"

# Link all the symlinks
for src in $(find -H "$DOTFILES" -maxdepth 2 -name '*.symlink' -not -path '*.git*') ; do
    dst="$HOME/.$(basename "${src%.*}")"
    overwrite_all=false backup_all=false skip_all=false
    info "Linking ${dst}"
    link_file "${src}" "${dst}"
done

# Run everything called install.sh
# This file isn't called install.sh so it doesn't get executed
for f in $(find -H "$DOTFILES" -maxdepth 2 -name 'install.sh' -not -path '*.git*') ; do
    f=$(realpath $f)

    info "Installing ${f}"
    sh -c "${f}"
    success "Installed ${f}"
done

