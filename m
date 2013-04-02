Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:60242 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760521Ab3DBTnV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Apr 2013 15:43:21 -0400
Received: by mail-wi0-f175.google.com with SMTP id c10so2925593wiw.8
        for <util-linux@vger.kernel.org>; Tue, 02 Apr 2013 12:43:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/13] lscpu: fix error message
Date: Tue,  2 Apr 2013 20:42:51 +0100
Message-Id: <1364931777-2645-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/lscpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 46f9e35..e90e8f5 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1357,7 +1357,7 @@ int main(int argc, char *argv[])
 	if (cpu_modifier_specified && mod->mode == OUTPUT_SUMMARY) {
 		fprintf(stderr,
 			_("%s: options --all, --online and --offline may only "
-			  "be used with options --extended or --parsable.\n"),
+			  "be used with options --extended or --parse.\n"),
 			program_invocation_short_name);
 		return EXIT_FAILURE;
 	}
-- 
1.8.2

