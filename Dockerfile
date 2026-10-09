FROM binwiederhier/ntfy:latest
EXPOSE 80
CMD ["serve", "--listen-http", ":80", "--cache-file", "/var/cache/ntfy/cache.db", "--behind-proxy"]
