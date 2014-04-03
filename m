Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:52562 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaDCVl6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 Apr 2014 17:41:58 -0400
From: =?UTF-8?q?Thomas=20B=C3=A4chler?= <thomas@archlinux.org>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20B=C3=A4chler?= <thomas@archlinux.org>
Subject: [PATCH] fstrim: add systemd units
Date: Thu,  3 Apr 2014 23:41:51 +0200
Message-Id: <1396561311-12825-1-git-send-email-thomas@archlinux.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This adds a timer and a service for systemd that runs
fstrim -a once a day.

The Persistent=true option used will only work on systemd 212
or newer.
---
 sys-utils/.gitignore        |  1 +
 sys-utils/Makemodule.am     |  6 ++++++
 sys-utils/fstrim.service.in |  6 ++++++
 sys-utils/fstrim.timer      | 10 ++++++++++
 4 files changed, 23 insertions(+)
 create mode 100644 sys-utils/fstrim.service.in
 create mode 100644 sys-utils/fstrim.timer

diff --git a/sys-utils/.gitignore b/sys-utils/.gitignore
index 8d8737a..bcd6e02 100644
--- a/sys-utils/.gitignore
+++ b/sys-utils/.gitignore
@@ -18,3 +18,4 @@ sparc32.8
 sparc32bash.8
 sparc64.8
 x86_64.8
+fstrim.service
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index ae254a3..1c2b210 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -53,8 +53,14 @@ dist_man_MANS += sys-utils/fstrim.8
 fstrim_SOURCES = sys-utils/fstrim.c
 fstrim_LDADD = $(LDADD) libcommon.la libmount.la
 fstrim_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir)
+systemdsystemunit_DATA += \
+	sys-utils/fstrim.service \
+	sys-utils/fstrim.timer
 endif
 
+PATHFILES += \
+	sys-utils/fstrim.service
+
 if LINUX
 #
 # Linux-only utils with no another dependencies. All another dependencies have
diff --git a/sys-utils/fstrim.service.in b/sys-utils/fstrim.service.in
new file mode 100644
index 0000000..52155d0
--- /dev/null
+++ b/sys-utils/fstrim.service.in
@@ -0,0 +1,6 @@
+[Unit]
+Description=Discard unused blocks
+
+[Service]
+Type=oneshot
+ExecStart=@sbindir@/fstrim -a
diff --git a/sys-utils/fstrim.timer b/sys-utils/fstrim.timer
new file mode 100644
index 0000000..24eeee5
--- /dev/null
+++ b/sys-utils/fstrim.timer
@@ -0,0 +1,10 @@
+[Unit]
+Description=Discard unused blocks once a day
+
+[Timer]
+OnCalendar=daily
+AccuracySec=1h
+Persistent=true
+
+[Install]
+WantedBy=multi-user.target
-- 
1.9.1

