Return-Path: P@draigBrady.com
Message-ID: <501FD845.50001@draigBrady.com>
Date: Mon, 06 Aug 2012 15:44:21 +0100
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: suggestion to avoid erroneous lines in findmnt/lslocks/...
References: <501D42D2.6050904@draigBrady.com> <20120806081533.GA24621@x2.net.home> <20120806111059.GB24621@x2.net.home>
In-Reply-To: <20120806111059.GB24621@x2.net.home>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 08/06/2012 12:10 PM, Karel Zak wrote:
> On Mon, Aug 06, 2012 at 10:15:33AM +0200, Karel Zak wrote:
>> I'll fix it to use iscntrl() and \x?? hex (to be consistent our
>> another outputs).
> 
> Fixed:
> 
>  - mount(8) uses '?' like coreutils for control chars (note that
>    listing mode in mount(8) is in maintenance mode, use findmnt(8) if
>    you want something better)
> 
>  - \x<code> is used in findmnt, lsblk, partx, ... for control and non-printable
>    chars
> 
>  - in the raw and export (NAME=data) output are also replaced already existing
>    \x<code> sequences (aaa\x20bbb --> aaa\x5cx20bbb).
> 
>    This is not used in the default output to keep it human readable (\x?? is
>    pretty common in /dev/disk/by-*).
> 
> 
> I have also fixed the way how lib/tt.c counts cells, it's possible
> that old findmnt, lsblk, ... versions have a problem with some languages
> (e.g JP) where more than one cell is necessary to print one multibyte.

Cool.

I did a quick test...

$ echo $LANG
en_US.utf8
$ mkdir tst && cd tst
$ truncate -s10M img
$ mkfs.ext2 -F img
$ mkdir ascii "$(printf 'co\ntrol')" 'back\slash' 'es\x63aped' "$(printf 'nonútf8' | iconv -t iso-8859-15)" '日一二三四五六'
$ for mnt in ascii "$(printf 'co\ntrol')" 'back\slash' 'es\x63aped' "$(printf 'nonútf8' | iconv -t iso-8859-15)" '日一二三四五六'; do
>   sudo mount img "$mnt"
>   ~/git/util-linux/findmnt -l /dev/loop1
>   ~/git/util-linux/findmnt -rn /dev/loop1 | cut -d' ' -f1
>   sleep 1
>   sudo umount /dev/loop1
> done

TARGET                 SOURCE     FSTYPE OPTIONS
/home/padraig/tst/ascii /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
/home/padraig/tst/ascii
TARGET                       SOURCE     FSTYPE OPTIONS
/home/padraig/tst/co\x0atrol /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
/home/padraig/tst/co\x0atrol
TARGET                       SOURCE     FSTYPE OPTIONS
/home/padraig/tst/back\slash /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
/home/padraig/tst/back\slash
TARGET                       SOURCE     FSTYPE OPTIONS
/home/padraig/tst/es\x63aped /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
/home/padraig/tst/es\x5cx63aped
TARGET SOURCE     FSTYPE OPTIONS

       /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
/home/padraig/tst/non\xfffffffatf8
TARGET                         SOURCE     FSTYPE OPTIONS
/home/padraig/tst/日一二三四五六 /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
/home/padraig/tst/\xffffffe6\xffffff97...

So two questions.

1. Should the back\slash case be back\x5cslash in both cases?

2. The nonútf8 one produces an errant new line.
Also in this case could you fall back to using \x escapes for the whole string?

cheers,
Pádraig.
