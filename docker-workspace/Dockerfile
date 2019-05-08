FROM jcchen/emacs:latest

MAINTAINER Jessie.chen <jccode.chen@gmail.com>

ENV DEBIAN_FRONTEND noninteractive


# apt source ("http://mirrors.163.com")
ARG APT_MIRROR=
RUN /bin/bash -c 'if [[ -n "$APT_MIRROR" ]]; then sed -i 's#http://archive.ubuntu.com#$APT_MIRROR#g' /etc/apt/sources.list; fi'


# packages
RUN apt-get update --fix-missing
RUN apt-get -y install \
	git \
	software-properties-common \
	build-essential \
	xterm \
	wget \
	curl



ARG HOME=/root



#
# Common lisp
#
## --------------------

# ccl (Clozure CL)
# RUN wget -q https://github.com/Clozure/ccl/releases/download/v1.11.5/ccl-1.11.5-linuxx86.tar.gz \
# 	&& mkdir -p /usr/local/src \
# 	&& tar -C /usr/local/src -xf ccl-1.11.5-linuxx86.tar.gz

# ENV "PATH" "$PATH:/usr/local/src/ccl/scripts/"


# ccl
ENV CCL_VERSION 1.10
RUN mkdir -p /usr/local/src \
	&& cd /usr/local/src \
	&& curl -SL "ftp://ftp.clozure.com/pub/release/${CCL_VERSION}/ccl-${CCL_VERSION}-linuxx86.tar.gz" | tar xzv --exclude='.svn' --exclude='examples' \
	&& ln -s /usr/local/src/ccl/scripts/ccl64 /usr/local/bin/ccl


# quicklisp
# RUN  curl -SLO https://beta.quicklisp.org/release-key.txt \
# 	&& curl -SLO https://beta.quicklisp.org/quicklisp.lisp \
# 	&& curl -SLO https://beta.quicklisp.org/quicklisp.lisp.asc \
# 	&& gpg --import release-key.txt \
# 	&& gpg --verify quicklisp.lisp.asc quicklisp.lisp \
# 	&& echo "(quicklisp-quickstart:install)(let ((ql-util::*do-not-prompt* t))(ql:add-to-init-file))(ccl:quit 0)" >> quicklisp.lisp \
# 	&& ccl --load quicklisp.lisp \
# 	&& rm release-key.txt quicklisp.lisp quicklisp.lisp.asc


# RUN wget -O /quicklisp.lisp https://beta.quicklisp.org/quicklisp.lisp \
# 	&& ccl --batch --load /quicklisp.lisp --eval "(quicklisp-quickstart:install)"
# ADD .ccl-init.lisp $HOME/.ccl-init.lisp


RUN cd /tmp && curl -O https://beta.quicklisp.org/quicklisp.lisp \
	&& echo "(load \"quicklisp.lisp\") (quicklisp-quickstart:install :path \"/opt/quicklisp\") (ql::without-prompting (ql:add-to-init-file))" | ccl





## emacs config
# RUN git clone https://github.com/jccode/emacs.git $HOME/emacs \
#     && cd $HOME/emacs \
#     && git submodule init \
#     && git submodule update \
#     && cd plugins/haskell-mode \
#     && make haskell-mode-autoloads.el


RUN apt-get -y install curl
ADD build.el /tmp/build.el
RUN git clone https://github.com/jccode/emacs.d.git $HOME/emacs \
	&& cd $HOME/emacs \
    # && emacs -nw --batch --eval '(progn (load-file "~/emacs/init.el") (all-the-icons-install-fonts 1))'
	&& emacs -nw --batch --script /tmp/build.el \
	&& git config user.name jcchen.code && git config user.email jcchen.code@gmail.com \
	&& rm /tmp/build.el

ADD .emacs.d/ $HOME/.emacs.d/

# Fix org mode issue
RUN rm -rf $HOME/.emacs.d/elpa/org*/*.elc


# emacs epa, gpg
RUN git clone https://github.com/ecraven/pinentry-emacs.git $HOME/.emacs.d/pinentry-emacs
ADD .gnupg $HOME/.gnupg



# ledger

## build dependencies
# RUN apt-get -y install cmake doxygen \
#      libboost-system-dev libboost-dev python-dev gettext git \
#      libboost-date-time-dev libboost-filesystem-dev \
#      libboost-iostreams-dev libboost-python-dev libboost-regex-dev \
#      libboost-test-dev libedit-dev libgmp3-dev libmpfr-dev texinfo

## clone & build
# RUN git clone https://github.com/ledger/ledger /tmp/ledger && \
#     cd /tmp/ledger && \
# 	git submodule update --init && \
# 	./acprep make && \
# 	make check && \
# 	make install && \
# 	cd / && \
#     rm -rf /tmp/ledger

RUN add-apt-repository ppa:mbudde/ledger && \
    apt-get update && \
    apt-get -y install ledger



# blog (hugo)
ARG BLOG_DIR=$HOME/code/blog
RUN apt-get -y install hugo
RUN git clone https://github.com/jcchen9416/blog.git $BLOG_DIR \
	&& cd $BLOG_DIR \
	&& git submodule init \
	&& git submodule update \
	&& git config user.name jcchen9416 && git config user.email jcchen9416@gmail.com \
	&& cd $BLOG_DIR/public \
	&& git checkout master \
	&& git config user.name jcchen9416 && git config user.email jcchen9416@gmail.com
EXPOSE 1313





# clean
RUN apt-get autoclean && apt-get autoremove


# Add files
RUN mkdir $HOME/bin
ADD one-time-init.sh $HOME/bin


# ENTRYPOINT ["bash", "-c", "fcitx; /bin/bash; "]

ADD docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/bin/bash"]
