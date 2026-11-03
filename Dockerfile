FROM binwiederhier/ntfy:latest
EXPOSE 80
CMD ["serve", \
     "--listen-http", ":80", \
     "--base-url", "https://hardik-relay.onrender.com", \
     "--cache-file", "/tmp/cache.db", \
     "--attachment-cache-dir", "/tmp/attachments", \
     "--attachment-file-size-limit", "200M", \
     "--attachment-total-size-limit", "2G", \
     "--visitor-attachment-daily-bandwidth-limit", "5G", \
     "--attachment-expiry-duration", "24h", \
     "--behind-proxy"]
