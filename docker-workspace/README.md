
Build
=====

    docker build -t jcchen/workspace --build-arg APT_MIRROR=http://mirrors.163.com .


Usage
=====

1. Run `bash`.

        docker run --rm --name workspace -it -e DISPLAY="$DISPLAY" -v "/d:/windows/d" -v "/e:/windows/e" -v "/f:/windows/f" -v "/c/Users/01372461/ownCloud:/root/ownCloud" jcchen/workspace:latest

    or

        docker run --rm --name workspace -it -e DISPLAY="$DISPLAY" -v "/d:/windows/d" -v "/e:/windows/e" -v "/f:/windows/f" -v "/c/Users/01372461/ownCloud:/root/ownCloud" jcchen/workspace:latest bash

2. Run emacs.

    Run `bash`, then type 'emacs' to launch it.

    or

    Run directly

        docker run --rm --name workspace -e DISPLAY="$DISPLAY" -v "/d:/windows/d" -v "/e:/windows/e" -v "/f:/windows/f" -v "/c/Users/01372461/ownCloud:/root/ownCloud" jcchen/workspace:latest emacs

