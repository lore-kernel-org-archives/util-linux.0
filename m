Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:62959 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbaKJVuJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Nov 2014 16:50:09 -0500
Received: by mail-wi0-f180.google.com with SMTP id hi2so11948475wib.7
        for <util-linux@vger.kernel.org>; Mon, 10 Nov 2014 13:50:06 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/6] tests: fix memory leak [AddressSanitizer]
Date: Mon, 10 Nov 2014 21:49:51 +0000
Message-Id: <1415656195-20458-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/cpuset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/cpuset.c b/lib/cpuset.c
index e5b6b9d..d715720 100644
--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -388,6 +388,7 @@ int main(int argc, char *argv[])
 	printf("[%s]\n", cpulist_create(buf, buflen, set, setsize));
 
 	free(buf);
+	free(mask);
 	free(range);
 	cpuset_free(set);
 
-- 
2.1.3

