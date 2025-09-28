function _wslwrap_links --description "List Windows exe symlinks in /usr/local/bin"
    for file in /usr/local/bin/*
        if test -L $file
            set -l target (readlink $file)
            if _wslwrap_in_windows_filesystem $target
                basename "$file"
            end
        end
    end
end
