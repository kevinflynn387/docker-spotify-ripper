FROM ubuntu:latest
MAINTAINER kevinflynn387@gmail.com

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    	git wget iputils-ping lame build-essential libffi-dev python-pip python-dev python3-dev libffi-dev && \
	wget https://pkgs.rpmfusion.org/repo/pkgs/nonfree/libspotify/libspotify-12.1.51-Linux-x86_64-release.tar.gz/83efddcc195d6ff12b24c97c767a5e45/libspotify-12.1.51-Linux-x86_64-release.tar.gz && \
	tar xvf libspotify-12.1.51-Linux-x86_64-release.tar.gz && \
	rm -f libspotify-12.1.51-Linux-x86_64-release.tar.gz && \
	cd libspotify-12.1.51-Linux-x86_64-release && \
	make install prefix=/usr/local && \
	pip install setuptools && \
	pip install pyspotify && \
	git clone https://github.com/hbashton/spotify-ripper.git && \
	cd spotify-ripper && \
	python setup.py install && \
	apt-get autoremove && \
	apt-get clean && \
    	rm -rf /var/lib/apt/lists/* && \
    	rm -rf /tmp/

# where we write the files
VOLUME ["/data"]

ADD ./start.sh /start.sh
ADD ./spotify_appkey.key /root/.spotify-ripper/spotify_appkey.key
ADD ./config.ini /root/.spotify-ripper/config.ini
RUN chmod u+x  /start.sh
CMD ["/start.sh"]
