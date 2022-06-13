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

# Add dotfiles and chown
FROM start AS temp_files
ADD https://github.com/MEHColeman/dotfiles/archive/refs/heads/master.zip /temp/
RUN apt-get update -qq
RUN apt-get install -yqq unzip
RUN unzip /temp/master.zip

FROM start AS final
COPY --from=temp_files /home/tester/dotfiles-master /home/tester/.dotfiles

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

CMD ["/bin/sh"]
