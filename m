Return-Path: systemd-devel-bounces@lists.freedesktop.org
Date: Wed, 25 Jun 2014 00:36:45 +0000
From: Minchan Kim <minchan@kernel.org>
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Message-ID: <20140625003645.GC11030@gmail.com>
References: <53953D5C.1080004@gmail.com> <i8pg6b-mg8.ln1@hurikhan77.spdns.de>
 <5395BE60.70309@gmail.com> <pd8h6b-ufa.ln1@hurikhan77.spdns.de>
 <5395FF3A.9050407@gmail.com> <20140624062209.GA10661@gmail.com>
 <53A91C0A.2020807@gmail.com> <20140624065816.GA11030@gmail.com>
 <20140624074958.GB11030@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20140624074958.GB11030@gmail.com>
Cc: util-linux@vger.kernel.org, Kai Krakow <hurikhan77@gmail.com>,
        systemd-devel@lists.freedesktop.org, kay@vrfy.org,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: [systemd-devel] systemd-213: regression with zram
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>,
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>,
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: systemd-devel-bounces@lists.freedesktop.org
Sender: "systemd-devel" <systemd-devel-bounces@lists.freedesktop.org>
List-ID: <util-linux.vger.kernel.org>

Hello Alexander,

On Tue, Jun 24, 2014 at 07:49:58AM +0000, Minchan Kim wrote:
> On Tue, Jun 24, 2014 at 07:21:12AM +0000, Minchan Kim wrote:
> > On Tue, Jun 24, 2014 at 12:34:50PM +0600, Alexander E. Patrakov wrote:
> > > 24.06.2014 12:22, Minchan Kim wrote:
> > > >
> > > >Hello,
> > > >
> > > >Sorry for the late response.
> > > 
> > > Better late than never.
> > > 
> > > >If I parse your problem correctly, you meant that changing disksize is
> > > >failed while someone opens /dev/zram0?
> > > >
> > > >I tried test which opens "/dev/zram0" with O_RDWR and sleep forever
> > > >and then echo $((512<<20)) > /sys/block/zram0/disksize is successful.
> > > >IOW, it's okay with me.
> > > 
> > > No, this is only a part of the problem. A valid test would be:
> > > 
> > > 0. Reset the unused zram device.
> > > 1. Use a program that opens /dev/zram0 with O_RDWR and sleeps until killed.
> > > 2. While that program sleeps, echo the correct value to
> > > /sys/block/zram0/disksize.
> > > 3. Verify (e.g. in /proc/partitions) that the disk size is applied
> > > correctly. It is.
> > > 4. While that program still sleeps, attempt to mkswap /dev/zram0.
> > > This fails:
> > > 
> > > mkswap: error: swap area needs to be at least 40 KiB
> > > 
> > > There is nothing in dmesg.
> > 
> > Thanks. I could reproduce.
> > When I read strace result, fstat access closed fd which seem to be
> > a culprit.
> > 
> > Cced util-linux.
> 
> When I read disk-utils/mkswap.c, it's not a problem of mkswap.
> The problem is ioctl(fd, BLKGETSIZE64, bytes) is not work in
> your scenario. IOW, kernel fault.
> Hmm,, will investgate it.
> 
> Thanks for the report!

Could you test this patch? It passed my test.
Thanks!

>From 4ab4931c3fa7e6527e3a849d5e4c4f727143e66c Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Wed, 25 Jun 2014 09:20:24 +0900
Subject: [PATCH] zram: revalidate disk after capacity change

Alexander reported mkswap on /dev/zram0 is failed if other process
is opening the block device file.

Step is as follows,

0. Reset the unused zram device.
1. Use a program that opens /dev/zram0 with O_RDWR and sleeps until killed.
2. While that program sleeps, echo the correct value to /sys/block/zram0/disksize.
3. Verify (e.g. in /proc/partitions) that the disk size is applied correctly. It is.
4. While that program still sleeps, attempt to mkswap /dev/zram0. This fails:
result: mkswap: error: swap area needs to be at least 40 KiB

When I investigated, the size get by ioctl(fd, BLKGETSIZE64) on mkswap
to get a size of blockdev was zero although zram0 has right size
by 2.

The reason is zram didn't revalidate disk after changing capacity
so that size of blockdev's inode is not uptodate until all of file is close.

This patch should fix the problem.

Reported-by: Alexander E. Patrakov <patrakov@gmail.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 48eccb350180..089e72cd37be 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -622,8 +622,10 @@ static void zram_reset_device(struct zram *zram, bool reset_capacity)
 	memset(&zram->stats, 0, sizeof(zram->stats));
 
 	zram->disksize = 0;
-	if (reset_capacity)
+	if (reset_capacity) {
 		set_capacity(zram->disk, 0);
+		revalidate_disk(zram->disk);
+	}
 	up_write(&zram->init_lock);
 }
 
@@ -664,6 +666,7 @@ static ssize_t disksize_store(struct device *dev,
 	zram->comp = comp;
 	zram->disksize = disksize;
 	set_capacity(zram->disk, zram->disksize >> SECTOR_SHIFT);
+	revalidate_disk(zram->disk);
 	up_write(&zram->init_lock);
 	return len;
 
-- 
2.0.0

_______________________________________________
systemd-devel mailing list
systemd-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/systemd-devel
