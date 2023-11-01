# syntax=docker/dockerfile:1
# escape=\
FROM dev/000-base-layered:local AS dev_000-base
FROM scratch

COPY --from=dev_000-base / /
USER human
WORKDIR /home/human
ENV HOME /home/human
ENV PATH /usr/local/bin:$PATH
ENV HOSTNAME machine
ENTRYPOINT ["/entrypoint.sh"]
CMD ["zsh"]
