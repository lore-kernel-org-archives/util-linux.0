Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4144 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402Ab1K1J2D (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Nov 2011 04:28:03 -0500
Date: Mon, 28 Nov 2011 10:27:58 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Maurizio Lombardi <m.lombardi85@gmail.com>, util-linux@vger.kernel.org
Subject: Re: mkfs.minix V3 is broken
Message-ID: <20111128092758.GC29168@nb.net.home>
References: <CAMtsiiDWF3xCiFtENTaYS36zKOJjRHML0x2nk1P0d0zeU3qi0A@mail.gmail.com> <1321913175.3253.8.camel@offbook> <CAMtsiiDrWGKthY52+HT5r19g9EFRG2NHKMD3vni-SeaMNfuGDg@mail.gmail.com> <1322431418.3213.7.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322431418.3213.7.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 27, 2011 at 11:03:38PM +0100, Davidlohr Bueso wrote:
> On Tue, 2011-11-22 at 10:03 +0100, Maurizio Lombardi wrote:
> > On Mon, Nov 21, 2011 at 11:06 PM, Davidlohr Bueso <dave@gnu.org> wrote:
> > >
> > > Most of the work I did on supporting v3 was based on the kernel's
> > > implementation and the mkfs shipped with minix (by ast), so a lot of
> > > what you say makes sense. I've taken a quick look at the changes and
> > > most are bugs are pretty straightforward, except:
> > >
> > > - mkfs.minix: The total number of zones is limited to 65536 only on V1
> > > filesystems
> > >
> > > Unless I'm missing something, this doesn't really change any logic.
> > 
> > Sorry, probably the commit message is not very well written... However
> > this commit fixes a very nasty bug, let me explain why....
> > Look at what the code did *before* my patch:
> > 
> > if (fs_version == 3)
> >      magic = MINIX3_SUPER_MAGIC;
> > if (fs_version == 2) {
> >      if (namelen == 14)
> >        magic = MINIX2_SUPER_MAGIC;
> >      else
> >        magic = MINIX2_SUPER_MAGIC2;
> > } else {
> >     if (BLOCKS > MINIX_MAX_INODES)
> >        BLOCKS = MINIX_MAX_INODES;
> > }
> > 
> > Can you see what happens if fs_version is == 3 ?
> > The total number of blocks is restricted to a maximum of 65536 both
> > with V1 and V3 filesystems, this is wrong because the total number of
> > blocks in V3 is a 32 bit number (the same of V2). With this
> > realization, it is really simple to fix the bug, and this is exactly
> > what I did:
> 
> Oh, yes, my bad, we should definitely have more blocks with v3. 
> 
> I made a couple of filesystems with your changes and things look good,
> specially incrementing the amount of inodes. The 60 character filename
> was already featured but it's good to specify it explicitly as well.
> 
> Karel, unless you have any objections please pull these changes in.

 Merged, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
