Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f195.google.com ([209.85.217.195]:35805 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbcDCIfg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Apr 2016 04:35:36 -0400
Received: by mail-lb0-f195.google.com with SMTP id gk8so13959402lbc.2
        for <util-linux@vger.kernel.org>; Sun, 03 Apr 2016 01:35:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/3] chrt: make --sched-* short options to require an argument
Date: Sun,  3 Apr 2016 09:35:27 +0100
Message-Id: <1459672529-2278-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1459672529-2278-1-git-send-email-kerolasa@iki.fi>
References: <1459672529-2278-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

These options are expecting an argument, and the long options struct already
required them.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 schedutils/chrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 363d6e1..64a5858 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -399,7 +399,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while((c = getopt_long(argc, argv, "+abdDfiphmoPTrRvV", longopts, NULL)) != -1)
+	while((c = getopt_long(argc, argv, "+abdD:fiphmoP:T:rRvV", longopts, NULL)) != -1)
 	{
 		int ret = EXIT_FAILURE;
 
-- 
2.8.0

