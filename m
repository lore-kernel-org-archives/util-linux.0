Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:45081 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760943Ab3EBSwP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 May 2013 14:52:15 -0400
Received: by mail-wi0-f180.google.com with SMTP id h11so932484wiv.7
        for <util-linux@vger.kernel.org>; Thu, 02 May 2013 11:52:13 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/16] lib: copy argmatch from gnulib
Date: Thu,  2 May 2013 19:51:33 +0100
Message-Id: <1367520701-14962-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Both argmatch.h and argmatch.c are copied from gnulib.  Biggest
difference is that messaging does not use same quoting as the gnulib
does.  Other than that code is nearly untouched.

gnulib-commit: 92f3a4c8e52e64c233e260431d095dbf88554c14
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/Makemodule.am |   1 +
 include/argmatch.h    | 100 +++++++++++++++++++
 lib/Makemodule.am     |   1 +
 lib/argmatch.c        | 272 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 374 insertions(+)
 create mode 100644 include/argmatch.h
 create mode 100644 lib/argmatch.c

diff --git a/include/Makemodule.am b/include/Makemodule.am
index 7ba4593..f27d67e 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -1,6 +1,7 @@
 
 dist_noinst_HEADERS += \
 	include/all-io.h \
+	include/argmatch.h \
 	include/at.h \
 	include/bitops.h \
 	include/blkdev.h \
diff --git a/include/argmatch.h b/include/argmatch.h
new file mode 100644
index 0000000..57dcb6d
--- /dev/null
+++ b/include/argmatch.h
@@ -0,0 +1,100 @@
+/* argmatch.h -- definitions and prototypes for argmatch.c
+
+   Copyright (C) 1990, 1998-1999, 2001-2002, 2004-2005, 2009-2013 Free Software
+   Foundation, Inc.
+
+   This program is free software: you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 3 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
+
+/* Written by David MacKenzie <djm@ai.mit.edu>
+   Modified by Akim Demaille <demaille@inf.enst.fr> */
+
+#ifndef ARGMATCH_H_
+# define ARGMATCH_H_ 1
+
+# include <stddef.h>
+
+# define ARRAY_CARDINALITY(Array) (sizeof (Array) / sizeof *(Array))
+
+/* Assert there are as many real arguments as there are values
+   (argument list ends with a NULL guard).  */
+
+# define ARGMATCH_VERIFY(Arglist, Vallist) \
+    verify (ARRAY_CARDINALITY (Arglist) == ARRAY_CARDINALITY (Vallist) + 1)
+
+/* Return the index of the element of ARGLIST (NULL terminated) that
+   matches with ARG.  If VALLIST is not NULL, then use it to resolve
+   false ambiguities (i.e., different matches of ARG but corresponding
+   to the same values in VALLIST).  */
+
+ptrdiff_t argmatch (char const *arg, char const *const *arglist,
+                    char const *vallist, size_t valsize);
+
+# define ARGMATCH(Arg, Arglist, Vallist) \
+  argmatch (Arg, Arglist, (char const *) (Vallist), sizeof *(Vallist))
+
+/* xargmatch calls this function when it fails.  This function should not
+   return.  By default, this is a function that calls ARGMATCH_DIE which
+   in turn defaults to 'exit (exit_failure)'.  */
+typedef void (*argmatch_exit_fn) (void);
+extern argmatch_exit_fn argmatch_die;
+
+/* Report on stderr why argmatch failed.  Report correct values. */
+
+void argmatch_invalid (char const *context, char const *value,
+                       ptrdiff_t problem);
+
+/* Left for compatibility with the old name invalid_arg */
+
+# define invalid_arg(Context, Value, Problem) \
+  argmatch_invalid (Context, Value, Problem)
+
+
+
+/* Report on stderr the list of possible arguments.  */
+
+void argmatch_valid (char const *const *arglist,
+                     char const *vallist, size_t valsize);
+
+# define ARGMATCH_VALID(Arglist, Vallist) \
+  argmatch_valid (Arglist, (char const *) (Vallist), sizeof *(Vallist))
+
+
+
+/* Same as argmatch, but upon failure, report an explanation of the
+   failure, and exit using the function EXIT_FN. */
+
+ptrdiff_t __xargmatch_internal (char const *context,
+                                char const *arg, char const *const *arglist,
+                                char const *vallist, size_t valsize,
+                                argmatch_exit_fn exit_fn);
+
+/* Programmer friendly interface to __xargmatch_internal. */
+
+# define XARGMATCH(Context, Arg, Arglist, Vallist)              \
+  ((Vallist) [__xargmatch_internal (Context, Arg, Arglist,      \
+                                    (char const *) (Vallist),   \
+                                    sizeof *(Vallist),          \
+                                    argmatch_die)])
+
+/* Convert a value into a corresponding argument. */
+
+char const *argmatch_to_argument (char const *value,
+                                  char const *const *arglist,
+                                  char const *vallist, size_t valsize);
+
+# define ARGMATCH_TO_ARGUMENT(Value, Arglist, Vallist)                  \
+  argmatch_to_argument (Value, Arglist,                                 \
+                        (char const *) (Vallist), sizeof *(Vallist))
+
+#endif /* ARGMATCH_H_ */
diff --git a/lib/Makemodule.am b/lib/Makemodule.am
index afc2156..6757cb9 100644
--- a/lib/Makemodule.am
+++ b/lib/Makemodule.am
@@ -2,6 +2,7 @@
 noinst_LTLIBRARIES += libcommon.la
 libcommon_la_CFLAGS = $(AM_CFLAGS)
 libcommon_la_SOURCES = \
