Return-Path: dbueso@aomail.uab.es
Date: Tue, 11 Oct 2011 23:03:21 -0400
From: Davidlohr Bueso <dbueso@aomail.uab.es>
Subject: [PATCH] lib/strutils: share parse_range()
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1318388601.1923.4.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

This function is currently only being used by partx(8), but it's handy and generic enough that we can use it elsewhere as well.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 include/strutils.h |    2 ++
 lib/strutils.c     |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 partx/partx.c      |   35 -----------------------------------
 3 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/include/strutils.h b/include/strutils.h
index dbcc3d9..28af8b5 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -45,4 +45,6 @@ extern int string_to_idarray(const char *list, int ary[], size_t arysz,
 extern int string_to_bitarray(const char *list, char *ary,
 			    int (*name2bit)(const char *, size_t));
 
+extern int parse_range(const char *str, int *lower, int *upper);
+
 #endif
diff --git a/lib/strutils.c b/lib/strutils.c
index aad9f77..fc9ec68 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -424,7 +424,7 @@ int string_to_idarray(const char *list, int ary[], size_t arysz,
  * as a possition in the 'ary' bit array. It means that the 'id' has to be in
  * range <0..N> where N < sizeof(ary) * NBBY.
  *
- * Returns: 0 on sucess, <0 on error.
+ * Returns: 0 on success, <0 on error.
  */
 int string_to_bitarray(const char *list,
 		     char *ary,
@@ -461,6 +461,49 @@ int string_to_bitarray(const char *list,
 	return 0;
 }
 
+/*
+ * Parse the lower and higher values in a string containing 
+ * "lower:higher" or "lower-higher" format. Note that either
+ * the lower or the higher values may be missing.
+ *
+ * Returns: 0 on success, <0 on error.
+ */
+int parse_range(const char *str, int *lower, int *upper)
+{
+	char *end = NULL;
+
+	if (!str)
+		return 0;
+
+	*upper = *lower = 0;
+	errno = 0;
+
+	if (*str == ':') {				/* <:N> */
+		str++;
+		*upper = strtol(str, &end, 10);
+		if (errno || !end || *end || end == str)
+			return -1;
+	} else {
+		*upper = *lower = strtol(str, &end, 10);
+		if (errno || !end || end == str)
+			return -1;
+
+		if (*end == ':' && !*(end + 1))		/* <M:> */
+			*upper = 0;
+		else if (*end == '-' || *end == ':') {	/* <M:N> <M-N> */
+			str = end + 1;
+			end = NULL;
+			errno = 0;
+			*upper = strtol(str, &end, 10);
+
+			if (errno || !end || *end || end == str)
+				return -1;
+		}
+	}
+	return 0;
+}
+
+
 #ifdef TEST_PROGRAM
 
 int main(int argc, char *argv[])
diff --git a/partx/partx.c b/partx/partx.c
index 3a9da9e..2631d1f 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -558,41 +558,6 @@ done:
 	return rc;
 }
 
-static int parse_range(const char *str, int *lower, int *upper)
-{
-	char *end = NULL;
-
-	if (!str)
-		return 0;
-
-	*upper = *lower = 0;
-	errno = 0;
-
-	if (*str == ':') {				/* <:N> */
-		str++;
-		*upper = strtol(str, &end, 10);
-		if (errno || !end || *end || end == str)
-			return -1;
-	} else {
-		*upper = *lower = strtol(str, &end, 10);
-		if (errno || !end || end == str)
-			return -1;
-
-		if (*end == ':' && !*(end + 1))		/* <M:> */
-			*upper = 0;
-		else if (*end == '-' || *end == ':') {	/* <M:N> <M-N> */
-			str = end + 1;
-			end = NULL;
-			errno = 0;
-			*upper = strtol(str, &end, 10);
-
-			if (errno || !end || *end || end == str)
-				return -1;
-		}
-	}
-	return 0;
-}
-
 static blkid_partlist get_partlist(blkid_probe pr,
 			const char *device, char *type)
 {
-- 
1.7.7
