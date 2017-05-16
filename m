Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbdEPMlc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 16 May 2017 08:41:32 -0400
Date: Tue, 16 May 2017 14:41:27 +0200
From: Karel Zak <kzak@redhat.com>
To: "W. Trevor King" <wking@tremily.us>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] WIP: mount.8: Split out fstab-specific mount options
Message-ID: <20170516124127.tuul34kfniki7f4y@ws.net.home>
References: <20170511122442.qwzpw7f6xdsc7im2@ws.net.home>
 <cee125bdea0faac3b4c9d7e856425fe9106756e7.1494510090.git.wking@tremily.us>
 <20170512075451.auqemicjfogreepq@ws.net.home>
 <20170512173629.GG3035@valgrind.tremily.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170512173629.GG3035@valgrind.tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 12, 2017 at 10:36:29AM -0700, W. Trevor King wrote:
> Right, but the things with MNT_INVERT are the defaults (what you get
> if none of the given options toggle the flag).
> 
> > > >    The "default" is interpreted as "auto" by "mount -a".
> > > 
> > > This last line means "defaults" is effectively a synonym for "auto" in
> > > fstab, an presumably "auto" would always be preferred (because it more
> > 
> > More precisely, mount -a cares about "noauto" only, everything else
> > is "auto".
> 
> Is that really true?  I think:
> 
> * ‘noauto,auto’ means the same thing as a bare ‘auto’.

Unfortunately no. 

It's strange, but "mount -a" search for "noauto" and do not evaluate
the options as flags. The libmount follows the original mount(8) with
this behavior. I'll try to fix it.

> * With your wording, I'd expect ‘noauto,defaults’ to also mean the
>   same thing as ‘auto’ or ‘defaults’.  But looking at the code again,
>   It still looks like ‘defaults’ is a no-op (not clearing
>   MNT_MS_NOAUTO), so ‘noauto,defaults’ would be the same as ‘noauto’.
> 
> If those are both right, I think we should adjust my patch to say that
> ‘defaults’ is a no-op with no qualifications.

Yes, "defaults" is just zero, no-op.

> > > clearly marks the change from the "no flag bits set" initial
> > > state).  I've started roughing out a sketch of where I think this
> > > should go below, although there are a number of things that I'm
> > > not clear on (e.g. are the X-* and x-* options in the same boat as
> > > comment=*?  What is (no)sub about?).
> > 
> > Yes, we use x- and X- for 3rd party options (e.g. x-systemd), the
> > options are ignored for mount(2) syscall.
> 
> But are they only meaningful in fstab?  Or are there use-cases where
> people would use them when calling mount(8) directly?

If you want to store some mount option in users-space then use x-* on
command line makes sense. For example systemd execs mount(8) and they
do not have to use fstab (they may use systemd.mount unit) or generate 
mount on-the-fly by another way.

> I still don't see the point to using ‘defaults’ when you could have
> the same config using the more explicit:
> 
>   LABEL=MyHomeDev   /home      ext4    auto                0  2

You think about it too much :-))) The "default" is just placeholder.

> Using ‘defaults’ says one of
> a few things:
> 
> a. I have no preferences, and:
> 
>    i. Opening mount(8) to see which of (no)auto is the default is more
>       work than I want to invest.
>    ii. I can't think of an option where I can rely on the kernel or
>        libmount to preserve the current default (e.g., there's a
>        chance that the kernel makes ro the default, and a chance that
>        libmount makes noauto the default, etc.)

This is true (but, we don't plan to make "noauto" default :-).

> Case a seems like a very unlikely position.  There may be users who
> don't care what the (no)lazytime default is, but are there users who
> don't care about (no)auto or ro/rw?  Perhaps there are (and they can

I think it's fine to say that default are very basic things like
"rw, suid, dev, exec, auto, nouser, async" but nothing else. (Sorry, in
my previous reply I have selected "async" as bad example.)

If you don't want to rely on kernel defaults then you have to
explicit in your fstab. That's all.

BTW, to make it more complicated... we have also FS specific options,
and FS specific defaults and in many case it's possible to change it
per-superblok by tools like tune2fs In this case the default will be
different for sda1 and sda2.

> use ‘defaults’ to get that behavior).  Case b seems much more likely,
> and I think using ‘defaults’ as the “typical example” will confuse
> readers who expect the man-page writer to understand ‘defaults’ (and
> so fall into case a.ii?).  I think ‘auto’ and ‘rw’ are both extremely
> likely to remain defaults, but the kernel would cause more backwards
> compat issues by swapping the default there, so:
> 
>   LABEL=MyHomeDev   /home      ext4    rw                  0  2
> 
> is probably the best “typical example”.  And the “paranoid example”
> would be:
> 
>   LABEL=MyHomeDev   /home      ext4    auto,rw             0  2

"rw" is no-op, kernel API has nothing like RW flag (we have
MS_RDONLY). It's still possible that your device will be mounted
read-only (pretty common for NFS exported read-only) or mount(8) will
try another attempt with MS_RDONLY flag (maybe disabled by -w on
command line). The reason is that mount ro is usually better 
than don't mount nothing.

> for “libmount might go crazy and change it's mind so I'm pinning the
> current ‘auto’ default”.
> 
> > LABEL=MyOptDev    /opt       ext4    auto,auto_da_alloc  0  2
> 
> With ‘auto’ being a default that libmount is unlikely to change, the
> example should probably be:
> 
>   LABEL=MyOptDev    /opt       ext4    auto_da_alloc       0  2

yes

...

> I think documenting the kernel defaults is useful (less digging for
> interested users).

The very basic options are described in mount(2) syscall man page with 
some info about versions etc. Maybe we can re-use this information in 
mount(8) for the basic options. 

(And from pedantic point of view, it's possible to backport kernel
features (pretty common for enterprise long time supported kernels),
so all information about kernel versions maybe inaccurate..)

> If either project sets up something where the default could be swapped
> without warning (e.g. they provide bits for MS_FOO and MS_NOFOO and
> make no statement about the planned kernel version for the default
> swap), then we should definitely call that out explicitly:
> 
>   foo (default in Linux 12.2)
>     Set foo.
> 
>     WARNING: Future Linux may make nofoo the default value without
>     warning.  Users who have a preference should explicitly set either
>     foo or nofoo to protect themselves from such an occurrence.
> 
>   nofoo
>     Unset foo.
> 
>     WARNING: Future Linux may make this the default value without
>     warning, see foo for details.

I still believe that it would be better to add some generic description 
about defaults where we can describe that nothing 100% than add the WARNING.

> > Maybe rather than "FSTAB-SPECIFIC ..." use two subsections, one for
> > kernel and another for user-sapce:
> > 
> > .SH FILESYSTEM-INDEPENDENT MOUNT OPTIONS
> > .SS Generic kernel mount options
> 
> Sounds great; I'll do this in v2.

Thanks.

> Would you like me to work that up
> now, or would you rather kick around the other issues above more
> before a reroll?

Maybe we can do it in more steps (patches):

 1) for the fstab.5 -> mount.8 and "Generic kernel mount options" subsection
 2) describe "defaults" placeholders and cleanup the examples
 3) add info about default+versions from mount(2) to mount(8)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
