Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23054 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755052AbaDPJEL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Apr 2014 05:04:11 -0400
Date: Wed, 16 Apr 2014 11:03:59 +0200
From: Karel Zak <kzak@redhat.com>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: Idea to force given cached entry to be invalidated?
Message-ID: <20140416090359.GF5786@x2.net.home>
References: <534C9625.8030906@cn.fujitsu.com>
 <20140415112159.GE5786@x2.net.home>
 <534DD487.6090700@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <534DD487.6090700@cn.fujitsu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 16, 2014 at 08:53:27AM +0800, Qu Wenruo wrote:
> >So the problem is not that btrfs is fast enough ;-)
> According to your explaination, it seems that if there is any modification
> to the block device, libblkid will rescan it and not
> to use the old cache, do I understand it right?

Yes, blkid_verify():

	if (now >= dev->bid_time &&
#ifdef HAVE_STRUCT_STAT_ST_MTIM_TV_NSEC
	    (st.st_mtime < dev->bid_time ||
	        (st.st_mtime == dev->bid_time &&
		 st.st_mtim.tv_nsec / 1000 <= dev->bid_utime)) &&
#else
	    st.st_mtime <= dev->bid_time &&
#endif
	    (diff < BLKID_PROBE_MIN ||
		(dev->bid_flags & BLKID_BID_FL_VERIFIED &&
		 diff < BLKID_PROBE_INTERVAL)))
		return dev;


It checks two basic things:

 a) compare device st_mtime with cache entry time (bid_time and bid_utime), 
    the valid cache entry has not to be older than device mtime.

 b) valid cache entry has not to be older than BLKID_PROBE_MIN (2 sec)
    and previous blkid_verify() validation remaining in memory has not 
    to be older than BLKID_PROBE_INTERVAL (200s). 

> >BTW, it would be nice to have --verbose option for btrfs-scan, now it
> >seems like black box.
> I'd like to add it, but as you know, 'btrfs dev scan' just calls a btrfs
> ioctl, so even '--verbose' is added,
> nothing useful will be printed out. :(

Well, I mean at least info about for what devices it calls the ioctls.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
