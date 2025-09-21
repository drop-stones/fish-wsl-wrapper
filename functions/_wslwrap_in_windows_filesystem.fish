function _wslwrap_in_windows_filesystem --description 'Detect if current directory is in Windows filesystem (/mnt/[a-z]/)'
    return (string match -qr '^/mnt/[a-z]/' -- (pwd))
end
