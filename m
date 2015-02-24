Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:54050 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbbBXPd1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 10:33:27 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] logger: link libsystemd-daemon.so
Date: Tue, 24 Feb 2015 16:33:15 +0100
Message-Id: <1424791995-690-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1424791995-690-1-git-send-email-sweet_f_a@gmx.de>
References: <1424791995-690-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Noticed on openSUSE 13.1:
util-linux-2.26/misc-utils/logger.c:735: undefined reference to `sd_booted'

Introduced in d77dc29e.

CC: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/Makemodule.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index 94e0958..3c79bec 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -23,8 +23,8 @@ usrbin_exec_PROGRAMS += logger
 dist_man_MANS += misc-utils/logger.1
 logger_SOURCES = misc-utils/logger.c lib/strutils.c
 if HAVE_SYSTEMD
-logger_LDADD = $(SYSTEMD_LIBS) $(SYSTEMD_JOURNAL_LIBS)
-logger_CFLAGS = $(SYSTEMD_CFLAGS) $(SYSTEMD_JOURNAL_CFLAGS)
+logger_LDADD = $(SYSTEMD_LIBS) $(SYSTEMD_DAEMON_LIBS) $(SYSTEMD_JOURNAL_LIBS)
+logger_CFLAGS = $(SYSTEMD_CFLAGS) $(SYSTEMD_DAEMON_CFLAGS) $(SYSTEMD_JOURNAL_CFLAGS)
 endif
 endif # BUILD_LOGGER
 
-- 
1.8.4.5

