Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:59700 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761552AbbA1UoE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 28 Jan 2015 15:44:04 -0500
From: Jan Kara <jack@suse.cz>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH] mount: Further FAT mount option update
Date: Wed, 28 Jan 2015 10:50:53 +0100
Message-Id: <1422438653-26499-1-git-send-email-jack@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add some mount options mentioned in Documentation/filesystems/vfat.txt.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 sys-utils/mount.8 | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index bfa82a0d7635..fac4b0c9b517 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1989,7 +1989,16 @@ If set, causes discard/TRIM commands to be issued to the block device
 when blocks are freed.  This is useful for SSD devices and
 sparse/thinly-provisioned LUNs.
 .TP
-.BR fat= {12 | 16 | 32 }
+.B dos1xfloppy
+If set, use a fallback default BIOS Parameter Block configuration, determined
+by backing device size. These static parameters match defaults assumed by DOS
+1.x for 160 kiB, 180 kiB, 320 kiB, and 360 kiB floppies and floppy images.
+.TP
+.BR errors= { panic | continue | remount-ro }
+Specify FAT behavior on critical errors: panic, continue without doing
+anything, or remount the partition in read-only mode (default behavior).
+.TP
+.BR fat= { 12 | 16 | 32 }
 Specify a 12, 16 or 32 bit fat.  This overrides
 the automatic FAT type detection routine.  Use with caution!
 .TP
@@ -1998,10 +2007,32 @@ Character set to use for converting between 8 bit characters
 and 16 bit Unicode characters.  The default is iso8859-1.
 Long filenames are stored on disk in Unicode format.
 .TP
-.B nfs
-If set, enables in-memory indexing of directory inodes to reduce the
-frequency of ESTALE errors in NFS client operations.  Useful only when
-the filesystem is exported via NFS.
+.BR nfs= { stale_rw | nostale_ro }
+Enable this only if you want to export the FAT filesystem over NFS.
+
+.BR stale_rw :
+This option maintains an index (cache) of directory inodes which is used by the
+nfs-related code to improve look-ups. Full file operations (read/write) over
+NFS are supported but with cache eviction at NFS server, this could result in
+spurious
+.B ESTALE
+errors.
+
+.BR nostale_ro :
+This option bases the inode number and filehandle
+on the on-disk location of a file in the FAT directory entry.
+This ensures that
+.B ESTALE
+will not be returned after a file is
+evicted from the inode cache. However, it means that operations
+such as rename, create and unlink could cause filehandles that
+previously pointed at one file to point at a different file,
+potentially causing data corruption. For this reason, this
+option also mounts the filesystem readonly.
+
+To maintain backward compatibility, '-o nfs' is also accepted,
+defaulting to
+.BR stale_rw .
 .TP
 .BI tz=UTC
 This option disables the conversion of timestamps
@@ -2029,6 +2060,14 @@ Turn on the
 flag.  Attempts to chown or chmod files do not return errors,
 although they fail.  Use with caution!
 .TP
+.B rodir
+FAT has the ATTR_RO (read-only) attribute. On Windows, the ATTR_RO of the
+directory will just be ignored, and is used only by applications as a flag
+(e.g. it's set for the customized folder).
+
+If you want to use ATTR_RO as read-only flag even for the directory, set this
+option.
+.TP
 .B showexec
 If set, the execute permission bits of the file will be allowed only if
 the extension part of the name is \&.EXE, \&.COM, or \&.BAT.  Not set by default.
-- 
2.1.2

