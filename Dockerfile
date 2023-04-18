FROM golang:1.19.5-bullseye
#FROM alt:p8

COPY binaryFiles/main /etc/watcher/main
COPY binaryFiles/watcher.sh /etc/watcher/watcher.sh
COPY binaryFiles/data.txt /etc/watcher/data.txt


USER 0

RUN groupadd main -g 50000 && \
    useradd main -u 10000 -g main -G root -M -d /etc/watcher/ \
    && chown 10000:50000 /etc/watcher/main \
    && chown 10000:50000 /etc/watcher/watcher.sh \
    && chown 10000:50000 /etc/watcher/data.txt \
    && chmod 500 /etc/watcher/main \
    && chmod 500 /etc/watcher/watcher.sh \
    && chmod 500 /etc/watcher/data.txt


USER 10000:50000

EXPOSE 8080

ENTRYPOINT ["/etc/watcher/watcher.sh"]
