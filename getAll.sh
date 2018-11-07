#in case ubuntu deletes all debs, pull them all back down

apt-get install --reinstall -d $(for pkg in `dpkg --get-selections | awk '{print $1}' ` ; do echo $pkg; done  | grep -v cudnn | tr '\n' ' ')
