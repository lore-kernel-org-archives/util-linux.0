Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:57705 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab2LPKoS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Dec 2012 05:44:18 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so1401144wib.1
        for <util-linux@vger.kernel.org>; Sun, 16 Dec 2012 02:44:17 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/14] ipcs: add --bytes size output option
Date: Sun, 16 Dec 2012 10:43:52 +0000
Message-Id: <1355654642-22106-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes the command being a little closer standard compliant.  See
IEEE Std 1003.1 referral link below for more information.

References: http://pubs.opengroup.org/onlinepubs/009696799/utilities/ipcs.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.1 | 3 +++
 sys-utils/ipcs.c | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sys-utils/ipcs.1 b/sys-utils/ipcs.1
index 0a617d6..5fc3a81 100644
--- a/sys-utils/ipcs.1
+++ b/sys-utils/ipcs.1
@@ -68,6 +68,9 @@ Show status summary.
 .TP
 .B \-\-human
 Print sizes in human readable format.
+.TP
+\fB\-b\fR, \fB\-\-bytes\fR
+Print sizes in bytes.
 .SH SEE ALSO
 .BR ipcrm (1),
 .BR ipcmk (1),
diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 66c6302..d611354 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -67,6 +67,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_(" -l, --limits      show resource limits\n"), out);
 	fputs(_(" -u, --summary     show status summary\n"), out);
 	fputs(_("     --human       show sizes in human readable format\n"), out);
+	fputs(_(" -b, --bytes       show sizes in bytes\n"), out);
 	fprintf(out, USAGE_MAN_TAIL("ipcs(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
@@ -88,11 +89,12 @@ int main (int argc, char **argv)
 		{"limits", no_argument, NULL, 'l'},
 		{"summary", no_argument, NULL, 'u'},
 		{"human", no_argument, NULL, OPT_HUMAN},
+		{"bytes", no_argument, NULL, 'b'},
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
 	};
-	char options[] = "i:mqsatpcluVh";
+	char options[] = "i:mqsatpclubVh";
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -135,6 +137,9 @@ int main (int argc, char **argv)
 		case OPT_HUMAN:
 			unit = IPC_UNIT_HUMAN;
 			break;
+		case 'b':
+			unit = IPC_UNIT_BYTES;
+			break;
 		case 'h':
 			usage(stdout);
 		case 'V':
-- 
1.8.0.2

