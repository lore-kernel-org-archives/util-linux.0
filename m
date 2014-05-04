Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:57049 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbaEDPuY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:24 -0400
Received: by mail-wg0-f52.google.com with SMTP id l18so5622596wgh.35
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/15] cytune: be consistent with interval data type
Date: Sun,  4 May 2014 16:49:44 +0100
Message-Id: <1399218596-21321-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The sleep(3) uses unsigned int as input.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index 64e15cc..63f6980 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -149,7 +149,7 @@ static void summary(int sig)
 	cc->timeout_value = 0;
 }
 
-static void query_tty_stats(int argc, char **argv, int interval, int numfiles,
+static void query_tty_stats(int argc, char **argv, unsigned int interval, int numfiles,
 		     unsigned long *threshold_value,
 		     unsigned long *timeout_value)
 {
@@ -273,7 +273,7 @@ static void query_tty_stats(int argc, char **argv, int interval, int numfiles,
 int main(int argc, char **argv)
 {
 	int query = 0;
-	int interval = 1;
+	unsigned int interval = 1;
 	int file;
 	int i;
 
-- 
1.9.2

