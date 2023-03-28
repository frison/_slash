FROM jekyll/jekyll:latest

COPY --chown=jekyll:jekyll ./files /
RUN /bootstrap.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["echo", "Static Site Successfully Generated"]
