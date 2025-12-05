FROM ghcr.io/basecamp/fizzy:main

USER root

# Copy custom config for containerized deployment
COPY config/database.yml /rails/config/database.yml
COPY config/initializers/smtp.rb /rails/config/initializers/smtp.rb
COPY config/initializers/url_options.rb /rails/config/initializers/url_options.rb
COPY --chmod=755 bin/start /rails/bin/start

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD curl -f http://localhost/up || exit 1

EXPOSE 80
CMD ["./bin/start"]
