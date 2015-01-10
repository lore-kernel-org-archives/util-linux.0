Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:61126 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753393AbbAJNly (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 10 Jan 2015 08:41:54 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] setarch: in the usage text only mention options that actually do something
Date: Sat, 10 Jan 2015 14:41:35 +0100
Message-Id: <1420897295-17573-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1420897295-17573-1-git-send-email-bensberg@justemail.net>
References: <1420897295-17573-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It is enough that --4gb is mentioned in the man page.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/setarch.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index a60d2b0..96fd183 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -111,7 +111,6 @@ static void __attribute__((__noreturn__)) show_help(void)
 	fputs(_(" -X, --read-implies-exec  turns on READ_IMPLIES_EXEC\n"), stdout);
 	fputs(_(" -Z, --mmap-page-zero     turns on MMAP_PAGE_ZERO\n"), stdout);
 	fputs(_(" -3, --3gb                limits the used address space to a maximum of 3 GB\n"), stdout);
-	fputs(_("     --4gb                ignored (for backward compatibility only)\n"), stdout);
 	fputs(_("     --uname-2.6          turns on UNAME26\n"), stdout);
 	fputs(_(" -v, --verbose            say what options are being switched on\n"), stdout);
 	fputs(_("     --list               list settable architectures, and exit\n"), stdout);
-- 
1.7.0.4

