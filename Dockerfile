FROM binwiederhier/ntfy:latest
EXPOSE 80
CMD ["serve", \
     "--listen-http", ":80", \
     "--base-url", "https://hardik-relay.onrender.com", \
     "--cache-file", "/var/cache/ntfy/cache.db", \
     "--attachment-cache-dir", "/var/cache/ntfy/attachments", \
     "--attachment-file-size-limit", "25M", \
     "--behind-proxy"]
