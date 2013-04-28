Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:32797 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab3D1RLi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Apr 2013 13:11:38 -0400
Received: by mail-wg0-f48.google.com with SMTP id f11so3112519wgh.27
        for <util-linux@vger.kernel.org>; Sun, 28 Apr 2013 10:11:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/11] cal: trim three month display trailing white spaces
Date: Sun, 28 Apr 2013 18:11:06 +0100
Message-Id: <1367169067-23705-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Includes fix to checks that conform earlier output practise.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c           | 11 +++++++----
 tests/expected/cal/3m      | 20 ++++++++++----------
 tests/expected/cal/sep1752 | 20 ++++++++++----------
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 949f003..a03cd3c 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -540,8 +540,10 @@ monthly3(int day, int month, int year) {
 	width = (julian ? J_WEEK_LEN : WEEK_LEN) -1;
 	for (i = 0; i < 2; i++) {
 		snprintf(lineout, sizeof(lineout),
-			"%s  %s  %s\n", out_prev.s[i], out_curm.s[i], out_next.s[i]);
+			"%s  %s  %s", out_prev.s[i], out_curm.s[i], out_next.s[i]);
+		trim_trailing_spaces(lineout);
 		my_putstring(lineout);
+		my_putstring("\n");
 	}
 	for (i = 2; i < FMT_ST_LINES; i++) {
 		int w1, w2, w3;
@@ -553,12 +555,13 @@ monthly3(int day, int month, int year) {
 		w2 += (out_curm.s[i] == Hrow ? Slen : 0);
 		w3 += (out_next.s[i] == Hrow ? Slen : 0);
 #endif
-		snprintf(lineout, sizeof(lineout), "%-*s  %-*s  %-*s\n",
+		snprintf(lineout, sizeof(lineout), "%-*s  %-*s  %s",
 		       w1, out_prev.s[i],
 		       w2, out_curm.s[i],
-		       w3, out_next.s[i]);
-
+		       out_next.s[i]);
+		trim_trailing_spaces(lineout);
 		my_putstring(lineout);
+		my_putstring("\n");
 	}
 }
 
diff --git a/tests/expected/cal/3m b/tests/expected/cal/3m
index 724d521..a7bdca4 100644
--- a/tests/expected/cal/3m
+++ b/tests/expected/cal/3m
@@ -1,37 +1,37 @@
 
 Gregorian - Monday-based week
