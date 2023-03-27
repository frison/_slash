FROM jekyll/jekyll:latest

# Permission Issues not doing this, doesn't matter b/c only used
# for static site generation.
RUN chown -R root:root /usr/gem && \
    chmod 777 -R /usr/gem

COPY ./files /
RUN /bootstrap.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["echo", "Static Site Successfully Generated"]
