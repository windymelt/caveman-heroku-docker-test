FROM ubuntu:16.04

ENV libs 'automake libcurl4-gnutls-dev make gcc curl bzip2 locales libev-dev bison libbison-dev'
RUN apt-get update \
  && apt-get install -y ${libs}

ENV roswell_archive_url 'https://github.com/roswell/roswell/archive/release.tar.gz'
RUN echo 'install roswell' \
  && curl -SL ${roswell_archive_url} \
  | tar -xzC /tmp/ \
  && cd /tmp/roswell-release \
  && sh bootstrap \
  && ./configure \
  && make \
  && make install \
  && rm -rf /tmp/roswell-release

# locale setting
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN ros setup && ros --version
ENV PATH /root/.roswell/bin:/usr/local/bin:$PATH
RUN ros install qlot
RUN ros install clack

# Assuming whole application directory is mounted as /app
WORKDIR /app/

COPY ./t ./t
COPY ./db ./db
COPY ./src ./src
COPY ./images ./images
COPY ./static ./static
COPY ./templates ./templates
COPY qlfile *.asd *.lisp docker-bootstrap.sh ./

RUN qlot install && qlot bundle

CMD ./docker-bootstrap.sh
