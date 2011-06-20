Return-Path: john.lindgren@tds.net
Message-ID: <4DFF3613.9050705@tds.net>
Date: Mon, 20 Jun 2011 07:59:15 -0400
From: John Lindgren <john.lindgren@tds.net>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, Andreas Dilger <adilger@sun.com>
Subject: Re: blkid: excessive random reads probing for ZFS on NTFS filesystem
References: <4DF50D58.9020800@tds.net> <20110620111640.GE17967@nb.net.home>
In-Reply-To: <20110620111640.GE17967@nb.net.home>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 06/20/2011 07:16 AM, Karel Zak wrote:
> On Sun, Jun 12, 2011 at 03:02:48PM -0400, John Lindgren wrote:
>> I noticed blkid causing a noticeable amount of disk hits while
>> identifying an NTFS (Win7) partition, and did an strace to find out why
>> this was.  It seems that the probe_zfs() function does a
>> seek-and-read-41-bytes pattern 64 times in the 130 to 520 KB region of
>> the partition.
> Is it really so big problem on traditional HDDs?
Many traditional HD's are rated with a seek time of ~10 ms (though I
work with older hardware mostly; newer ones may be better).  So by a
naive calculation that would make probe_zfs take 0.64 seconds.  Now, in
the case of probe_zfs, the seeks have good locality, so in practice it
will not take that long -- provided blkid is the only program accessing
the disk at that time.  If the system has some sort of read-ahead
process running during boot (as I do), then locality is lost for both
blkid and the read-ahead process, and you get thrashing.

Also take into consideration that while 64 seeks may not seem excessive
in itself, that is for only one filesystem, and blkid checks something
on the order of 40 different filesystems.  (Fortunately none of the
others take anywhere near the number of seeks that zfs_probe does.)

Andreas: As far as implementation, I think the ZFS code could be
improved by parsing the name-value pair list *before* searching for a
valid uberblock, rather than after.  I don't have any ZFS filesystems
around to test with, or I would try to do this myself.

-- John
