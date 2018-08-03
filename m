Return-Path: util-linux-owner@vger.kernel.org
Received: from outpost.hi.is ([130.208.165.166]:36842 "EHLO outpost.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729985AbeHCXSX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 3 Aug 2018 19:18:23 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by outpost.hi.is (8.14.7/8.14.7) with ESMTP id w73LC6ZJ027055
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <util-linux@vger.kernel.org>; Fri, 3 Aug 2018 21:12:06 GMT
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id w73LC4cM026488
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Fri, 3 Aug 2018 21:12:04 GMT
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id w73LC492030976
        for <util-linux@vger.kernel.org>; Fri, 3 Aug 2018 21:12:04 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id w73LC40n030975
        for util-linux@vger.kernel.org; Fri, 3 Aug 2018 21:12:04 GMT
Date: Fri, 3 Aug 2018 21:12:04 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] man pages: Remove "left" (or change to "l") in the column
 formats of tables
Message-ID: <20180803211203.GA30947@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  A developmental version of "groff" issued a warning, for example with
"test-groff -b -e -mandoc -T utf8 -rF0 -t -w w -z":

troff: <logger.1>:299: warning: can't find font 't'

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 disk-utils/fsck.minix.8 | 2 +-
 login-utils/last.1      | 2 +-
 misc-utils/logger.1     | 4 ++--
 misc-utils/uuidparse.1  | 4 ++--
 sys-utils/blkzone.8     | 4 ++--
 sys-utils/rtcwake.8.in  | 2 +-
 text-utils/hexdump.1    | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/disk-utils/fsck.minix.8 b/disk-utils/fsck.minix.8
index 9660e4f12..f7abb9b37 100644
--- a/disk-utils/fsck.minix.8
+++ b/disk-utils/fsck.minix.8
@@ -21,7 +21,7 @@ The \fIdevice\fR name will usually have the following form:
 .RS
 .TS
 tab(:);
-left l l.
+l l.
 /dev/hda[1\(en63]:IDE disk 1
 /dev/hdb[1\(en63]:IDE disk 2
 /dev/sda[1\(en15]:SCSI disk 1
diff --git a/login-utils/last.1 b/login-utils/last.1
index 069f065ac..619be3f3d 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -153,7 +153,7 @@ The options that take the
 .I time
 argument understand the following formats:
 .TS
-left l2 l.
+l2 l.
 YYYYMMDDhhmmss
 YYYY-MM-DD hh:mm:ss
 YYYY-MM-DD hh:mm	(seconds will be set to 00)
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 9e83a0b53..bbadd3ddc 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -295,7 +295,7 @@ Valid facility names are:
 .IP
 .TS
 tab(:);
-left l l.
+l l.
 \fBauth
 \fBauthpriv\fR:for security information of a sensitive nature
 \fBcron
@@ -318,7 +318,7 @@ Valid level names are:
 .IP
 .TS
 tab(:);
-left l l.
+l l.
 \fBemerg
 \fBalert
 \fBcrit
diff --git a/misc-utils/uuidparse.1 b/misc-utils/uuidparse.1
index 9afa6b071..979926755 100644
--- a/misc-utils/uuidparse.1
+++ b/misc-utils/uuidparse.1
@@ -14,7 +14,7 @@ arguments or standard input.  The inputs are white-space separated.
 .SS Variants
 .TS
 tab(:);
-left l l.
+l l.
 NCS:Network Computing System identifier.  These were the original UUIDs.
 DCE:The Open Software Foundation's (OSF) Distributed Computing Environment UUIDs.
 Microsoft:Microsoft Windows platform globally unique identifier (GUID).
@@ -23,7 +23,7 @@ other:Unknown variant.  Usually invalid input data.
 .SS Types
 .TS
 tab(:);
-left l l.
+l l.
 nil:Special type for zero in type file.
 time-based:The DCE time based.
 DCE:The DCE time and MAC Address.
diff --git a/sys-utils/blkzone.8 b/sys-utils/blkzone.8
index 5d99f9461..bf7f15f58 100644
--- a/sys-utils/blkzone.8
+++ b/sys-utils/blkzone.8
@@ -26,7 +26,7 @@ starting zone or the size of the report, as explained below.
 .B Report output
 .TS
 tab(:);
-left l l.
+l l.
 start:Zone start sector
 len:Zone length in number of sectors
 wptr:Zone write pointer position
@@ -39,7 +39,7 @@ type:Zone type
 .B Zone conditions
 .TS
 tab(:);
-left l l.
+l l.
 cl:Closed
 nw:Not write pointer
 em:Empty
diff --git a/sys-utils/rtcwake.8.in b/sys-utils/rtcwake.8.in
index 52287d85b..9aaca6d79 100644
--- a/sys-utils/rtcwake.8.in
+++ b/sys-utils/rtcwake.8.in
@@ -69,7 +69,7 @@ Set the wakeup time to the value of the timestamp.  Format of the
 timestamp can be any of the following:
 .TS
 tab(|);
-left l2 l.
+l2 l.
 YYYYMMDDhhmmss
 YYYY-MM-DD hh:mm:ss
 YYYY-MM-DD hh:mm|(seconds will be set to 00)
diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index 23c32d70c..5651a6f41 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -242,7 +242,7 @@ displayed using the following, lower-case, names.  Characters greater than
 .RS 10
 .TS
 tab(|);
-left l l l l l.
+l l l l l l.
 000 nul|001 soh|002 stx|003 etx|004 eot|005 enq
 006 ack|007 bel|008 bs|009 ht|00A lf|00B vt
 00C ff|00D cr|00E so|00F si|010 dle|011 dc1
-- 
2.18.0


-- 
Bjarni I. Gislason
