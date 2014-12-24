Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:59815 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751611AbaLXQ4a (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Dec 2014 11:56:30 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/10] textual: list the options of setarch in a more alphabetical order
Date: Wed, 24 Dec 2014 17:56:06 +0100
Message-Id: <1419440170-10850-6-git-send-email-bensberg@justemail.net>
In-Reply-To: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
References: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/setarch.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index e00198c..73329a4 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -95,25 +95,28 @@ static void __attribute__((__noreturn__)) show_help(void)
 		printf(_(" %s <arch> [options] [<program> [<argument>...]]\n"), program_invocation_short_name);
 	else
 		printf(_(" %s [options] [<program> [<argument>...]]\n"), program_invocation_short_name);
+
 	fputs(USAGE_OPTIONS, stdout);
-	fputs(_(" -v, --verbose            says what options are being switched on\n"), stdout);
-	fputs(_(" -R, --addr-no-randomize  disables randomization of the virtual address space\n"), stdout);
-	fputs(_(" -F, --fdpic-funcptrs     makes function pointers point to descriptors\n"), stdout);
-	fputs(_(" -Z, --mmap-page-zero     turns on MMAP_PAGE_ZERO\n"), stdout);
-	fputs(_(" -L, --addr-compat-layout changes the way virtual memory is allocated\n"), stdout);
-	fputs(_(" -X, --read-implies-exec  turns on READ_IMPLIES_EXEC\n"), stdout);
 	fputs(_(" -B, --32bit              turns on ADDR_LIMIT_32BIT\n"), stdout);
+	fputs(_(" -F, --fdpic-funcptrs     makes function pointers point to descriptors\n"), stdout);
 	fputs(_(" -I, --short-inode        turns on SHORT_INODE\n"), stdout);
+	fputs(_(" -L, --addr-compat-layout changes the way virtual memory is allocated\n"), stdout);
+	fputs(_(" -R, --addr-no-randomize  disables randomization of the virtual address space\n"), stdout);
 	fputs(_(" -S, --whole-seconds      turns on WHOLE_SECONDS\n"), stdout);
 	fputs(_(" -T, --sticky-timeouts    turns on STICKY_TIMEOUTS\n"), stdout);
+	fputs(_(" -X, --read-implies-exec  turns on READ_IMPLIES_EXEC\n"), stdout);
+	fputs(_(" -Z, --mmap-page-zero     turns on MMAP_PAGE_ZERO\n"), stdout);
 	fputs(_(" -3, --3gb                limits the used address space to a maximum of 3 GB\n"), stdout);
 	fputs(_("     --4gb                ignored (for backward compatibility only)\n"), stdout);
 	fputs(_("     --uname-2.6          turns on UNAME26\n"), stdout);
+	fputs(_(" -v, --verbose            say what options are being switched on\n"), stdout);
 	fputs(_("     --list               list settable architectures, and exit\n"), stdout);
+
 	fputs(USAGE_SEPARATOR, stdout);
 	fputs(USAGE_HELP, stdout);
 	fputs(USAGE_VERSION, stdout);
 	printf(USAGE_MAN_TAIL("setarch(8)"));
+
 	exit(EXIT_SUCCESS);
 }
 
-- 
1.7.0.4

