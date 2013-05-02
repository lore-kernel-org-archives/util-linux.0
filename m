Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:37623 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760451Ab3EBSwA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 May 2013 14:52:00 -0400
Received: by mail-we0-f175.google.com with SMTP id s43so744541wey.20
        for <util-linux@vger.kernel.org>; Thu, 02 May 2013 11:51:59 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/16] tests: add calendar reformation check
Date: Thu,  2 May 2013 19:51:29 +0100
Message-Id: <1367520701-14962-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/cal/sep1752 | 198 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ts/cal/sep1752       |  95 ++++++++++++++++++++++
 2 files changed, 293 insertions(+)
 create mode 100644 tests/expected/cal/sep1752
 create mode 100755 tests/ts/cal/sep1752

diff --git a/tests/expected/cal/sep1752 b/tests/expected/cal/sep1752
new file mode 100644
index 0000000..b718fa0
--- /dev/null
+++ b/tests/expected/cal/sep1752
@@ -0,0 +1,198 @@
+
+Gregorian - Monday-based month
+   September 1752   
+Mo Tu We Th Fr Sa Su
+    1  2 14 15 16 17
+18 19 20 21 22 23 24
+25 26 27 28 29 30
+
+
+
+Gregorian - Sunday-based month
+   September 1752   
+Su Mo Tu We Th Fr Sa
+       1  2 14 15 16
+17 18 19 20 21 22 23
+24 25 26 27 28 29 30
+
+
+
+Julian - Monday-based month
+       September 1752      
+Mon Tue Wed Thu Fri Sat Sun
+    245 246 258 259 260 261
+262 263 264 265 266 267 268
+269 270 271 272 273 274
+
+
+
+Julian - Sunday-based month
+       September 1752      
+Sun Mon Tue Wed Thu Fri Sat
+        245 246 258 259 260
+261 262 263 264 265 266 267
+268 269 270 271 272 273 274
+
+
+
+Gregorian - Monday-based three months
+     August 1752         September 1752         October 1752    
+Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su
+                1  2      1  2 14 15 16 17                     1
+ 3  4  5  6  7  8  9  18 19 20 21 22 23 24   2  3  4  5  6  7  8
+10 11 12 13 14 15 16  25 26 27 28 29 30      9 10 11 12 13 14 15
+17 18 19 20 21 22 23                        16 17 18 19 20 21 22
+24 25 26 27 28 29 30                        23 24 25 26 27 28 29
+31                                          30 31               
+Gregorian - Sunday-based three months
+     August 1752         September 1752         October 1752    
+Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
+                   1         1  2 14 15 16   1  2  3  4  5  6  7
+ 2  3  4  5  6  7  8  17 18 19 20 21 22 23   8  9 10 11 12 13 14
+ 9 10 11 12 13 14 15  24 25 26 27 28 29 30  15 16 17 18 19 20 21
+16 17 18 19 20 21 22                        22 23 24 25 26 27 28
+23 24 25 26 27 28 29                        29 30 31            
+30 31                                                           
+Julian - Monday-based three months
+        August 1752                 September 1752                October 1752       
+Mon Tue Wed Thu Fri Sat Sun  Mon Tue Wed Thu Fri Sat Sun  Mon Tue Wed Thu Fri Sat Sun
+                    214 215      245 246 258 259 260 261                          275
+216 217 218 219 220 221 222  262 263 264 265 266 267 268  276 277 278 279 280 281 282
+223 224 225 226 227 228 229  269 270 271 272 273 274      283 284 285 286 287 288 289
+230 231 232 233 234 235 236                               290 291 292 293 294 295 296
+237 238 239 240 241 242 243                               297 298 299 300 301 302 303
+244                                                       304 305                    
+Julian - Sunday-based three months
+        August 1752                 September 1752                October 1752       
+Sun Mon Tue Wed Thu Fri Sat  Sun Mon Tue Wed Thu Fri Sat  Sun Mon Tue Wed Thu Fri Sat
+                        214          245 246 258 259 260  275 276 277 278 279 280 281
+215 216 217 218 219 220 221  261 262 263 264 265 266 267  282 283 284 285 286 287 288
+222 223 224 225 226 227 228  268 269 270 271 272 273 274  289 290 291 292 293 294 295
+229 230 231 232 233 234 235                               296 297 298 299 300 301 302
+236 237 238 239 240 241 242                               303 304 305                
+243 244                                                                              
+Gregorian - Monday-based year
+                               1752                               
+
+       January               February                 March       
+Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su
+       1  2  3  4  5                   1  2                      1
+ 6  7  8  9 10 11 12    3  4  5  6  7  8  9    2  3  4  5  6  7  8
+13 14 15 16 17 18 19   10 11 12 13 14 15 16    9 10 11 12 13 14 15
+20 21 22 23 24 25 26   17 18 19 20 21 22 23   16 17 18 19 20 21 22
+27 28 29 30 31         24 25 26 27 28 29      23 24 25 26 27 28 29
+                                              30 31
+        April                   May                   June        
+Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su
+       1  2  3  4  5                1  2  3    1  2  3  4  5  6  7
+ 6  7  8  9 10 11 12    4  5  6  7  8  9 10    8  9 10 11 12 13 14
+13 14 15 16 17 18 19   11 12 13 14 15 16 17   15 16 17 18 19 20 21
+20 21 22 23 24 25 26   18 19 20 21 22 23 24   22 23 24 25 26 27 28
+27 28 29 30            25 26 27 28 29 30 31   29 30
+
+        July                  August                September     
+Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su
+       1  2  3  4  5                   1  2       1  2 14 15 16 17
+ 6  7  8  9 10 11 12    3  4  5  6  7  8  9   18 19 20 21 22 23 24
+13 14 15 16 17 18 19   10 11 12 13 14 15 16   25 26 27 28 29 30
+20 21 22 23 24 25 26   17 18 19 20 21 22 23
+27 28 29 30 31         24 25 26 27 28 29 30
+                       31
+       October               November               December      
+Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su
+                   1          1  2  3  4  5                1  2  3
+ 2  3  4  5  6  7  8    6  7  8  9 10 11 12    4  5  6  7  8  9 10
+ 9 10 11 12 13 14 15   13 14 15 16 17 18 19   11 12 13 14 15 16 17
+16 17 18 19 20 21 22   20 21 22 23 24 25 26   18 19 20 21 22 23 24
+23 24 25 26 27 28 29   27 28 29 30            25 26 27 28 29 30 31
+30 31
+
+Gregorian - Sunday-based year
+                               1752                               
+
+       January               February                 March       
+Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
+          1  2  3  4                      1    1  2  3  4  5  6  7
+ 5  6  7  8  9 10 11    2  3  4  5  6  7  8    8  9 10 11 12 13 14
+12 13 14 15 16 17 18    9 10 11 12 13 14 15   15 16 17 18 19 20 21
+19 20 21 22 23 24 25   16 17 18 19 20 21 22   22 23 24 25 26 27 28
+26 27 28 29 30 31      23 24 25 26 27 28 29   29 30 31
+
+        April                   May                   June        
+Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
+          1  2  3  4                   1  2       1  2  3  4  5  6
+ 5  6  7  8  9 10 11    3  4  5  6  7  8  9    7  8  9 10 11 12 13
+12 13 14 15 16 17 18   10 11 12 13 14 15 16   14 15 16 17 18 19 20
+19 20 21 22 23 24 25   17 18 19 20 21 22 23   21 22 23 24 25 26 27
+26 27 28 29 30         24 25 26 27 28 29 30   28 29 30
+                       31
+        July                  August                September     
+Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
+          1  2  3  4                      1          1  2 14 15 16
+ 5  6  7  8  9 10 11    2  3  4  5  6  7  8   17 18 19 20 21 22 23
+12 13 14 15 16 17 18    9 10 11 12 13 14 15   24 25 26 27 28 29 30
+19 20 21 22 23 24 25   16 17 18 19 20 21 22
+26 27 28 29 30 31      23 24 25 26 27 28 29
+                       30 31
+       October               November               December      
+Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
+ 1  2  3  4  5  6  7             1  2  3  4                   1  2
+ 8  9 10 11 12 13 14    5  6  7  8  9 10 11    3  4  5  6  7  8  9
+15 16 17 18 19 20 21   12 13 14 15 16 17 18   10 11 12 13 14 15 16
+22 23 24 25 26 27 28   19 20 21 22 23 24 25   17 18 19 20 21 22 23
+29 30 31               26 27 28 29 30         24 25 26 27 28 29 30
+                                              31
+
+Julian - Monday-based year
+                           1752                          
+
+          January                       February         
+Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun
+          1   2   3   4   5                        32  33
+  6   7   8   9  10  11  12    34  35  36  37  38  39  40
+ 13  14  15  16  17  18  19    41  42  43  44  45  46  47
+ 20  21  22  23  24  25  26    48  49  50  51  52  53  54
+ 27  28  29  30  31            55  56  57  58  59  60
+
+           March                         April           
+Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun
+                         61            92  93  94  95  96
+ 62  63  64  65  66  67  68    97  98  99 100 101 102 103
+ 69  70  71  72  73  74  75   104 105 106 107 108 109 110
+ 76  77  78  79  80  81  82   111 112 113 114 115 116 117
+ 83  84  85  86  87  88  89   118 119 120 121
+ 90  91
+            May                           June           
+Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun
+                122 123 124   153 154 155 156 157 158 159
+125 126 127 128 129 130 131   160 161 162 163 164 165 166
+132 133 134 135 136 137 138   167 168 169 170 171 172 173
+139 140 141 142 143 144 145   174 175 176 177 178 179 180
+146 147 148 149 150 151 152   181 182
+
+            July                         August          
+Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun
+        183 184 185 186 187                       214 215
+188 189 190 191 192 193 194   216 217 218 219 220 221 222
+195 196 197 198 199 200 201   223 224 225 226 227 228 229
+202 203 204 205 206 207 208   230 231 232 233 234 235 236
+209 210 211 212 213           237 238 239 240 241 242 243
+                              244
+         September                      October          
+Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun
+    245 246 258 259 260 261                           275
+262 263 264 265 266 267 268   276 277 278 279 280 281 282
+269 270 271 272 273 274       283 284 285 286 287 288 289
+                              290 291 292 293 294 295 296
+                              297 298 299 300 301 302 303
+                              304 305
+          November                      December         
+Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun
+        306 307 308 309 310                   336 337 338
+311 312 313 314 315 316 317   339 340 341 342 343 344 345
+318 319 320 321 322 323 324   346 347 348 349 350 351 352
+325 326 327 328 329 330 331   353 354 355 356 357 358 359
+332 333 334 335               360 361 362 363 364 365 366
+
+
+Julian - Sunday-based year
diff --git a/tests/ts/cal/sep1752 b/tests/ts/cal/sep1752
new file mode 100755
index 0000000..68ea342
--- /dev/null
+++ b/tests/ts/cal/sep1752
@@ -0,0 +1,95 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="$(dirname $0)/../.."
+TS_DESC="September 1752"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+set -o pipefail
+
+USETERM=$( ts_has_option "useterm" "$*" )
+MYMONTH="09 1752"
+MYYEAR="1752"
+
+[ "$USETERM" == "yes" ] && TS_VERBOSE="yes"
+ts_log ""
+
+
+ts_log "Gregorian - Monday-based month"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL -1m
+fi
+$TS_CMD_CAL -1m $MYMONTH >> $TS_OUTPUT
+ts_log "Gregorian - Sunday-based month"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL -1s $MYMONTH
+fi
+$TS_CMD_CAL -1s $MYMONTH >> $TS_OUTPUT
+ts_log "Julian - Monday-based month"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL -1mj $MYMONTH
+fi
+$TS_CMD_CAL -1mj $MYMONTH >> $TS_OUTPUT
+ts_log "Julian - Sunday-based month"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL -1sj $MYMONTH
+fi
+$TS_CMD_CAL -1sj $MYMONTH >> $TS_OUTPUT
+
+
+ts_log "Gregorian - Monday-based three months"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL -3m
+fi
+$TS_CMD_CAL -3m $MYMONTH >> $TS_OUTPUT
+ts_log "Gregorian - Sunday-based three months"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL -3s $MYMONTH
+fi
+$TS_CMD_CAL -3s $MYMONTH >> $TS_OUTPUT
+ts_log "Julian - Monday-based three months"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL -3mj $MYMONTH
+fi
+$TS_CMD_CAL -3mj $MYMONTH >> $TS_OUTPUT
+ts_log "Julian - Sunday-based three months"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL -3sj $MYMONTH
+fi
+$TS_CMD_CAL -3sj $MYMONTH >> $TS_OUTPUT
+
+
+ts_log "Gregorian - Monday-based year"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL -1m $MYYEAR
+fi
+$TS_CMD_CAL -1m $MYYEAR >> $TS_OUTPUT
+ts_log "Gregorian - Sunday-based year"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL -1s $MYYEAR
+fi
+$TS_CMD_CAL -1s $MYYEAR >> $TS_OUTPUT
+ts_log "Julian - Monday-based year"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL -1mj $MYYEAR
+fi
+$TS_CMD_CAL -1mj $MYYEAR >> $TS_OUTPUT
+ts_log "Julian - Sunday-based year"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL -1sj $MYYEAR
+fi
+
+ts_finalize
-- 
1.8.2.2

