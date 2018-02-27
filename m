Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0b-00272701.pphosted.com ([208.86.201.61]:45124 "EHLO
        mx0b-00272701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751539AbeB0TAh (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Feb 2018 14:00:37 -0500
Received: from pps.filterd (m0107986.ppops.net [127.0.0.1])
        by mx0b-00272701.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1RIg1VC027365
        for <util-linux@vger.kernel.org>; Tue, 27 Feb 2018 12:44:30 -0600
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp0022.outbound.protection.outlook.com [216.32.181.22])
        by mx0b-00272701.pphosted.com with ESMTP id 2gd71p1rr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Tue, 27 Feb 2018 12:44:22 -0600
From: Steve Kenton <skenton@ou.edu>
To: util-linux@vger.kernel.org
Cc: Steve Kenton <skenton@ou.edu>
Subject: [PATCH 1/1] Update mount options for UDF
Date: Tue, 27 Feb 2018 12:44:07 -0600
Message-Id: <20180227184407.5945-1-skenton@ou.edu>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Steve Kenton <skenton@ou.edu>
Acked-by: Jan Kara <jack@suse.cz>
---
 sys-utils/mount.8 | 89 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 22 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index c040730a2..2f9890aae 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2034,20 +2034,51 @@ still possible to read compressed files if mounted with the
 option.
 
 .SS "Mount options for udf"
-udf is the "Universal Disk Format" filesystem defined by the Optical
-Storage Technology Association, and is often used for DVD-ROM.
+UDF is the "Universal Disk Format" filesystem defined by OSTA, the Optical
+Storage Technology Association, and is often used for DVD-ROM, frequently
+in the form of a hybrid UDF/ISO-9660 filesystem. It is, however,
+perfectly usable by itself on disk drives, flash drives and other block devices.
 See also
 .IR iso9660 .
 .TP
+.B uid=
+Make all files in the filesystem belong to the given user.
+uid=forget can be specified independently of (or usually in
+addition to) uid=<user> and results in UDF
+not storing uids to the media. In fact the recorded uid
+is the 32-bit overflow uid -1 as defined by the UDF standard.
+The value is given as either <user> which is a valid user name or the corresponding
+decimal user id, or the special string "forget".
+.TP
 .B gid=
-Set the default group.
+Make all files in the filesystem belong to the given group.
+gid=forget can be specified independently of (or usually in
+addition to) gid=<group> and results in UDF
+not storing gids to the media. In fact the recorded gid
+is the 32-bit overflow gid -1 as defined by the UDF standard.
+The value is given as either <group> which is a valid group name or the corresponding
+decimal group id, or the special string "forget".
 .TP
 .B umask=
-Set the default umask.
+Mask out the given permissions from all inodes read from the filesystem.
 The value is given in octal.
 .TP
-.B uid=
-Set the default user.
+.B mode=
+If mode= is set the permissions of all non-directory inodes read from the
+filesystem will be set to the given mode. The value is given in octal.
+.TP
+.B dmode=
+If dmode= is set the permissions of all directory inodes read from the
+filesystem will be set to the given dmode. The value is given in octal.
+.TP
+.B bs=
+Set the block size. Default value prior to kernel version 2.6.30 was
+2048. Since 2.6.30 and prior to 4.11 it was logical device block size with
+fallback to 2048. Since 4.11 it is logical block size with fallback to
+any valid block size between logical device block size and 4096.
+
+For other details see the updated mkudffs.8 manpage, section
+COMPATIBILITY and BLOCK SIZE.
 .TP
 .B unhide
 Show otherwise hidden files.
@@ -2055,41 +2086,55 @@ Show otherwise hidden files.
 .B undelete
 Show deleted files in lists.
 .TP
+.B adinicb
+Embed data in the inode. (default)
+.TP
+.B noadinicb
+Don't embed data in the inode.
+.TP
+.B shortad
+Use short UDF address descriptors.
+.TP
+.B longad
+Use long UDF address descriptors. (default)
+.TP
 .B nostrict
 Unset strict conformance.
-.\" .TP
-.\" .B utf8
-.\" (unused).
 .TP
 .B iocharset
 Set the NLS character set.
-.TP
-.B bs=
-Set the block size. (May not work unless 2048.)
+.SS Mount options for debugging and disaster recovery
 .TP
 .B novrs
-Skip volume sequence recognition.
+Ignore the Volume Recognition Sequence and attempt to mount anyway.
 .TP
 .B session=
-Set the CDROM session counting from 0.  Default: last session.
+Select the session number for multi-session recorded optical media. (default= last session)
 .TP
 .B anchor=
-Override standard anchor location.  Default: 256.
+Override standard anchor location. (default= 256)
+.TP
+.B lastblock=
+Set the last block of the filesystem.
+.SS Unused historical mount options that may be encountered and should be removed
+.TP
+.B uid=ignore
+use uid=<user> instead.
+.TP
+.B gid=ignore
+use gid=<group> instead.
 .TP
 .B volume=
-Override the VolumeDesc location. (unused)
+Override the VolumeDesc location.
 .TP
 .B partition=
-Override the PartitionDesc location. (unused)
-.TP
-.B lastblock=
-Set the last block of the filesystem.
+Override the PartitionDesc location.
 .TP
 .B fileset=
-Override the fileset block location. (unused)
+Override the fileset block location.
 .TP
 .B rootdir=
-Override the root directory location. (unused)
+Override the root directory location.
 
 .SS "Mount options for ufs"
 .TP
-- 
2.16.1.72.g5be1f00

