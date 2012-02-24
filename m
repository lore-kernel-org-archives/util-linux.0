Return-Path: util-linux-owner@vger.kernel.org
Received: from www.linutronix.de ([62.245.132.108]:58298 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798Ab2BXRPG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 24 Feb 2012 12:15:06 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] Add uuid to the linker flags if using built LIBBLKID
Date: Fri, 24 Feb 2012 18:16:08 +0100
Message-Id: <1330103768-32139-2-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1330103768-32139-1-git-send-email-bigeasy@linutronix.de>
References: <1330103768-32139-1-git-send-email-bigeasy@linutronix.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

|ld: warning: libuuid.so.1, needed by ../libblkid/src/.libs/libblkid.so, not found (try using -rpath or -rpath-link)
|../libblkid/src/.libs/libblkid.so: undefined reference to `uuid_unparse@UUID_1.0'

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 config/include-Makefile.am |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/config/include-Makefile.am b/config/include-Makefile.am
index 29760d4..895d4bc 100644
--- a/config/include-Makefile.am
+++ b/config/include-Makefile.am
@@ -31,6 +31,9 @@ ul_libuuid_la = $(top_builddir)/libuuid/src/libuuid.la
 $(ul_libuuid_la):
 	$(MAKE) -C $(ul_libuuid_builddir)
 
+if BUILD_LIBBLKID
+ ul_libblkid_la += $(ul_libuuid_la)
+endif
 
 # mount
 ul_libmount_srcdir = $(top_srcdir)/libmount/src
-- 
1.7.9

