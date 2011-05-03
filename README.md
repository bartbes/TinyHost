**TinyHost** is simple bash script that uses a few small, basic utilities to 'upload' files to [TinyUrl][].

###Needed utilities###

    awk
    base64
    bash
    curl
    file
    perl

###Usage###

    tinyhost.sh [-m mimetype] <[-f] filename|-i>

With -m a mimetype can be specified, to override the detection, -f is optional for the filename, and using -i stdin can be used instead of a file.
For example:

    tinyhost.sh myfile.html

###License###
At the moment, all rights reserved, will decide upon a license later.

[tinyurl]:  http://tinyurl.com
