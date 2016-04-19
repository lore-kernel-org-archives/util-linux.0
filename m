Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:35316 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754734AbcDSOnX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Apr 2016 10:43:23 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1asWs3-0006ie-L4
	for util-linux@vger.kernel.org; Tue, 19 Apr 2016 16:43:19 +0200
Received: from 95.131.151.139 ([95.131.151.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2016 16:43:19 +0200
Received: from yumkam by 95.131.151.139 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2016 16:43:19 +0200
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: [RFC][WIP][PATCH] fsck -l and lvm/dmcrypt/md/etc
Date: Tue, 19 Apr 2016 17:42:55 +0300
Message-ID: <m3twixk6c0.fsf@gmail.com>
References: <m34mbbrd8d.fsf@gmail.com>
	<20160418105923.lj5sb2m4joxxehno@ws.net.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Karel Zak <kzak@redhat.com> writes:

> On Sat, Apr 09, 2016 at 12:40:18AM +0300, Yuriy M. Kaminskiy wrote:
>> I think this algorithm should work:
>> 
>> 1) walk /dev/block/${dev}/slaves recursively (e.g. lvm-over- luks-
>> over-lvm- over-md, first-level slaves won't work), collect all
>> whole-disk devices;
>> 2) sort this list by device numbers (to avoid AB/BA deadlocks), remove
>> duplicates;
>> 3) acquire all locks consequently.
>> 
>> There are some unavoidable flaws (e.g. if someone alters structure while fsck
>> is running), and some things could be improved, but it should work in
>> most cases (and if it fails, it is just no worse than current behavior).
>> 
>> I've tested with LVM and LUKS-over-LVM on (debian's) 3.16 kernel, it seems
>> works as expected.
>> 
>> What is not covered: /dev/loop* (and I have no plans for it).
>> 
>> Comments? NACKs?
>
> The question is if we really need it :-)

Yes?

> All the care fsck has about whole-disks is about performance, because
> we assume (on classic rotation disks) that execute fsck on more
> partitions in the same time is bad idea.
>
> The problem with stacked devices is that we have no clue about sectors
> mapping. Your patch locks all the disks, but maybe kernel will read
> only from some subset of the disks, etc.

Is this likely scenario? (Or even possible? I can imagine that, with
lvm-over-raid1+, kernel theoretically can schedule one fsck instance to
read only slaveA, and another to read only from slaveB, thus avoiding
seeking; but I suspect, in practice it will just roundrobin all requests
over both slaves, thus same seekstorm.)

> From my point of view the best way is not to care about it in
> userspace at all and depend on kernel I/O scheduling only. The

No problem. Please set in-kernel fsck-friendly io scheduler for fsck
instead. (Oh, there are none exists?)

> optimization probably still makes sense for classic layout
> "HDD->partition", but I don't think we need to extend this
> functionality to another use-cases.

`fsck -A` does not execute fsck for any stacked devices in
parallel. `fsck -l` does. This is inconsistent and unfair. Alternative
(simplier) patch attached (compile-tested only).


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=fsck-l-disallow-parallel-fsck-for-stacked-devices.patch

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 84d2dcc..73ec9bd 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -109,6 +109,7 @@ struct fsck_instance {
 
 	int	lock;		/* flock()ed lockpath file descriptor or -1 */
 	char	*lockpath;	/* /run/fsck/<diskname>.lock or NULL */
+	int	lock_stacked;	/* flock()ed stacked file descriptor or -1 */
 
 	int	exit_status;
 	struct timeval start_time;
@@ -337,6 +338,7 @@ static int is_irrotational_disk(dev_t disk)
 
 static void lock_disk(struct fsck_instance *inst)
 {
+	char path[PATH_MAX];
 	dev_t disk = fs_get_disk(inst->fs, 1);
 	char *diskpath = NULL, *diskname;
 
@@ -365,6 +367,18 @@ static void lock_disk(struct fsck_instance *inst)
 	if (!diskname)
 		diskname = diskpath;
 
+	snprintf(path, sizeof(path), FSCK_RUNTIME_DIRNAME "/stacked.lock");
+
+	inst->lock_stacked = open(path, O_RDONLY|O_CREAT|O_CLOEXEC,
+				    S_IWUSR|S_IRUSR|S_IRGRP|S_IROTH);
+	if (inst->lock_stacked >= 0) {
+		if (flock(inst->lock_stacked,
+			fs_is_stacked(inst->fs) ? LOCK_EX : LOCK_SH) != 0) {
+			close(inst->lock_stacked);	/* failed */
+			inst->lock_stacked = -1;
+		}
+	}
+ 	
 	xasprintf(&inst->lockpath, FSCK_RUNTIME_DIRNAME "/%s.lock", diskname);
 
 	if (verbose)
@@ -410,10 +424,12 @@ static void unlock_disk(struct fsck_instance *inst)
 		printf(_("Unlocking %s.\n"), inst->lockpath);
 
 	close(inst->lock);			/* unlock */
+	close(inst->lock_stacked);		/* unlock */
 
 	free(inst->lockpath);
 
 	inst->lock = -1;
+	inst->lock_stacked = -1;
 	inst->lockpath = NULL;
 }
 

--=-=-=--

