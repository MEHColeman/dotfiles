FROM ubuntu:22.04 AS start
LABEL maintainer="Mark Coleman <m@rkcoleman.co.uk>"
ENV DEBIAN_FRONTEND=noninteractive

# Create test user and add to sudoers

RUN apt-get update
RUN apt-get install -yqq sudo curl

RUN useradd -m -s /bin/zsh -p test tester
RUN usermod -aG sudo tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers
WORKDIR /home/tester

# Chown files
RUN chown -R tester:tester /home/tester

# Switch testuser
USER tester
ENV HOME /home/tester

# Change working directory
WORKDIR /home/tester/.dotfiles

CMD ["/bin/sh"]
