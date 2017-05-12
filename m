Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755933AbdELHy4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 12 May 2017 03:54:56 -0400
Date: Fri, 12 May 2017 09:54:51 +0200
From: Karel Zak <kzak@redhat.com>
To: "W. Trevor King" <wking@tremily.us>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] WIP: mount.8: Split out fstab-specific mount options
Message-ID: <20170512075451.auqemicjfogreepq@ws.net.home>
References: <20170511122442.qwzpw7f6xdsc7im2@ws.net.home>
 <cee125bdea0faac3b4c9d7e856425fe9106756e7.1494510090.git.wking@tremily.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <cee125bdea0faac3b4c9d7e856425fe9106756e7.1494510090.git.wking@tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 11, 2017 at 06:48:54AM -0700, W. Trevor King wrote:
> And list the default settings for the X/noX pairs.  This clears up
> some ambiguity around the meaning of "defaults" and fills in some
> entries missing from the earlier man pages.
> 
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
> On Thu, May 11, 2017 at 02:24:42PM +0200, Karel Zak wrote:
> > It's placeholder, but kernel uses some options like "rw,exec,suid"
> > by default…
> 
> And these are “everying marked with MNT_INVERT in optmap.c as well as
> whatever filesystem-specific defaults”, right?

Well, inverted options may be used to invert previously used options.
The way how the options has been set is arbitrary (default, remount,
on command line invert fstab setting, etc.). You can use it together
on the same command line

  mount -o async,noasync,foo,bar

is pretty valid. The last used option win (=noasync).

> >    The real mount options depends on built-in kernel defaults and
> >    default mount options defined by filesystem superblock. The usual
> >    kernel behaviour is to mount filesystems with rw, suid and exec
> >    flags by default. See the beginning of this section for more details.
> >
> >    The "default" is interpreted as "auto" by "mount -a".
> 
> This last line means "defaults" is effectively a synonym for "auto" in
> fstab, an presumably "auto" would always be preferred (because it more

More precisely, mount -a cares about "noauto" only, everything else is
"auto".

> clearly marks the change from the "no flag bits set" initial state).
> I've started roughing out a sketch of where I think this should go
> below, although there are a number of things that I'm not clear on
> (e.g. are the X-* and x-* options in the same boat as comment=*?  What
> is (no)sub about?).

Yes, we use x- and X- for 3rd party options (e.g. x-systemd), the
options are ignored for mount(2) syscall.

>  sys-utils/fstab.5 |  33 +----------
>  sys-utils/mount.8 | 164 ++++++++++++++++++++++++++++++------------------------
>  2 files changed, 95 insertions(+), 102 deletions(-)
> 
> diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
> index 07d0287..16f6662 100644
> --- a/sys-utils/fstab.5
> +++ b/sys-utils/fstab.5
> @@ -62,7 +62,7 @@ The following is a typical example of an
>  entry:
>  .sp
>  .RS 7
> -LABEL=t-home2   /home      ext4    defaults,auto_da_alloc      0  2
> +LABEL=t-home2   /home      ext4    auto,auto_da_alloc      0  2

I think it's fine to have an example with the placeholder, maybe add more
lines to the example:

LABEL=MyHomeDev   /home      ext4    defaults            0  2
LABEL=MyOptDev    /opt       ext4    auto,auto_da_alloc  0  2


> -Basic filesystem-independent options are:

It's probably good idea to maintain the options description on one place, but it 
would be nice to add note about mount(8), something like

 For filesystem-independent options see mount(8).

>  .SH FILESYSTEM-INDEPENDENT MOUNT OPTIONS
> -Some of these options are only useful when they appear in the
> -.I /etc/fstab
> -file.
>  
>  Some of these options could be enabled or disabled by default
>  in the system kernel.  To check the current setting see the options
> @@ -837,7 +835,7 @@ mounted (but not every filesystem actually honors them \(en e.g.\&, the
>  option today has an effect only for ext2, ext3, fat, vfat and ufs):
>  
>  .TP
> -.B async
> +.B async \fR(default)

Please, don't use "(default)" there. We don't control what is the
default. It does not have to be the same for all kernels (and kernel
versions).

> +.SH FSTAB-SPECIFIC MOUNT OPTIONS
> +The following options apply only to fstab entries and are not useful when calling
> +.BR mount
> +directly.

Not true. mount(8) does not care about mount options source.
(Yes, "defaults" is placeholder that makes sense only in fstab, but
it's not an error to use it on command line, etc.). 

Maybe rather than "FSTAB-SPECIFIC ..." use two subsections, one for
kernel and another for user-sapce:

.SH FILESYSTEM-INDEPENDENT MOUNT OPTIONS
.SS Generic kernel mount options
async
 ...
atime
 ...

.SS User-space mount options
default
  ...
auto
  ...


Does it make more sense?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
