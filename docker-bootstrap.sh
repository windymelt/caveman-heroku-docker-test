#!/bin/bash

PORT=${PORT:-5000}

exec qlot exec ros \
  -e "(ql:quickload :swank)" \
  -e "(setf swank::*loopback-interface* \"0.0.0.0\")" \
  -e "(swank:create-server :port 6005 :dont-close t :style :spawn)" \
  -l bundle-libs/bundle.lisp \
  -S . ~/.roswell/bin/clackup --server :woo --address 0.0.0.0 --address :: --port $PORT app.lisp
