Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp3.ono.com ([62.42.230.163]:32782 "EHLO smtp3.ono.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbbFFEYw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 6 Jun 2015 00:24:52 -0400
From: Guillem Jover <guillem@hadrons.org>
To: util-linux@vger.kernel.org
Cc: Steven Chamberlain <steven@pyro.eu.org>
Subject: [PATCH 3/3] include/c: Define F_DUPFD_CLOEXEC on kFreeBSD systems if missing
Date: Sat,  6 Jun 2015 06:19:07 +0200
Message-Id: <1433564347-9515-4-git-send-email-guillem@hadrons.org>
In-Reply-To: <1433564347-9515-1-git-send-email-guillem@hadrons.org>
References: <1433564347-9515-1-git-send-email-guillem@hadrons.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The kernel of FreeBSD version 10 and higher supports this fcntl command,
but the system libc, in this case glibc, might not yet know about it.

Signed-off-by: Guillem Jover <guillem@hadrons.org>
---
 include/c.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/c.h b/include/c.h
index a72e264..1eda75f 100644
--- a/include/c.h
+++ b/include/c.h
@@ -231,6 +231,12 @@ static inline int dirfd(DIR *d)
 #define O_CLOEXEC 0
 #endif
 
+#ifdef __FreeBSD_kernel__
+#ifndef F_DUPFD_CLOEXEC
+#define F_DUPFD_CLOEXEC	17	/* Like F_DUPFD, but FD_CLOEXEC is set */
+#endif
+#endif
+
 
 #ifndef AI_ADDRCONFIG
 #define AI_ADDRCONFIG 0x0020
-- 
2.2.1.209.g41e5f3a

