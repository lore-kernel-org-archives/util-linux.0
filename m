Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:43427 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbaHCORy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Aug 2014 10:17:54 -0400
Received: by mail-wg0-f47.google.com with SMTP id b13so6455867wgh.30
        for <util-linux@vger.kernel.org>; Sun, 03 Aug 2014 07:17:53 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/7] zramctl: mark --reset mutually exclusive with --algorithm and --streams
Date: Sun,  3 Aug 2014 15:17:39 +0100
Message-Id: <1407075463-19586-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reset is setting algorithm to lz4 and streams to 1.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/zramctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index 04744fd..9a3d5d2 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -425,8 +425,10 @@ int main(int argc, char **argv)
 	};
 
 	static const ul_excl_t excl[] = {
+		{ 'a', 'r' },
 		{ 'f', 'o', 'r' },
 		{ 'o', 'r', 's' },
+		{ 'r', 't' },
 		{ 0 }
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
-- 
2.0.3

