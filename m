Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:43356 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab3KJSZI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 13:25:08 -0500
Received: by mail-wg0-f50.google.com with SMTP id k14so2165341wgh.17
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 10:25:07 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/13] tests: cal: do not let --week=<num> to adjust requested month
Date: Sun, 10 Nov 2013 18:23:36 +0000
Message-Id: <1384107820-498-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
References: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The previous commit made --week=<number> to have smaller weight value
than a month supplied by user.  The commit started to print the month
that has more days at the week when a week is split to two months, and
only one month output is requested.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/cal/weekarg | 84 +++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/tests/expected/cal/weekarg b/tests/expected/cal/weekarg
index 639f0f7..75e2efb 100644
--- a/tests/expected/cal/weekarg
+++ b/tests/expected/cal/weekarg
@@ -1,13 +1,13 @@
 
 Gregorian - Monday-based, week 40, 3 month 
-      August 2013             September 2013            October 2013     
+     September 2013            October 2013            November 2013     
    Mo Tu We Th Fr Sa Su     Mo Tu We Th Fr Sa Su     Mo Tu We Th Fr Sa Su
-31           1  2  3  4  35                    1  40     1  2  3  4  5  6 
-32  5  6  7  8  9 10 11  36  2  3  4  5  6  7  8  41  7  8  9 10 11 12 13 
-33 12 13 14 15 16 17 18  37  9 10 11 12 13 14 15  42 14 15 16 17 18 19 20 
-34 19 20 21 22 23 24 25  38 16 17 18 19 20 21 22  43 21 22 23 24 25 26 27 
-35 26 27 28 29 30 31     39 23 24 25 26 27 28 29  44 28 29 30 31          
-                         40 30                                            
+35                    1  40     1  2  3  4  5  6  44              1  2  3 
+36  2  3  4  5  6  7  8  41  7  8  9 10 11 12 13  45  4  5  6  7  8  9 10 
+37  9 10 11 12 13 14 15  42 14 15 16 17 18 19 20  46 11 12 13 14 15 16 17 
+38 16 17 18 19 20 21 22  43 21 22 23 24 25 26 27  47 18 19 20 21 22 23 24 
+39 23 24 25 26 27 28 29  44 28 29 30 31           48 25 26 27 28 29 30    
+40 30                                                                     
 Gregorian - Sunday-based, week 40, 3 month 
      September 2013            October 2013            November 2013     
    Su Mo Tu We Th Fr Sa     Su Mo Tu We Th Fr Sa     Su Mo Tu We Th Fr Sa
@@ -18,14 +18,14 @@ Gregorian - Sunday-based, week 40, 3 month
 39 29 30                 43 27 28 29 30 31        47 24 25 26 27 28 29 30 
                                                                           
 Julian - Monday-based, week 40, 3 month 
-          August 2013                   September 2013                   October 2013         
+        September 2013                   October 2013                    November 2013        
    Mon Tue Wed Thu Fri Sat Sun     Mon Tue Wed Thu Fri Sat Sun     Mon Tue Wed Thu Fri Sat Sun
-31             213 214 215 216  35                         244  40     274 275 276 277 278 279 
-32 217 218 219 220 221 222 223  36 245 246 247 248 249 250 251  41 280 281 282 283 284 285 286 
-33 224 225 226 227 228 229 230  37 252 253 254 255 256 257 258  42 287 288 289 290 291 292 293 
-34 231 232 233 234 235 236 237  38 259 260 261 262 263 264 265  43 294 295 296 297 298 299 300 
-35 238 239 240 241 242 243      39 266 267 268 269 270 271 272  44 301 302 303 304             
-                                40 273                                                         
+35                         244  40     274 275 276 277 278 279  44                 305 306 307 
+36 245 246 247 248 249 250 251  41 280 281 282 283 284 285 286  45 308 309 310 311 312 313 314 
+37 252 253 254 255 256 257 258  42 287 288 289 290 291 292 293  46 315 316 317 318 319 320 321 
+38 259 260 261 262 263 264 265  43 294 295 296 297 298 299 300  47 322 323 324 325 326 327 328 
+39 266 267 268 269 270 271 272  44 301 302 303 304              48 329 330 331 332 333 334     
+40 273                                                                                         
 Julian - Sunday-based, week 40, 3 month 
         September 2013                   October 2013                    November 2013        
    Sun Mon Tue Wed Thu Fri Sat     Sun Mon Tue Wed Thu Fri Sat     Sun Mon Tue Wed Thu Fri Sat
@@ -36,14 +36,14 @@ Julian - Sunday-based, week 40, 3 month
 39 272 273                      43 300 301 302 303 304          47 328 329 330 331 332 333 334 
                                                                                                
 Gregorian - Monday-based, week 40, 1 month 
