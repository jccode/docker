#!/bin/sh


# Import gpg keys
KEY_FILE_DIR=~/ownCloud/tools/keyfiles

if [ -f $KEY_FILE_DIR/key.pub ]; then
    echo "Import gpg keys"
    gpg --import $KEY_FILE_DIR/key.pub
    gpg --pinentry-mode loopback --import $KEY_FILE_DIR/key.prv
fi

