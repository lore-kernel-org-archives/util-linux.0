Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: question about findmnt --target
Date: Tue, 17 Mar 2015 18:14:00 +0100
Cc: util-linux@vger.kernel.org
References: <201503171608.58423.sweet_f_a@gmx.de> <20150317163426.GW28925@ws.net.home>
In-Reply-To: <20150317163426.GW28925@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201503171814.00580.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Tuesday 17 March 2015, Karel Zak wrote:
> On Tue, Mar 17, 2015 at 04:08:58PM +0100, Ruediger Meier wrote:
> > Hi,
> >
> > I wonder what is the correct way to find a mount which is mounted
> > to a certain target directory. findmnt --target will also find a
> > mount if you specify a subdirectory of a mountpoint:
> >
> > $ mkdir /tmp/bla
> > $ findmnt --target /tmp/bla
> > TARGET SOURCE                        FSTYPE OPTIONS
> > /tmp   /dev/mapper/vg0-tmpdirs[/tmp] ext4 ....
> >
> > The man page let me think that --target should not find the parent
> > directory.
>
> No, it's expected behavior since:
>
>     commit b215d8e9a71ca8d22df6111ddc9d28bd896febb1
>     Author: Dave Reisner <dreisner@archlinux.org>
>     Date:   Wed Apr 25 20:30:52 2012 -0400

Ok, but this was a regression for a common use case. I guess to late to 
revert. Even you liked this old behavior:

commit 1f42e1089aadbe537bb59143502ebd1767d3f7ea
Author: Karel Zak <kzak@redhat.com>
Date:   Sun Jan 2 22:56:31 2011 +0100

    tests: use findmnt(8) for mount --move test


> and the current git tree contains:
>
>        -T, --target path
>              Explicitly define the mount target (mountpoint
>              directory). If the path is not a  mountpoint file
>              or directory than findmnt checks path elements in
>              reverse order for get the mountpoint (this
>              feature is supported only if search in kernel
>              files and unsupported for --fstab).

Ah ok, but IMO because of this regression we should make it even more 
clear. Probably the first sentence should not contain "mount target" 
and "mountpoint" without also using the term "parent directory" or 
similar. 

I think for df(1) it's written nicely:

  df [OPTION]... [FILE]...
  Show information about the file system on which each FILE resides, or
  all file systems by default.

> > $TS_CMD_MOUNT --move $DIR_A $DIR_B
> >
> > # check the move
> > $TS_CMD_FINDMNT --kernel --target "$DIR_B" &> /dev/null
> > [ "$?" == "0" ] || ts_die "Cannot find binded $DIR_B"
> > [...]
> >
> > This findmnt line will never fail I guess.
>
> Right, this is mistake, solution is to remove --target:
>
>     TS_CMD_FINDMNT --kernel "$DIR_B" &> /dev/null

>
> The disadvantage is that without --source/target findmnt(8) tries
> to use the path as source and then as target. It's bad in same cases.
>
> Maybe we need a new option to disable the evaluation of the target
> path elements. (--strict-target)

What about "findmnt --target /bla/xyz --no-parents" instead 
of --strict-target?

I have to admint that I don't really like the current behavior 
of --target and the default case without --source/target. Of course we 
can't change it anymore.

cu,
Rudi
