FROM alpine:latest

ENV LANG=C.UTF-8
ENV TERM=xterm-256color

# -------------------------------------------------
# Base packages
# -------------------------------------------------
RUN apk update && apk add --no-cache \
  bash \
  zsh \
  git \
  curl \
  wget \
  ca-certificates \
  build-base \
  cmake \
  unzip \
  tar \
  gzip \
  ripgrep \
  fzf \
  fd \
  python3 \
  py3-pip \
  fontconfig \
  openssl-dev \
  musl-dev \
  neovim \
  font-hack-nerd

# Rust
# -------------------------------------------------
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
  | sh -s -- -y --no-modify-path

ENV PATH="/root/.cargo/bin:${PATH}"

RUN rustup default stable \
  && rustup component add rustfmt clippy rust-analyzer


# -------------------------------------------------
# Neovim upgrade
# -------------------------------------------------
# RUN echo "http://dl-cdn.alpinelinux.org/edge/community" >> /etc/apk/repositories \
# && apk update && apk upgrade neovim \


# -------------------------------------------------
# Install lazyvim
# -------------------------------------------------
RUN git clone https://github.com/LazyVim/starter ~/.config/nvim \
  && rm -rf ~/.config/nvim/.git \
  && echo 'require("lazyvim").setup({ colorscheme = "habamax", })' >> /root/.config/nvim/lua/config/lazy.lua \
  && echo 'vim.o.shell = "/bin/zsh"' >> /root/.config/nvim/lua/config/options.lua


# -------------------------------------------------
# Oh My Zsh
# -------------------------------------------------
RUN git clone https://github.com/ohmyzsh/ohmyzsh.git /root/.oh-my-zsh \
  && curl -fsSL 'https://raw.githubusercontent.com/sanek200000/Linux_sources/refs/heads/main/.zshrc' -o /root/.zshrc \
  && curl -fsSL 'https://raw.githubusercontent.com/sanek200000/Linux_sources/refs/heads/main/heist.zsh-theme' -o /root/.oh-my-zsh/themes/heist.zsh-theme \
  && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/plugins/zsh-syntax-highlighting \
  && git clone https://github.com/zsh-users/zsh-autosuggestions.git /root/.oh-my-zsh/plugins/zsh-autosuggestions


WORKDIR /workspace
CMD ["zsh"]

