FROM ubuntu:18.04
MAINTAINER Mark Coleman <m@rkcoleman.co.uk>

# OS updates and install
# git curl zsh ca-certificates and openssh-client needed for oh-my-zsh
# installation
# make needed for dotfile installations
RUN apt-get -qq update
RUN apt-get install -yqq --no-install-recommends git sudo zsh make curl \
            ca-certificates openssh-client -qq -y

# Create test user and add to sudoers
RUN useradd -m -s /bin/zsh tester
RUN usermod -aG sudo tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Add dotfiles and chown
ADD . /home/tester/.dotfiles
RUN chown -R tester:tester /home/tester

# Switch testuser
USER tester
ENV HOME /home/tester

# Change working directory
WORKDIR /home/tester/.dotfiles

# Run setup
RUN make target_env=generic_ubuntu all

CMD ["/bin/zsh"]