-     August 2006         September 2006         October 2006    
+     August 2006         September 2006         October 2006
 Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su
     1  2  3  4  5  6               1  2  3                     1
  7  8  9 10 11 12 13   4  5  6  7  8  9 10   2  3  4  5  6  7  8
 14 15 16 17 18 19 20  11 12 13 14 15 16 17   9 10 11 12 13 14 15
 21 22 23 24 25 26 27  18 19 20 21 22 23 24  16 17 18 19 20 21 22
 28 29 30 31           25 26 [7m27[27m 28 29 30     23 24 25 26 27 28 29
-                                            30 31               
+                                            30 31
 Gregorian - Sunday-based week
-     August 2006         September 2006         October 2006    
+     August 2006         September 2006         October 2006
 Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
        1  2  3  4  5                  1  2   1  2  3  4  5  6  7
  6  7  8  9 10 11 12   3  4  5  6  7  8  9   8  9 10 11 12 13 14
 13 14 15 16 17 18 19  10 11 12 13 14 15 16  15 16 17 18 19 20 21
 20 21 22 23 24 25 26  17 18 19 20 21 22 23  22 23 24 25 26 27 28
-27 28 29 30 31        24 25 26 [7m27[27m 28 29 30  29 30 31            
-                                                                
+27 28 29 30 31        24 25 26 [7m27[27m 28 29 30  29 30 31
+
 Julian - Monday-based week
-        August 2006                 September 2006                October 2006       
+        August 2006                 September 2006                October 2006
 Mon Tue Wed Thu Fri Sat Sun  Mon Tue Wed Thu Fri Sat Sun  Mon Tue Wed Thu Fri Sat Sun
     213 214 215 216 217 218                  244 245 246                          274
 219 220 221 222 223 224 225  247 248 249 250 251 252 253  275 276 277 278 279 280 281
 226 227 228 229 230 231 232  254 255 256 257 258 259 260  282 283 284 285 286 287 288
 233 234 235 236 237 238 239  261 262 263 264 265 266 267  289 290 291 292 293 294 295
 240 241 242 243              268 269 [7m270[27m 271 272 273      296 297 298 299 300 301 302
-                                                          303 304                    
+                                                          303 304
 Julian - Sunday-based week
-        August 2006                 September 2006                October 2006       
+        August 2006                 September 2006                October 2006
 Sun Mon Tue Wed Thu Fri Sat  Sun Mon Tue Wed Thu Fri Sat  Sun Mon Tue Wed Thu Fri Sat
         213 214 215 216 217                      244 245  274 275 276 277 278 279 280
 218 219 220 221 222 223 224  246 247 248 249 250 251 252  281 282 283 284 285 286 287
 225 226 227 228 229 230 231  253 254 255 256 257 258 259  288 289 290 291 292 293 294
 232 233 234 235 236 237 238  260 261 262 263 264 265 266  295 296 297 298 299 300 301
-239 240 241 242 243          267 268 269 [7m270[27m 271 272 273  302 303 304                
-                                                                                     
+239 240 241 242 243          267 268 269 [7m270[27m 271 272 273  302 303 304
+
diff --git a/tests/expected/cal/sep1752 b/tests/expected/cal/sep1752
index b718fa0..283983d 100644
--- a/tests/expected/cal/sep1752
+++ b/tests/expected/cal/sep1752
@@ -36,41 +36,41 @@ Sun Mon Tue Wed Thu Fri Sat
 
 
 Gregorian - Monday-based three months
-     August 1752         September 1752         October 1752    
+     August 1752         September 1752         October 1752
 Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su
                 1  2      1  2 14 15 16 17                     1
  3  4  5  6  7  8  9  18 19 20 21 22 23 24   2  3  4  5  6  7  8
 10 11 12 13 14 15 16  25 26 27 28 29 30      9 10 11 12 13 14 15
 17 18 19 20 21 22 23                        16 17 18 19 20 21 22
 24 25 26 27 28 29 30                        23 24 25 26 27 28 29
-31                                          30 31               
+31                                          30 31
 Gregorian - Sunday-based three months
-     August 1752         September 1752         October 1752    
+     August 1752         September 1752         October 1752
 Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
                    1         1  2 14 15 16   1  2  3  4  5  6  7
  2  3  4  5  6  7  8  17 18 19 20 21 22 23   8  9 10 11 12 13 14
  9 10 11 12 13 14 15  24 25 26 27 28 29 30  15 16 17 18 19 20 21
 16 17 18 19 20 21 22                        22 23 24 25 26 27 28
-23 24 25 26 27 28 29                        29 30 31            
-30 31                                                           
+23 24 25 26 27 28 29                        29 30 31
+30 31
 Julian - Monday-based three months
-        August 1752                 September 1752                October 1752       
+        August 1752                 September 1752                October 1752
 Mon Tue Wed Thu Fri Sat Sun  Mon Tue Wed Thu Fri Sat Sun  Mon Tue Wed Thu Fri Sat Sun
                     214 215      245 246 258 259 260 261                          275
 216 217 218 219 220 221 222  262 263 264 265 266 267 268  276 277 278 279 280 281 282
 223 224 225 226 227 228 229  269 270 271 272 273 274      283 284 285 286 287 288 289
 230 231 232 233 234 235 236                               290 291 292 293 294 295 296
 237 238 239 240 241 242 243                               297 298 299 300 301 302 303
-244                                                       304 305                    
+244                                                       304 305
 Julian - Sunday-based three months
-        August 1752                 September 1752                October 1752       
+        August 1752                 September 1752                October 1752
 Sun Mon Tue Wed Thu Fri Sat  Sun Mon Tue Wed Thu Fri Sat  Sun Mon Tue Wed Thu Fri Sat
                         214          245 246 258 259 260  275 276 277 278 279 280 281
 215 216 217 218 219 220 221  261 262 263 264 265 266 267  282 283 284 285 286 287 288
 222 223 224 225 226 227 228  268 269 270 271 272 273 274  289 290 291 292 293 294 295
 229 230 231 232 233 234 235                               296 297 298 299 300 301 302
-236 237 238 239 240 241 242                               303 304 305                
-243 244                                                                              
+236 237 238 239 240 241 242                               303 304 305
+243 244
 Gregorian - Monday-based year
                                1752                               
 
-- 
1.8.2.2

