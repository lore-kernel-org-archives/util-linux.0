Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:55890 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754492AbdFWVhQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Jun 2017 17:37:16 -0400
From: "W. Trevor King" <wking@tremily.us>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 3/8] sys-utils/mount.8: Document 'defaults' as a no-op
Date: Fri, 23 Jun 2017 14:30:21 -0700
Message-Id: <cad8fa3591afeaa36e685829a61a8d7e88a48e00.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The new line is from:

On Thu, May 11, 2017 at 02:24:42PM +0200, Karel Zak wrote [1]:
> My suggestion (man page):
>
>   default
>
>    No-op placeholder with no impact to the filesystem mount options.
>
>    The real mount options depends on built-in kernel defaults and
>    default mount options defined by filesystem superblock. The usual
>    kernel behaviour is to mount filesystems with rw, suid and exec
>    flags by default. See the beginning of this section for more details.
>
>    The "default" is interpreted as "auto" by "mount -a".

I've dropped the "real mount options" and "See the beginning" lines,
because that's true of every option, not just 'defaults'.

I've dropped the "usual kernel behavior" line, because it seems more
appropriate to document that on the option entry itself
(e.g. documenting that rw is the default on the rw entry).

I've dropped the the "auto" line because "auto" is also currently a
no-op:

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

so there's no special relationship between 'defaults' and 'auto'.

[1]: Message-ID: <20170511122442.qwzpw7f6xdsc7im2@ws.net.home>
     Subject: Re: libmount: Is the 'defaults' option intentionally a no-op?
     Date: Thu, 11 May 2017 14:24:42 +0200
[2]: Message-ID: <20170516124127.tuul34kfniki7f4y@ws.net.home>
     Subject: Re: [PATCH] WIP: mount.8: Split out fstab-specific mount options
     Date: Tue, 16 May 2017 14:41:27 +0200

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 sys-utils/mount.8 | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 7800734..26e6ce0 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -960,11 +960,7 @@ For more details, see
 
 .TP
 .B defaults
-Use the default options:
-.BR rw ", " suid ", " dev ", " exec ", " auto ", " nouser ", and " async .
-
-Note that the real set of all default mount options depends on kernel
-and filesystem type.  See the beginning of this section for more details.
+A no-op placeholder with no impact to the filesystem mount options.
 .TP
 .B dev
 Interpret character or block special devices on the filesystem.
-- 
2.1.0.60.g85f0837

