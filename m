Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33198 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdEPOCt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 16 May 2017 10:02:49 -0400
Received: by mail-lf0-f54.google.com with SMTP id m18so11888557lfj.0
        for <util-linux@vger.kernel.org>; Tue, 16 May 2017 07:02:49 -0700 (PDT)
Date: Tue, 16 May 2017 16:02:45 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: udf: Incorrect implementation of Unicode strings
Message-ID: <20170516140245.GE10015@pali>
References: <201705121638.59416@pali>
 <20170515100940.lggq2um6xt3dg66p@ws.net.home>
 <20170515123845.GA10015@pali>
 <20170516110139.v63qiov2ndxw2gwa@ws.net.home>
 <20170516115940.GD10015@pali>
 <20170516125257.s6ndqrergbkghcoh@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170516125257.s6ndqrergbkghcoh@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 16 May 2017 14:52:57 Karel Zak wrote:
> On Tue, May 16, 2017 at 01:59:40PM +0200, Pali Rohár wrote:
> > On Tuesday 16 May 2017 13:01:39 Karel Zak wrote:
> > > On Mon, May 15, 2017 at 02:38:45PM +0200, Pali Rohár wrote:
> > > > But question remain what to do with UUID.
> > > 
> > > It seem generated UUID is libblkid feature and another tools/systems
> > > don't use anything like UUID for UDF, right?
> > 
> > Yes. Introduced in https://github.com/karelzak/util-linux/pull/135
> 
> :-)
> 
> > But I would like to see UUID support also on other places (e.g. Grub2)
> > so it would be possible to use it really as UUID of FS. Which means we
> > need some normalized way of generation.
> 
> OK.
> 
> > > If yes... then we can keep it unchanged, generate UUDI in the same way
> > > as now (hexadecimal digits). The "OSTA Unicode fix" maybe be used for
> > > LABEL= (etc) only. I guess nothing forces use to generate UUIDs from 
> > > decoded VolSetId.
> > > 
> > > Anyway, UUID has to be printable.
> > 
> > Lets first define allowed characters in UUID and then what we do with
> > UDF's UUID.
> > 
> > Printable means only printable ASCII? Or also printable from Unicode? Or
> > only alphanumeric?
> 
> I'd like to be very conservative and avoid anything else than ASCII.
> It's identifier that should be usable everywhere.
> 
> udev uses the UUID for paths and symlinks, "bad chars" are escaped and
> it's very user unfriendly. We should be also user friendly to non-UTF
> users, terminals, etc.
> 
> IMHO the best solution would be to use lowercase hex-digits like for
> another filesystems (and super ideal would be follow UUID notation for
> formatting (e.g. "c5490147-2a6c-4c8a-aa1b-33492034f927") ;-).

We have only 16 Unicode characters (and first 8 are hexdigits), so
above format for 128bit UUID notation is not possible.

Currently VolSetID is parsed as bytes instead of (Unicode) characters.
We can correctly parse it, read first 16 chars, convert then UTF-8 and
then use those UTF-8 bytes as input for generating UUID. This step has
advantage that deals with Unicode (and does not matter on internal
representation of VolSetID string stored in UDF) and also that produce
normalized bytes which can be later used...

You want to have only lowercase hexdigits in UUID. I understand this
reason, it makes sense. But how to generate UUID from (potentially
arbitrary) UTF-8 sequence of 16 Unicode characters? Because UTF-8 is
variable length encoding.

Currently UUID generator split those 16 chars/bytes into first and
second half because according to UDF standard that first half should
contain only hexdigits (and in most cases they really are!). Half which
is not alphanumeric is encoded via %02x per byte. And final string
truncated to 16 bytes (to have fixed length).

What we can do is to take UTF-8 sequence (instead raw UDF bytes) and
encode non-hexdigits bytes (instead non-alnum) via %02x. And truncate
again to 16 hexdigits.

What do you think about it? Or do you have better idea?

> > > > I suggest to include all UDF changes in one release, so "breakage" would
> > > > be just between two versions. So if above Label/UUID changes would not
> > > > be ready for next release, I would suggest to postpone currently merged
> > > > UDF changes.
> > > 
> > > Yes.
> 
> I have released v2.30-rc1, we have time to -rc2 (~1 month).
> 
>     Karel
> 

-- 
Pali Rohár
pali.rohar@gmail.com
