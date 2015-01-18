Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:51108 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751593AbbARUko (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 18 Jan 2015 15:40:44 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] ionice: drop the duplicate docstring
Date: Sun, 18 Jan 2015 21:40:29 +0100
Message-Id: <1421613631-5732-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 schedutils/ionice.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/schedutils/ionice.c b/schedutils/ionice.c
index fb5d04a..5528afe 100644
--- a/schedutils/ionice.c
+++ b/schedutils/ionice.c
@@ -100,8 +100,6 @@ static void ioprio_setid(int which, int ioclass, int data, int who)
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	fputs(_("\nSets or gets the IO scheduling class and priority of processes.\n"), out);
-
 	fputs(USAGE_HEADER, out);
 	fprintf(out,  _(" %1$s [options] -p <pid>...\n"
 			" %1$s [options] -P <pgid>...\n"
-- 
1.7.0.4

