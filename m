Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40800 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755739AbaDQIV3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Apr 2014 04:21:29 -0400
Date: Thu, 17 Apr 2014 10:21:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: Idea to force given cached entry to be invalidated?
Message-ID: <20140417082105.GH5786@x2.net.home>
References: <534C9625.8030906@cn.fujitsu.com>
 <20140415112159.GE5786@x2.net.home>
 <534DD487.6090700@cn.fujitsu.com>
 <20140416090359.GF5786@x2.net.home>
 <534F2B8F.5010906@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <534F2B8F.5010906@cn.fujitsu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 17, 2014 at 09:17:03AM +0800, Qu Wenruo wrote:
> But after some tests, it seems that the ctime/mtime based cache seems not
> perfect due to the fact that multiple

Yes, the cache is not perfect -- it was originally introduced by Ted
in time when things was less complicated :-) The current goal is to
avoid the cache usage, so we have low-level API in libblkid to bypass
the cache at all, and in userspace we use this API or udev db. I guess
that many users have the cache empty, because it's unnecessary for
fsck, mount, lsblk, findmnt, systemd etc.

> device file can be created in different fs with same major/minor number.
> especially each of them has individual ctime/mtime timestamp.
> 
> So if someone (maybe insane) use mknod to create as block device file and
> use 'btrfs dev del' on the newly created
> block device file, libblkid will still be unable to detect the change since
> the ctime/mtime of block device file in /dev/
> does not change.

Not sure if I understand, it would be nice to have complete example.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
