Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:57374 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753833AbaKCVRb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 3 Nov 2014 16:17:31 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] swapon: reword some usage strings
Date: Mon,  3 Nov 2014 22:17:17 +0100
Message-Id: <1415049437-2301-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1415049437-2301-1-git-send-email-bensberg@justemail.net>
References: <1415049437-2301-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also remove some inconsistent periods and properly punctuate
the closing sentence.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/swapon.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 8f7e918..a457607 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -756,9 +756,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		" <file>                 name of file to be used\n"), out);
 
 	fputs(_("\nAvailable discard policy types (for --discard):\n"
-		" once	  : only single-time area discards are issued.\n"
-		" pages	  : discard freed pages before they are reused.\n"
-		" * if no policy is selected both discard types are enabled. (default)\n"), out);
+		" once	  : only single-time area discards are issued\n"
+		" pages	  : freed pages are discarded before they are reused\n"
+		" If no policy is selected, both discard types are enabled (default).\n"), out);
 
 	fputs(_("\nAvailable columns (for --show):\n"), out);
 	for (i = 0; i < ARRAY_SIZE(infos); i++)
-- 
1.7.0.4

