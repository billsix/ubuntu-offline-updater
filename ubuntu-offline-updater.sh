# arch-offile-updater.sh


# The MIT License (MIT)

# Copyright (c) 2018 William Emerison Six

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.




# arch-offile-updater.sh
#
# A program which allows an online Arch system to be
# mirrored to an offline Arch system.
#
# Before this script can be run, you need to make an
# Arch install on a machine with an internet connection.
# The partition size should be very small (say 8GB), so that
# you can then run "dd" on the partition, (and use "split"
# if needed to burn onto 2 DVDs).
#
# On the offline system, use the Arch live dvd to
# "dd" the image onto the offline system's harddrive.
# Use resize2fs to expand the filesystem to use the full
# harddrive.  Then finish the arch installation. (bootloader,
# update /etc/fstab to have the UUIDs, etc)
#
# (Side note, given that I split my "dd"ed image onto two DVDs, I needed
# to "cat" them both to /dev/shm/ (which is just a RAM
# based filesystem), because the filesystem in the
# Arch installer live DVD did not have enough space
# to put a 8GB image before "dd"ing it to the harddrive)
#
# Once the offline system is functional, you will want
# to get updated packages over time.  That is what this
# script does.
#
# On the online system, run "pacman -Syuu" to update the
# system, or install any new packages using "pacman -S".
#
# Then run this script, which will make a directory which
# contains 1) All of the gpg signatures in /etc/pacman.d
# 2) The package metadata in /var/lib/pacman/sync and
# 3) All of the packages in /var/cache/pacman/pkg.
# Now burn the create directory to a DVD, and extract
# on the offline system using arch-update-apply.sh as root.
#
# This script also then deletes the contents of /var/cache/pacman/sync,
# so that when you run the script again a month later, you
# don't have to reburn packages which have already been transferred.
#
#




# create directory into which the updates will go
filename=sync$(date '+%Y-%m-%d-%H-%M-%S')
mkdir $filename
cp arch-update-apply.sh $filename/
cd $filename

# zip the appropriate files
tar -cvf - /var/lib/pacman/sync/ | gzip > varlibpacmansync.tgz
tar -cvf - /var/cache/pacman/pkg/ | gzip > varcachepacmanpkg.tgz
tar -cvf - /etc/pacman.d/ | gzip > etcpacmand.tgz

# delete the packages from the local system, so that they are
# not transferred multiple times.
rm -rf /var/cache/pacman/pkg/*
cd ..


