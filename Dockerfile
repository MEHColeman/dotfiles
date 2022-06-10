FROM ubuntu:22.04
LABEL maintainer="Mark Coleman <m@rkcoleman.co.uk>"

# Create test user and add to sudoers
RUN useradd -m -s /bin/zsh tester
RUN usermod -aG sudo tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Add dotfiles and chown
ADD . /home/tester/.dotfiles

# Install the most commonly required packages and tools
# Some (like make) are prerequisites to the dotfile installation
RUN /home/tester/.dotfiles/install/basic_install

# Chown files
RUN chown -R tester:tester /home/tester

# Switch testuser
USER tester
ENV HOME /home/tester

# Change working directory
WORKDIR /home/tester/.dotfiles

# Run setup
RUN make target_env=generic_ubuntu all

CMD ["/bin/zsh"]
