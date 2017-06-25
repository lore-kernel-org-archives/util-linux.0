Return-Path: elseifthen@gmx.com
Subject: [PATCH 2/4] Docs: add a comment for constants to boilerplate.c
To: Karel Zak <kzak@redhat.com>
References: <e5059958-a9b9-2ff4-f1b8-6122520bacac@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <114eaa89-93f4-e878-5619-19baf7fbdd84@gmx.com>
Date: Sun, 25 Jun 2017 17:49:06 -0400
MIME-Version: 1.0
In-Reply-To: <e5059958-a9b9-2ff4-f1b8-6122520bacac@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Documentation/boilerplate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/boilerplate.c b/Documentation/boilerplate.c
index 5b2e59b..b70955d 100644
--- a/Documentation/boilerplate.c
+++ b/Documentation/boilerplate.c
@@ -29,6 +29,11 @@
 #include "closestream.h"
 #include "nls.h"
 
+/*
+ * FIXME: remove this comment.
+ * Other usage() constants that are not demonstrated below:
+ * USAGE_FUNCTIONS USAGE_COMMANDS USAGE_COLUMNS
+ */
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
@@ -37,9 +42,6 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
         fputs(USAGE_SEPARATOR, out);
         fputs(_("Short program description.\n"), out);
 
-	fputs(USAGE_FUNCTIONS, out);
-	fputs(_(" -s, --do-something      some specific task\n"), out);
-	fputs(_(" -o, --do-other          some different task\n"), out);
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -n, --no-argument       option does not use argument\n"), out);
 	fputs(_("     --optional[=<arg>]  option argument is optional\n"), out);
