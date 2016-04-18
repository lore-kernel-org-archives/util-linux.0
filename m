Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:35553 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbcDROWO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 10:22:14 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id A6123AD27
	for <util-linux@vger.kernel.org>; Mon, 18 Apr 2016 14:22:04 +0000 (UTC)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] libblkid: make blkid_do_wipe() work with probes with offset
Date: Mon, 18 Apr 2016 16:22:05 +0200
Message-Id: <1460989325-28748-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When a probe is created with an offset, e.g. via
blkid_probe_set_device(), this offset is correctly used when looking for
the signatures, but is not respected by blkid_do_wipe() function.
Therefore the signature is removed from an invalid location.

Usecase: Wiping signatures from an area on the block device where
partition is to be created (but as it does not exist yet, there's no
device node for it and probe on the whole block device has to be used
with correct offset and length).

Reproducer:
======================== wiper.c ===========================

const char *dev;
unsigned long offset;
unsigned long size;

int main(int argc, char** argv) {

        if (argc != 4) {
                printf("usage: wiper dev offset size\n");
                exit(1);
        }

        dev = argv[1];
        offset = strtoull(argv[2], NULL, 10);
        size = strtoull(argv[3], NULL, 10);

        printf("dev=%s, off=%llu, size=%llu\n", dev, offset, size);

        int fd = open (dev, O_RDWR);
        if (fd == -1) {
                perror("open");
                exit(1);
        }

        blkid_loff_t wipe_offset = offset * SECTOR_SIZE;
        blkid_loff_t wipe_size = size * SECTOR_SIZE;

        int ret;

        blkid_probe pr;
        pr = blkid_new_probe();
        if (!pr)
                return 0;
        ret = blkid_probe_set_device(pr, fd, wipe_offset, wipe_size);
        ret = blkid_probe_enable_superblocks(pr, 1);
        ret = blkid_probe_set_superblocks_flags(pr, BLKID_SUBLKS_MAGIC);

        while (blkid_do_probe(pr) == 0) {
                ret = blkid_do_wipe(pr, 0);
        }

        blkid_free_probe(pr);
        close(fd);
}
======================== wiper.c ===========================

Steps to reproduce:
modprobe scsi_debug
parted -s /dev/sdX mklabel gpt
parted -s /dev/sdX mkpart first 2048s 4095s
mkfs.ext2 /dev/sdX1

wipefs -np /dev/sdX1

./wiper /dev/sdX1 2048 2048

Actual result: wiper gets into endless loop, because
blkid_do_wipe() wipes at wrong location (1080), leaving the signature
on /dev/sdc1. So it is again found by blkid_do_probe(), and so on.

Expected result: wiper clears the ext2 signature at offset 1049656(=1080+2048*512).

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 libblkid/src/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 34d97b8..0c8625c 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -1121,7 +1121,7 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
 	if (rc || len == 0 || off == NULL)
 		return 0;
 
-	offset = strtoumax(off, NULL, 10);
+	offset = strtoumax(off, NULL, 10) + pr->off;
 	fd = blkid_probe_get_fd(pr);
 	if (fd < 0)
 		return -1;
-- 
1.8.4.5

