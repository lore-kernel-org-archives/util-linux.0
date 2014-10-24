Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-phx2.redhat.com ([209.132.183.24]:43374 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbaJXJrG convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 24 Oct 2014 05:47:06 -0400
Date: Fri, 24 Oct 2014 05:47:04 -0400 (EDT)
From: Federico Simoncelli <fsimonce@redhat.com>
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: util-linux@vger.kernel.org, kzak@redhat.com
Message-ID: <1065283474.51295427.1414144024844.JavaMail.zimbra@redhat.com>
In-Reply-To: <alpine.LFD.2.00.1410241127260.2242@localhost.localdomain>
References: <1414078476-11007-1-git-send-email-fsimonce@redhat.com> <1414078476-11007-2-git-send-email-fsimonce@redhat.com> <alpine.LFD.2.00.1410241127260.2242@localhost.localdomain>
Subject: Re: [PATCH 2/2] blkdiscard: fail on sector misalignment
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

----- Original Message -----
> From: "Lukáš Czerner" <lczerner@redhat.com>
> To: "Federico Simoncelli" <fsimonce@redhat.com>
> Cc: util-linux@vger.kernel.org, kzak@redhat.com
> Sent: Friday, October 24, 2014 11:37:33 AM
> Subject: Re: [PATCH 2/2] blkdiscard: fail on sector misalignment
> 
> On Thu, 23 Oct 2014, Federico Simoncelli wrote:
> 
> > Date: Thu, 23 Oct 2014 15:34:36 +0000
> > From: Federico Simoncelli <fsimonce@redhat.com>
> > To: util-linux@vger.kernel.org
> > Cc: kzak@redhat.com, lczerner@redhat.com,
> >     Federico Simoncelli <fsimonce@redhat.com>
> > Subject: [PATCH 2/2] blkdiscard: fail on sector misalignment
> > 
> > ---
> >  sys-utils/blkdiscard.c            | 10 +++++++---
> >  tests/expected/blkdiscard/offsets | 12 ++++++------
> >  2 files changed, 13 insertions(+), 9 deletions(-)
> > 
> > diff --git a/sys-utils/blkdiscard.c b/sys-utils/blkdiscard.c
> > index 1eb2b285..76c72b8 100644
> > --- a/sys-utils/blkdiscard.c
> > +++ b/sys-utils/blkdiscard.c
> > @@ -144,9 +144,9 @@ int main(int argc, char **argv)
> >  	if (ioctl(fd, BLKSSZGET, &secsize))
> >  		err(EXIT_FAILURE, _("%s: BLKSSZGET ioctl failed"), path);
> >  
> > -	/* align range to the sector size */
> > -	range[0] = (range[0] + secsize - 1) & ~(secsize - 1);
> > -	range[1] &= ~(secsize - 1);
> > +	/* check offset alignment to the sector size */
> > +	if (range[0] % secsize)
> > +		errx(EXIT_FAILURE, _("%s: offset %" PRIu64 " is not aligned"), path,
> > range[0]);
> >  
> >  	/* is the range end behind the end of the device ?*/
> >  	if (range[0] > blksize)
> > @@ -155,6 +155,10 @@ int main(int argc, char **argv)
> >  	if (end < range[0] || end > blksize)
> >  		range[1] = blksize - range[0];
> >  
> > +	/* check length alignment to the sector size */
> > +	if (range[1] % secsize)
> > +		errx(EXIT_FAILURE, _("%s: length %" PRIu64 " is not aligned"), path,
> > range[1]);
> > +
> 
> Looks good, however remember that the tool is intended to be used by
> the end user, can we be a bit more helpful ? We already know the
> secsize it should be aligned to, so we can print that as well.

I will update the error message.

> However it just occurred to me that aligning it to secsize is not
> enough. It should be aligned to discard_granularity.

Aligning to discard_granularity is an optimization, on the other hand
not aligning to secsize would result in the ioctl failing (EINVAL).

-- 
Federico
