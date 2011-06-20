Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24989 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768Ab1FTMqR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Jun 2011 08:46:17 -0400
Date: Mon, 20 Jun 2011 14:46:12 +0200
From: Karel Zak <kzak@redhat.com>
To: John Lindgren <john.lindgren@tds.net>
Cc: util-linux@vger.kernel.org, Andreas Dilger <adilger@sun.com>
Subject: Re: blkid: excessive random reads probing for ZFS on NTFS
	filesystem
Message-ID: <20110620124612.GF17967@nb.net.home>
References: <4DF50D58.9020800@tds.net> <20110620111640.GE17967@nb.net.home> <4DFF3613.9050705@tds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DFF3613.9050705@tds.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 20, 2011 at 07:59:15AM -0400, John Lindgren wrote:
> On 06/20/2011 07:16 AM, Karel Zak wrote:
> > On Sun, Jun 12, 2011 at 03:02:48PM -0400, John Lindgren wrote:
> >> I noticed blkid causing a noticeable amount of disk hits while
> >> identifying an NTFS (Win7) partition, and did an strace to find out why
> >> this was.  It seems that the probe_zfs() function does a
> >> seek-and-read-41-bytes pattern 64 times in the 130 to 520 KB region of
> >> the partition.
> > Is it really so big problem on traditional HDDs?
> Many traditional HD's are rated with a seek time of ~10 ms (though I
> work with older hardware mostly; newer ones may be better).  So by a
> naive calculation that would make probe_zfs take 0.64 seconds.  Now, in
> the case of probe_zfs, the seeks have good locality, so in practice it
> will not take that long -- provided blkid is the only program accessing
> the disk at that time.  If the system has some sort of read-ahead
> process running during boot (as I do), then locality is lost for both
> blkid and the read-ahead process, and you get thrashing.
>
> Also take into consideration that while 64 seeks may not seem excessive
> in itself, that is for only one filesystem, and blkid checks something
> on the order of 40 different filesystems.  (Fortunately none of the
> others take anywhere near the number of seeks that zfs_probe does.)

 Unfortunately, the old less expensive version of the ZFS detection
 code was insufficient.  See Andreas' patches:

 commit e54a76ca076625b1883ddf0595162eb8de81d5d1
 Author: Andreas Dilger <adilger@sun.com>
 Date:   Wed Feb 17 10:21:27 2010 +0100

 commit a1fbeb3df35d1441c4ef64ea7e04c2b1fda38ba2
 Author: Andreas Dilger <adilger@sun.com>
 Date:   Thu Mar 11 15:16:46 2010 +0100


> Andreas: As far as implementation, I think the ZFS code could be
> improved by parsing the name-value pair list *before* searching for a
> valid uberblock, rather than after.

 Doesn't depend the position of the list on the position of the valid
 uberblock?

> I don't have any ZFS filesystems
> around to test with, or I would try to do this myself.

 There is a test image, see tests/ts/blkid/images-fs/zfs.img.bz2

 Maybe you can try to move zfs to the end of the probed filesystems 
 in libblkid/src/superblocks/superblocks.c. It would be better to
 probe for exotic and "expensive" filesytems later.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