+	lib/argmatch.c \
 	lib/at.c \
 	lib/blkdev.c \
 	lib/canonicalize.c \
diff --git a/lib/argmatch.c b/lib/argmatch.c
new file mode 100644
index 0000000..58ce5e1
--- /dev/null
+++ b/lib/argmatch.c
@@ -0,0 +1,272 @@
+/* argmatch.c -- find a match for a string in an array
+
+   Copyright (C) 1990, 1998-1999, 2001-2007, 2009-2013 Free Software
+   Foundation, Inc.
+
+   This program is free software: you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 3 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
+
+/* Written by David MacKenzie <djm@ai.mit.edu>
+   Modified by Akim Demaille <demaille@inf.enst.fr> */
+
+#include <config.h>
+
+/* Specification.  */
+#include "argmatch.h"
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "nls.h"
+
+#include "error.h"
+
+#if USE_UNLOCKED_IO
+# include "unlocked-io.h"
+#endif
+
+/* When reporting an invalid argument, show nonprinting characters
+   by using the quoting style ARGMATCH_QUOTING_STYLE.  Do not use
+   literal_quoting_style.  */
+#ifndef ARGMATCH_QUOTING_STYLE
+# define ARGMATCH_QUOTING_STYLE locale_quoting_style
+#endif
+
+/* Non failing version of argmatch call this function after failing. */
+#ifndef ARGMATCH_DIE
+# define ARGMATCH_DIE exit (EXIT_FAILURE)
+#endif
+
+#ifdef ARGMATCH_DIE_DECL
+ARGMATCH_DIE_DECL;
+#endif
+
+static void
+__argmatch_die (void)
+{
+  ARGMATCH_DIE;
+}
+
+/* Used by XARGMATCH and XARGCASEMATCH.  See description in argmatch.h.
+   Default to __argmatch_die, but allow caller to change this at run-time. */
+argmatch_exit_fn argmatch_die = __argmatch_die;
+
+
+/* If ARG is an unambiguous match for an element of the
+   NULL-terminated array ARGLIST, return the index in ARGLIST
+   of the matched element, else -1 if it does not match any element
+   or -2 if it is ambiguous (is a prefix of more than one element).
+
+   If VALLIST is none null, use it to resolve ambiguities limited to
+   synonyms, i.e., for
+     "yes", "yop" -> 0
+     "no", "nope" -> 1
+   "y" is a valid argument, for 0, and "n" for 1.  */
+
+ptrdiff_t
+argmatch (const char *arg, const char *const *arglist,
+          const char *vallist, size_t valsize)
+{
+  size_t i;                     /* Temporary index in ARGLIST.  */
+  size_t arglen;                /* Length of ARG.  */
+  ptrdiff_t matchind = -1;      /* Index of first nonexact match.  */
+  bool ambiguous = false;       /* If true, multiple nonexact match(es).  */
+
+  arglen = strlen (arg);
+
+  /* Test all elements for either exact match or abbreviated matches.  */
+  for (i = 0; arglist[i]; i++)
+    {
+      if (!strncmp (arglist[i], arg, arglen))
+        {
+          if (strlen (arglist[i]) == arglen)
+            /* Exact match found.  */
+            return i;
+          else if (matchind == -1)
+            /* First nonexact match found.  */
+            matchind = i;
+          else
+            {
+              /* Second nonexact match found.  */
+              if (vallist == NULL
+                  || memcmp (vallist + valsize * matchind,
+                             vallist + valsize * i, valsize))
+                {
+                  /* There is a real ambiguity, or we could not
+                     disambiguate. */
+                  ambiguous = true;
+                }
+            }
+        }
+    }
+  if (ambiguous)
+    return -2;
+  else
+    return matchind;
+}
+
+/* Error reporting for argmatch.
+   CONTEXT is a description of the type of entity that was being matched.
+   VALUE is the invalid value that was given.
+   PROBLEM is the return value from argmatch.  */
+
+void
+argmatch_invalid (const char *context, const char *value, ptrdiff_t problem)
+{
+  char const *format = (problem == -1
+                        ? _("invalid argument %s for %s")
+                        : _("ambiguous argument %s for %s"));
+
+  error (0, 0, format, value, context);
+}
+
+/* List the valid arguments for argmatch.
+   ARGLIST is the same as in argmatch.
+   VALLIST is a pointer to an array of values.
+   VALSIZE is the size of the elements of VALLIST */
+void
+argmatch_valid (const char *const *arglist,
+                const char *vallist, size_t valsize)
+{
+  size_t i;
+  const char *last_val = NULL;
+
+  /* We try to put synonyms on the same line.  The assumption is that
+     synonyms follow each other */
+  fputs (_("Valid arguments are:"), stderr);
+  for (i = 0; arglist[i]; i++)
+    if ((i == 0)
+        || memcmp (last_val, vallist + valsize * i, valsize))
+      {
+        fprintf (stderr, "\n  - %s", arglist[i]);
+        last_val = vallist + valsize * i;
+      }
+    else
+      {
+        fprintf (stderr, ", %s", arglist[i]);
+      }
+  putc ('\n', stderr);
+}
+
+/* Never failing versions of the previous functions.
+
+   CONTEXT is the context for which argmatch is called (e.g.,
+   "--version-control", or "$VERSION_CONTROL" etc.).  Upon failure,
+   calls the (supposed never to return) function EXIT_FN. */
+
+ptrdiff_t
+__xargmatch_internal (const char *context,
+                      const char *arg, const char *const *arglist,
+                      const char *vallist, size_t valsize,
+                      argmatch_exit_fn exit_fn)
+{
+  ptrdiff_t res = argmatch (arg, arglist, vallist, valsize);
+  if (res >= 0)
+    /* Success. */
+    return res;
+
+  /* We failed.  Explain why. */
+  argmatch_invalid (context, arg, res);
+  argmatch_valid (arglist, vallist, valsize);
+  (*exit_fn) ();
+
+  return -1; /* To please the compilers. */
+}
+
+/* Look for VALUE in VALLIST, an array of objects of size VALSIZE and
+   return the first corresponding argument in ARGLIST */
+const char *
+argmatch_to_argument (const char *value,
+                      const char *const *arglist,
+                      const char *vallist, size_t valsize)
+{
+  size_t i;
+
+  for (i = 0; arglist[i]; i++)
+    if (!memcmp (value, vallist + valsize * i, valsize))
+      return arglist[i];
+  return NULL;
+}
+
+#ifdef TEST
+/*
+ * Based on "getversion.c" by David MacKenzie <djm@gnu.ai.mit.edu>
+ */
+char *program_name;
+
+/* When to make backup files.  */
+enum backup_type
+{
+  /* Never make backups.  */
+  no_backups,
+
+  /* Make simple backups of every file.  */
+  simple_backups,
+
+  /* Make numbered backups of files that already have numbered backups,
+     and simple backups of the others.  */
+  numbered_existing_backups,
+
+  /* Make numbered backups of every file.  */
+  numbered_backups
+};
+
+/* Two tables describing arguments (keys) and their corresponding
+   values */
+static const char *const backup_args[] =
+{
+  "no", "none", "off",
+  "simple", "never",
+  "existing", "nil",
+  "numbered", "t",
+  0
+};
+
+static const enum backup_type backup_vals[] =
+{
+  no_backups, no_backups, no_backups,
+  simple_backups, simple_backups,
+  numbered_existing_backups, numbered_existing_backups,
+  numbered_backups, numbered_backups
+};
+
+int
+main (int argc, const char *const *argv)
+{
+  const char *cp;
+  enum backup_type backup_type = no_backups;
+
+  program_name = (char *) argv[0];
+
+  if (argc > 2)
+    {
+      fprintf (stderr, "Usage: %s [VERSION_CONTROL]\n", program_name);
+      exit (1);
+    }
+
+  if ((cp = getenv ("VERSION_CONTROL")))
+    backup_type = XARGMATCH ("$VERSION_CONTROL", cp,
+                             backup_args, backup_vals);
+
+  if (argc == 2)
+    backup_type = XARGMATCH (program_name, argv[1],
+                             backup_args, backup_vals);
+
+  printf ("The version control is '%s'\n",
+          ARGMATCH_TO_ARGUMENT (backup_type, backup_args, backup_vals));
+
+  return 0;
+}
+#endif
-- 
1.8.2.2

