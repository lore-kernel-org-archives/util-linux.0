Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33361 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbcEIV1x (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 May 2016 17:27:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so22518241wme.0
        for <util-linux@vger.kernel.org>; Mon, 09 May 2016 14:27:52 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 11/12] write: improve coding style
Date: Mon,  9 May 2016 22:27:27 +0100
Message-Id: <1462829248-6935-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index b10c129..e3e749e 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -76,7 +76,7 @@ struct write_control {
 	char dst_tty[PATH_MAX];
 };
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
@@ -199,11 +199,9 @@ static void search_utmp(struct write_control *ctl)
 			return;
 		}
 		errx(EXIT_FAILURE, _("%s has messages disabled"), ctl->dst_login);
-	} else if (valid_ttys > 1) {
+	} else if (valid_ttys > 1)
 		warnx(_("%s is logged in more than once; writing to %s"),
 		      ctl->dst_login, ctl->dst_tty);
-	}
-
 }
 
 /*
@@ -215,6 +213,15 @@ static void signal_handler(int signo)
 }
 
 /*
+ * PUTC - fputc_careful wrapper
+ */
+static inline void PUTC(char c)
+{
+	if (fputc_careful(c, stdout, '^') == EOF)
+		err(EXIT_FAILURE, _("carefulputc failed"));
+}
+
+/*
  * write_line - like fputs(), but makes control characters visible and
  *     turns \n into \r\n.
  */
@@ -222,8 +229,6 @@ static void write_line(char *s)
 {
 	char c;
 
-#define	PUTC(c)	if (fputc_careful(c, stdout, '^') == EOF) \
-    err(EXIT_FAILURE, _("carefulputc failed"));
 	while (*s) {
 		c = *s++;
 		if (c == '\n')
@@ -231,7 +236,6 @@ static void write_line(char *s)
 		PUTC(c);
 	}
 	return;
-#undef PUTC
 }
 
 /*
@@ -333,7 +337,6 @@ int main(int argc, char **argv)
 		if (!(ctl.src_tty = ttyname(src_fd)))
 			errx(EXIT_FAILURE,
 			     _("can't find your tty's name"));
-
 		/*
 		 * We may have /dev/ttyN but also /dev/pts/xx. Below,
 		 * check_tty() will put "/dev/" in front, so remove that
-- 
2.8.2

