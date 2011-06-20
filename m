Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52930 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841Ab1FTOFB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Jun 2011 10:05:01 -0400
Date: Mon, 20 Jun 2011 16:04:57 +0200
From: Karel Zak <kzak@redhat.com>
To: John Lindgren <john.lindgren@tds.net>
Cc: util-linux@vger.kernel.org, Andreas Dilger <adilger@sun.com>
Subject: Re: blkid: excessive random reads probing for ZFS on NTFS
	filesystem
Message-ID: <20110620140457.GI17967@nb.net.home>
References: <4DF50D58.9020800@tds.net> <20110620111640.GE17967@nb.net.home> <4DFF3613.9050705@tds.net> <20110620124612.GF17967@nb.net.home> <4DFF45A0.1040703@tds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DFF45A0.1040703@tds.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 20, 2011 at 09:05:36AM -0400, John Lindgren wrote:
> I did try that; however, blkid checks *all* filesystems, even after it
> finds a match, just in case two probes turn up positive.  Even passing
> "-n nozfs" doesn't actually prevent it from checking for ZFS.

 The name of the FS in libblkid is zfs_member :-)

    blkid -p -o udev -n nozfs_member

 Yeah, crazy name, see our TODO file:

   - add something like "blkid --list-known" to list all supported
     filesystems/raids
     
 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
