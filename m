Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36731 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbdGaTzW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jul 2017 15:55:22 -0400
Received: by mail-wr0-f196.google.com with SMTP id y67so31617189wrb.3
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 12:55:22 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 5/9] libuuid: use access(2) when checking /dev/random availability
Date: Mon, 31 Jul 2017 20:55:04 +0100
Message-Id: <20170731195508.11661-6-kerolasa@iki.fi>
In-Reply-To: <20170731195508.11661-1-kerolasa@iki.fi>
References: <20170731195508.11661-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The access(2) is more lightwight than stat(2), and tells whether random
device(s) can be read or not, unlike the earlier stat() call.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libuuid/src/gen_uuid.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 21e361293..7dafcaeed 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -534,9 +534,8 @@ void uuid_generate_random(uuid_t out)
  */
 static int have_random_source(void)
 {
-	struct stat s;
-
-	return (!stat("/dev/random", &s) || !stat("/dev/urandom", &s));
+	return (access("/dev/random", R_OK) == 0 ||
+		access("/dev/urandom", R_OK) == 0);
 }
 
 
-- 
2.13.3

