function _wslwrap_normalize_path --description "Strip embedded \r from WSLWRAP_PATH entries"
    set -q WSLWRAP_PATH; or return
    # Idempotent: only rewrite when \r is actually present (avoids --on-variable recursion)
    string match -q '*\r*' -- $WSLWRAP_PATH; or return

    set -l cleaned
    for entry in $WSLWRAP_PATH
        set -a cleaned (string replace -a \r '' -- $entry)
    end
    set -gx WSLWRAP_PATH $cleaned
end
