Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:39478 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755723Ab1K0WDn (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 27 Nov 2011 17:03:43 -0500
Subject: Re: mkfs.minix V3 is broken
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Maurizio Lombardi <m.lombardi85@gmail.com>
Cc: util-linux@vger.kernel.org
In-Reply-To: <CAMtsiiDrWGKthY52+HT5r19g9EFRG2NHKMD3vni-SeaMNfuGDg@mail.gmail.com>
References: <CAMtsiiDWF3xCiFtENTaYS36zKOJjRHML0x2nk1P0d0zeU3qi0A@mail.gmail.com>
	 <1321913175.3253.8.camel@offbook>
	 <CAMtsiiDrWGKthY52+HT5r19g9EFRG2NHKMD3vni-SeaMNfuGDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 27 Nov 2011 23:03:38 +0100
Message-ID: <1322431418.3213.7.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2011-11-22 at 10:03 +0100, Maurizio Lombardi wrote:
> On Mon, Nov 21, 2011 at 11:06 PM, Davidlohr Bueso <dave@gnu.org> wrote:
> >
> > Most of the work I did on supporting v3 was based on the kernel's
> > implementation and the mkfs shipped with minix (by ast), so a lot of
> > what you say makes sense. I've taken a quick look at the changes and
> > most are bugs are pretty straightforward, except:
> >
> > - mkfs.minix: The total number of zones is limited to 65536 only on V1
> > filesystems
> >
> > Unless I'm missing something, this doesn't really change any logic.
> 
> Sorry, probably the commit message is not very well written... However
> this commit fixes a very nasty bug, let me explain why....
> Look at what the code did *before* my patch:
> 
> if (fs_version == 3)
>      magic = MINIX3_SUPER_MAGIC;
> if (fs_version == 2) {
>      if (namelen == 14)
>        magic = MINIX2_SUPER_MAGIC;
>      else
>        magic = MINIX2_SUPER_MAGIC2;
> } else {
>     if (BLOCKS > MINIX_MAX_INODES)
>        BLOCKS = MINIX_MAX_INODES;
> }
> 
> Can you see what happens if fs_version is == 3 ?
> The total number of blocks is restricted to a maximum of 65536 both
> with V1 and V3 filesystems, this is wrong because the total number of
> blocks in V3 is a 32 bit number (the same of V2). With this
> realization, it is really simple to fix the bug, and this is exactly
> what I did:

Oh, yes, my bad, we should definitely have more blocks with v3. 

I made a couple of filesystems with your changes and things look good,
specially incrementing the amount of inodes. The 60 character filename
was already featured but it's good to specify it explicitly as well.

Karel, unless you have any objections please pull these changes in.

Thanks,
Davidlohr

> 
> if (fs_version == 3)
>      magic = MINIX3_SUPER_MAGIC;
> - if (fs_version == 2) {
> +else if (fs_version == 2) {
>      if (namelen == 14)
>        magic = MINIX2_SUPER_MAGIC;
>      else
>        magic = MINIX2_SUPER_MAGIC2;
> } else {
>     if (BLOCKS > MINIX_MAX_INODES)
>        BLOCKS = MINIX_MAX_INODES;
> }
> 
> >
> > I'll give the changes a proper test over the weekend.
> 
> Ok, thanks.
> In case you accept the changes I did, this is the github repository
> link with read-only access from where you can pull the changes from:
> 
> git://github.com/maurizio-lombardi/util-linux.git
> 
> Regards,


