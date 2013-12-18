Return-Path: util-linux-owner@vger.kernel.org
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:40339 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558Ab3LRWNz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 18 Dec 2013 17:13:55 -0500
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com
Subject: [PATCH] man: Syntax and spelling fixes.
Date: Thu, 19 Dec 2013 00:13:48 +0200
Message-Id: <1387404828-29648-1-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 login-utils/nologin.8 | 2 +-
 sys-utils/lscpu.1     | 2 +-
 sys-utils/mount.8     | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/login-utils/nologin.8 b/login-utils/nologin.8
index b7fe1d9..1cbaa33 100644
--- a/login-utils/nologin.8
+++ b/login-utils/nologin.8
@@ -33,7 +33,7 @@ access is always refused independently on the file.
 .BR pam_nologin (8)
 PAM module usually prevents all non-root users from logging into the system.
 .BR pam_nologin (8)
-functionality is controled by /var/run/nologin or /etc/nologin file. 
+functionality is controlled by /var/run/nologin or /etc/nologin file. 
 .SH AUTHORS
 .UR kzak@redhat.com
 Karel Zak
diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index bf81a44..5e838fb 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -82,7 +82,7 @@ and hypervisor support CPU polarization.
 .TP
 .B MMHZ
 Maximum megaherz value for the cpu.  Useful when lscpu is used as hardware
-inventory infomation gathering tool.  Notice that the megahertz value is
+inventory information gathering tool.  Notice that the megahertz value is
 dynamic, and driven by CPU governor depending on current resource need.
 .RE
 .SH OPTIONS
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 1810d0b..364b515 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2673,7 +2673,7 @@ Make the data allocator use the filestreams allocation mode
 across the entire filesystem rather than just on directories
 configured to use it.
 .TP
-.BP ikeep | noikeep
+.BR ikeep | noikeep
 When ikeep is specified, XFS does not delete empty inode
 clusters and keeps them around on disk.  When noikeep is
 specified, empty inode clusters are returned to the free
@@ -2719,7 +2719,7 @@ The default value is 8 buffers.
 If the memory cost of 8 log buffers is too high on small
 systems, then it may be reduced at some cost to performance
 on metadata intensive workloads. The logbsize option below
-controls the size of each buffer and so is also relevent to
+controls the size of each buffer and so is also relevant to
 this case.
 .TP
 .BR logbsize=value
-- 
1.8.3.1

