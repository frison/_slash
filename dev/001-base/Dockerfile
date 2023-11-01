# syntax=docker/dockerfile:1
# escape=\
FROM dev/000-base-layered:local as dev_000-base
FROM scratch

COPY --from=dev-000-base / /
USER human
WORKDIR /home/human
ENV HOME /home/human
ENV PATH /usr/local/bin:$PATH
ENV HOSTNAME machine
ENTRYPOINT ["/entrypoint.sh"]
CMD ["zsh"]
