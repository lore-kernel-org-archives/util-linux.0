Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752541AbdEPMxC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 16 May 2017 08:53:02 -0400
Date: Tue, 16 May 2017 14:52:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: udf: Incorrect implementation of Unicode strings
Message-ID: <20170516125257.s6ndqrergbkghcoh@ws.net.home>
References: <201705121638.59416@pali>
 <20170515100940.lggq2um6xt3dg66p@ws.net.home>
 <20170515123845.GA10015@pali>
 <20170516110139.v63qiov2ndxw2gwa@ws.net.home>
 <20170516115940.GD10015@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170516115940.GD10015@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 16, 2017 at 01:59:40PM +0200, Pali Rohár wrote:
> On Tuesday 16 May 2017 13:01:39 Karel Zak wrote:
> > On Mon, May 15, 2017 at 02:38:45PM +0200, Pali Rohár wrote:
> > > But question remain what to do with UUID.
> > 
> > It seem generated UUID is libblkid feature and another tools/systems
> > don't use anything like UUID for UDF, right?
> 
> Yes. Introduced in https://github.com/karelzak/util-linux/pull/135

:-)

> But I would like to see UUID support also on other places (e.g. Grub2)
> so it would be possible to use it really as UUID of FS. Which means we
> need some normalized way of generation.

OK.

> > If yes... then we can keep it unchanged, generate UUDI in the same way
> > as now (hexadecimal digits). The "OSTA Unicode fix" maybe be used for
> > LABEL= (etc) only. I guess nothing forces use to generate UUIDs from 
> > decoded VolSetId.
> > 
> > Anyway, UUID has to be printable.
> 
> Lets first define allowed characters in UUID and then what we do with
> UDF's UUID.
> 
> Printable means only printable ASCII? Or also printable from Unicode? Or
> only alphanumeric?

I'd like to be very conservative and avoid anything else than ASCII.
It's identifier that should be usable everywhere.

udev uses the UUID for paths and symlinks, "bad chars" are escaped and
it's very user unfriendly. We should be also user friendly to non-UTF
users, terminals, etc.

IMHO the best solution would be to use lowercase hex-digits like for
another filesystems (and super ideal would be follow UUID notation for
formatting (e.g. "c5490147-2a6c-4c8a-aa1b-33492034f927") ;-).

> > > I suggest to include all UDF changes in one release, so "breakage" would
> > > be just between two versions. So if above Label/UUID changes would not
> > > be ready for next release, I would suggest to postpone currently merged
> > > UDF changes.
> > 
> > Yes.

I have released v2.30-rc1, we have time to -rc2 (~1 month).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
