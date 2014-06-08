Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:59416 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753325AbaFHPGp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 8 Jun 2014 11:06:45 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Tobias Klausmann <klausman@schwarzvogel.de>
Subject: Re: [PATCH] libfdisk: fix bsd_translate_fstype() for alpha
Date: Sun, 8 Jun 2014 17:06:36 +0200
Cc: util-linux@vger.kernel.org
References: <20140608104251.GA72528@skade.schwarzvogel.de> <20140608134433.GC2336@rampage> <20140608140936.GA110210@skade.schwarzvogel.de>
In-Reply-To: <20140608140936.GA110210@skade.schwarzvogel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406081706.36899.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 08 June 2014, Tobias Klausmann wrote:
> Hi!
>
> On Sun, 08 Jun 2014, Dave Reisner wrote:
> > On Sun, Jun 08, 2014 at 03:32:48PM +0200, Ruediger Meier wrote:
> > > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> > >
> > > Reported-by: Tobias Klausmann <klausman@schwarzvogel.de>
> > > Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> > > ---
> > >  libfdisk/src/bsd.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/libfdisk/src/bsd.c b/libfdisk/src/bsd.c
> > > index a81afd2..df0fc13 100644
> > > --- a/libfdisk/src/bsd.c
> > > +++ b/libfdisk/src/bsd.c
> > > @@ -773,8 +773,10 @@ static int bsd_translate_fstype (int
> > > linux_type) case 0x06: /* DOS 16-bit >=32M */
> > >  	case 0xe1: /* DOS access       */
> > >  	case 0xe3: /* DOS R/O          */
> > > +#if !defined (__alpha__)
> > >  	case 0xf2: /* DOS secondary    */
> > >  		return BSD_FS_MSDOS;
> > > +#endif
> >
> > What would be the harm on defining this for platforms which don't
> > include it? Why is a partition type excluded from this
> > architecture?
>
> For some reason, 8 has two meanings: BSD_FS_MSDOS almost
> everywhere, but BSD_FS_EXT2 on Alpha. I'm not well-versed enough
> in the code to be sure whether the case above (0xf2) is a "can't
> happen" on Alpha).

It can happen on alpha! But there is no better translation than the 
default BSD_FS_OTHER. Like most of the other MBR partition types have 
no translation for BSD.

> It may be that the better approach would be to return an error
> condition or something entirely different, including BSD_FS_EXT2.

Type EXT2 can't come from MBR because there is no such type in 
include/pt-mbr.h.

The real stupidness which makes the other code look confusing happens in 
include/pt-bsd.h. The comment says it:

/* this is annoying, but it's also the way it is :-( */
#ifdef __alpha__
#define BSD_FS_EXT2     8               /* ext2 file system */
#else
#define BSD_FS_MSDOS    8               /* MS-DOS file system */
#endif

BSD partition specs say "8" means usually EXT2 but only on alpha it 
means MSDOS. This makes these partion tables incompatible between hosts 
of different arch. But there are even more reasons why BSD partions are 
not arch independent. It was probably bad designed long time ago.

In theory we could add all combinatons of fdisk features like
 - create BSD partions to be used on alpha
 - create BSD partions to be used on big endian
 - etc.

But this would be probably over the top. Currently we only support BSD 
partitions for the arch we are running.

BTW on Linux these partition types are AFAIK not really used anyway. The 
FS type is usually determined from the data inside the partition. 
That's why we don't have special partition types for all kind of linux 
filesystems, just 83=Linux but I guess even this one is not needed, 
except to make partition tables more human readable (if the type was 
set correctly at all when partion was created).


cu,
Rudi
