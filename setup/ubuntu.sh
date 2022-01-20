## Setup of tools to ubuntu 21.10 the codes may be different for other systems

apt-get update && \
    apt-get upgrade -y 

# AWS dependences
apt-get install -y \
    less \
    man \
    ssh \
    python \
    python3-pip \
    jq \
    jo

pip3 install awscli

# Configure AWS envoriment files
source .env


# Mojitools dependences
apt-get install -y \
    time \
    bubblewrap \
    bc \
    cpuset \
    fpc \
    spim \
    ocaml-nox

bash mojtools/check-deps.sh
