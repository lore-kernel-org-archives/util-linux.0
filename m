Return-Path: util-linux-owner@vger.kernel.org
Received: from nagini.codelibre.net ([80.68.93.164]:54245 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab1LPXPk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 16 Dec 2011 18:15:40 -0500
Date: Fri, 16 Dec 2011 23:15:38 +0000
From: Roger Leigh <rleigh@codelibre.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] Add mount option for initramfs
Message-ID: <20111216231538.GR17458@codelibre.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fd5uyaI9j6xoeUBo"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--fd5uyaI9j6xoeUBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've attached a trivial patch for an "initramfs" mount option.  The
purpose of this patch is that selected mounts in /etc/fstab can be
identified for mounting in the generated initramfs.  This will
permit e.g. mounting of a separate /etc and /usr and any other
admin-configured filesystems prior to init starting.

Uses: encrypted /etc and unencrypted / and /usr
      separate /usr mounted with rootfs
      - this means libraries and binaries on /usr are available
        from the initramfs onward, solving a whole host of
        problems with e.g. nss and pam modules having dependent
        libs in /usr, etc., which aren't available during boot.

Feel free to change the name to something more generic; this is
intended for use with Debian's initramfs-tools initramfs
generator, but may have potential for cross-distribution use.


Regards,
Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.

--fd5uyaI9j6xoeUBo
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-mount-Allow-initramfs-dummy-mount-option.patch"

>From e588ddb89eb3d8b63291dd7cdad5c134fd221a2d Mon Sep 17 00:00:00 2001
From: Roger Leigh <rleigh@debian.org>
Date: Fri, 16 Dec 2011 23:07:35 +0000
Subject: [PATCH] mount: Allow initramfs dummy mount option

---
 mount/mount.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/mount/mount.c b/mount/mount.c
index 9b444c4..05e82fa 100644
--- a/mount/mount.c
+++ b/mount/mount.c
@@ -202,6 +202,7 @@ static const struct opt_map opt_map[] = {
   { "nostrictatime", 0, 1, MS_STRICTATIME }, /* kernel default atime */
 #endif
   { "nofail",	0, 0, MS_COMMENT},	/* Do not fail if ENOENT on dev */
+  { "initramfs", 0, 0, MS_COMMENT},     /* Mount filesystem in initramfs */
   { NULL,	0, 0, 0		}
 };
 
-- 
1.7.7.3


--fd5uyaI9j6xoeUBo--
