Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:48783 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbaEDPuq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:46 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so5632005wgh.14
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:44 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/15] cytune: remove unnecessary type casts
Date: Sun,  4 May 2014 16:49:51 +0100
Message-Id: <1399218596-21321-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index 4f0ddc7..5bb1328 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -115,8 +115,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 static inline double dtime(struct timeval *tvpnew, struct timeval *tvpold)
 {
 	double diff;
-	diff = (double)tvpnew->tv_sec - (double)tvpold->tv_sec;
-	diff += ((double)tvpnew->tv_usec - (double)tvpold->tv_usec) / 1000000;
+	diff = (double)(tvpnew->tv_sec - tvpold->tv_sec);
+	diff += (double)(tvpnew->tv_usec - tvpold->tv_usec) / 1000000;
 	return diff;
 }
 
-- 
1.9.2

