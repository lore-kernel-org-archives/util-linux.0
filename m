Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:32812 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab3KJSZD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 13:25:03 -0500
Received: by mail-wi0-f173.google.com with SMTP id ey11so1320991wid.6
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 10:25:01 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/13] tests: cal: take account week numbers when determing month lenght
Date: Sun, 10 Nov 2013 18:23:34 +0000
Message-Id: <1384107820-498-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
References: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The month header does not need to wrap if month width with week number
allows printing to single line.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/cal/bigyearw | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tests/expected/cal/bigyearw b/tests/expected/cal/bigyearw
index 61bf92f..d7fe0a2 100644
--- a/tests/expected/cal/bigyearw
+++ b/tests/expected/cal/bigyearw
@@ -20,8 +20,7 @@ Gregorian - Sunday-based month with week numbers
 52 24 25 26 27 28 29 30 
 53 31                   
 Julian - Monday-based month with week numbers
-           December           
-      1234567890123456789     
+ December 1234567890123456789 
    Mon Tue Wed Thu Fri Sat Sun
 48                 335 336 337 
 49 338 339 340 341 342 343 344 
@@ -30,8 +29,7 @@ Julian - Monday-based month with week numbers
 52 359 360 361 362 363 364 365 
                                
 Julian - Sunday-based month with week numbers
-           December           
-      1234567890123456789     
+ December 1234567890123456789 
    Sun Mon Tue Wed Thu Fri Sat
 48                     335 336 
 49 337 338 339 340 341 342 343 
@@ -60,8 +58,7 @@ Gregorian - Sunday-based three months with week numbers
 48 26 27 28 29 30        52 24 25 26 27 28 29 30   4 28 29 30 31          
                          53 31                                            
 Julian - Monday-based three months with week numbers
-           November                        December                         January           
-      1234567890123456789             1234567890123456789             1234567890123456790     
+ November 1234567890123456789    December 1234567890123456789     January 1234567890123456790 
    Mon Tue Wed Thu Fri Sat Sun     Mon Tue Wed Thu Fri Sat Sun     Mon Tue Wed Thu Fri Sat Sun
 44         305 306 307 308 309  48                 335 336 337   1   1   2   3   4   5   6   7 
 45 310 311 312 313 314 315 316  49 338 339 340 341 342 343 344   2   8   9  10  11  12  13  14 
@@ -70,8 +67,7 @@ Julian - Monday-based three months with week numbers
 48 331 332 333 334              52 359 360 361 362 363 364 365   5  29  30  31                 
                                                                                                
 Julian - Sunday-based three months with week numbers
-           November                        December                         January           
-      1234567890123456789             1234567890123456789             1234567890123456790     
+ November 1234567890123456789    December 1234567890123456789     January 1234567890123456790 
    Sun Mon Tue Wed Thu Fri Sat     Sun Mon Tue Wed Thu Fri Sat     Sun Mon Tue Wed Thu Fri Sat
 44             305 306 307 308  48                     335 336  53       1   2   3   4   5   6 
 45 309 310 311 312 313 314 315  49 337 338 339 340 341 342 343   1   7   8   9  10  11  12  13 
-- 
1.8.4.2

