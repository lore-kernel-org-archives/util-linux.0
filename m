Return-Path: util-linux-owner@vger.kernel.org
Received: from cn.fujitsu.com ([59.151.112.132]:37873 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750998AbaDQBP6 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Apr 2014 21:15:58 -0400
Message-ID: <534F2B8F.5010906@cn.fujitsu.com>
Date: Thu, 17 Apr 2014 09:17:03 +0800
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: <util-linux@vger.kernel.org>
Subject: Re: libblkid: Idea to force given cached entry to be invalidated?
References: <534C9625.8030906@cn.fujitsu.com> <20140415112159.GE5786@x2.net.home> <534DD487.6090700@cn.fujitsu.com> <20140416090359.GF5786@x2.net.home>
In-Reply-To: <20140416090359.GF5786@x2.net.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


-------- Original Message --------
Subject: Re: libblkid: Idea to force given cached entry to be invalidated?
From: Karel Zak <kzak@redhat.com>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Date: 2014年04月16日 17:03
> On Wed, Apr 16, 2014 at 08:53:27AM +0800, Qu Wenruo wrote:
>>> So the problem is not that btrfs is fast enough ;-)
>> According to your explaination, it seems that if there is any modification
>> to the block device, libblkid will rescan it and not
>> to use the old cache, do I understand it right?
> Yes, blkid_verify():
>
> 	if (now >= dev->bid_time &&
> #ifdef HAVE_STRUCT_STAT_ST_MTIM_TV_NSEC
> 	    (st.st_mtime < dev->bid_time ||
> 	        (st.st_mtime == dev->bid_time &&
> 		 st.st_mtim.tv_nsec / 1000 <= dev->bid_utime)) &&
> #else
> 	    st.st_mtime <= dev->bid_time &&
> #endif
> 	    (diff < BLKID_PROBE_MIN ||
> 		(dev->bid_flags & BLKID_BID_FL_VERIFIED &&
> 		 diff < BLKID_PROBE_INTERVAL)))
> 		return dev;
>
>
> It checks two basic things:
>
>   a) compare device st_mtime with cache entry time (bid_time and bid_utime),
>      the valid cache entry has not to be older than device mtime.
>
>   b) valid cache entry has not to be older than BLKID_PROBE_MIN (2 sec)
>      and previous blkid_verify() validation remaining in memory has not
>      to be older than BLKID_PROBE_INTERVAL (200s).
>
>>> BTW, it would be nice to have --verbose option for btrfs-scan, now it
>>> seems like black box.
>> I'd like to add it, but as you know, 'btrfs dev scan' just calls a btrfs
>> ioctl, so even '--verbose' is added,
>> nothing useful will be printed out. :(
> Well, I mean at least info about for what devices it calls the ioctls.
>
>      Karel
>
Thanks for all your explaination.
Now I think I am somewhat clear of the libblkid cache now.

But after some tests, it seems that the ctime/mtime based cache seems 
not perfect due to the fact that multiple
device file can be created in different fs with same major/minor number.
especially each of them has individual ctime/mtime timestamp.

So if someone (maybe insane) use mknod to create as block device file 
and use 'btrfs dev del' on the newly created
block device file, libblkid will still be unable to detect the change 
since the ctime/mtime of block device file in /dev/
does not change.

Will libblkid be able to deal with it in later versions? (Although not 
related to my original problem now)

Thanks,
Qu
