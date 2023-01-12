FROM golang:1.20rc3-buster
#FROM alt:p8

COPY binaryFiles/main /etc/watcher/main
COPY binaryFiles/watcher.sh /etc/watcher/watcher.sh


USER 0

RUN ln /bin/bash /etc/watcher/bash

RUN groupadd main -g 50000 && \
    useradd main -u 10000 -g main -M -d /etc/watcher/ \
    && chown 10000:50000 /etc/watcher/main \
    && chown 10000:50000 /etc/watcher/watcher.sh \
    && chown 10000:50000 /etc/watcher/bash \
    && chmod 500 /etc/watcher/main \
    && chmod 500 /etc/watcher/watcher.sh \
    && chmod 505 /etc/watcher/bash

USER 10000:50000

EXPOSE 8080

#ENTRYPOINT ["/etc/watcher/watcher.sh"]
CMD ["/etc/watcher/bash", "-c", "/etc/watcher/watcher.sh"]
