FROM jekyll/jekyll:latest

COPY --chown=jekyll:jekyll ./files /
RUN /bootstrap.sh
COPY --chown=jekyll:jekyll ./*.md /
# To have "containers-as-a-service" we need to be able to mutate the container at runtime
# which requires that to happen in the entrypoint. To speed up the development cycle,
# we can copy the files that we're working on after
# This can also be accomplished via a volume mount, but that's a bit more complicated.
# COPY --chown=jekyll:jekyll ./rabbit_files /

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["echo", "Static Site Successfully Generated"]
