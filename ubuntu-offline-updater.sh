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




# create directory into which the updates will go
filename=sync$(date '+%Y-%m-%d-%H-%M-%S')
mkdir $filename
cp ubuntu-update-apply.sh $filename/
cd $filename

# zip the appropriate files
tar -cvf - /var/lib/apt/lists | gzip > varlibaptlistssync.tgz
tar -cvf - /var/cache/apt/archives | gzip > varcacheaptarchives.tgz
tar -cvf - /etc/apt/sources.list.d/ | gzip > sourceslistd.tgz
cp /etc/apt/trusted.gpg .

# delete the packages from the local system, so that they are
# not transferred multiple times.
rm -rf /var/cache/apt/archives/*
cd ..
