Return-Path: util-linux-owner@vger.kernel.org
Received: from nagini.codelibre.net ([80.68.93.164]:37343 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1LQKPD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Dec 2011 05:15:03 -0500
Date: Sat, 17 Dec 2011 10:15:00 +0000
From: Roger Leigh <rleigh@codelibre.net>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] Add man page entry for initramfs
Message-ID: <20111217101500.GS17458@codelibre.net>
References: <20111216231538.GR17458@codelibre.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="K1SnTjlYS/YgcDEx"
In-Reply-To: <20111216231538.GR17458@codelibre.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--K1SnTjlYS/YgcDEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 16, 2011 at 11:15:38PM +0000, Roger Leigh wrote:
> Hi,
> 
> I've attached a trivial patch for an "initramfs" mount option.  The
> purpose of this patch is that selected mounts in /etc/fstab can be
> identified for mounting in the generated initramfs.  This will
> permit e.g. mounting of a separate /etc and /usr and any other
> admin-configured filesystems prior to init starting.

The following patch documents this in the mount(8) manpage.


Regards,
Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.

--K1SnTjlYS/YgcDEx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-mount.8-Document-initramfs-mount-option.patch"

>From 6ea3cf1bdc58d2c1e0124967268d1d1e82c838a4 Mon Sep 17 00:00:00 2001
From: Roger Leigh <rleigh@debian.org>
Date: Sat, 17 Dec 2011 10:11:49 +0000
Subject: [PATCH 2/2] mount.8: Document initramfs mount option

---
 mount/mount.8 |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/mount/mount.8 b/mount/mount.8
index fc352b5..f7be9d3 100644
--- a/mount/mount.8
+++ b/mount/mount.8
@@ -917,6 +917,16 @@ This option implies the options
 (unless overridden by subsequent options, as in the option line
 .BR group,dev,suid ).
 .TP
+.B initramfs
+The filesystem will be mounted by initial initramfs, before the root
+filesystem becomes available.  This permits separation of files
+required for boot onto separate filesystems, such as those in /etc and
+/usr.  This additionally permits selected encryption of files in /etc,
+for example, while leaving the remainder of the files in / and /usr
+unencrypted for performance.  Note that filesystems marked using this
+option may require the running of a tool to update the initramfs
+following any changes.
+.TP
 .B iversion
 Every time the inode is modified, the i_version field will be incremented.
 .TP
-- 
1.7.7.3


--K1SnTjlYS/YgcDEx--
