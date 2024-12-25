FROM rockylinux/rockylinux:9 AS fetcher

RUN \
  useradd --create-home -u 50000 -G 100 jenkins
RUN \
  dnf install -y git

USER jenkins

RUN \
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o /tmp/rustup.sh && \
  sh /tmp/rustup.sh -y && \
  . "$HOME/.cargo/env" && \
  rustup toolchain install nightly && \
  rustup default nightly

WORKDIR /directory

CMD ["bash"]

