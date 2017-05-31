Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:55395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751034AbdEaSuW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 May 2017 14:50:22 -0400
Subject: [PATCH 1/4] docs: update v2.30-ReleaseNotes
To: Karel Zak <kzak@redhat.com>
References: <584f9692-26d2-0385-ccf0-7805403cddb6@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <1f8cc788-734c-c272-cb6a-0d55931f0df5@gmx.com>
Date: Wed, 31 May 2017 14:50:06 -0400
MIME-Version: 1.0
In-Reply-To: <584f9692-26d2-0385-ccf0-7805403cddb6@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Documentation/releases/v2.30-ReleaseNotes | 38 ++++++++++++++++---------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/Documentation/releases/v2.30-ReleaseNotes b/Documentation/releases/v2.30-ReleaseNotes
index 3702178..f9a45a1 100644
--- a/Documentation/releases/v2.30-ReleaseNotes
+++ b/Documentation/releases/v2.30-ReleaseNotes
@@ -1,39 +1,41 @@
-Util-linux 2.30 Release Notes 
-============================= 
+Util-linux 2.30 Release Notes
+=============================
 
-The libblkid library has been fixed to extract LABEL= and UUID= from UDF
-rather than from ISO9660 header on hybrid CDROM/DVD media. This changes
-makes UDF media on Linux user-space more compatible with another operation
-systems. Unfortunately, this change may introduce regression for (unusual)
-hybrid CDROM/DVDs where ISO and UDF use a different LABEL=.
+The libblkid library has been improved for hybrid CDROM/DVD media by extracting
+the LABEL and UUID values from the UDF header, rather than the ISO9660 header.
+This change makes hybrid CDROM/DVD media created on other operating systems more
+compatible in Linux user-space. Unfortunately, this change may introduce a
+regression for (unusual) hybrid CDROM/DVDs where the ISO and UDF headers use a
+different LABEL.
 
 The deprecated command tailf has been removed. Use "tail -f" from coreutils.
 
-blkzone -- NEW COMMAND to run zone commands on block device that support Zoned
+blkzone -- NEW COMMAND to run zone commands on block devices that support Zoned
 Block Commands (ZBC) or Zoned-device ATA Commands (ZAC). The currently
 supported functionality is 'report' and 'reset'.
 [thanks to Shaun Tancheff (Seagate), Damien Le Moal (WD)]
 
-fincore -- NEW COMMAND to count pages of file contents in core (memory). 
+fincore -- NEW COMMAND to count pages of file contents in core (memory).
 [thanks to Masatake YAMATO (Red Hat)]
 
 lsmem -- NEW COMMAND to list the ranges of available memory with their online
-status (originally implemented in Perl for s390-tools). [thanks to Clemens von Mann 
+status (originally implemented in Perl for s390-tools). [thanks to Clemens von Mann
 and Heiko Carstens (IBM)]
 
 chmem -- NEW COMMAND to set memory online/offline status [thanks to Heiko
 Carstens (IBM)]
 
-The old and dead Alpha and Cmos code has been removed from hwclock command.
+Removed Alpha and dead code from hwclock's --directisa option.
 
-The command fallocate supports "insert range" operation now.
+The command fallocate supports an "insert range" operation now.
 
-The command "column -t|--table" has been modified to use libsmartcols. Now it
-provides almost all functionality of the library on command line, for example
-print header for table, reorder columns, align columns to the right, print
-tree-like output, wrap lines in cells, truncate text in cells, etc.
+The command "column -t|--table" has been modified to use libsmartcols. It now
+provides nearly all of that library's functionality from the command line. For
+example: printing a table header, reordering columns, aligning columns
+to the right, printing tree-like output, wrapping lines in cells, truncating
+text in cells, etc.
 
-The libmount library provides API to generate exit codes and error/warning
+The libmount library now provides an API to generate exit codes and error/warning
 messages compatible with mount(8).
 
 
@@ -48,7 +50,7 @@ CVE-2016-2779 - This security issue is NOT FIXED yet.  It is possible to
   disable the ioctl TIOCSTI by setsid() only.  Unfortunately, setsid()
   has well-defined use cases in su(1) and runuser(1) and any changes
   would introduce regressions.  It seems we need a better way -- ideally
-  another ioctl to disable TIOCSTI without setsid() or in userspace
+  another ioctl to disable TIOCSTI without setsid() or in a userspace
   implemented pty container (planned as experimental su(1) feature).
 
 
