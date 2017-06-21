Return-Path: util-linux-owner@vger.kernel.org
Received: from prod-mx.aristanetworks.com ([162.210.130.12]:55079 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751998AbdFUXwB (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 19:52:01 -0400
Date: Wed, 21 Jun 2017 16:43:05 -0700
From: Ivan Delalande <colona@arista.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: [PATCH] dmesg: print only 2 hex digits for each hex-escaped byte
Message-ID: <20170621234305.GA7746@visor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

As buf is passed as a signed char buffer in fwrite_hex, fprintf will
print every byte from 0x80 as a signed-extended int causing each of
these bytes to be printed as "\xffffff80" and such, which can be pretty
confusing. Force fprintf to use the argument as a char to make it print
only 2 digits, e.g. "\x80".

Signed-off-by: Ivan Delalande <colona@arista.com>
---
 sys-utils/dmesg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index b83cfb1bb..821d8bbb2 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -613,7 +613,7 @@ static int fwrite_hex(const char *buf, size_t size, FILE *out)
 	size_t i;
 
 	for (i = 0; i < size; i++) {
-		int rc = fprintf(out, "\\x%02x", buf[i]);
+		int rc = fprintf(out, "\\x%02hhx", buf[i]);
 		if (rc < 0)
 			return rc;
 	}
-- 
2.13.1
