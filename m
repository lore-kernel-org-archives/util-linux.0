Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:39870 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752170AbdFWVik (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Jun 2017 17:38:40 -0400
From: "W. Trevor King" <wking@tremily.us>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 0/8] sys-utils/mount.8: Clarify 'defaults' and separate kernel/userspace options
Date: Fri, 23 Jun 2017 14:30:18 -0700
Message-Id: <cover.1498252231.git.wking@tremily.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Here's a reroll of May's v1 [1].  Larger changes since v1:

* Split into multiple patches, something like Karel had suggested [2].
* Punt to mount(2) for defaults for filesystem-independent kernel
  options, instead of adding local "(default)" marks.  This is is also
  something like Karl had suggested in [2].
* Replaced the broken "synonym for auto" 'defaults' definition which
  I'd floated in v1 with a line from Karel's earlier suggestion [3].
* Added two examples to fstab(5) based on Karel's initial suggestions
  [4] and subsequent discussion.
* Added a few copy-edit patches.

After the v1 discussion, I think something should happen to (no)auto
as well:

On Tue, May 16, 2017 at 02:41:27PM +0200, Karel Zak wrote [2]:
> On Fri, May 12, 2017 at 10:36:29AM -0700, W. Trevor King wrote:
> > > > >    The "default" is interpreted as "auto" by "mount -a".
> > > >
> > > > This last line means "defaults" is effectively a synonym for
> > > > "auto" in fstab, an presumably "auto" would always be
> > > > preferred (because it more
> > >
> > > More precisely, mount -a cares about "noauto" only, everything
> > > else is "auto".
> >
> > Is that really true?  I think:
> >
> > * ‘noauto,auto’ means the same thing as a bare ‘auto’.
>
> Unfortunately no.
>
> It's strange, but "mount -a" search for "noauto" and do not evaluate
> the options as flags. The libmount follows the original mount(8)
> with this behavior. I'll try to fix it.

It's not clear to me whether Karel intends to clarify the mount(8)
documentation on this point or if he intends to adjust the current
libmount behavior, so I've left that language alone in this series.
If the intention is to document 'auto' as another no-op (matching the
current implementation), I'm happy to submit an additional patch.

Cheers,
Trevor

[1]: http://marc.info/?l=util-linux-ng&m=149451719727754&w=2
     Message-Id: <cee125bdea0faac3b4c9d7e856425fe9106756e7.1494510090.git.wking@tremily.us>
     Subject: [PATCH] WIP: mount.8: Split out fstab-specific mount options
     Date: Thu, 11 May 2017 06:48:54 -0700
[2]: http://marc.info/?l=util-linux-ng&m=149493849402047&w=2
     Message-ID: <20170516124127.tuul34kfniki7f4y@ws.net.home>
     Subject: Re: [PATCH] WIP: mount.8: Split out fstab-specific mount options
     Date: Tue, 16 May 2017 14:41:27 +0200
[3]: http://marc.info/?l=util-linux-ng&m=149450548823490&w=2
     Message-ID: <20170511122442.qwzpw7f6xdsc7im2@ws.net.home>
     Subject: Re: libmount: Is the 'defaults' option intentionally a no-op?
     Date: Thu, 11 May 2017 14:24:42 +0200
[4]: http://marc.info/?l=util-linux-ng&m=149457573010153&w=2
     Message-ID: <20170512075451.auqemicjfogreepq@ws.net.home>
     Subject: Re: [PATCH] WIP: mount.8: Split out fstab-specific mount options
     Date: Fri, 12 May 2017 09:54:51 +0200

W. Trevor King (8):
  sys-utils/fstab.5: Remove basic filesystem-independent options
  sys-utils/fstab.5: Remove 'defaults' from examples
  sys-utils/mount.8: Document 'defaults' as a no-op
  sys-utils/mount.8: Simplify nouser
  sys-utils/mount.8: Drop systemd paragraph from x-* entry
  sys-utils/mount.8: Clarify x-mount.mkdir deprecation
  sys-utils/mount.8: Split filesystem-independent options into kernel
    and userspace subsections
  sys-utils/mount.8: Document libmount defaults

 sys-utils/fstab.5 |  38 +++------------
 sys-utils/mount.8 | 137 +++++++++++++++++++++++++++++++-----------------------
 2 files changed, 84 insertions(+), 91 deletions(-)

-- 
2.1.0.60.g85f0837

