Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Thu, 29 Aug 2013 19:02:51 +0100
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/17] lib/time-util: copy time parsing functions from
 systemd
Message-ID: <20130829180250.GB28314@gmail.com>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
 <1377626779-26030-10-git-send-email-kerolasa@iki.fi>
 <20130829101127.GD24438@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130829101127.GD24438@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 29, 2013 at 12:11:27PM +0200, Karel Zak wrote:
> On Tue, Aug 27, 2013 at 07:06:12PM +0100, Sami Kerola wrote:
> > +static char *startswith(const char *s, const char *prefix)
> > +static char *startswith_no_case(const char *s, const char *prefix)
> > +static char *endswith(const char *s, const char *postfix)
> 
>  We already have startswith() and endswith() in libmount/src/utils.c.
> 
>  What about to move the code to lib/strutils.c (together with
>  *_no_case() versions)?

I hope the following is roughly what you where thinking.



>From a1969bc9f9d08b05c2fa6f750388cfdf6033fc1a Mon Sep 17 00:00:00 2001
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 29 Aug 2013 15:50:17 +0100
Subject: [PATCH 11/26] lib/strutils: move *swith() functions to private
 library
Organization: Lastminute.com

Avoid code dublication in libmount and time-util.

Proposed-by: Karel Zak <kzak@redhat.com>
Reference: http://markmail.org/message/h7zexvqsieqngtmx
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/strutils.h           |  4 +++
 lib/strutils.c               | 67 ++++++++++++++++++++++++++++++++++++++++++++
 lib/time-util.c              | 58 --------------------------------------
 libmount/src/context_mount.c |  1 +
 libmount/src/mountP.h        |  5 ----
 libmount/src/optmap.c        |  1 +
 libmount/src/utils.c         | 31 --------------------
 7 files changed, 73 insertions(+), 94 deletions(-)

diff --git a/include/strutils.h b/include/strutils.h
index 709fcad..8d8a6e4 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -102,4 +102,8 @@ extern int parse_range(const char *str, int *lower, int *upper, int def);
 
 extern int streq_except_trailing_slash(const char *s1, const char *s2);
 
+extern char *startswith(const char *s, const char *prefix);
+extern char *startswith_no_case(const char *s, const char *prefix);
+extern char *endswith(const char *s, const char *postfix);
+
 #endif
diff --git a/lib/strutils.c b/lib/strutils.c
index c263b86..95ab5a8 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <sys/stat.h>
 #include <string.h>
+#include <assert.h>
 
 #include "c.h"
 #include "nls.h"
@@ -685,6 +686,72 @@ int streq_except_trailing_slash(const char *s1, const char *s2)
 	return equal;
 }
 
+/*
+ * Match string beginning.
+ */
+char *startswith(const char *s, const char *prefix)
+{
+	const char *a, *b;
+
+	assert(s);
+	assert(prefix);
+
+	a = s, b = prefix;
+	for (;;) {
+		if (*b == 0)
+			return (char *)a;
+		if (*a != *b)
+			return NULL;
+
+		a++, b++;
+	}
+}
+
+/*
+ * Case insensitive match string beginning.
+ */
+char *startswith_no_case(const char *s, const char *prefix)
+{
+	const char *a, *b;
+
+	assert(s);
+	assert(prefix);
+
+	a = s, b = prefix;
+	for (;;) {
+		if (*b == 0)
+			return (char *)a;
+		if (tolower(*a) != tolower(*b))
+			return NULL;
+
+		a++, b++;
+	}
+}
+
+/*
+ * Match string ending.
+ */
+char *endswith(const char *s, const char *postfix)
+{
+	size_t sl, pl;
+
+	assert(s);
+	assert(postfix);
+
+	sl = strlen(s);
+	pl = strlen(postfix);
+
+	if (pl == 0)
+		return (char *)s + sl;
+
+	if (sl < pl)
+		return NULL;
+
+	if (memcmp(s + sl - pl, postfix, pl) != 0)
+		return NULL;
+
+	return (char *)s + sl - pl;
+}
 
 #ifdef TEST_PROGRAM
 
