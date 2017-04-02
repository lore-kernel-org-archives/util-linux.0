Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34475 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdDBIOo (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 2 Apr 2017 04:14:44 -0400
Received: by mail-wr0-f196.google.com with SMTP id w43so25630751wrb.1
        for <util-linux@vger.kernel.org>; Sun, 02 Apr 2017 01:14:43 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/3] lib/cpuset: stop changing variable that is not read
Date: Sun,  2 Apr 2017 09:14:35 +0100
Message-Id: <20170402081436.861-2-kerolasa@iki.fi>
In-Reply-To: <20170402081436.861-1-kerolasa@iki.fi>
References: <20170402081436.861-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/cpuset.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/cpuset.c b/lib/cpuset.c
index fbe99e2a5..6d82522f5 100644
--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -255,7 +255,6 @@ int cpumask_parse(const char *str, cpu_set_t *set, size_t setsize)
 			CPU_SET_S(cpu + 2, setsize, set);
 		if (val & 8)
 			CPU_SET_S(cpu + 3, setsize, set);
-		len--;
 		ptr--;
 		cpu += 4;
 	}
-- 
2.12.2

