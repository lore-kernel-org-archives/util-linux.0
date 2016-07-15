Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48682 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbcGOIjW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jul 2016 04:39:22 -0400
Date: Fri, 15 Jul 2016 10:39:20 +0200
From: Karel Zak <kzak@redhat.com>
To: "Veeraiyan Chidambaram (RBEI/ECF32)"
	<Veeraiyan.Chidambaram@in.bosch.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] liblkid: fix probe_nilfs2 I/O error backup
Message-ID: <20160715083920.6wuhdp6ubllywltp@ws.net.home>
References: <fc61fac781e54ced943435e9902b2a42@SGPMBX1019.APAC.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fc61fac781e54ced943435e9902b2a42@SGPMBX1019.APAC.bosch.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 11, 2016 at 07:40:59AM +0000, Veeraiyan Chidambaram (RBEI/ECF32) wrote:
> Hello  All,
> 
> In our system recently updated libblkid-2.24 to libblkid-2.26.
> After updating  of libblkid, blkid -p -u noraid /dev/sr0  stopped 
> working for my Mixed mode CD (audio + data) and doesnt give any output.
> 
> libblkid run's probe function to find      
> When I  investigated further found probe of nilfs file system is failing with I/O error
> (before nilfs file system probe iso9660 probe was successful) .
> 
> The nilfs probe function does the following
> 1. reads for primary partition 
> 2. read backup partition
> 3. checks the nilfs related validity checks
>    if validate fails returns 1 meaning CD file system is 
>    not an nilfs file system.
> 4. if validation is successful then copy the necessary information and 
>    return 0 meaning CD is nilfs file system.
> 
> In my case
> 1. Read of primary portion is successful.
> 2. Read Backup partition is falls with I/O error.
> 3. retuns errno -5 

Would be enough to ignore the backup block errors if the primary block
is valid?

> I would like to propose the following fix 
> 
> 
> In nilfs file system probe
> 1. read primary partition 
> 2. validate the primary partition if fails return 1 i.e no file system found for nilfs file system in the CD.
> 3. if backup partition if validate.
> 4. then validate backup partition and then copy the necessary information and 
>    return 0 meaning CD is nilfs file system.

Your patch completely ignores backup block if the primary is not
valid. I think it's not expected behavior.

Please, try the patch below.

    Karel


diff --git a/libblkid/src/superblocks/nilfs.c b/libblkid/src/superblocks/nilfs.c
index cd93d7b..ab0f74c 100644
--- a/libblkid/src/superblocks/nilfs.c
+++ b/libblkid/src/superblocks/nilfs.c
@@ -109,18 +109,29 @@ static int probe_nilfs2(blkid_probe pr,
 	if (!sbp)
 		return errno ? -errno : 1;
 
+	valid[0] = nilfs_valid_sb(pr, sbp, 0);
+
+
 	/* backup */
 	sbb = (struct nilfs_super_block *) blkid_probe_get_buffer(
 			pr, NILFS_SBB_OFFSET(pr->size), sizeof(struct nilfs_super_block));
-	if (!sbb)
-		return errno ? -errno : 1;
+	if (!sbb) {
+		valid[1] = 0;
+
+		/* If the primary block is valid then continue and ignore also
+		 * I/O errors for backup block. Note the this is probably CD
+		 * where I/O errors and the end of the disk/session are "normal".
+		 */
+		if (!valid[0])
+			return errno ? -errno : 1;
+	} else
+		valid[1] = nilfs_valid_sb(pr, sbb, 1);
+
 
 	/*
 	 * Compare two super blocks and set 1 in swp if the secondary
 	 * super block is valid and newer.  Otherwise, set 0 in swp.
 	 */
-	valid[0] = nilfs_valid_sb(pr, sbp, 0);
-	valid[1] = nilfs_valid_sb(pr, sbb, 1);
 	if (!valid[0] && !valid[1])
 		return 1;
 
