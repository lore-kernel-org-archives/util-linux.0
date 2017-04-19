Return-Path: elseifthen@gmx.com
Subject: [PATCH 5/5] optutils.h: don't print non-graph characters
To: Karel Zak <kzak@redhat.com>
References: <7592945f-746d-7f67-192a-78dff67923d5@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <6ec461ac-79c9-ec72-4687-cb77db68bfbf@gmx.com>
Date: Tue, 18 Apr 2017 23:11:33 -0400
MIME-Version: 1.0
In-Reply-To: <7592945f-746d-7f67-192a-78dff67923d5@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


There is no eloquent way to exclude/include arch dependent arguments
from the ul_excl_t array. So when an arch dependent argument is left
undefined err_exclusive_options() was printing out-of-bounds values.
This commit cause them to be skipped instead.

err_exclusive_options() shouldn't be printing out-of-bounds values
in any case.

Also change the error massage from 'options' to 'arguments' as some
programs, like hwclock, distinguish between options and functions.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 include/optutils.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/optutils.h b/include/optutils.h
index 325cb88..0dc127b 100644
--- a/include/optutils.h
+++ b/include/optutils.h
@@ -5,6 +5,7 @@
 
 #include "c.h"
 #include "nls.h"
+#include "cctype.h"
 
 static inline const char *option_to_longopt(int c, const struct option *opts)
 {
@@ -81,8 +82,8 @@ static inline void err_exclusive_options(
 			else if (status[e] != c) {
 				size_t ct = 0;
 
-				fprintf(stderr, _("%s: these options are "
-						  "mutually exclusive:"),
+				fprintf(stderr, _("%s: mutually exclusive "
+						  "arguments:"),
 						program_invocation_short_name);
 
 				for (op = excl[e];
@@ -91,7 +92,7 @@ static inline void err_exclusive_options(
 					const char *n = option_to_longopt(*op, opts);
 					if (n)
 						fprintf(stderr, " --%s", n);
-					else
+					else if (c_isgraph(*op))
 						fprintf(stderr, " -%c", *op);
 				}
 				fputc('\n', stderr);
