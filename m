Return-Path: barumuga@redhat.com
Date: Fri, 02 Mar 2012 22:28:04 -0500 (EST)
From: Balamurugan Arumugam <barumuga@redhat.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: unclear udev format output of blkid
Message-ID: <aab02f03-78b0-4931-bcf8-bd691f2915a0@zmail01.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20120302132453.GG18642@x2.net.home>
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
List-ID: <util-linux.vger.kernel.org>


Hi Karel,

> 
> On Fri, Mar 02, 2012 at 06:18:13AM -0500, Balamurugan Arumugam wrote:
> > We are trying to parse blkid output in python for all devices and
> > their attributes.
> 
>  Why? Maybe we can help you...
> 
>  Do you know that udev db already contains all the attributes? Try:
> 
>     udevadm info --export-db
> 
>  See also lsblk --help, it returns many information about block
>  devices.
> 

I found lsblk is useful and replacing our usage of blkid.  Thanks for your help.


> > I found two strange things.
> > 1. udev format output is grouped by empty newline, but I see an
> > extra newline in between.
> > Below is the example,
> 
>  See Thomas's response, this output format is deprecated. Use "-o
>  export".
> 
>  Unfortunately, the "export" format does not contain devname too.
>  This
>  problem should be fixed in git tree now. (Thanks for bug report.)
> 
> > [root@fedora-16-test ~]# blkid -c /dev/null -o udev
> 
>  The command blkid without '-p' returns only small subset of all
>  available attributes. The command blkid was originally designed
>  for LABEL/UUID conversion to devname. The cache (high-level API of
>  the library) does not contain more information.
> 
>  I'd like to remove the cache from blkid command and use the
>  low-level
>  (-p) by default one day. The cache is confusing for many people...
> 
> 
>  My suggestion is to read the information from udev db (you can use
>  libudev too) or use something like:
> 
>   for x in $(lsblk --output KNAME); do
>     blkid -p -o export /dev/$x
>     echo
>   done
>  
>  I hope that one day the for() will be unnecessary and blkid without
>  -p will return all information.
> 

libudev python binding is the way to go than 'ugly' parsing of command output.

Cheers,
Bala
