Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33234 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbbFUMdb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 21 Jun 2015 08:33:31 -0400
Received: by wgwi7 with SMTP id i7so1480019wgw.0
        for <util-linux@vger.kernel.org>; Sun, 21 Jun 2015 05:33:30 -0700 (PDT)
Date: Sun, 21 Jun 2015 13:33:21 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Joshua Hudson <joshudson@gmail.com>
cc: util-linux@vger.kernel.org
Subject: Re: mkfs.minix misbehaves on 4GB filesystems
In-Reply-To: <CA+jjjYT6T0A=bY5=Kbga+WhR0FZse1LdHLmDCxFqhRspvS-gdw@mail.gmail.com>
Message-ID: <alpine.LNX.2.03.1506211326540.3757@iki.fi>
References: <CA+jjjYT6T0A=bY5=Kbga+WhR0FZse1LdHLmDCxFqhRspvS-gdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, 20 Jun 2015, Joshua Hudson wrote:
> Note that 1) I'm not on the mailing list and 2) I'm on vacation for a 
> week. Consider patch signed off. Have fun.

Hi Joshua,

I reviewed your change, and changed couple magic numbers to be used from 
MINIX_MAX_INODES definition plus tidied up tiny coding style issues. The 
change is also available from my github branch minix.

https://github.com/kerolasa/lelux-utiliteetit/commit/9d170c877ec8c821e9c99ef4f7e37209d2d8c98c

--->8----
>From 9d170c877ec8c821e9c99ef4f7e37209d2d8c98c Mon Sep 17 00:00:00 2001
From: Joshua Hudson <joshudson@gmail.com>
Date: Sat, 20 Jun 2015 20:44:14 -0700
Subject: [PATCH] mkfs.minix: increase maximum minix v2 and v3 file system
 sizes

mkfs.minix misbehaves when attempting to create a large v2 or v3
filesystem.  I finally traced it down to attempting to create too many
inodes so that the first zone is past 65535 blocks in.  This obviously
doesn't work as the on-disk superblock says this is a 16 bit integer.

I wrote a patch that catches this, clamps to the absolute v2/v3 limit
(like it already does for v1), and sets the blocks per inode to a more
reasonable ratio when exceeding half a gigabyte.  Having a half-gig
filesystem with most files being smaller than 3k isn't really reasonable.

I suppose if you don't want to adjust inode sizes automatically you could
take that part out, and it will just crab sooner.

Given the non-attention in the code, I suspect nobody ever had cause to
try such a big minix filesystem.  Well I have my reasons involving some
deeply embedded work where ext2 would place too much strain on the
hardware.

Reviewed-by: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Joshua Hudson <joshudson@gmail.com>
---
 disk-utils/mkfs.minix.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index c84aed2..564f2b4 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -49,6 +49,9 @@
  * 06.29.11  -  Overall cleanups for util-linux and v3 support
  *              Davidlohr Bueso <dave@gnu.org>
  *
+ * 06.20.15  -  Do not infinite loop or crash on large devices
+ *              Joshua Hudson <joshudson@gmail.com>
+ *
  * Usage:  mkfs [-c | -l filename ] [-12v3] [-nXX] [-iXX] device [size-in-blocks]
  *
  *	-c for readablility checking (SLOW!)
@@ -504,9 +507,16 @@ static void setup_tables(void) {
 	super_set_nzones();
 	zones = get_nzones();
 
-	/* some magic nrs: 1 inode / 3 blocks */
-	if ( req_nr_inodes == 0 ) 
-		inodes = BLOCKS/3;
+	/* some magic nrs: 1 inode / 3 blocks for smaller filesystems,
+	 * for one inode / 16 blocks for large ones. mkfs will eventually
+	 * crab about too far when getting close to the maximum size. */
+	if (req_nr_inodes == 0)
+		if (2048 * 1024 < BLOCKS)	/* 2GB */
+			inodes = BLOCKS / 16;
+		else if (512 * 1024 < BLOCKS)	/* 0.5GB */
+			inodes = BLOCKS / 8;
+		else
+			inodes = BLOCKS / 3;
 	else
 		inodes = req_nr_inodes;
 	/* Round up inode count to fill block size */
@@ -524,8 +534,13 @@ static void setup_tables(void) {
 		if (inodes > MINIX_MAX_INODES)
 			inodes = MINIX_MAX_INODES;
 	}
-
 	super_set_map_blocks(inodes);
+	if (MINIX_MAX_INODES < first_zone_data())
+		errx(MKFS_EX_ERROR,
+		     _("First data block at %jd, which is too far (max %d).\n"
+		       "Try specifying fewer inodes by passing -i <inodes>"),
+		     first_zone_data(),
+		     MINIX_MAX_INODES);
 	imaps = get_nimaps();
 	zmaps = get_nzmaps();
 
@@ -793,6 +808,8 @@ int main(int argc, char ** argv) {
 	} else /* fs_version == 1 */
 		if (BLOCKS > MINIX_MAX_INODES)
 			BLOCKS = MINIX_MAX_INODES;
+	if (BLOCKS > MINIX_MAX_INODES * BITS_PER_BLOCK)
+		BLOCKS = MINIX_MAX_INODES * BITS_PER_BLOCK;	/* Utter maximum: Clip. */
 	setup_tables();
 	if (check)
 		check_blocks();
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
