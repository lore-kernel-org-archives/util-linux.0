Return-Path: util-linux-owner@vger.kernel.org
Received: from p01c12o145.mxlogic.net ([208.65.145.68]:33793 "EHLO
	p01c12o145.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbaG2WuO (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 29 Jul 2014 18:50:14 -0400
Date: Tue, 29 Jul 2014 18:42:47 -0400
From: Joe Lawrence <joe.lawrence@stratus.com>
To: <util-linux-ng@vger.kernel.org>
CC: Karel Zak <kzak@redhat.com>, Joe Lawrence <joe.lawrence@stratus.com>,
        Bill Kuzeja <william.kuzeja@stratus.com>
Subject: [PATCH] libblkid: use sector size for GPT magic offset
Message-ID: <alpine.DEB.2.02.1407291822460.5738@jlaw-desktop.mno.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Karel & list,

Stratus encountered a problem recently when installing RHEL7 onto a 
Seagate ST300MP0065 disk (4k native sector size).  This disk happened to 
contain a GPT from a previous OS install and Anaconda hung when running 
"wipefs -f -a /dev/sda" to try and clear the old GPT.

Tests running the same install (old GPT) with 512 sector size disks 
succeeded.

To manually reproduce with the latest upstream git util-linux and without 
Anaconda we did the following:

 % lsscsi | grep /dev/sda                                                                                                 
 [3:0:1:0]    disk    SEAGATE  ST300MP0065      K001  /dev/sda                                                            
                                                                                                                          
 % dmesg | grep '3:0:1:0'                                                                                                 
 scsi 3:0:1:0: Direct-Access     SEAGATE  ST300MP0065      K001 PQ: 0 ANSI: 6                                             
 scsi 3:0:1:0: SSP: handle(0x000a), sas_addr(0x5000c5007687000d), phy(4), device_name(0x5000c5007687000c)                 
 scsi 3:0:1:0: SSP: enclosure_logical_id(0x500605b006d3a670), slot(7)                                                     
 scsi 3:0:1:0: qdepth(254), tagged(1), simple(0), ordered(0), scsi_level(7), cmd_que(1)                                   
 sd 3:0:1:0: [sda] Spinning up disk...                                                                                    
 sd 3:0:1:0: Attached scsi generic sg6 type 0                                                                             
 sd 3:0:1:0: [sda] 73259046 4096-byte logical blocks: (300 GB/279 GiB)                                                    
 sd 3:0:1:0: [sda] Write Protect is off                                                                                   
 sd 3:0:1:0: [sda] Mode Sense: db 00 10 08                                                                                
 sd 3:0:1:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA                                        
 sd 3:0:1:0: [sda] 73259046 4096-byte logical blocks: (300 GB/279 GiB)                                                    
 sd 3:0:1:0: [sda] 73259046 4096-byte logical blocks: (300 GB/279 GiB)                                                    
 sd 3:0:1:0: [sda] Attached SCSI disk                                                                                     
                                                                                                                          
 % dd if=/dev/zero of=/dev/sda bs=1M count=100                                                              
 100+0 records in                                                                                                         
 100+0 records out                                                                                                        
 104857600 bytes (105 MB) copied, 0.688838 s, 152 MB/s                                                                    
 
 % parted /dev/sda --script -- mklabel gpt                                                                  
 % parted /dev/sda --script -- mkpart linux 0 -1                                                            
 Warning: The resulting partition is not properly aligned for best performance.                                           
 % parted /dev/sda --script -- print                                                                        
 Model: SEAGATE ST300MP0065 (scsi)                                                                                        
 Disk /dev/sda: 300GB                                                                                                     
 Sector size (logical/physical): 4096B/4096B                                                                              
 Partition Table: gpt                                                                                                     
 Disk Flags:                                                                                                              
                                                                                                                          
 Number  Start   End    Size   File system  Name   Flags                                                                  
  1      24.6kB  300GB  300GB               linux                                                                         
                                                                                                                          
 % wipefs -f -a /dev/sda                                                                                                  
 /dev/sda: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49 20 50 41 52 54                                        
 /dev/sda: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49 20 50 41 52 54                                        
 /dev/sda: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49 20 50 41 52 54                                        
 /dev/sda: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49 20 50 41 52 54                                        
 /dev/sda: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49 20 50 41 52 54
 ... endless loop ...

The problem seemed to arise out of libblkid's probe_gpt_pt routine, where 
it calls blkid_probe_set_magic with the "lba << 9".  That was fine for the 
512 disk, but not the 4k disk -- wipefs would later clear the magic data @
byte 512 (not 4096) and then rescan and find the magic again, looping 
endlessly.

See the patch below which moved us past this bug for 4k sector
size disks.  I *think* it's the right approach, but I wasn't sure if
further refactoring of code south of the blkid_partitions_need_typeonly 
check would be necessary.  It's not called by wipefs (or blkid for 
that matter), so I wasn't sure how to test it.

Regards,

-- Joe

-->8-- -->8--  -->8-- -->8--  -->8-- -->8--  -->8-- -->8-- 

>From 0216cbd3ae407a1ca2dc50a32542c81181998fb4 Mon Sep 17 00:00:00 2001
From: Joe Lawrence <joe.lawrence@stratus.com>
Date: Wed, 23 Jul 2014 16:39:26 -0400
Subject: [PATCH] libblkid: use sector size for GPT magic offset

probe_gpt_pt should consider the sector size when setting the offset of
the GPT magic, for it may be 512 or 4k.

Signed-off-by: Joe Lawrence <joe.lawrence@stratus.com>
---
 libblkid/src/partitions/gpt.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/libblkid/src/partitions/gpt.c b/libblkid/src/partitions/gpt.c
index 7fccd51..0c4ce31 100644
--- a/libblkid/src/partitions/gpt.c
+++ b/libblkid/src/partitions/gpt.c
@@ -303,7 +303,7 @@ static int probe_gpt_pt(blkid_probe pr,
 	blkid_parttable tab = NULL;
 	blkid_partlist ls;
 	uint64_t fu, lu;
-	uint32_t ssf, i;
+	uint32_t ssz, ssf, i;
 	efi_guid_t guid;
 	int ret;
 
@@ -329,7 +329,9 @@ static int probe_gpt_pt(blkid_probe pr,
 
 	blkid_probe_use_wiper(pr, lba * blkid_probe_get_size(pr), 8);
 
-	if (blkid_probe_set_magic(pr, lba << 9,
+	ssz = blkid_probe_get_sectorsize(pr);
+
+	if (blkid_probe_set_magic(pr, ssz * lba,
 			      sizeof(GPT_HEADER_SIGNATURE_STR) - 1,
 			      (unsigned char *) GPT_HEADER_SIGNATURE_STR))
 		goto err;
@@ -348,13 +350,13 @@ static int probe_gpt_pt(blkid_probe pr,
 	if (!ls)
 		goto nothing;
 
-	tab = blkid_partlist_new_parttable(ls, "gpt", lba << 9);
+	tab = blkid_partlist_new_parttable(ls, "gpt", ssz * lba);
 	if (!tab)
 		goto err;
 
 	blkid_parttable_set_uuid(tab, (const unsigned char *) &guid);
 
-	ssf = blkid_probe_get_sectorsize(pr) / 512;
+	ssf = ssz / 512;
 
 	fu = le64_to_cpu(h->first_usable_lba);
 	lu = le64_to_cpu(h->last_usable_lba);
-- 
1.7.10.4

