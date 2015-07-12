Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:55833 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbbGLEkl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 12 Jul 2015 00:40:41 -0400
Message-ID: <55A1EAB5.1030108@tlinx.org>
Date: Sat, 11 Jul 2015 21:19:01 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Tom Yan <tom.ty89@gmail.com>, util-linux@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: optimal io size / custom alignment -- caution on custom aligns
References: <CAGnHSE=gtd2WVcxOBoyfqnp3QtT4RHfK356GHastBbiK5mtmFA@mail.gmail.com> <20150615133154.GV1992@ws.net.home>
In-Reply-To: <20150615133154.GV1992@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Sat, Jun 13, 2015 at 10:52:04PM +0800, Tom Yan wrote
>
> I think we can test "optimal_io_size % physical_sector_size" and use physical
> sector size as the granularity if the optimal_io_size is a strange number.
>
>> In any case, it would be nice if fdisk can allow customize alignment
>> (like gdisk does), so that users can at least decide how partitions
>> should be aligned in weird cases like this. With that, the long-time
>> deprecated "dos compatibility" might be able to go as well.
>
> I'll think about it...
>
>     Karel
> ---------------------
>   
I know it's been a while since the above note was written, but just
saw it reviewing old messages and thought I'd pass on a warning.


Warning...if your stripe size  (the strip on 1 disk x # data disks)
is not a power of 2, don't bother trying to make perl.

It uses the gnu DB libraries that choke on non-power-of-two
"optimal" I/O sizes (had a RAID 50 that I took 3, 4-data-spindle RAIDS
and striped them.  strip=64k, stripe=256k, optimal with 3 stripes was
listed @ 768k.  Several of the gnu libs used assumptions that the optimal
size would be a power of 2.  If not, the DB would become corrupt --
of course it was only my machine -- not until I read the code and saw
the power of 2 assumption....ARG!  Took almost a year for that, since first
version of perl I found it in was 5.14.  Wasn't fixed for 5.16 or 5.18...
dunnow about now.

Just a random caution...the bug was in the gdbm/ndbm code.  Sometime
later I needed a disk replacement.  went to a RAID10 -- 2 mirrors,
stripped.  The old bug hasn't cropped up since.   I recommended to
the perl folk that they should test for that case.  They didn't think
it would be a problem, given I was the only reportee... But others
may  have run into that or not used db's... but, the p5p teamm
didn't want the extra work so they closed the bug as invalid....
invalid?!



