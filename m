Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56879 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab2JHHIx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 03:08:53 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so3225349wib.1
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2012 00:08:52 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/14] pg: refactor argument handing
Date: Mon,  8 Oct 2012 08:08:10 +0100
Message-Id: <1349680100-18120-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
References: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add function parse_arguments(), which has the same code block that was in
over long, and too deeply intended, main().

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/pg.c | 159 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 84 insertions(+), 75 deletions(-)

diff --git a/text-utils/pg.c b/text-utils/pg.c
index c4a86ca..f9b6ac8 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -1581,12 +1581,91 @@ found_bw:
 		fclose(fbuf);
 }
 
+static int
+parse_arguments(int arg, int argc, char **argv)
+{
+	FILE *input;
+
+	files.first = arg;
+	files.last = arg + argc - 1;
+	for (; argv[arg]; arg += nextfile) {
+		nextfile = 1;
+		files.current = arg;
+		if (argc > 2) {
+			static int firsttime;
+			firsttime++;
+			if (firsttime > 1) {
+				mesg(_("(Next file: "));
+				mesg(argv[arg]);
+				mesg(")");
+ newfile:
+				if (ontty) {
+					prompt(-1);
+					switch (cmd.key) {
+					case 'n':
+						/*
+						 * Next file.
+						 */
+						if (cmd.count == 0)
+							cmd.count = 1;
+						nextfile = cmd.count;
+						if (checkf()) {
+							nextfile = 1;
+							mesg(":");
+							goto newfile;
+						}
+						continue;
+					case 'p':
+						/*
+						 * Previous file.
+						 */
+						if (cmd.count == 0)
+							cmd.count = 1;
+						nextfile = 0 - cmd.count;
+						if (checkf()) {
+							nextfile = 1;
+							mesg(":");
+							goto newfile;
+						}
+						continue;
+					case 'q':
+					case 'Q':
+						quit(exitstatus);
+					}
+				} else
+					mesg("\n");
+			}
+		}
+		if (strcmp(argv[arg], "-") == 0)
+			input = stdin;
+		else {
+			input = fopen(argv[arg], "r");
+			if (input == NULL) {
+				pgerror(errno, argv[arg]);
+				exitstatus++;
+				continue;
+			}
+		}
+		if (ontty == 0 && argc > 2) {
+			/*
+			 * Use the prefix as specified by SUSv2.
+			 */
+			write_all(1, "::::::::::::::\n", 15);
+			write_all(1, argv[arg], strlen(argv[arg]));
+			write_all(1, "\n::::::::::::::\n", 16);
+		}
+		pgfile(input, argv[arg]);
+		if (input != stdin)
+			fclose(input);
+	}
+	return exitstatus;
+}
+
 int
 main(int argc, char **argv)
 {
 	int arg, i;
 	char *p;
-	FILE *input;
 
 	progname = basename(argv[0]);
 	xasprintf(&copyright,
@@ -1703,81 +1782,11 @@ endargs:
 			invopt(argv[arg]);
 		}
 	}
-	if (argc == 1) {
+	if (argc == 1)
 		pgfile(stdin, "stdin");
-	} else {
-		files.first = arg;
-		files.last = arg + argc - 1;
-		for ( ; argv[arg]; arg += nextfile) {
-			nextfile = 1;
-			files.current = arg;
-			if (argc > 2) {
-				static int firsttime;
-				firsttime++;
-				if (firsttime > 1) {
-					mesg(_("(Next file: "));
-					mesg(argv[arg]);
-					mesg(")");
-newfile:
-					if (ontty) {
-					prompt(-1);
-					switch(cmd.key) {
-					case 'n':
-						/*
-					 	* Next file.
-					 	*/
-						if (cmd.count == 0)
-							cmd.count = 1;
-						nextfile = cmd.count;
-						if (checkf()) {
-							nextfile = 1;
-							mesg(":");
-							goto newfile;
-						}
-						continue;
-					case 'p':
-						/*
-					 	* Previous file.
-					 	*/
-						if (cmd.count == 0)
-							cmd.count = 1;
-						nextfile = 0 - cmd.count;
-						if (checkf()) {
-							nextfile = 1;
-							mesg(":");
-							goto newfile;
-						}
-						continue;
-					case 'q':
-					case 'Q':
-						quit(exitstatus);
-				}
-				} else mesg("\n");
-				}
-			}
-			if (strcmp(argv[arg], "-") == 0)
-				input = stdin;
-			else {
-				input = fopen(argv[arg], "r");
-				if (input == NULL) {
-					pgerror(errno, argv[arg]);
-					exitstatus++;
-					continue;
-				}
-			}
-			if (ontty == 0 && argc > 2) {
-				/*
-				 * Use the prefix as specified by SUSv2.
-				 */
-				write_all(1, "::::::::::::::\n", 15);
-				write_all(1, argv[arg], strlen(argv[arg]));
-				write_all(1, "\n::::::::::::::\n", 16);
-			}
-			pgfile(input, argv[arg]);
-			if (input != stdin)
-				fclose(input);
-		}
-	}
+	else
+		exitstatus = parse_arguments(arg, argc, argv);
+
 	quit(exitstatus);
 	/*NOTREACHED*/
 	return 0;
-- 
1.7.12.2

