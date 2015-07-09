Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.pxnet.com ([89.1.7.7]:37261 "EHLO mail.pxnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbbGINbi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Jul 2015 09:31:38 -0400
Message-Id: <309a90194b08d5c512dce7638564bcb31ed23c51.1436438005.git.tilman@imap.cc>
In-Reply-To: <cover.1436438005.git.tilman@imap.cc>
References: <cover.1436438005.git.tilman@imap.cc>
From: Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 2/3] ldattach: order line disciplines canonically
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Tilman Schmidt <tilman@imap.cc>,
        Paul Bolle <pebolle@tiscali.nl>, Sami Kerola <kerolasa@iki.fi>
Date: Thu,  9 Jul 2015 15:22:32 +0200 (CEST)
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

List line disciplines in numerical order and put official names
before convenience aliases.

Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---
 sys-utils/ldattach.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sys-utils/ldattach.c b/sys-utils/ldattach.c
index 5317d22..bd4fadd 100644
--- a/sys-utils/ldattach.c
+++ b/sys-utils/ldattach.c
@@ -62,14 +62,15 @@ struct gsm_config
 #ifndef N_GIGASET_M101
 # define N_GIGASET_M101 16
 #endif
-#ifndef N_GSM0710
-# define N_GSM0710 21
-#endif
 
 #ifndef N_PPS
 # define N_PPS 18
 #endif
 
+#ifndef N_GSM0710
+# define N_GSM0710 21
+#endif
+
 #define MAXINTROPARMLEN 32
 
 /* attach a line discipline ioctl */
@@ -86,7 +87,6 @@ struct ld_table {
 
 /* currently supported line disciplines, plus some aliases */
 static const struct ld_table ld_discs[] = {
-	{ "GSM0710",		N_GSM0710},
 	{ "TTY",		N_TTY },
 	{ "SLIP",		N_SLIP },
 	{ "MOUSE",		N_MOUSE },
@@ -101,10 +101,11 @@ static const struct ld_table ld_discs[] = {
 	{ "SYNC_PPP",		N_SYNC_PPP },
 	{ "SYNCPPP",		N_SYNC_PPP },
 	{ "HCI",		N_HCI },
-	{ "PPS",		N_PPS },
+	{ "GIGASET_M101",	N_GIGASET_M101 },
 	{ "M101",		N_GIGASET_M101 },
 	{ "GIGASET",		N_GIGASET_M101 },
-	{ "GIGASET_M101",	N_GIGASET_M101 },
+	{ "PPS",		N_PPS },
+	{ "GSM0710",		N_GSM0710},
 	{ NULL,	0 }
 };
 
-- 
1.9.2.459.g68773ac

