FROM binwiederhier/ntfy:latest
EXPOSE 80
CMD ["serve", \
     "--listen-http", ":80", \
     "--base-url", "https://hardik-relay.onrender.com", \
     "--cache-file", "/tmp/cache.db", \
     "--attachment-cache-dir", "/tmp/attachments", \
     "--attachment-file-size-limit", "30M", \
     "--attachment-expiry-duration", "24h", \
     "--behind-proxy"]
