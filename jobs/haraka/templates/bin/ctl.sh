#!/bin/bash

JOB=haraka
USER=vcap
RUN_DIR=/var/vcap/sys/run/${JOB}
LOG_DIR=/var/vcap/sys/log/${JOB}
PKG_DIR=/var/vcap/packages/${JOB}
PIDFILE=${RUN_DIR}/pid
PATH=${PATH}:/var/vcap/packages/node/bin

case ${1} in
    start)
        mkdir -p ${RUN_DIR} ${LOG_DIR}
        chown -R ${USER}:${USER} ${RUN_DIR} ${LOG_DIR}

        cd ${PKG_DIR}

		node haraka.js

        ;;
    stop)
        kill -9 `cat ${PIDFILE} && rm -rf ${PIDFILE}`
        ;;
    *)
        echo "Usage: ctl {start|stop}"
        ;;
esac
