FROM busybox:latest

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

#CMD ["/entrypoint.sh"]
CMD /bin/sh ./entrypoint.sh