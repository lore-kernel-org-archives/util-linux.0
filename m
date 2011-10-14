Return-Path: dave@gnu.org
Date: Fri, 14 Oct 2011 16:32:15 -0400
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH] lib/strutils: add default value to parse_range()
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1318624335.1923.14.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

This function currently sets the low or high values to 0 when the string doesn't
contain a value, like '123:' or ':123'. In order to make it more flexible, we allow it
to be passed an arbitrary value.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 include/strutils.h |    2 +-
 lib/strutils.c     |    7 ++++---
 partx/partx.c      |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/strutils.h b/include/strutils.h
index 28af8b5..9765a77 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -45,6 +45,6 @@ extern int string_to_idarray(const char *list, int ary[], size_t arysz,
 extern int string_to_bitarray(const char *list, char *ary,
 			    int (*name2bit)(const char *, size_t));
 
-extern int parse_range(const char *str, int *lower, int *upper);
+extern int parse_range(const char *str, int *lower, int *upper, int def);
 
 #endif
diff --git a/lib/strutils.c b/lib/strutils.c
index fb18229..6b2ec79 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -464,18 +464,19 @@ int string_to_bitarray(const char *list,
 /*
  * Parse the lower and higher values in a string containing
  * "lower:higher" or "lower-higher" format. Note that either
- * the lower or the higher values may be missing.
+ * the lower or the higher values may be missing, and the def
+ * value will be assigned to it by default.
  *
  * Returns: 0 on success, <0 on error.
  */
-int parse_range(const char *str, int *lower, int *upper)
+int parse_range(const char *str, int *lower, int *upper, int def)
 {
 	char *end = NULL;
 
 	if (!str)
 		return 0;
 
-	*upper = *lower = 0;
+	*upper = *lower = def;
 	errno = 0;
 
 	if (*str == ':') {				/* <:N> */
diff --git a/partx/partx.c b/partx/partx.c
index 2631d1f..bf18a4e 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -699,7 +699,7 @@ int main(int argc, char **argv)
 			what = ACT_LIST;
 			break;
 		case 'n':
-			if (parse_range(optarg, &lower, &upper))
+			if (parse_range(optarg, &lower, &upper, 0))
 				errx(EXIT_FAILURE, _("failed to parse --nr <M-N> range"));
 			break;
 		case 'o':
-- 
1.7.7
