Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:38652 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbaKJVuO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Nov 2014 16:50:14 -0500
Received: by mail-wg0-f45.google.com with SMTP id x12so10069142wgg.32
        for <util-linux@vger.kernel.org>; Mon, 10 Nov 2014 13:50:12 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/6] libmount: fix memory overflow [AddressSanitizer]
Date: Mon, 10 Nov 2014 21:49:53 +0000
Message-Id: <1415656195-20458-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

==10918==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7fffd795b680 at pc 0x0000004447c6 bp 0x7fffd795b3e0 sp 0x7fffd795ab78
WRITE of size 129 at 0x7fffd795b680 thread T0
    #0 0x4447c5 in scanf_common(void*, int, bool, char const*, __va_list_tag*) (/home/src/util-linux/.libs/lt-mount+0x4447c5)
    #1 0x445892 in sscanf (/home/src/util-linux/.libs/lt-mount+0x445892)
    #2 0x7fe78709a3d3 in get_filesystems /home/src/util-linux/libmount/src/utils.c:581:7
    #3 0x7fe78709a1ba in mnt_get_filesystems /home/src/util-linux/libmount/src/utils.c:622:7
    #4 0x7fe7870aa78f in do_mount_by_pattern /home/src/util-linux/libmount/src/context_mount.c:833:7
    #5 0x7fe7870a9534 in mnt_context_do_mount /home/src/util-linux/libmount/src/context_mount.c:951:9
    #6 0x7fe7870aab2b in mnt_context_mount /home/src/util-linux/libmount/src/context_mount.c:1051:8
    #7 0x4ba9f5 in main /home/src/util-linux/sys-utils/mount.c:1107:7
    #8 0x7fe785caa03f in __libc_start_main (/usr/lib/libc.so.6+0x2003f)
    #9 0x4b9f9c in _start (/home/src/util-linux/.libs/lt-mount+0x4b9f9c)

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libmount/src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index 456a898..33e2c5b 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -578,7 +578,7 @@ static int get_filesystems(const char *filename, char ***filesystems, const char
 
 		if (*line == '#' || strncmp(line, "nodev", 5) == 0)
 			continue;
-		if (sscanf(line, " %128[^\n ]\n", name) != 1)
+		if (sscanf(line, " %" stringify(sizeof(line) - 1)  "[^\n ]\n", name) != 1)
 			continue;
 		if (strcmp(name, "*") == 0) {
 			rc = 1;
-- 
2.1.3

