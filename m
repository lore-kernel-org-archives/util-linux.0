Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62524 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab1FTLQo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Jun 2011 07:16:44 -0400
Date: Mon, 20 Jun 2011 13:16:40 +0200
From: Karel Zak <kzak@redhat.com>
To: John Lindgren <john.lindgren@tds.net>
Cc: util-linux@vger.kernel.org, Andreas Dilger <adilger@sun.com>
Subject: Re: blkid: excessive random reads probing for ZFS on NTFS
	filesystem
Message-ID: <20110620111640.GE17967@nb.net.home>
References: <4DF50D58.9020800@tds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DF50D58.9020800@tds.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 12, 2011 at 03:02:48PM -0400, John Lindgren wrote:
> I noticed blkid causing a noticeable amount of disk hits while
> identifying an NTFS (Win7) partition, and did an strace to find out why
> this was.  It seems that the probe_zfs() function does a
> seek-and-read-41-bytes pattern 64 times in the 130 to 520 KB region of
> the partition.

 Is it really so big problem on traditional HDDs?

> This of course is slow on a traditional hard disk, and
> seems excessive.  I don't know the internals of NTFS or of ZFS.  Can
> someone with a little more knowledge in this area provide some pointers
> as to why this might be happening?

 CC: Andreas who is the code (co)author.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
