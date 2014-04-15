Return-Path: util-linux-owner@vger.kernel.org
Received: from cn.fujitsu.com ([59.151.112.132]:64281 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750865AbaDOEvp convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 15 Apr 2014 00:51:45 -0400
Message-ID: <534CBB1E.70701@cn.fujitsu.com>
Date: Tue, 15 Apr 2014 12:52:46 +0800
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: <util-linux@vger.kernel.org>
Subject: Re: libblkid: Idea to force given cached entry to be invalidated?
References: <534C9625.8030906@cn.fujitsu.com> <20140415042729.GC3403@thunk.org>
In-Reply-To: <20140415042729.GC3403@thunk.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


-------- Original Message --------
Subject: Re: libblkid: Idea to force given cached entry to be invalidated?
From: Theodore Ts'o <tytso@mit.edu>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Date: 2014年04月15日 12:27
> On Tue, Apr 15, 2014 at 10:15:01AM +0800, Qu Wenruo wrote:
>> Though the above patch try to avoid the whole cache, it's not good enough
>> since it break the pricible not
>> to probe the devices too frequently.
>>
>> After some searching, it seems that libblkid does not provide such API, or
>> am I missing something?
> The blkid_verify() function is designed to make sure the information
> in the cache corresponds with reality.  If it does not, it will update
> the cache to match with reality, so it will do what you want.
>
> Using blkid_verify() will involve accessing the disk involved, but
> that's still better than the alternative of scanning all of the disks
> in the system.
>
> Cheers,
>
> 					- Ted
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
I hope I was wrong but according to the codes, blkid_verify() seems 
still using the cache:
------
blkid_dev blkid_verify(blkid_cache cache, blkid_dev dev)
{
......
             (diff < BLKID_PROBE_MIN ||
                 (dev->bid_flags & BLKID_BID_FL_VERIFIED &&
                  diff < BLKID_PROBE_INTERVAL)))
                 return dev;
------

So it seems not working in the case.

Also in the btrfs-progs codes, it has already called blkid_verify() 
before operations.

Thanks,
Qu.
