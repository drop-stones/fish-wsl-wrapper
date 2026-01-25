function _wslwrap_in_windows_filesystem --argument-names path --description 'Detect if current directory is in Windows filesystem (/mnt/[a-z]/)'
    return (string match -rq '^/mnt/[a-z](?:/|$)' -- $path)
end
