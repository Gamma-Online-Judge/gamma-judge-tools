FROM ubuntu:21.10

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y tzdata locales

# Set the timezone
RUN echo "Europe/Berlin" | tee /etc/timezone && \
    ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Set the locale for UTF-8 support
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen && \
    locale-gen && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# AWS CLI needs the PYTHONIOENCODING environment varialbe to handle UTF-8 correctly:
ENV PYTHONIOENCODING=UTF-8

# man and less are needed to view 'aws <command> help'
# ssh allows us to log in to new instances
# vim is useful to write shell scripts
# python* is needed to install aws cli using pip install

RUN apt-get install -y \
    less \
    man \
    ssh \
    python \
    python3-pip 

RUN pip3 install awscli


# MojTools deps 

RUN apt-get install -y \
    time \
    bubblewrap \
    bc \
    cpuset \
    fpc \
    spim \
    ocaml-nox

COPY . .

ENTRYPOINT ["sh", "entrypoint.sh"]