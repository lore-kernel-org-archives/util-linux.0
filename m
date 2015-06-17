Return-Path: util-linux-owner@vger.kernel.org
Received: from oceania.blizzart.net ([212.83.174.218]:34744 "EHLO
	oceania.blizzart.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757180AbbFQQFm convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 17 Jun 2015 12:05:42 -0400
Received: from webmail.alteroot.org (localhost [IPv6:::1])
	by oceania.blizzart.net (Postfix) with ESMTPSA id 6313A5F79E
	for <util-linux@vger.kernel.org>; Wed, 17 Jun 2015 17:59:18 +0200 (CEST)
Mime-Version: 1.0
Date: Wed, 17 Jun 2015 15:59:18 +0000
Content-Type: text/plain; charset="utf-8"
Message-ID: <361341ee5502b6112bc452c27c15ea9f@webmail.alteroot.org>
From: "Romain Bouvier" <skunnyk@alteroot.org>
Subject: [PATCH] Return correct value for uuid_generate_time_safe
To: util-linux@vger.kernel.org
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Make return value consistent for consecutive calls.
If you call uuid_generate_time_safe, it should always
return -1 if it can't guarantee uniqueness.
Without this patch, on consecutive calls where it can't guarantee
uniqueness, the first call returns -1, but later calls return 0.

Reported-by: Romain Bouvier <skunnyk@alteroot.org>
Signed-off-by: Andreas Henriksson <andreas@fatal.se>

---
 libuuid/src/gen_uuid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index eb79339..2c5b955 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -227,6 +227,9 @@ static int get_clock(uint32_t *clock_high, uint32_t *clock_low,
        int                             len;
        int                             ret = 0;

+       if (state_fd == -1)
+               ret = -1;
+
        if (state_fd == -2) {
                save_umask = umask(0);
                state_fd = open(LIBUUID_CLOCK_FILE, O_RDWR|O_CREAT|O_CLOEXEC, 0660);
-- 
2.4.3
