Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:58273 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab2LPKoN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Dec 2012 05:44:13 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so2061727wgb.1
        for <util-linux@vger.kernel.org>; Sun, 16 Dec 2012 02:44:12 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/14] ipcs: assist debugging
Date: Sun, 16 Dec 2012 10:43:50 +0000
Message-Id: <1355654642-22106-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

One will be able to see enum symbols when debugging, which is not the
case when values are specified as define list.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 6ef0bbe..889c868 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -25,11 +25,14 @@
 
 #include "ipcutils.h"
 
-#define LIMITS 1
-#define STATUS 2
-#define CREATOR 3
-#define TIME 4
-#define PID 5
+enum output_formats {
+	NOTSPECIFIED,
+	LIMITS,
+	STATUS,
+	CREATOR,
+	TIME,
+	PID
+};
 
 static void do_shm (char format);
 static void print_shm (int id);
@@ -68,7 +71,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 int main (int argc, char **argv)
 {
 	int opt, msg = 0, sem = 0, shm = 0, id=0, print=0;
-	char format = 0;
+	char format = NOTSPECIFIED;
 	static const struct option longopts[] = {
 		{"id", required_argument, NULL, 'i'},
 		{"shmems", no_argument, NULL, 'm'},
-- 
1.8.0.2