diff --git a/lib/time-util.c b/lib/time-util.c
index c8fcc2a..a0b27bf 100644
--- a/lib/time-util.c
+++ b/lib/time-util.c
@@ -30,64 +30,6 @@
 
 #define streq(a,b) (strcmp((a),(b)) == 0)
 
-static char *startswith(const char *s, const char *prefix)
-{
-	const char *a, *b;
-
-	assert(s);
-	assert(prefix);
-
-	a = s, b = prefix;
-	for (;;) {
-		if (*b == 0)
-			return (char *)a;
-		if (*a != *b)
-			return NULL;
-
-		a++, b++;
-	}
-}
-
-static char *startswith_no_case(const char *s, const char *prefix)
-{
-	const char *a, *b;
-
-	assert(s);
-	assert(prefix);
-
-	a = s, b = prefix;
-	for (;;) {
-		if (*b == 0)
-			return (char *)a;
-		if (tolower(*a) != tolower(*b))
-			return NULL;
-
-		a++, b++;
-	}
-}
-
-static char *endswith(const char *s, const char *postfix)
-{
-	size_t sl, pl;
-
-	assert(s);
-	assert(postfix);
-
-	sl = strlen(s);
-	pl = strlen(postfix);
-
-	if (pl == 0)
-		return (char *)s + sl;
-
-	if (sl < pl)
-		return NULL;
-
-	if (memcmp(s + sl - pl, postfix, pl) != 0)
-		return NULL;
-
-	return (char *)s + sl - pl;
-}
-
 static int parse_sec(const char *t, usec_t *usec)
 {
 	 static const struct {
diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 94db1ac..4f376e4 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -21,6 +21,7 @@
 
 #include "linux_version.h"
 #include "mountP.h"
+#include "strutils.h"
 
 /*
  * Kernel supports only one MS_PROPAGATION flag change by one mount(2) syscall,
diff --git a/libmount/src/mountP.h b/libmount/src/mountP.h
index 9e6f4bd..9362c00 100644
--- a/libmount/src/mountP.h
+++ b/libmount/src/mountP.h
@@ -137,11 +137,6 @@ extern int mnt_run_test(struct libmnt_test *tests, int argc, char *argv[]);
 #endif
 
 /* utils.c */
-extern int endswith(const char *s, const char *sx)
-			__attribute__((nonnull));
-extern int startswith(const char *s, const char *sx)
-			__attribute__((nonnull));
-
 extern char *stripoff_last_component(char *path);
 
 extern int mnt_valid_tagname(const char *tagname);
diff --git a/libmount/src/optmap.c b/libmount/src/optmap.c
index 504a5cf..5b25b8f 100644
--- a/libmount/src/optmap.c
+++ b/libmount/src/optmap.c
@@ -58,6 +58,7 @@
  * mount/mount.h.
  */
 #include "mountP.h"
+#include "strutils.h"
 
 /*
  * fs-independent mount flags (built-in MNT_LINUX_MAP)
diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index 4e6a131..9f99241 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -23,37 +23,6 @@
 #include "env.h"
 #include "match.h"
 
-int endswith(const char *s, const char *sx)
-{
-	ssize_t off;
-
-	assert(s);
-	assert(sx);
-
-	off = strlen(s);
-	if (!off)
-		return 0;
-	off -= strlen(sx);
-	if (off < 0)
-		return 0;
-
-        return !strcmp(s + off, sx);
-}
-
-int startswith(const char *s, const char *sx)
-{
-	size_t off;
-
-	assert(s);
-	assert(sx);
-
-	off = strlen(sx);
-	if (!off)
-		return 0;
-
-        return !strncmp(s, sx, off);
-}
-
 int append_string(char **a, const char *b)
 {
 	size_t al, bl;
-- 
1.8.4




-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
