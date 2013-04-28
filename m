Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42417 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab3D1RLe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Apr 2013 13:11:34 -0400
Received: by mail-wi0-f172.google.com with SMTP id hm14so2054485wib.5
        for <util-linux@vger.kernel.org>; Sun, 28 Apr 2013 10:11:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/11] cal: allow day highlight testing
Date: Sun, 28 Apr 2013 18:11:04 +0100
Message-Id: <1367169067-23705-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Requires similar trick as done with more to by pass check whether a
session is or isn't interactive.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/Makemodule.am | 8 ++++++++
 misc-utils/cal.c         | 6 ++++++
 tests/commands.sh        | 2 +-
 tests/expected/cal/1m    | 8 ++++----
 tests/expected/cal/3m    | 8 ++++----
 tests/expected/cal/year  | 8 ++++----
 6 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index a615047..dcd55bf 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -12,14 +12,22 @@ endif
 
 cal_LDADD = $(LDADD)
 
+check_PROGRAMS += test_cal
+test_cal_SOURCES = $(cal_SOURCES)
+test_cal_CFLAGS = -DTEST_CAL_PROGRAM
+test_cal_LDADD = $(LDADD)
+
 if HAVE_TINFO
 cal_LDADD += -ltinfo @NCURSES_LIBS@
+test_cal_LDADD += -ltinfo @NCURSES_LIBS@
 else
 if HAVE_NCURSES
 cal_LDADD += @NCURSES_LIBS@
+test_cal_LDADD += @NCURSES_LIBS@
 else
 if HAVE_TERMCAP
 cal_LDADD += -ltermcap
+test_cal_LDADD += -ltermcap
 endif
 endif # !HAVE_NCURSES
 endif # !HAVE_TINFO
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index a7fd423..949f003 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -72,6 +72,10 @@
 #include "mbsalign.h"
 #include "strutils.h"
 
+#ifdef TEST_CAL_PROGRAM
+# define NON_INTERACTIVE_MORE 1
+#endif
+
 #if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW)
 # ifdef HAVE_NCURSES_H
 #  include <ncurses.h>
@@ -392,8 +396,10 @@ main(int argc, char **argv) {
 	}
 	headers_init(julian);
 
+#ifndef NON_INTERACTIVE_MORE
 	if (!isatty(STDOUT_FILENO))
 		day = 0; /* don't highlight */
+#endif
 
 	if (yflag)
 		yearly(day, year, julian);
diff --git a/tests/commands.sh b/tests/commands.sh
index d12c009..7848b10 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -25,7 +25,7 @@ TS_HELPER_SYSINFO="$top_builddir/test_sysinfo"
 TS_CMD_ADDPART=${TS_CMD_ADDPART:-"$top_builddir/addpart"}
 TS_CMD_DELPART=${TS_CMD_DELPART:-"$top_builddir/delpart"}
 TS_CMD_BLKID=${TS_CMD_BLKID-"$top_builddir/blkid"}
-TS_CMD_CAL=${TS_CMD_CAL-"$top_builddir/cal"}
+TS_CMD_CAL=${TS_CMD_CAL-"$top_builddir/test_cal"}
 TS_CMD_COLRM=${TS_CMD_COLRM:-"$top_builddir/colrm"}
 TS_CMD_COL=${TS_CMD_COL:-"$top_builddir/col"}
 TS_CMD_COLUMN=${TS_CMD_COLUMN:-"$top_builddir/column"}
diff --git a/tests/expected/cal/1m b/tests/expected/cal/1m
index f657875..1d95643 100644
--- a/tests/expected/cal/1m
+++ b/tests/expected/cal/1m
@@ -6,7 +6,7 @@ Mo Tu We Th Fr Sa Su
  4  5  6  7  8  9 10
 11 12 13 14 15 16 17
 18 19 20 21 22 23 24
