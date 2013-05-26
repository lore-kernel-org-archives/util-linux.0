Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:47509 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab3EZJO0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 May 2013 05:14:26 -0400
Received: by mail-wi0-f181.google.com with SMTP id hi5so769435wib.8
        for <util-linux@vger.kernel.org>; Sun, 26 May 2013 02:14:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/4] tests: check cal works when year is far in future
Date: Sun, 26 May 2013 10:14:09 +0100
Message-Id: <1369559650-12341-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
References: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/cal/bigyear | 206 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ts/cal/bigyear       |  95 +++++++++++++++++++++
 2 files changed, 301 insertions(+)
 create mode 100644 tests/expected/cal/bigyear
 create mode 100755 tests/ts/cal/bigyear

diff --git a/tests/expected/cal/bigyear b/tests/expected/cal/bigyear
new file mode 100644
index 0000000..dec7949
--- /dev/null
+++ b/tests/expected/cal/bigyear
@@ -0,0 +1,206 @@
+
+Gregorian - Monday-based month
+      December      
+12345678901234567890
+Mo Tu We Th Fr Sa Su
+             1  2  3 
+ 4  5  6  7  8  9 10 
+11 12 13 14 15 16 17 
+18 19 20 21 22 23 24 
+25 26 27 28 29 30 31 
+                     
+Gregorian - Sunday-based month
+      December      
+12345678901234567890
+Su Mo Tu We Th Fr Sa
+                1  2 
+ 3  4  5  6  7  8  9 
+10 11 12 13 14 15 16 
+17 18 19 20 21 22 23 
+24 25 26 27 28 29 30 
+31                   
+Julian - Monday-based month
+          December         
+    12345678901234567890   
+Mon Tue Wed Thu Fri Sat Sun
+                335 336 337 
+338 339 340 341 342 343 344 
+345 346 347 348 349 350 351 
+352 353 354 355 356 357 358 
+359 360 361 362 363 364 365 
+                            
+Julian - Sunday-based month
+          December         
+    12345678901234567890   
+Sun Mon Tue Wed Thu Fri Sat
+                    335 336 
+337 338 339 340 341 342 343 
+344 345 346 347 348 349 350 
+351 352 353 354 355 356 357 
+358 359 360 361 362 363 364 
+365                         
+Gregorian - Monday-based three months
+      November              December               January      
+12345678901234567890  12345678901234567890  12345678901234567891
+Mo Tu We Th Fr Sa Su Mo Tu We Th Fr Sa Su Mo Tu We Th Fr Sa Su
+       1  2  3  4  5               1  2  3   1  2  3  4  5  6  7 
+ 6  7  8  9 10 11 12   4  5  6  7  8  9 10   8  9 10 11 12 13 14 
+13 14 15 16 17 18 19  11 12 13 14 15 16 17  15 16 17 18 19 20 21 
+20 21 22 23 24 25 26  18 19 20 21 22 23 24  22 23 24 25 26 27 28 
+27 28 29 30           25 26 27 28 29 30 31  29 30 31             
+                                                                 
+Gregorian - Sunday-based three months
+      November              December               January      
+12345678901234567890  12345678901234567890  12345678901234567891
+Su Mo Tu We Th Fr Sa Su Mo Tu We Th Fr Sa Su Mo Tu We Th Fr Sa
+          1  2  3  4                  1  2      1  2  3  4  5  6 
+ 5  6  7  8  9 10 11   3  4  5  6  7  8  9   7  8  9 10 11 12 13 
+12 13 14 15 16 17 18  10 11 12 13 14 15 16  14 15 16 17 18 19 20 
+19 20 21 22 23 24 25  17 18 19 20 21 22 23  21 22 23 24 25 26 27 
+26 27 28 29 30        24 25 26 27 28 29 30  28 29 30 31          
+                      31                                         
+Julian - Monday-based three months
+          November                     December                     January          
+    12345678901234567890         12345678901234567890         12345678901234567891   
+Mon Tue Wed Thu Fri Sat Sun Mon Tue Wed Thu Fri Sat Sun Mon Tue Wed Thu Fri Sat Sun
+        305 306 307 308 309                  335 336 337    1   2   3   4   5   6   7 
+310 311 312 313 314 315 316  338 339 340 341 342 343 344    8   9  10  11  12  13  14 
+317 318 319 320 321 322 323  345 346 347 348 349 350 351   15  16  17  18  19  20  21 
+324 325 326 327 328 329 330  352 353 354 355 356 357 358   22  23  24  25  26  27  28 
+331 332 333 334              359 360 361 362 363 364 365   29  30  31                 
+                                                                                      
+Julian - Sunday-based three months
+          November                     December                     January          
+    12345678901234567890         12345678901234567890         12345678901234567891   
+Sun Mon Tue Wed Thu Fri Sat Sun Mon Tue Wed Thu Fri Sat Sun Mon Tue Wed Thu Fri Sat
+            305 306 307 308                      335 336        1   2   3   4   5   6 
+309 310 311 312 313 314 315  337 338 339 340 341 342 343    7   8   9  10  11  12  13 
+316 317 318 319 320 321 322  344 345 346 347 348 349 350   14  15  16  17  18  19  20 
+323 324 325 326 327 328 329  351 352 353 354 355 356 357   21  22  23  24  25  26  27 
+330 331 332 333 334          358 359 360 361 362 363 364   28  29  30  31             
+                             365                                                      
+Gregorian - Monday-based year
+                       12345678901234567890                       
+
+       January               February                 March       
+Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su
+                   1          1  2  3  4  5          1  2  3  4  5   
+ 2  3  4  5  6  7  8    6  7  8  9 10 11 12    6  7  8  9 10 11 12   
+ 9 10 11 12 13 14 15   13 14 15 16 17 18 19   13 14 15 16 17 18 19   
+16 17 18 19 20 21 22   20 21 22 23 24 25 26   20 21 22 23 24 25 26   
+23 24 25 26 27 28 29   27 28                  27 28 29 30 31         
+30 31                                                                
+        April                   May                   June        
+Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su
+                1  2    1  2  3  4  5  6  7             1  2  3  4   
+ 3  4  5  6  7  8  9    8  9 10 11 12 13 14    5  6  7  8  9 10 11   
+10 11 12 13 14 15 16   15 16 17 18 19 20 21   12 13 14 15 16 17 18   
+17 18 19 20 21 22 23   22 23 24 25 26 27 28   19 20 21 22 23 24 25   
+24 25 26 27 28 29 30   29 30 31               26 27 28 29 30         
+                                                                     
+        July                  August                September     
+Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su
+                1  2       1  2  3  4  5  6                1  2  3   
+ 3  4  5  6  7  8  9    7  8  9 10 11 12 13    4  5  6  7  8  9 10   
+10 11 12 13 14 15 16   14 15 16 17 18 19 20   11 12 13 14 15 16 17   
+17 18 19 20 21 22 23   21 22 23 24 25 26 27   18 19 20 21 22 23 24   
+24 25 26 27 28 29 30   28 29 30 31            25 26 27 28 29 30      
+31                                                                   
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
+                       12345678901234567890                       
+
+       January               February                 March       
+Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
+ 1  2  3  4  5  6  7             1  2  3  4             1  2  3  4   
+ 8  9 10 11 12 13 14    5  6  7  8  9 10 11    5  6  7  8  9 10 11   
+15 16 17 18 19 20 21   12 13 14 15 16 17 18   12 13 14 15 16 17 18   
+22 23 24 25 26 27 28   19 20 21 22 23 24 25   19 20 21 22 23 24 25   
+29 30 31               26 27 28               26 27 28 29 30 31      
+                                                                     
+        April                   May                   June        
+Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
+                   1       1  2  3  4  5  6                1  2  3   
+ 2  3  4  5  6  7  8    7  8  9 10 11 12 13    4  5  6  7  8  9 10   
+ 9 10 11 12 13 14 15   14 15 16 17 18 19 20   11 12 13 14 15 16 17   
+16 17 18 19 20 21 22   21 22 23 24 25 26 27   18 19 20 21 22 23 24   
+23 24 25 26 27 28 29   28 29 30 31            25 26 27 28 29 30      
+30                                                                   
+        July                  August                September     
+Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
+                   1          1  2  3  4  5                   1  2   
+ 2  3  4  5  6  7  8    6  7  8  9 10 11 12    3  4  5  6  7  8  9   
+ 9 10 11 12 13 14 15   13 14 15 16 17 18 19   10 11 12 13 14 15 16   
+16 17 18 19 20 21 22   20 21 22 23 24 25 26   17 18 19 20 21 22 23   
+23 24 25 26 27 28 29   27 28 29 30 31         24 25 26 27 28 29 30   
+30 31                                                                
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
+                   12345678901234567890                  
+
+          January                       February         
+Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun
+                          1            32  33  34  35  36   
+  2   3   4   5   6   7   8    37  38  39  40  41  42  43   
+  9  10  11  12  13  14  15    44  45  46  47  48  49  50   
+ 16  17  18  19  20  21  22    51  52  53  54  55  56  57   
+ 23  24  25  26  27  28  29    58  59                       
+ 30  31                                                     
+           March                         April           
+Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun
+         60  61  62  63  64                        91  92   
+ 65  66  67  68  69  70  71    93  94  95  96  97  98  99   
+ 72  73  74  75  76  77  78   100 101 102 103 104 105 106   
+ 79  80  81  82  83  84  85   107 108 109 110 111 112 113   
+ 86  87  88  89  90           114 115 116 117 118 119 120   
+                                                            
+            May                           June           
+Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun
+121 122 123 124 125 126 127               152 153 154 155   
+128 129 130 131 132 133 134   156 157 158 159 160 161 162   
+135 136 137 138 139 140 141   163 164 165 166 167 168 169   
+142 143 144 145 146 147 148   170 171 172 173 174 175 176   
+149 150 151                   177 178 179 180 181           
+                                                            
+            July                         August          
+Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun
+                    182 183       213 214 215 216 217 218   
+184 185 186 187 188 189 190   219 220 221 222 223 224 225   
+191 192 193 194 195 196 197   226 227 228 229 230 231 232   
+198 199 200 201 202 203 204   233 234 235 236 237 238 239   
+205 206 207 208 209 210 211   240 241 242 243               
+212                                                         
+         September                      October          
+Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun
+                244 245 246                           274   
+247 248 249 250 251 252 253   275 276 277 278 279 280 281   
+254 255 256 257 258 259 260   282 283 284 285 286 287 288   
+261 262 263 264 265 266 267   289 290 291 292 293 294 295   
+268 269 270 271 272 273       296 297 298 299 300 301 302   
+                              303 304                       
+          November                      December         
+Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun
+        305 306 307 308 309                   335 336 337   
+310 311 312 313 314 315 316   338 339 340 341 342 343 344   
+317 318 319 320 321 322 323   345 346 347 348 349 350 351   
+324 325 326 327 328 329 330   352 353 354 355 356 357 358   
+331 332 333 334               359 360 361 362 363 364 365   
+                                                            
+
+Julian - Sunday-based year
diff --git a/tests/ts/cal/bigyear b/tests/ts/cal/bigyear
new file mode 100755
index 0000000..8b8acd8
--- /dev/null
+++ b/tests/ts/cal/bigyear
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
+TS_DESC="Year 12345678901234567890"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+set -o pipefail
+
+USETERM=$( ts_has_option "useterm" "$*" )
+MYMONTH="12 12345678901234567890"
+MYYEAR="12345678901234567890"
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
1.8.2.3

