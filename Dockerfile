FROM binwiederhier/ntfy:latest
EXPOSE 80
CMD ["serve", "--listen-http", ":80", "--behind-proxy", "--cache-file", ""]
