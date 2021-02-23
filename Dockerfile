FROM debian:stable-slim
MAINTAINER kevinflynn387 [https://github.com/kevinflynn387/] <kevinflynn387@gmail.com>

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
        git wget iputils-ping lame build-essential libffi-dev python3-venv python3-pip python3-dev vim && \
        wget https://github.com/kevinflynn387/docker-spotify-ripper-ubuntu/raw/master/libspotify-12.1.51-Linux-x86_64-release.tar.gz && \
        tar xvf libspotify-12.1.51-Linux-x86_64-release.tar.gz && \
        rm -f libspotify-12.1.51-Linux-x86_64-release.tar.gz && \
        cd libspotify-12.1.51-Linux-x86_64-release && \
        make install prefix=/usr/local && \
        pip3 install setuptools && \
        pip3 install pyspotify && \
        git clone https://github.com/hbashton/spotify-ripper.git && \
        cd spotify-ripper && \
        python3 setup.py install && \
        apt-get autoremove && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* && \
        rm -rf /tmp/

# where we write the files
VOLUME ["/data"]

ENV USER=spotifyripper
ENV UID=1001
ENV GID=100
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $USER

ADD ./start.sh /start.sh
ADD ./spotify_appkey.key /home/spotifyripper/.spotify-ripper/spotify_appkey.key
ADD ./config.ini /home/spotifyripper/.spotify-ripper/config.ini
RUN chmod u+x  /start.sh /home/spotifyripper/.spotify-ripper/spotify_appkey.key /home/spotifyripper/.spotify-ripper/config.ini
RUN chown $UID:$GID /start.sh
USER $USER
CMD ["/start.sh"]
