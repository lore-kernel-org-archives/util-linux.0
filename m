Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35864 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdHLIcQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 12 Aug 2017 04:32:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id d40so8769734wma.3
        for <util-linux@vger.kernel.org>; Sat, 12 Aug 2017 01:32:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] look: use WORDLIST environment variable to find word list
Date: Sat, 12 Aug 2017 09:32:08 +0100
Message-Id: <20170812083208.1208-2-kerolasa@iki.fi>
In-Reply-To: <20170812083208.1208-1-kerolasa@iki.fi>
References: <20170812083208.1208-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The WORDLIST is the same hunspell(1) and ispell(1) uses to achieve the same.
Apparently aspell(1) does not work with files like traditional dict lists.

Reference: https://github.com/hunspell/hunspell/blob/master/man/hunspell.1#L388
Reference: http://www.skrenta.com/rt/man/ispell.1.html
Reference: http://aspell.net/man-html/Creating-an-Individual-Word-List.html#Creating-an-Individual-Word-List
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/look.1 | 5 +++++
 misc-utils/look.c | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/misc-utils/look.1 b/misc-utils/look.1
index 503e38584..cca83416e 100644
--- a/misc-utils/look.1
+++ b/misc-utils/look.1
@@ -101,6 +101,11 @@ sort -d /etc/passwd -o /tmp/look.dict
 look -t: root:foobar /tmp/look.dict
 .nf
 .RE
+.SH ENVIRONMENT
+.TP
+.B WORDLIST
+Path to a dictionary file.  The environment variable has greater priority
+than the dictionary path defined in FILES segment.
 .SH FILES
 .IP "\fB/usr/share/dict/words\fR" 4
 the dictionary
diff --git a/misc-utils/look.c b/misc-utils/look.c
index 60fbbbfca..00061f2a3 100644
--- a/misc-utils/look.c
+++ b/misc-utils/look.c
@@ -104,7 +104,12 @@ main(int argc, char *argv[])
 
 	setlocale(LC_ALL, "");
 
-	file = _PATH_WORDS;
+	if ((file = getenv("WORDLIST"))) {
+		if (access(file, R_OK))
+			err(EXIT_FAILURE, "WORDLIST=%s", file);
+	} else
+		file = _PATH_WORDS;
+
 	termchar = '\0';
 	string = NULL;		/* just for gcc */
 
-- 
2.14.1

