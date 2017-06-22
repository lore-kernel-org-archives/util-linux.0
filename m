Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:52922 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752409AbdFVCTf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 22:19:35 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: overriding STRTOXX_EXIT_CODE does not work
Date: Thu, 22 Jun 2017 04:19:26 +0200
Cc: util-linux@vger.kernel.org
References: <201706211856.05354.sweet_f_a@gmx.de> <20170621220640.dujsbx45ndk3mpdk@ws.net.home>
In-Reply-To: <20170621220640.dujsbx45ndk3mpdk@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201706220419.27112.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 22 June 2017, Karel Zak wrote:
> On Wed, Jun 21, 2017 at 06:56:05PM +0200, Ruediger Meier wrote:
> > Hi,
> >
> > I found a little annoying issue. The trick to re-define
> > STRTOXX_EXIT_CODE (see a99c913091c, 2012-03-30) can't work.
> > When compiling strutils.c it will always use the default from
> > strutils.h
> >
> >
> > STRTOXX_EXIT_CODE is used only at 3 places:
> >
> > disk-utils/fsck.c:#define STRTOXX_EXIT_CODE     FSCK_EX_USAGE
> > misc-utils/blkid.c:#define STRTOXX_EXIT_CODE    BLKID_EXIT_OTHER
> > sys-utils/tunelp.c:#define STRTOXX_EXIT_CODE    3
> >
> >
> > But there are more candidates where the return codes are broken
> > since strutils.h was introduced, for example here f150ac37.
> >
> > $ grep -l "strutils.h" `git grep -l  
> > "FINDFS_\|MNT_EX\|MKFS_EX\|FSCK_EX" --  "*.c"` disk-utils/fsck.c
> > disk-utils/fsck.cramfs.c
> > disk-utils/fsck.minix.c
> > disk-utils/mkfs.cramfs.c
> > disk-utils/mkfs.minix.c
> > libmount/src/context_mount.c
> > libmount/src/context_umount.c
> > sys-utils/fstrim.c
> > sys-utils/mount.c
> >
> >
> > Should we make STRTOXX_EXIT_CODE usable by moving  strutils.c to
> > strutils.h, like optutils.h? Or any other ideas?
>
> I don't think use static inline for everything is the right way,
> maybe we can introduce
>
>   static int _strutils_exitcode;
>
>   void strutils_set_exitcode(int ex) {
>     _strutils_exitcode  = ex;
>   }
>
> function and call the function from main() for utils where it matter.

Should be good enough for our use cases.


cu,
Rudi
