Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 4/5] lspcu: minor manpage improvement
Date: Fri, 29 Jul 2016 14:13:35 +0200
In-Reply-To: <1469794416-97361-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1469794416-97361-1-git-send-email-heiko.carstens@de.ibm.com>
Message-Id: <1469794416-97361-5-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Always use the word "can" instead of "may" to be consistent with the
descriptions of the other columns.

Also print "lspcu" always with bold characters like everywhere else in
the man page.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 72065d611630..55480aad983f 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -54,7 +54,7 @@ The logical book number.  A book can contain several sockets.
 The logical drawer number.  A drawer can contain several books.
 .TP
 .B NODE
-The logical NUMA node number.  A node may contain several drawers.
+The logical NUMA node number.  A node can contain several drawers.
 .TP
 .B CACHE
 Information about how caches are shared between CPUs.
@@ -90,7 +90,7 @@ and hypervisor support CPU polarization.
 .RE
 .TP
 .B MAXMHZ
-Maximum megahertz value for the CPU.  Useful when lscpu is used as hardware
+Maximum megahertz value for the CPU. Useful when \fBlscpu\fP is used as hardware
 inventory information gathering tool.  Notice that the megahertz value is
 dynamic, and driven by CPU governor depending on current resource need.
 .TP
-- 
2.6.6
