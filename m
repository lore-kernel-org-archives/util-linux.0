Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:39576 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935574Ab3DHTdT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:33:19 -0400
Received: by mail-we0-f169.google.com with SMTP id x43so5033221wey.28
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:33:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/14] setarch: clean up usage()
Date: Mon,  8 Apr 2013 20:32:46 +0100
Message-Id: <1365449579-13238-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Requested-by: Karel Zak <kzak@redhat.com>
References: http://marc.info/?l=util-linux-ng&m=136516351523680&w=2
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setarch.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index f6c0e20..051cbef 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -90,32 +90,30 @@ enum {
 static void __attribute__((__noreturn__))
 show_help(void)
 {
-   printf(USAGE_HEADER);
-   printf(_(" %s%s [options] [program [program arguments]]\n"),
-         program_invocation_short_name,
+  fputs(USAGE_HEADER, stdout);
+  printf(_(" %s%s [options] [program [program arguments]]\n"),
+	 program_invocation_short_name,
 	 !strcmp(program_invocation_short_name, "setarch") ? " <arch>" : "");
 
-   printf(USAGE_OPTIONS);
-   printf(_(
-   " -v, --verbose            says what options are being switched on\n"
-   " -R, --addr-no-randomize  disables randomization of the virtual address space\n"
-   " -F, --fdpic-funcptrs     makes function pointers point to descriptors\n"
-   " -Z, --mmap-page-zero     turns on MMAP_PAGE_ZERO\n"
-   " -L, --addr-compat-layout changes the way virtual memory is allocated\n"
-   " -X, --read-implies-exec  turns on READ_IMPLIES_EXEC\n"
-   " -B, --32bit              turns on ADDR_LIMIT_32BIT\n"
-   " -I, --short-inode        turns on SHORT_INODE\n"
-   " -S, --whole-seconds      turns on WHOLE_SECONDS\n"
-   " -T, --sticky-timeouts    turns on STICKY_TIMEOUTS\n"
-   " -3, --3gb                limits the used address space to a maximum of 3 GB\n"
-   "     --4gb                ignored (for backward compatibility only)\n"
-   "     --uname-2.6          turns on UNAME26\n"));
-   printf(_(
-   "     --list               list settable architectures, and exit\n"));
+  fputs(USAGE_OPTIONS, stdout);
+  fputs(_(" -v, --verbose            says what options are being switched on\n"), stdout);
+  fputs(_(" -R, --addr-no-randomize  disables randomization of the virtual address space\n"), stdout);
+  fputs(_(" -F, --fdpic-funcptrs     makes function pointers point to descriptors\n"), stdout);
+  fputs(_(" -Z, --mmap-page-zero     turns on MMAP_PAGE_ZERO\n"), stdout);
+  fputs(_(" -L, --addr-compat-layout changes the way virtual memory is allocated\n"), stdout);
+  fputs(_(" -X, --read-implies-exec  turns on READ_IMPLIES_EXEC\n"), stdout);
+  fputs(_(" -B, --32bit              turns on ADDR_LIMIT_32BIT\n"), stdout);
+  fputs(_(" -I, --short-inode        turns on SHORT_INODE\n"), stdout);
+  fputs(_(" -S, --whole-seconds      turns on WHOLE_SECONDS\n"), stdout);
+  fputs(_(" -T, --sticky-timeouts    turns on STICKY_TIMEOUTS\n"), stdout);
+  fputs(_(" -3, --3gb                limits the used address space to a maximum of 3 GB\n"), stdout);
+  fputs(_("     --4gb                ignored (for backward compatibility only)\n"), stdout);
+  fputs(_("     --uname-2.6          turns on UNAME26\n"), stdout);
+  fputs(_("     --list               list settable architectures, and exit\n"), stdout);
 
-  printf(USAGE_SEPARATOR);
-  printf(USAGE_HELP);
-  printf(USAGE_VERSION);
+  fputs(USAGE_SEPARATOR, stdout);
+  fputs(USAGE_HELP, stdout);
+  fputs(USAGE_VERSION, stdout);
   printf(USAGE_MAN_TAIL("setarch(8)"));
 
   exit(EXIT_SUCCESS);
-- 
1.8.2.1

