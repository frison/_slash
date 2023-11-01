# syntax=docker/dockerfile:1
# escape=\
FROM dev/000-base-layered:local AS dev-000-base-layered
FROM scratch

COPY --from=dev-000-base-layered / /
USER human
WORKDIR /home/human
ENV HOME /home/human
ENV PATH /usr/local/bin:$PATH
ENV HOSTNAME machine
ENTRYPOINT ["/entrypoint.sh"]
CMD ["zsh"]
