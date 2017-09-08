Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753206AbdIHHjZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 8 Sep 2017 03:39:25 -0400
Date: Fri, 8 Sep 2017 09:39:21 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/1] Two changes before we go to rc
Message-ID: <20170908073921.a537fid3dnghsgme@ws.net.home>
References: <e5219e08-60f7-d35d-c81c-64cb598c7e84@gmx.com>
 <20170905110005.jjcfq3rvch7jtqhi@ws>
 <2072373a-a369-863d-40d7-ebf4abb3fe78@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2072373a-a369-863d-40d7-ebf4abb3fe78@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 07, 2017 at 04:50:00PM -0400, J William Piggott wrote:
> My thoughts were:
> 
>  It was Rudi's idea, so I assumed he wanted to implement it.
> 
>  It doesn't look to me like this can be done with sed alone. It seems
>  like it would take too long to finish for this cycle?

Probably yes. It is not anything urgent so it could be done later (or
never -- the current usage() output seems good too). The idea is not
bad, but it's pretty invasive... I have no strong opinion about it.

>  I didn't think all of the details had been hammered out yet, like:
> 
>  * ul currently uses the same argument notation for usage and docs.
>    coreutils usages and docs both use their notation style.
>    So won't this switch mean changing all of the docs as well?

Good point.

>  * Your final example was:
> 
> > after change:
> >    -e, --exclude MAJOR     exclude specified devices (see below)
> >    -I, --include MAJOR     show only specified devices (see below)
> >    -o, --output COLUMNS    output columns (see below)
> >    -x, --sort COLUMN       sort output by column
> > 
> >  The MAJOR command separated list of the device major numbers. The
> >  ramdisk devices are excluded by default.
> > 
> >  Available COLUMNS:
> >    NAME  device name
> >    KNAME  internal kernel device name
> >    ...
> 
> Coreutils starts the details sections with the magic argument. See
> 'split --help' and 'date --help'. I think that is better because they
> align and you don't have to look for them.
> 
> IMO, coreutils usage is too verbose and busy; it should be a quick

Well, I'd like to keep our usage() stuff compact and short.

> reference for users that already understand the command and should be as
> terse as possible. Otherwise they probably need to read the manual.
> 
> Perhaps the magic argument name should not be too abstract(MAJOR) and
> its details should be a simple example list? Something like:
> 
>    -e, --exclude DEV       exclude specified devices (see below)
>    -I, --include DEV       show only specified devices (see below)
>    -o, --output COLUMNS    output columns (see below)
>    -x, --sort COLUMN       sort output by column
> 
> DEV: 1,2,3 ... major_dev_number
> 
> COLUMNS: NAME,KNAME, ...
> 
> The linkage between the magic argument and its details section should be
> strong enough to not require any more explanation.

"(see below)" seems good enough 

> I think mixed case for section headers is fine:
> Usage:
> Options:
> SIZE:
> ...

Yes.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
