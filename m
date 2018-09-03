Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727523AbeICOg7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Sep 2018 10:36:59 -0400
Date: Mon, 3 Sep 2018 12:17:25 +0200
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: RFD: --enable-bindir-path ?
Message-ID: <20180903101725.ngjabihabq2n6oeg@ws.net.home>
References: <5B82E969.6090409@tlinx.org>
 <20180830084556.ubvu5e5qhzih5fng@ws.net.home>
 <5B89C74D.8030701@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5B89C74D.8030701@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Aug 31, 2018 at 03:55:09PM -0700, L A Walsh wrote:
> conversely, the opposite would be where bin are in /bin and /usr/bin is
> a symlink to /bin, and same for the libdirs and sbin.
> 
>    There is nothing in switch description about /doc, or /man being mounted
> on /usr/<equiv>, so why would one move those around?

just asking to be sure

> > I have nothing against this feature, but question is if it's important
> > enough to implement and support it ;-)
> ---
>    Well the sbin dirs are separate in cygwin, but /usr/bin is copy /bin
> same for the lib dir.  It's really not that much to implement.  Only thing
> it means is that if /usr is a separate partition, then during boot,
> all your files in /bin, lib, lib64/ sbin...will be on the root, while and
> boot can continue.  While if all the libs+binaries are /usr, it's hard to
> mount.  So the use case is ensuring the system will boot?

There is so many ways how to keep different groups of users happy... ;-)

I don't care which is the best and I really don't making such decisions.
The defaults are usually about mainstream distros, but we don't ignore
another use-cases. If you have good use-case then I'm ready to support
it (well, if the change has not bad impact to the current behavior).

> > Anyway, now this no issue as we use initram images where is all
> > stuff that is necessary to assemble usable hierarchy of filesystems
> > (including RAIDs, NFS moutpoints, etc.)
> > 
> >     Karel
> ----
>    Who is this 'we' kimosami? ;^)
> 
>    Not me, nor anyone following the systemd recommendations for boot
> speed.

Blame systemd is good sport ;-), but in this case... we have had
ramdisks with usable mount(8) and another stuff for complicated setups
many years before systemd...

> Everything worked well until libs needed for 'mount' started appearing
> on /usr.  If you had everything on a ram disk that was needed for boot,
> but then the libs for some of the programs were out on the hard disk,
> the ram disk would have a hard time proceeding as well.

The current util-linux upstream default is to install mount(8)
to $bindir and --enable-usrdir-path is not enabled by default. The
default is to install libmount also to /lib if $libdir is a different to
$usrlib_execdir.

All you need is to specify --libdir=/lib

 $ ./configure --disable-makeinstall-chown --disable-makeinstall-setuid --libdir=/lib
 $ make install DESTDIR=/home/projects/util-linux/util-linux/xxx

 $ find /home/projects/util-linux/util-linux/xxx/lib
 /home/projects/util-linux/util-linux/xxx/lib
 /home/projects/util-linux/util-linux/xxx/lib/libmount.so.1
 /home/projects/util-linux/util-linux/xxx/lib/libblkid.so.1.1.0
 /home/projects/util-linux/util-linux/xxx/lib/libsmartcols.so.1.1.0
 /home/projects/util-linux/util-linux/xxx/lib/libuuid.so.1.3.0
 /home/projects/util-linux/util-linux/xxx/lib/libfdisk.so.1
 /home/projects/util-linux/util-linux/xxx/lib/libmount.so.1.1.0
 /home/projects/util-linux/util-linux/xxx/lib/libfdisk.so.1.1.0
 /home/projects/util-linux/util-linux/xxx/lib/libuuid.so.1
 /home/projects/util-linux/util-linux/xxx/lib/libsmartcols.so.1
 /home/projects/util-linux/util-linux/xxx/lib/libblkid.so.1

So, technically your use-case is already supported, although I agree
that it is not user-friendly and maybe explicit "enable-bindir-path"
would be better.

[The default install to $usrlib in Makefiles is autotools-ism around
 $prefix and we respect this woodoo ;-) I'd like to not change it
 because it always introduces new issues and the current solution seems
 well tested and it seems stable for years. I guess all we need is to
 make it more usable by ./configue.

 Maybe from long term point of view the answer is "meson" :-) ]

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
