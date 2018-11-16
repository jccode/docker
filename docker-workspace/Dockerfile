FROM jcchen/emacs:latest

MAINTAINER Jessie.chen <jccode.chen@gmail.com>

ENV DEBIAN_FRONTEND noninteractive


# apt source ("http://mirrors.163.com")
ARG APT_MIRROR=
RUN /bin/bash -c 'if [[ -n "$APT_MIRROR" ]]; then sed -i 's#http://archive.ubuntu.com#$APT_MIRROR#g' /etc/apt/sources.list; fi'


# packages
RUN apt-get -y install \
    git \
    build-essential \
    xterm

ARG HOME=/root

# emacs config
RUN git clone -b http https://github.com/jccode/emacs.git $HOME/emacs \
    && cd $HOME/emacs \
    && git submodule init \
    && git submodule update \
    && cd plugins/haskell-mode \
    && make haskell-mode-autoloads.el

ADD .emacs.d/ $HOME/.emacs.d/


# clean
RUN apt-get autoclean && apt-get autoremove


# ENTRYPOINT ["bash", "-c", "fcitx; /bin/bash; "]

ADD docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/bin/bash"]