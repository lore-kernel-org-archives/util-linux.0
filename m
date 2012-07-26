Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.9]:56493 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab2GZOLz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 26 Jul 2012 10:11:55 -0400
Message-ID: <50115026.3020207@bernhard-voelker.de>
Date: Thu, 26 Jul 2012 16:11:50 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] prlimit: improve error messages for bad --pid invocation
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


>From 5c4f86f565c61d23a73d2aa46331edd75ec382df Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Thu, 26 Jul 2012 16:10:23 +0200
Subject: [PATCH] prlimit: improve error messages for bad --pid invocation

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 sys-utils/prlimit.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index c215421..2055adf 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -579,7 +579,7 @@ int main(int argc, char **argv)

 		case 'p':
 			if (pid)
-				errx(EXIT_FAILURE, _("only one --pid option may be specified."));
+				errx(EXIT_FAILURE, _("option --pid may be specified only once"));
 			pid = strtos32_or_err(optarg, _("invalid PID argument"));
 			break;
 		case 'h':
@@ -610,7 +610,7 @@ int main(int argc, char **argv)
 		}
 	}
 	if (argc > optind && pid)
-		errx(EXIT_FAILURE, _("options --pid and COMMAND are mutually exclusive."));
+		errx(EXIT_FAILURE, _("options --pid and COMMAND are mutually exclusive"));
 	if (!ncolumns) {
 		/* default columns */
 		columns[ncolumns++] = COL_RES;
-- 
1.7.7