-25 26 27 28 29 30
+25 26 [7m27[27m 28 29 30
 
 Gregorian - Sunday-based week
    September 2006   
@@ -15,7 +15,7 @@ Su Mo Tu We Th Fr Sa
  3  4  5  6  7  8  9
 10 11 12 13 14 15 16
 17 18 19 20 21 22 23
-24 25 26 27 28 29 30
+24 25 26 [7m27[27m 28 29 30
 
 Julian - Monday-based week
        September 2006      
@@ -24,7 +24,7 @@ Mon Tue Wed Thu Fri Sat Sun
 247 248 249 250 251 252 253
 254 255 256 257 258 259 260
 261 262 263 264 265 266 267
-268 269 270 271 272 273
+268 269 [7m270[27m 271 272 273
 
 Julian - Sunday-based week
        September 2006      
@@ -33,5 +33,5 @@ Sun Mon Tue Wed Thu Fri Sat
 246 247 248 249 250 251 252
 253 254 255 256 257 258 259
 260 261 262 263 264 265 266
-267 268 269 270 271 272 273
+267 268 269 [7m270[27m 271 272 273
 
diff --git a/tests/expected/cal/3m b/tests/expected/cal/3m
index ba9657d..724d521 100644
--- a/tests/expected/cal/3m
+++ b/tests/expected/cal/3m
@@ -6,7 +6,7 @@ Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su
  7  8  9 10 11 12 13   4  5  6  7  8  9 10   2  3  4  5  6  7  8
 14 15 16 17 18 19 20  11 12 13 14 15 16 17   9 10 11 12 13 14 15
 21 22 23 24 25 26 27  18 19 20 21 22 23 24  16 17 18 19 20 21 22
-28 29 30 31           25 26 27 28 29 30     23 24 25 26 27 28 29
+28 29 30 31           25 26 [7m27[27m 28 29 30     23 24 25 26 27 28 29
                                             30 31               
 Gregorian - Sunday-based week
      August 2006         September 2006         October 2006    
@@ -15,7 +15,7 @@ Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
  6  7  8  9 10 11 12   3  4  5  6  7  8  9   8  9 10 11 12 13 14
 13 14 15 16 17 18 19  10 11 12 13 14 15 16  15 16 17 18 19 20 21
 20 21 22 23 24 25 26  17 18 19 20 21 22 23  22 23 24 25 26 27 28
-27 28 29 30 31        24 25 26 27 28 29 30  29 30 31            
+27 28 29 30 31        24 25 26 [7m27[27m 28 29 30  29 30 31            
                                                                 
 Julian - Monday-based week
         August 2006                 September 2006                October 2006       
@@ -24,7 +24,7 @@ Mon Tue Wed Thu Fri Sat Sun  Mon Tue Wed Thu Fri Sat Sun  Mon Tue Wed Thu Fri Sa
 219 220 221 222 223 224 225  247 248 249 250 251 252 253  275 276 277 278 279 280 281
 226 227 228 229 230 231 232  254 255 256 257 258 259 260  282 283 284 285 286 287 288
 233 234 235 236 237 238 239  261 262 263 264 265 266 267  289 290 291 292 293 294 295
-240 241 242 243              268 269 270 271 272 273      296 297 298 299 300 301 302
+240 241 242 243              268 269 [7m270[27m 271 272 273      296 297 298 299 300 301 302
                                                           303 304                    
 Julian - Sunday-based week
         August 2006                 September 2006                October 2006       
@@ -33,5 +33,5 @@ Sun Mon Tue Wed Thu Fri Sat  Sun Mon Tue Wed Thu Fri Sat  Sun Mon Tue Wed Thu Fr
 218 219 220 221 222 223 224  246 247 248 249 250 251 252  281 282 283 284 285 286 287
 225 226 227 228 229 230 231  253 254 255 256 257 258 259  288 289 290 291 292 293 294
 232 233 234 235 236 237 238  260 261 262 263 264 265 266  295 296 297 298 299 300 301
-239 240 241 242 243          267 268 269 270 271 272 273  302 303 304                
+239 240 241 242 243          267 268 269 [7m270[27m 271 272 273  302 303 304                
                                                                                      
diff --git a/tests/expected/cal/year b/tests/expected/cal/year
index 616d61a..a79589d 100644
--- a/tests/expected/cal/year
+++ b/tests/expected/cal/year
@@ -32,7 +32,7 @@ Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su
  2  3  4  5  6  7  8    6  7  8  9 10 11 12    4  5  6  7  8  9 10
  9 10 11 12 13 14 15   13 14 15 16 17 18 19   11 12 13 14 15 16 17
 16 17 18 19 20 21 22   20 21 22 23 24 25 26   18 19 20 21 22 23 24
-23 24 25 26 27 28 29   27 28 29 30            25 26 27 28 29 30 31
+23 24 25 26 27 28 29   27 28 [7m29[27m 30            25 26 27 28 29 30 31
 30 31
 
 Gregorian - Sunday-based week
@@ -68,7 +68,7 @@ Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
  8  9 10 11 12 13 14    5  6  7  8  9 10 11    3  4  5  6  7  8  9
 15 16 17 18 19 20 21   12 13 14 15 16 17 18   10 11 12 13 14 15 16
 22 23 24 25 26 27 28   19 20 21 22 23 24 25   17 18 19 20 21 22 23
-29 30 31               26 27 28 29 30         24 25 26 27 28 29 30
+29 30 31               26 27 28 [7m29[27m 30         24 25 26 27 28 29 30
                                               31
 
 Julian - Monday-based week
@@ -120,7 +120,7 @@ Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun
 310 311 312 313 314 315 316   338 339 340 341 342 343 344
 317 318 319 320 321 322 323   345 346 347 348 349 350 351
 324 325 326 327 328 329 330   352 353 354 355 356 357 358
-331 332 333 334               359 360 361 362 363 364 365
+331 332 [7m333[27m 334               359 360 361 362 363 364 365
 
 
 Julian - Sunday-based week
@@ -172,6 +172,6 @@ Sun Mon Tue Wed Thu Fri Sat   Sun Mon Tue Wed Thu Fri Sat
 309 310 311 312 313 314 315   337 338 339 340 341 342 343
 316 317 318 319 320 321 322   344 345 346 347 348 349 350
 323 324 325 326 327 328 329   351 352 353 354 355 356 357
-330 331 332 333 334           358 359 360 361 362 363 364
+330 331 332 [7m333[27m 334           358 359 360 361 362 363 364
                               365
 
-- 
1.8.2.2

