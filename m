Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752915AbdF0Mtw (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Jun 2017 08:49:52 -0400
Date: Tue, 27 Jun 2017 14:49:48 +0200
From: Karel Zak <kzak@redhat.com>
To: "W. Trevor King" <wking@tremily.us>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/8] sys-utils/mount.8: Clarify 'defaults' and
 separate kernel/userspace options
Message-ID: <20170627124948.j2msp3fvvtrm4gtq@ws.net.home>
References: <cover.1498252231.git.wking@tremily.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 23, 2017 at 02:30:18PM -0700, W. Trevor King wrote:
> Here's a reroll of May's v1 [1].  Larger changes since v1:
> 
> * Split into multiple patches, something like Karel had suggested [2].
> * Punt to mount(2) for defaults for filesystem-independent kernel
>   options, instead of adding local "(default)" marks.  This is is also
>   something like Karl had suggested in [2].
> * Replaced the broken "synonym for auto" 'defaults' definition which
>   I'd floated in v1 with a line from Karel's earlier suggestion [3].
> * Added two examples to fstab(5) based on Karel's initial suggestions
>   [4] and subsequent discussion.
> * Added a few copy-edit patches.
> 
> After the v1 discussion, I think something should happen to (no)auto
> as well:
> 
> On Tue, May 16, 2017 at 02:41:27PM +0200, Karel Zak wrote [2]:
> > On Fri, May 12, 2017 at 10:36:29AM -0700, W. Trevor King wrote:
> > > > > >    The "default" is interpreted as "auto" by "mount -a".
> > > > >
> > > > > This last line means "defaults" is effectively a synonym for
> > > > > "auto" in fstab, an presumably "auto" would always be
> > > > > preferred (because it more
> > > >
> > > > More precisely, mount -a cares about "noauto" only, everything
> > > > else is "auto".
> > >
> > > Is that really true?  I think:
> > >
> > > * ‘noauto,auto’ means the same thing as a bare ‘auto’.
> >
> > Unfortunately no.
> >
> > It's strange, but "mount -a" search for "noauto" and do not evaluate
> > the options as flags. The libmount follows the original mount(8)
> > with this behavior. I'll try to fix it.
> 
> It's not clear to me whether Karel intends to clarify the mount(8)

It would be better to describe the current behavior. I'm not sure if I
want to fix it :-) 

The problem is that convert all mount options to the flags is relatively 
expensive, and I'm not sure it such change will provide any real
improvement for "mount -a". I guess "noauto,auto" is extremely unusual
setting, the another story is that fstab may be interpreted by another
tools (like systemd), so support this crazy setting will no change
anything in the real world.

It will be better to add to the man page a small note: "noauto" always win
and later specified "auto" does not change it :-)


> current implementation), I'm happy to submit an additional patch.

Please.

>   sys-utils/fstab.5: Remove basic filesystem-independent options
>   sys-utils/fstab.5: Remove 'defaults' from examples
>   sys-utils/mount.8: Document 'defaults' as a no-op
>   sys-utils/mount.8: Simplify nouser
>   sys-utils/mount.8: Drop systemd paragraph from x-* entry
>   sys-utils/mount.8: Clarify x-mount.mkdir deprecation
>   sys-utils/mount.8: Split filesystem-independent options into kernel
>     and userspace subsections
>   sys-utils/mount.8: Document libmount defaults
> 
>  sys-utils/fstab.5 |  38 +++------------
>  sys-utils/mount.8 | 137 +++++++++++++++++++++++++++++++-----------------------
>  2 files changed, 84 insertions(+), 91 deletions(-)

All the patches seems good.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