-     September 2013    
+      October 2013     
    Mo Tu We Th Fr Sa Su
-35                    1 
-36  2  3  4  5  6  7  8 
-37  9 10 11 12 13 14 15 
-38 16 17 18 19 20 21 22 
-39 23 24 25 26 27 28 29 
-40 30                   
+40     1  2  3  4  5  6 
+41  7  8  9 10 11 12 13 
+42 14 15 16 17 18 19 20 
+43 21 22 23 24 25 26 27 
+44 28 29 30 31          
+                        
 Gregorian - Sunday-based, week 40, 1 month 
       October 2013     
    Su Mo Tu We Th Fr Sa
@@ -54,14 +54,14 @@ Gregorian - Sunday-based, week 40, 1 month
 43 27 28 29 30 31       
                         
 Julian - Monday-based, week 40, 1 month 
-        September 2013        
+         October 2013         
    Mon Tue Wed Thu Fri Sat Sun
-35                         244 
-36 245 246 247 248 249 250 251 
-37 252 253 254 255 256 257 258 
-38 259 260 261 262 263 264 265 
-39 266 267 268 269 270 271 272 
-40 273                         
+40     274 275 276 277 278 279 
+41 280 281 282 283 284 285 286 
+42 287 288 289 290 291 292 293 
+43 294 295 296 297 298 299 300 
+44 301 302 303 304             
+                               
 Julian - Sunday-based, week 40, 1 month 
          October 2013         
    Sun Mon Tue Wed Thu Fri Sat
@@ -108,20 +108,20 @@ Julian - Monday-based, week 53 with colors, 1 month
  4  25  26  27  28  29  30  31 
                                
 Gregorian - Monday-based, week 40 with colors, 3 month 
-      August 2013             September 2013            October 2013     
+     September 2013            October 2013            November 2013     
    Mo Tu We Th Fr Sa Su     Mo Tu We Th Fr Sa Su     Mo Tu We Th Fr Sa Su
-31           1  2  3  4  35                    1  [7m40[27m     1  2  3  4  5  6 
-32  5  6  7  8  9 10 11  36  2  3  4  5  6  7  8  41 [7m 7[27m  8  9 10 11 12 13 
-33 12 13 14 15 16 17 18  37  9 10 11 12 13 14 15  42 14 15 16 17 18 19 20 
-34 19 20 21 22 23 24 25  38 16 17 18 19 20 21 22  43 21 22 23 24 25 26 27 
-35 26 27 28 29 30 31     39 23 24 25 26 27 28 29  44 28 29 30 31          
-                         [7m40[27m 30                                            
+35                    1  [7m40[27m     1  2  3  4  5  6  44              1  2  3 
+36  2  3  4  5  6  7  8  41 [7m 7[27m  8  9 10 11 12 13  45  4  5  6  7  8  9 10 
+37  9 10 11 12 13 14 15  42 14 15 16 17 18 19 20  46 11 12 13 14 15 16 17 
+38 16 17 18 19 20 21 22  43 21 22 23 24 25 26 27  47 18 19 20 21 22 23 24 
+39 23 24 25 26 27 28 29  44 28 29 30 31           48 25 26 27 28 29 30    
+[7m40[27m 30                                                                     
 Julian - Monday-based, week 40 with colors, 3 month 
-          August 2013                   September 2013                   October 2013         
+        September 2013                   October 2013                    November 2013        
    Mon Tue Wed Thu Fri Sat Sun     Mon Tue Wed Thu Fri Sat Sun     Mon Tue Wed Thu Fri Sat Sun
-31             213 214 215 216  35                         244  [7m40[27m     274 275 276 277 278 279 
-32 217 218 219 220 221 222 223  36 245 246 247 248 249 250 251  41 [7m280[27m 281 282 283 284 285 286 
-33 224 225 226 227 228 229 230  37 252 253 254 255 256 257 258  42 287 288 289 290 291 292 293 
-34 231 232 233 234 235 236 237  38 259 260 261 262 263 264 265  43 294 295 296 297 298 299 300 
-35 238 239 240 241 242 243      39 266 267 268 269 270 271 272  44 301 302 303 304             
-                                [7m40[27m 273                                                         
+35                         244  [7m40[27m     274 275 276 277 278 279  44                 305 306 307 
+36 245 246 247 248 249 250 251  41 [7m280[27m 281 282 283 284 285 286  45 308 309 310 311 312 313 314 
+37 252 253 254 255 256 257 258  42 287 288 289 290 291 292 293  46 315 316 317 318 319 320 321 
+38 259 260 261 262 263 264 265  43 294 295 296 297 298 299 300  47 322 323 324 325 326 327 328 
+39 266 267 268 269 270 271 272  44 301 302 303 304              48 329 330 331 332 333 334     
+[7m40[27m 273                                                                                         
-- 
1.8.4.2

