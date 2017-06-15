Return-Path: elseifthen@gmx.com
Subject: [PATCH 01/10] parse-date: replace ISDIGIT with c_isdigit
To: Karel Zak <kzak@redhat.com>
References: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ae61aa14-cf1f-4408-d91e-4de045a6c46f@gmx.com>
Date: Thu, 15 Jun 2017 19:37:20 -0400
MIME-Version: 1.0
In-Reply-To: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Reported-by: Ruediger Meier <ruediger.meier@ga-group.nl>
Influenced-by: gnulib 30784c4 Paul Eggert <eggert@cs.ucla.edu>
Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/parse-date.y | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/lib/parse-date.y b/lib/parse-date.y
index 75c8bb0..f4f9a10 100644
--- a/lib/parse-date.y
+++ b/lib/parse-date.y
@@ -93,17 +93,6 @@
 #endif
 
 /**
- * ISDIGIT differs from isdigit, as follows:
- * - Its arg may be any int or unsigned int; it need not be an unsigned char
- *   or EOF.
- * - It's typically faster.
- * POSIX says that only '0' through '9' are digits.  Prefer ISDIGIT to
- * isdigit unless it's important to use the locale's definition
- * of "digit" even when the host does not conform to POSIX.
- */
-#define ISDIGIT(c) ((unsigned int) (c) - '0' <= 9)
-
-/**
  * Shift A right by B bits portably, by dividing A by 2**B and
  * truncating towards minus infinity.  A and B should be free of side
  * effects, and B should be in the range 0 <= B <= INT_BITS - 2, where
@@ -1070,7 +1059,7 @@ static int yylex (union YYSTYPE *lvalp, parser_control *pc)
 		while (c = *pc->input, c_isspace (c))
 			pc->input++;
 
-		if (ISDIGIT (c) || c == '-' || c == '+') {
+		if (c_isdigit (c) || c == '-' || c == '+') {
 			char const *p;
 			int sign;
 			unsigned long int value;
@@ -1078,7 +1067,7 @@ static int yylex (union YYSTYPE *lvalp, parser_control *pc)
 				sign = c == '-' ? -1 : 1;
 				while (c = *++pc->input, c_isspace (c))
 					continue;
-				if (! ISDIGIT (c))
+				if (! c_isdigit (c))
 					/* skip the '-' sign */
 					continue;
 			} else
@@ -1090,12 +1079,12 @@ static int yylex (union YYSTYPE *lvalp, parser_control *pc)
 					return '?';
 				value = value1;
 				c = *++p;
-				if (! ISDIGIT (c))
+				if (! c_isdigit (c))
 					break;
 				if (ULONG_MAX / 10 < value)
 					return '?';
 			}
-			if ((c == '.' || c == ',') && ISDIGIT (p[1])) {
+			if ((c == '.' || c == ',') && c_isdigit (p[1])) {
 				time_t s;
 				int ns;
 				int digits;
@@ -1124,7 +1113,7 @@ static int yylex (union YYSTYPE *lvalp, parser_control *pc)
 				for (digits = 2;
 				     digits <= LOG10_BILLION; digits++) {
 					ns *= 10;
-					if (ISDIGIT (*p))
+					if (c_isdigit (*p))
 						ns += *p++ - '0';
 				}
 
@@ -1132,12 +1121,12 @@ static int yylex (union YYSTYPE *lvalp, parser_control *pc)
 				 * -Infinity.
 				 */
 				if (sign < 0)
-					for (; ISDIGIT (*p); p++)
+					for (; c_isdigit (*p); p++)
 						if (*p != '0') {
 							ns++;
 							break;
 						}
-				while (ISDIGIT (*p))
+				while (c_isdigit (*p))
 					p++;
 
 				/* Adjust to the timespec convention, which is
