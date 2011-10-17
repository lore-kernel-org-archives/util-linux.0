Return-Path: dave@gnu.org
Date: Mon, 17 Oct 2011 19:23:05 -0400
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH 1/3] prlimit: add build rules
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1318893785.5289.9.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/Makefile.am |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sys-utils/Makefile.am b/sys-utils/Makefile.am
index 7da9ff0..b8d9478 100644
--- a/sys-utils/Makefile.am
+++ b/sys-utils/Makefile.am
@@ -2,11 +2,11 @@ include $(top_srcdir)/config/include-Makefile.am
 
 bin_PROGRAMS =
 sbin_PROGRAMS =
-usrbin_exec_PROGRAMS = flock ipcrm ipcs ipcmk renice setsid
+usrbin_exec_PROGRAMS = flock ipcrm ipcs ipcmk renice setsid prlimit
 usrsbin_exec_PROGRAMS = readprofile
 
 dist_man_MANS = flock.1 ipcrm.1 ipcs.1 ipcmk.1 renice.1 setsid.1 \
-		readprofile.8
+		readprofile.8 prlimit.1
 
 if LINUX
 bin_PROGRAMS += dmesg
@@ -41,6 +41,9 @@ dmesg_SOURCES = dmesg.c $(top_srcdir)/lib/strutils.c
 ipcmk_SOURCES = ipcmk.c $(top_srcdir)/lib/strutils.c
 ipcrm_SOURCES = ipcrm.c  $(top_srcdir)/lib/strutils.c
 flock_SOURCES = flock.c $(top_srcdir)/lib/strutils.c
+prlimit_SOURCES = prlimit.c $(top_srcdir)/lib/strutils.c \
+			    $(top_srcdir)/lib/mbsalign.c \
+			    $(top_srcdir)/lib/tt.c
 
 if BUILD_MOUNTPOINT
 bin_PROGRAMS += mountpoint
-- 
1.7.7
