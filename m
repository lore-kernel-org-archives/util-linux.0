Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34953 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdIKT5U (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 Sep 2017 15:57:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id e64so7722717wmi.2
        for <util-linux@vger.kernel.org>; Mon, 11 Sep 2017 12:57:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/4] uuidparse: fix stack-buffer-overflow [asan]
Date: Mon, 11 Sep 2017 20:57:14 +0100
Message-Id: <20170911195717.817-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffee13b8f05 at
pc 0x55debcc9fda4 bp 0x7ffee13b8d70 sp 0x7ffee13b8520
WRITE of size 38 at 0x7ffee13b8f05 thread T0
    #0 0x55debcc9fda3 in scanf_common(void*, int, bool, char const*, __va_list_tag*) (/home/src/util-linux/.libs/lt-uuidparse+0x63da3)
    #1 0x55debcca077b in vscanf (/home/src/util-linux/.libs/lt-uuidparse+0x6477b)
    #2 0x55debcca085f in scanf (/home/src/util-linux/.libs/lt-uuidparse+0x6485f)
    #3 0x55debcd50fad in print_output /home/src/util-linux/misc-utils/uuidparse.c:284:10
    #4 0x55debcd4fcc5 in main /home/src/util-linux/misc-utils/uuidparse.c:355:2

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/uuidparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/uuidparse.c b/misc-utils/uuidparse.c
index 5fa34b23d..3347dc0af 100644
--- a/misc-utils/uuidparse.c
+++ b/misc-utils/uuidparse.c
@@ -279,7 +279,7 @@ static void print_output(struct control const *const ctrl, int argc,
 		fill_table_row(tb, argv[i]);
 
 	if (i == 0) {
-		char uuid[UUID_STR_LEN];
+		char uuid[UUID_STR_LEN + 1];
 
 		while (scanf(" %" stringify_value(UUID_STR_LEN)
 			     "[^ \t\n]%*c", uuid) && !feof(stdin))
-- 
2.14.1

