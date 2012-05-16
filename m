Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38174 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759923Ab2EPKNu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 May 2012 06:13:50 -0400
Date: Wed, 16 May 2012 12:13:46 +0200
From: Karel Zak <kzak@redhat.com>
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/2] blkid: introduce symbolic names for different blkid
 exit codes
Message-ID: <20120516101346.GR8268@x2.net.home>
References: <1337157512-31920-1-git-send-email-petr.uzel@suse.cz>
 <1337157512-31920-2-git-send-email-petr.uzel@suse.cz>
 <7856072A9D04C24B82DFE2B1112FE38A0F1E5D2336@MCHP058A.global-ad.net>
 <20120516092408.GA3670@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120516092408.GA3670@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 16, 2012 at 11:24:09AM +0200, Petr Uzel wrote:
> On Wed, May 16, 2012 at 10:52:40AM +0200, Voelker, Bernhard wrote:
> > Petr Uzel wrote:
> > 
> > >  #include "ismounted.h"
> > >  
> > > -#define STRTOXX_EXIT_CODE	4		/* strtoxx_or_err() */
> > > +#define STRTOXX_EXIT_CODE	BLKID_EXIT_OTHER	/* strtoxx_or_err() */
> > 
> > STRTOXX_EXIT_CODE is not used in blkid.c. Remove it?
> > ... or if it used in strutils.h, then this is not a nice interface.
> 
> Yep, it is used in strutils.h.

 Fortunately, STRTOXX_EXIT_CODE is rarely used (default is EXIT_FAILURE).

> > >  	if (rc == -2)
> > > -		return 8;	/* ambivalent probing result */
> > > +		return BLKID_EXIT_AMBIVAL;	/* ambivalent probing result */
> > >  	if (!nvals)
> > > -		return 2;	/* nothing detected */
> > > +		return BLKID_EXIT_NOTFOUND;	/* nothing detected */
> > >  
> > >  	return 0;		/* success */
> > >  }
> > 
> > These are not exit() codes, but return codes. 
> 
> Strictly speaking, yes. But the idea is that those codes are (or
> rather should be) propagated as exit value anyways...
> 
> > That value doesn't seem
> > to be of much interest anyway, because it's used only here in main()
> > in a for-loop, forgetting the return value of the previous iteration:
> > 
> >                for (i = 0; i < numdev; i++)
> >                         err = lowprobe_device(pr, devices[i], lowprobe, show,
> >                                         output_format,
> >                                         (blkid_loff_t) offset,
> >                                         (blkid_loff_t) size);
> 
> Hmm, the return value depends only on the last argument (device). I
> don't think this is intentional. Karel?
> 
>         # blkid -p /dev/sda /dev/sdb ; echo $?
>         /dev/sda: PTTYPE="gpt" 
>         error: /dev/sdb: No such file or directory
>         2
>         
>         # blkid -p /dev/sdb /dev/sda ; echo $?
>         error: /dev/sdb: No such file or directory
>         /dev/sda: PTTYPE="gpt" 
>         0

 It would be better to break the loop and exit after first error.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
