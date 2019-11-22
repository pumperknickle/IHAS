FROM ubuntu:xenial

RUN apt-get update
RUN apt-get install -y build-essential \
      libpcap-dev \
      libdnet-dev \
      libevent-dev \
      libpcre3-dev \
      make \
      bzip2 \
      nmap \
      psmisc \
      libtool \
      libdumbnet-dev \
      zlib1g-dev \
      rrdtool \
      net-tools \
      git-core \
      libreadline-dev \
      libedit-dev \
      bison \
      flex \
      farpd \
      lftp \
      iputils-ping \
      sudo \
      automake

RUN apt-get update && \
    apt-get install -y \
    zip \
    unzip \
    python \
    python-pyx \
    python-matplotlib \
    tcpdump \
    python-crypto \
    graphviz \
    imagemagick \
    gnuplot \
    python-gnuplot \
    python-dev \
    python-pip \
    libpcap-dev && apt-get clean

RUN git clone https://github.com/DataSoft/Honeyd.git
ADD honeyd.conf /Honeyd
ADD sniffagent.py /Honeyd

RUN cd Honeyd \
  && ./autogen.sh \
  && ./configure \
  && make \
  && make install

RUN apt-get install -y ftp-ssl
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /Honeyd/logs
RUN touch "/Honeyd/logs/test.log"
RUN ip a

RUN pip install scapy==2.3.2

EXPOSE 445
EXPOSE 16992
EXPOSE 16993

RUN honeyd -i eth0
CMD ["python", "/Honeyd/sniffagent.py"]
