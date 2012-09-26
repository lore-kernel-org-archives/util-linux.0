Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4914 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016Ab2IZVye (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Sep 2012 17:54:34 -0400
From: =?UTF-8?q?P=C3=A1draig=20Brady?= <P@draigBrady.com>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?P=C3=A1draig=20Brady?= <P@draigBrady.com>
Subject: [PATCH] column: clarify the --separator option
Date: Wed, 26 Sep 2012 22:20:07 +0100
Message-Id: <1348694407-28676-1-git-send-email-P@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Indicate that the string is a set,
which also clarifies that it's only
significant when parsing the input.
---
 text-utils/column.1 |    4 ++--
 text-utils/column.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/text-utils/column.1 b/text-utils/column.1
index 2050666..8a461a8 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -52,8 +52,8 @@ Output is formatted to a width specified as number of characters.
 Determine the number of columns the input contains and create a table.
 Columns are delimited with whitespace, by default, or with the characters
 supplied using the separator. Table output is useful for pretty-printing.
-.IP "\fB\-s, \-\-separator\fP \fIseparator\fP"
-Specify table separator (default is whitespace).
+.IP "\fB\-s, \-\-separator\fP \fIseparators\fP"
+Specify possible table delimiters (default is whitespace).
 .IP "\fB\-x, \-\-fillrows\fP"
 Fill columns before filling rows.
 .IP "\fB\-h, \-\-help\fP"
diff --git a/text-utils/column.c b/text-utils/column.c
index 61668fd..137c9a6 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -96,7 +96,7 @@ static void __attribute__((__noreturn__)) usage(int rc)
 	" -V, --version            output version information and exit\n"
 	" -c, --columns <width>    width of output in number of characters\n"
 	" -t, --table              create a table\n"
-	" -s, --separator <string> table delimiter\n"
+	" -s, --separator <string> possible table delimiters\n"
 	" -x, --fillrows           fill rows before columns\n"));
 
 	fprintf(out, _("\nFor more information see column(1).\n"));
-- 
1.7.6.4

