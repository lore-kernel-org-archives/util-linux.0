Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753496AbdEQHNi (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 May 2017 03:13:38 -0400
Date: Wed, 17 May 2017 09:13:33 +0200
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: udf: Incorrect implementation of Unicode strings
Message-ID: <20170517071333.wj4glanhfh2aje72@ws.net.home>
References: <201705121638.59416@pali>
 <20170515100940.lggq2um6xt3dg66p@ws.net.home>
 <20170515123845.GA10015@pali>
 <20170516110139.v63qiov2ndxw2gwa@ws.net.home>
 <20170516115940.GD10015@pali>
 <20170516125257.s6ndqrergbkghcoh@ws.net.home>
 <20170516140245.GE10015@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170516140245.GE10015@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 16, 2017 at 04:02:45PM +0200, Pali Rohár wrote:
> > > > If yes... then we can keep it unchanged, generate UUDI in the same way
> > > > as now (hexadecimal digits). The "OSTA Unicode fix" maybe be used for
> > > > LABEL= (etc) only. I guess nothing forces use to generate UUIDs from 
> > > > decoded VolSetId.
> > > > 
> > > > Anyway, UUID has to be printable.
> > > 
> > > Lets first define allowed characters in UUID and then what we do with
> > > UDF's UUID.
> > > 
> > > Printable means only printable ASCII? Or also printable from Unicode? Or
> > > only alphanumeric?
> > 
> > I'd like to be very conservative and avoid anything else than ASCII.
> > It's identifier that should be usable everywhere.
> > 
> > udev uses the UUID for paths and symlinks, "bad chars" are escaped and
> > it's very user unfriendly. We should be also user friendly to non-UTF
> > users, terminals, etc.
> > 
> > IMHO the best solution would be to use lowercase hex-digits like for
> > another filesystems (and super ideal would be follow UUID notation for
> > formatting (e.g. "c5490147-2a6c-4c8a-aa1b-33492034f927") ;-).
> 
> We have only 16 Unicode characters (and first 8 are hexdigits), so
> above format for 128bit UUID notation is not possible.
> 
> Currently VolSetID is parsed as bytes instead of (Unicode) characters.
> We can correctly parse it, read first 16 chars, convert then UTF-8 and
> then use those UTF-8 bytes as input for generating UUID. This step has
> advantage that deals with Unicode (and does not matter on internal
> representation of VolSetID string stored in UDF) and also that produce
> normalized bytes which can be later used...
> 
> You want to have only lowercase hexdigits in UUID. I understand this
> reason, it makes sense. But how to generate UUID from (potentially
> arbitrary) UTF-8 sequence of 16 Unicode characters? Because UTF-8 is
> variable length encoding.
> 
> Currently UUID generator split those 16 chars/bytes into first and
> second half because according to UDF standard that first half should
> contain only hexdigits (and in most cases they really are!). Half which
> is not alphanumeric is encoded via %02x per byte. And final string
> truncated to 16 bytes (to have fixed length).
> 
> What we can do is to take UTF-8 sequence (instead raw UDF bytes) and
> encode non-hexdigits bytes (instead non-alnum) via %02x. And truncate
> again to 16 hexdigits.

This is what I expected... don't think about it as about characters,
but as about random bytes that we print as %02x. The result will be 
always the same for the same UDF header, right?

The another option would be use some hash sum to standardize arbitrary
number of bytes (for example we use MD5 to generate UUID for
libblkid/src/superblocks/hfs.c). In this case we can use also some
another bytes from the header, for example volume_descriptor.tag. The
disadvantage is dependence on checksum code, so bad portability to
another projects (grub, etc.).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
