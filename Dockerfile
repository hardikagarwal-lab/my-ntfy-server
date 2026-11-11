FROM binwiederhier/ntfy:latest
EXPOSE 80
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["mkdir -p /tmp/attachments /tmp/saved_notes && \
      (while true; do \
        LATEST_NOTE=$( wget -qO- \"http://127.0.0.1:80/hardik_notes_992/json?poll=1&since=24h\" 2>/dev/null | grep '\"name\":\"notes_db.json\"' | tail -n 1 | sed -n 's/.*\"url\":\"\\([^\"]*\\)\".*/\\1/p' ); \
        if [ -n \"$LATEST_NOTE\" ]; then \
          FILE_ID=$(basename \"$LATEST_NOTE\"); \
          if [ -f \"/tmp/attachments/$FILE_ID\" ]; then \
            cp -f \"/tmp/attachments/$FILE_ID\" /tmp/saved_notes/notes_db.json 2>/dev/null; \
          fi; \
        fi; \
        USED=$(du -sm /tmp/attachments 2>/dev/null | cut -f1); \
        if [ -n \"$USED\" ] && [ \"$USED\" -ge 320 ]; then \
          wget -qO- --post-data=\"⚠️ Storage hit ${USED}MB. Clearing old chat videos while keeping Study Notes safe...\" http://127.0.0.1:80/hardik_sync_992 >/dev/null 2>&1; \
          rm -rf /tmp/attachments/*; \
          if [ -f /tmp/saved_notes/notes_db.json ]; then \
            wget -qO- --header=\"Filename: notes_db.json\" --post-file=/tmp/saved_notes/notes_db.json http://127.0.0.1:80/hardik_notes_992 >/dev/null 2>&1; \
          fi; \
        fi; \
        if wget -qO- \"http://127.0.0.1:80/hardik_sync_992/raw?poll=1&since=15s\" 2>/dev/null | grep -q \"CLEAN_TMP_NOW\"; then \
          rm -rf /tmp/attachments/*; \
          if [ -f /tmp/saved_notes/notes_db.json ]; then \
            wget -qO- --header=\"Filename: notes_db.json\" --post-file=/tmp/saved_notes/notes_db.json http://127.0.0.1:80/hardik_notes_992 >/dev/null 2>&1; \
          fi; \
          wget -qO- --post-data=\"✅ Chat videos cleared! Your Study Notes were safely preserved.\" http://127.0.0.1:80/hardik_sync_992 >/dev/null 2>&1; \
        fi; \
        sleep 12; \
      done) & \
      ntfy serve \
        --listen-http :80 \
        --base-url https://hardik-relay.onrender.com \
        --cache-file /tmp/cache.db \
        --cache-duration 3600h \
        --attachment-cache-dir /tmp/attachments \
        --attachment-file-size-limit 200M \
        --attachment-total-size-limit 400M \
        --visitor-attachment-daily-bandwidth-limit 5G \
        --attachment-expiry-duration 3600h \
        --behind-proxy"]
