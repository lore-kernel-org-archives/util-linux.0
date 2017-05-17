Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:50152 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbdEQTIE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 May 2017 15:08:04 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: Re: versioning
Date: Wed, 17 May 2017 21:07:49 +0200
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20170517074741.ltxnoawwvj56gc3m@ws.net.home> <591C8A09.6070100@gmail.com>
In-Reply-To: <591C8A09.6070100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201705172107.49456.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 17 May 2017, Bruce Dubbs wrote:
> Karel Zak wrote:
> >   Hi,
> >
> >   Sami has good point on IRC... do we really want to continue with
> > the current versioning schema? Now we use:
> >
> >      v2.xx[.y]
> >
> >   I don't expect v3 or v4, so the prefix v2 does not provide any
> >   information... and the 'xx' ('30' now) is already large number.
> >
> >   Suggestions:
> >
> >   1) do nothing; nobody cares and v2.31 looks good
> >
> >   2) remove '2' from the version:
> >
> >          major release:  v31
> >          update release: v31.1
> >
> >
> >   3) <your suggestion>?
>
> In managing about 1000 packages, I see a lot of different version
> numbering.   The vast majority of packages use (my terminology)
> major.minor.point for numbering. 

> The major number really should only 
> be increased when there are incompatibilities introduced in a package
> update.

I agree, so I'd also vote for keeping the current version scheme. But we 
could talk about some (theoretically) incompatible clean-up changes to 
justify v3.1.

I'm not talking about making things incompatible just to be incompatible 
but about ugly, outdated ifdefs which probably nobody needs anymore but 
also nobody would touch unless we actively review this.

One thing already mentioned in this thread was to drop any code and 
documention regarding kernel < 2.6  (maybe even <2.6.32 if it has any 
benefits).

Maybe others have even more ideas, e.g. officially requiring 
POSIX.1-2008  or newer to cleanup include/c.h, configure.ac, etc..

The benfit would be not only to have a smaller minor version but 
hopefully to get a few well defined requirements for UL in 
Documentation/ directory, which will not change until v4. 

cu,
Rudi

> Sometimes the numbering gets large,  For instance the current lvm2
> package number is 2.02.171.  But that is OK.  It tells us that the
> packages is updated frequently, but there is an effort to maintain
> backward compatibility.
>
> When a package like firefox is at 53.0.2, what does that tell us
> about the changes?
>
> Sometimes the numbering is downright silly.  I'll suggest that
> chromium at 58.0.3029.96 falls into that category.
>
> To give you an idea of what other packages use, take a look at
> http://wiki.linuxfromscratch.org/blfs/browser/trunk/BOOK/packages.ent
>
> The bottom line is that from our point of view, x.y.z works fine. 
> There is no need to change the current numbering scheme.
>
>    -- Bruce Dubbs
>       linuxfromscratch.org
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
