Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:16733 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932751Ab1JZL7u (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Oct 2011 07:59:50 -0400
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0LTO001MZ9B1SAA0@damascus.uab.es> for
 util-linux@vger.kernel.org; Wed, 26 Oct 2011 13:59:26 +0200 (CEST)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0LTO008MX9B1DL40@damascus.uab.es>
 forutil-linux@vger.kernel.org; Wed, 26 Oct 2011 13:59:25 +0200 (CEST)
Date: Wed, 26 Oct 2011 16:02:15 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH] partx: use USAGE_ macros
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1319637735.3771.13.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 partx/partx.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/partx/partx.c b/partx/partx.c
index b12eebc..c730e37 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -604,7 +604,8 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	int i;
 
-	fputs(_("\nUsage:\n"), out);
+	fputs(USAGE_HEADER, out);
+
 	fprintf(out,
 	      _(" %s [-a|-d|-s] [--nr <n:m> | <partition>] <disk>\n"),
 		program_invocation_short_name);
@@ -629,7 +630,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	for (i = 0; i < NCOLS; i++)
 		fprintf(out, " %10s  %s\n", infos[i].name, _(infos[i].help));
 
-	fprintf(out, _("\nFor more information see partx(8).\n"));
+	fprintf(out, USAGE_MAN_TAIL("partx(8)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
1.7.7



