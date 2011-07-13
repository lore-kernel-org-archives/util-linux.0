Return-Path: util-linux-owner@vger.kernel.org
Received: from imovil.entelpcs.cl ([200.72.211.69]:52256 "EHLO
	localhost6.localdomain6" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750706Ab1GMEUw convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Jul 2011 00:20:52 -0400
Subject: Re: [PATCH] minix: v3 super-block does not have s_state field
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
In-Reply-To: <1310485846-3685-1-git-send-email-kerolasa@iki.fi>
References: <1310485846-3685-1-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Jul 2011 00:05:31 -0400
Message-ID: <1310529931.4444.7.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2011-07-12 at 17:50 +0200, Sami Kerola wrote:
> Originally attempt was to use minix definitions and file system
> structures from linux/minix_fs.h, but that failed at first try.
> 
> mkfs.minix.c:164:10: error: no member named 's_state' in 'struct
>       minix3_super_block'
>                 Super3.s_state |= MINIX_VALID_FS;
>                 ~~~~~~ ^
> mkfs.minix.c:165:10: error: no member named 's_state' in 'struct
>       minix3_super_block'
>                 Super3.s_state &= ~MINIX_ERROR_FS;
> 
> Primary reason seems to be that the minix3 super-block does not
> have s_state field. And it looks to me that it has never had it.
> Further details about s_state can be found from minix v3 file
> system support kernel patch.

Yes, you are right. It was dropped during time for v3, but previous
versions still use it.

> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=939b00df0306bc4b5cd25c3c3c78e89b91e72fc8
> 
> Former minix disk s_state is now in kernel memory super-block
> info structure as a s_mount_state field, if someone wonders what
> happen to it.

I don't think we should always rely on having the kernel headers, that's
why the fallback is provided.

> 
> Issue appeared commit a2657ae3ffb56616ac9c921886bcca8ef242499f
> (13 days ago), and hopefully not too many users where affected as
> I am not sure how bad it is to have mismatch in super-block
> structure.

It can be quite bad depending on the mismatch, in this case the kernel
skips the s_state when using v3.

I think with this patch we address the issue without removing our
fallback.

From: Davidlohr Bueso <dave@gnu.org>
Date: Tue, 12 Jul 2011 23:55:14 -0400
Subject: [PATCH] minix: remove fs state

For v3 minix superblocks the state flag (s_state) has been removed, so drop it from the structure in accordance with the kernel's representation.

Reported-by: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/minix.h      |    1 -
 disk-utils/mkfs.minix.c |    7 ++-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/disk-utils/minix.h b/disk-utils/minix.h
index fc1d1c0..a13a2a4 100644
--- a/disk-utils/minix.h
+++ b/disk-utils/minix.h
@@ -62,7 +62,6 @@ struct minix3_super_block {
 	u16 s_pad2;
 	u16 s_blocksize;
 	u8  s_disk_version;
-        u16 s_state;
 };
 
 #define BLOCK_SIZE_BITS 10
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 916dd17..06d087e 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -160,11 +160,8 @@ static void check_mount(void) {
 static void super_set_state(void)
 {
 	switch (fs_version) {
-	case 3:
-		Super3.s_state |= MINIX_VALID_FS;
-		Super3.s_state &= ~MINIX_ERROR_FS;
-		break;
-	default:
+	case 1:
+	case 2:
 		Super.s_state |= MINIX_VALID_FS;
 		Super.s_state &= ~MINIX_ERROR_FS;
 		break;
-- 
1.7.4.1


