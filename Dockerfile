# Docked Fedora for Fluka building (and running)
# ========================================================
# dr.vittorio.boccone@ieee.org
# vittorio.boccone@dectris.com
#
# Rebuild: 
#   > docker build -t fedora_27-fluka . 
#
# Run image (w/o mount point volumes):
#   > docker run --rm -i -t fedora_27-fluka bash
#
# Run image with volumes and X11 passthough 
#   > docker run -i --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v $(pwd):/local_path -t

FROM  fedora:27

# RUN echo "http_caching=none" >> /etc/yum.conf
RUN dnf clean all
RUN dnf install -y yum-plugin-ovl

RUN dnf install -y make cpp gcc gcc-gfortran glibc-devel glibc-headers kernel-headers libgfortran emacs
RUN dnf install -y git git-lfs subversion lsof wget sed gawk diffutils vim nano

# Install flair from Vasilis's page
RUN dnf install -y http://www.fluka.org/flair/flair-2.3-0.noarch.rpm
RUN dnf install -y http://www.fluka.org/flair/flair-geoviewer-2.3-0.x86_64.rpm

# Install root and pyroot
RUN dnf install -y root* python2-root

# Install ipython scipy 
RUN dnf install -y scipy  ipython

# Add default user
RUN groupadd -g 10000 fluka
RUN useradd -r -u 1000 -g fluka fluka-user

ENV LOGNAME=fluka-user
ENV USER=fluka-user

RUN mkdir -p /opt/fluka

ENV FLUFOR=gfortran
ENV FLUPRO=/opt/fluka
