Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752075AbdERIeE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 18 May 2017 04:34:04 -0400
Date: Thu, 18 May 2017 10:34:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: udf: Incorrect implementation of Unicode strings
Message-ID: <20170518083400.pi6l3r3kbombo6qa@ws.net.home>
References: <201705121638.59416@pali>
 <20170516140245.GE10015@pali>
 <20170517071333.wj4glanhfh2aje72@ws.net.home>
 <201705172050.48793@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201705172050.48793@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 17, 2017 at 08:50:48PM +0200, Pali Rohár wrote:
> Still, more UDF disks created by Nero, new mkudffs or new udfclient have 
> only hexdigits stored in VolSetID. So it is better to use them directly 
> instead of encoding hexdigits characters via %02x.

OK, I see.

> I tried to modify current algorithm to take UTF-8 representation for its 
> input (therefore correctly handle both 8bit and 16bit OSTA Unicode) and 
> honor above hexdigits in VolSetID.
> 
> Please look at review my proposed changes:
> https://github.com/karelzak/util-linux/pull/439

Looks good.

It seems the most invasive change (in many cases) is the tolower() :-)
IMHO it's good idea to generate normalized UUID.

> > The another option would be use some hash sum to standardize
> > arbitrary number of bytes (for example we use MD5 to generate UUID
> > for libblkid/src/superblocks/hfs.c). In this case we can use also
> > some another bytes from the header, for example
> > volume_descriptor.tag. The disadvantage is dependence on checksum
> > code, so bad portability to another projects (grub, etc.).
> 
> Looks like too complicated, specially decision on checksum/hash function 
> could be problematic to implement in other projects. Probably hash 
> functions does not have to be fast (even there are fast MD5 
> implementations).

Yes, the portability to the another projects is painful in this case.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
