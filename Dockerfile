# syntax=docker/dockerfile:1
FROM alpine

EXPOSE 8080 8081 8082 8083 8084 8085

# Install packages
RUN apk add --no-cache \
    bash \
    build-base \
    libffi-dev \
    libc-dev \
    libtool \
    fd \
    fd-bash-completion \
    curl \
    go \
    build-base \
    fzf \
    libffi-dev \
    python3-dev \
    gpgme-dev \
    libc-dev \
    ripgrep \
    tree \
    git \
    xclip \
    python3 \
    py3-pip \
    nodejs \
    npm \
    tzdata \
    gettext \
    libtool \
    autoconf \
    automake \
    cmake \
    g++ \
    zip \
    starship \
    unzip

RUN ln -sf /bin/bash /bin/sh

# Install neovim and lsp's
RUN apk add neovim
RUN pip3 install pynvim black jsontool
RUN npm i -g neovim prettier bash-language-server vscode-langservers-extracted pyright typescript typescript-language-server vim-language-server yaml-language-server emmet-ls eslint

# Install packer
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Copy nvim config
RUN mkdir -p /root/.config/nvim
WORKDIR /root/.config/nvim
COPY init.lua .
COPY ./lua/ ./lua/
COPY ./plugin/ ./plugin/

# Switch to startup init.lua and packer install
WORKDIR /root/.config/nvim/lua/config
RUN cp init.lua _init.lua
RUN cp init_startup.lua init.lua
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
RUN cp _init.lua init.lua
RUN rm _init.lua

# Copy bash configs
COPY ./home/ /root/
RUN chmod +x /home/*.sh

# Setup go space
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
ARG GH_USER

RUN mkdir -p ${GOPATH}/src/github.com/$GH_USER ${GOPATH}/bin
RUN go install golang.org/x/tools/gopls@latest

# Create project workspace
RUN mkdir -p /root/workspace
WORKDIR /root/workspace

CMD ["tail", "-f", "/dev/null"]
