Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54785 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105Ab1H3JrG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 30 Aug 2011 05:47:06 -0400
Date: Tue, 30 Aug 2011 11:47:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH v2] whereis: search in path
Message-ID: <20110830094702.GP1855@nb.net.home>
References: <1313171742.3305.3.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313171742.3305.3.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Aug 12, 2011 at 01:55:42PM -0400, Davidlohr Bueso wrote:
>  misc-utils/whereis.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 68 insertions(+), 1 deletions(-)

Applied, thanks. ...but:

     $ whereis -m git-rm-commit
     git-rm-commit: /home/kzak/bin/git-rm-commit

the -m means "man pages only", but the result is executable file.

I have fixed this problem, the $PATH is used for binaries only and
ignored if -B is specified. See below.

    Karel

>From 4ff826f68a7d9bd1239644ab53be9b81fc8b7a37 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Tue, 30 Aug 2011 11:44:15 +0200
Subject: [PATCH] whereis: search in path for binaries only

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 misc-utils/whereis.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 90f7b90..03ea95e 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -299,8 +299,6 @@ findv(char **dirv, int dirc, char *cp)
 
 	while (dirc > 0)
 		findin(*dirv++, cp), dirc--;
-	while (*dirp)
-		findin(*dirp++, cp);
 }
 
 static void
@@ -315,9 +313,11 @@ looksrc(char *cp)
 static void
 lookbin(char *cp)
 {
-	if (Bflag == 0)
+	if (Bflag == 0) {
 		findv(bindirs, ARRAY_SIZE(bindirs)-1, cp);
-	else
+		while (*dirp)
+			findin(*dirp++, cp);		/* look $PATH */
+	 } else
 		findv(Bflag, Bcnt, cp);
 }
 
@@ -424,8 +424,6 @@ main(int argc, char **argv)
 	if (argc == 0)
 		usage(stderr);
 
-	fillpath();
-
 	do
 		if (argv[0][0] == '-') {
 			register char *cp = argv[0] + 1;
@@ -475,8 +473,11 @@ main(int argc, char **argv)
 				usage(stderr);
 			}
 			argv++;
-		} else
+		} else {
+			if (Bcnt == 0 && pathdir == NULL)
+				fillpath();
 			lookup(*argv++);
+		}
 	while (--argc > 0);
 
 	freepath();
-- 
1.7.6

