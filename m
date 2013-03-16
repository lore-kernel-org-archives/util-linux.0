Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f171.google.com ([74.125.82.171]:63433 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949Ab3CPXk3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Mar 2013 19:40:29 -0400
Received: by mail-we0-f171.google.com with SMTP id u54so4035466wey.30
        for <util-linux@vger.kernel.org>; Sat, 16 Mar 2013 16:40:28 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/7] whereis: add search scope listing option
Date: Sat, 16 Mar 2013 23:40:14 +0000
Message-Id: <1363477219-29245-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
References: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mostly useful when debugging why the command does, or does not, work.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/whereis.1 | 11 ++++++++++-
 misc-utils/whereis.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/misc-utils/whereis.1 b/misc-utils/whereis.1
index 86e6a39..9b33999 100644
--- a/misc-utils/whereis.1
+++ b/misc-utils/whereis.1
@@ -91,7 +91,16 @@ be used when any of the
 or
 .BR \-S
 options is used.
-
+.IP "\fB\-l"
+Output list of effective lookup paths the
+.B whereis
+is using.  When non of
+.BR \-B ,
+.BR \-M ,
+or
+.BR \-S
+is specified the option will out hard coded paths that the command was
+able to find on system.
 .SH EXAMPLE
 To find all files in
 .B /usr/bin
diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index eeec976..f579e29 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -167,6 +167,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		" -s         search only for sources\n"
 		" -S <dirs>  define sources lookup path\n"
 		" -u         search for unusual entries\n"
+		" -l         output effective lookup paths\n"
 		" -V         output version information and exit\n"
 		" -h         display this help and exit\n\n"), out);
 
@@ -387,6 +388,29 @@ static void lookup(char *argv, struct is_here *dirlist, int flags)
 	return;
 }
 
+static void list_search_dir(struct is_here *dirlist)
+{
+	while (dirlist) {
+		if (dirlist->path != NULL) {
+			switch (dirlist->type) {
+			case BIN_DIR:
+				printf("bin: ");
+				break;
+			case MAN_DIR:
+				printf("man: ");
+				break;
+			case SRC_DIR:
+				printf("src: ");
+				break;
+			default:
+				abort();
+			}
+			printf("%s\n", dirlist->path);
+		}
+		dirlist = dirlist->next;
+	}
+}
+
 int main(int argc, char **argv)
 {
 	struct is_here *dirlist;
@@ -456,6 +480,10 @@ int main(int argc, char **argv)
 						flags |= SRC_BIT;
 					continue;
 
+				case 'l':
+					list_search_dir(dirlist);
+					continue;
+
 				case 'V':
 					printf(UTIL_LINUX_VERSION);
 					return EXIT_SUCCESS;
-- 
1.8.2

