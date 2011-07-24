Return-Path: dave@gnu.org
Subject: [PATCH] whereis: remove find()
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 24 Jul 2011 19:05:48 -0400
Message-ID: <1311548748.3367.14.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Sun, 24 Jul 2011 10:59:25 -0400

Because findv() can do the same job find() does, we can simply remove it and call findv() with the size of each array.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 misc-utils/whereis.c |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 4f841f9..a331f45 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -55,7 +55,6 @@ void looksrc(char *);
 void lookbin(char *);
 void lookman(char *);
 void findv(char **, int, char *);
-void find(char **, char *);
 void findin(char *, char *);
 int itsit(char *, char *);
 
@@ -321,7 +320,7 @@ void
 looksrc(char *cp)
 {
 	if (Sflag == 0)
-		find(srcdirs, cp);
+		findv(srcdirs, ARRAY_SIZE(srcdirs)-1, cp);
 	else
 		findv(Sflag, Scnt, cp);
 }
@@ -330,7 +329,7 @@ void
 lookbin(char *cp)
 {
 	if (Bflag == 0)
-		find(bindirs, cp);
+		findv(bindirs, ARRAY_SIZE(bindirs)-1, cp);
 	else
 		findv(Bflag, Bcnt, cp);
 }
@@ -339,7 +338,7 @@ void
 lookman(char *cp)
 {
 	if (Mflag == 0)
-		find(mandirs, cp);
+		findv(mandirs, ARRAY_SIZE(mandirs)-1, cp);
 	else
 		findv(Mflag, Mcnt, cp);
 }
@@ -352,13 +351,6 @@ findv(char **dirv, int dirc, char *cp)
 }
 
 void
-find(char **dirs, char *cp)
-{
-	while (*dirs)
-		findin(*dirs++, cp);
-}
-
-void
 findin(char *dir, char *cp)
 {
 	DIR *dirp;
-- 
1.7.4.1
