Return-Path: util-linux-owner@vger.kernel.org
Received: from skade.schwarzvogel.de ([144.76.18.87]:32916 "EHLO
	mail.schwarzvogel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbaFHOJi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Jun 2014 10:09:38 -0400
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.83_RC1)
	(envelope-from <klausman@schwarzvogel.de>)
	id 1Wtdmy-000TEx-CI
	for util-linux@vger.kernel.org; Sun, 08 Jun 2014 16:09:36 +0200
Date: Sun, 8 Jun 2014 16:09:36 +0200
From: Tobias Klausmann <klausman@schwarzvogel.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: fix bsd_translate_fstype() for alpha
Message-ID: <20140608140936.GA110210@skade.schwarzvogel.de>
References: <20140608104251.GA72528@skade.schwarzvogel.de>
 <1402234368-17174-1-git-send-email-sweet_f_a@gmx.de>
 <20140608134433.GC2336@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140608134433.GC2336@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi! 

On Sun, 08 Jun 2014, Dave Reisner wrote:

> On Sun, Jun 08, 2014 at 03:32:48PM +0200, Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> > 
> > Reported-by: Tobias Klausmann <klausman@schwarzvogel.de>
> > Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> > ---
> >  libfdisk/src/bsd.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/libfdisk/src/bsd.c b/libfdisk/src/bsd.c
> > index a81afd2..df0fc13 100644
> > --- a/libfdisk/src/bsd.c
> > +++ b/libfdisk/src/bsd.c
> > @@ -773,8 +773,10 @@ static int bsd_translate_fstype (int linux_type)
> >  	case 0x06: /* DOS 16-bit >=32M */
> >  	case 0xe1: /* DOS access       */
> >  	case 0xe3: /* DOS R/O          */
> > +#if !defined (__alpha__)
> >  	case 0xf2: /* DOS secondary    */
> >  		return BSD_FS_MSDOS;
> > +#endif
> 
> What would be the harm on defining this for platforms which don't
> include it? Why is a partition type excluded from this architecture?

For some reason, 8 has two meanings: BSD_FS_MSDOS almost
everywhere, but BSD_FS_EXT2 on Alpha. I'm not well-versed enough
in the code to be sure whether the case above (0xf2) is a "can't
happen" on Alpha).

It may be that the better approach would be to return an error
condition or something entirely different, including BSD_FS_EXT2. 

For the Alphas I have access to, the patch from Ruediger works
just fine.

Regards,
Tobias

