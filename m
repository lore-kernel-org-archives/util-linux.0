Return-Path: <SRS0=sRCm=5N=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C677C2D0EE
	for <util-linux@archiver.kernel.org>; Sat, 28 Mar 2020 22:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BDA20732
	for <util-linux@archiver.kernel.org>; Sat, 28 Mar 2020 22:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgC1WkX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 28 Mar 2020 18:40:23 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47032 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbgC1WkX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 28 Mar 2020 18:40:23 -0400
Received: from localhost.localdomain (i19-les04-th2-31-36-16-7.sfr.lns.abo.bbox.fr [31.36.16.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 0CCF15648B4;
        Sat, 28 Mar 2020 23:33:56 +0100 (CET)
From:   Aurelien LAJOIE <orel@melix.net>
To:     util-linux@vger.kernel.org
Cc:     Aurelien LAJOIE <orel@melix.net>
Subject: [PATCH 2/3] cal: Correctly center the year
Date:   Sat, 28 Mar 2020 23:33:40 +0100
Message-Id: <20200328223341.11463-2-orel@melix.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200328223341.11463-1-orel@melix.net>
References: <20200328223341.11463-1-orel@melix.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Mar 28 23:33:56 2020 +0100 (CET))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Aurelien LAJOIE <orel@melix.net>
---
 misc-utils/cal.c                |  7 +++----
 tests/expected/cal/weeknum-ymjw | 14 +++++++-------
 tests/expected/cal/weeknum-ysjw | 14 +++++++-------
 tests/expected/cal/year-ymj     |  2 +-
 tests/expected/cal/year-ymjw    |  2 +-
 tests/expected/cal/year-ysj     |  2 +-
 tests/expected/cal/year-ysjw    |  2 +-
 7 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 728600377..7cd6545d1 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -907,11 +907,10 @@ static void monthly(const struct cal_control *ctl)
 static void yearly(const struct cal_control *ctl)
 {
 	char out[FMT_ST_CHARS];
-	int year_width = 0;
+	int year_width;
 
-	year_width += (ctl->week_width + 1) * (ctl->julian ? 2 : 3);
-	if (ctl->julian)
-		year_width--;
+	year_width = ctl->months_in_row * (ctl->week_width - 1) +
+		(ctl->months_in_row - 1) * ctl->gutter_width;
 
 	if (ctl->header_year) {
 		snprintf(out, sizeof(out), "%04d", ctl->req.year);
diff --git a/tests/expected/cal/weeknum-ymjw b/tests/expected/cal/weeknum-ymjw
index d4a1072b9..bcf9a1ecd 100644
--- a/tests/expected/cal/weeknum-ymjw
+++ b/tests/expected/cal/weeknum-ymjw
@@ -1,5 +1,5 @@
 Julian - Monday-based week with week numbers
-                              2001                             
+                                              2001                                              
 
             January                         February                           March            
    Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun
@@ -33,7 +33,7 @@ Julian - Monday-based week with week numbers
 43 295 296 297 298 299 300 301   47 323 324 325 326 327 328 329   51 351 352 353 354 355 356 357
 44 302 303 304                   48 330 331 332 333 334           52 358 359 360 361 362 363 364
                                                                    1 365                        
-                              2002                             
+                                              2002                                              
 
             January                         February                           March            
    Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun
@@ -67,7 +67,7 @@ Julian - Monday-based week with week numbers
 43 294 295 296 297 298 299 300   47 322 323 324 325 326 327 328   51 350 351 352 353 354 355 356
 44 301 302 303 304               48 329 330 331 332 333 334       52 357 358 359 360 361 362 363
                                                                    1 364 365                    
-                              2003                             
+                                              2003                                              
 
             January                         February                           March            
    Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun
@@ -101,7 +101,7 @@ Julian - Monday-based week with week numbers
 43 293 294 295 296 297 298 299   47 321 322 323 324 325 326 327   52 356 357 358 359 360 361 362
 44 300 301 302 303 304           48 328 329 330 331 332 333 334    1 363 364 365                
                                                                                                 
-                              2009                             
+                                              2009                                              
 
             January                         February                           March            
    Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun
@@ -135,7 +135,7 @@ Julian - Monday-based week with week numbers
 43 292 293 294 295 296 297 298   47 320 321 322 323 324 325 326   52 355 356 357 358 359 360 361
 44 299 300 301 302 303 304       48 327 328 329 330 331 332 333   53 362 363 364 365            
                                  49 334                                                         
-                              2010                             
+                                              2010                                              
 
             January                         February                           March            
    Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun
@@ -169,7 +169,7 @@ Julian - Monday-based week with week numbers
 42 291 292 293 294 295 296 297   47 326 327 328 329 330 331 332   51 354 355 356 357 358 359 360
 43 298 299 300 301 302 303 304   48 333 334                       52 361 362 363 364 365        
                                                                                                 
-                              2011                             
+                                              2011                                              
 
             January                         February                           March            
    Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun
@@ -203,7 +203,7 @@ Julian - Monday-based week with week numbers
 42 290 291 292 293 294 295 296   47 325 326 327 328 329 330 331   51 353 354 355 356 357 358 359
 43 297 298 299 300 301 302 303   48 332 333 334                   52 360 361 362 363 364 365    
 44 304                                                                                          
-                              2012                             
+                                              2012                                              
 
             January                         February                           March            
    Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun
diff --git a/tests/expected/cal/weeknum-ysjw b/tests/expected/cal/weeknum-ysjw
index 16b91adc5..b5a85279a 100644
--- a/tests/expected/cal/weeknum-ysjw
+++ b/tests/expected/cal/weeknum-ysjw
@@ -1,5 +1,5 @@
 Julian - Sunday-based week with week numbers
-                              2001                             
+                                              2001                                              
 
             January                         February                           March            
    Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat
@@ -33,7 +33,7 @@ Julian - Sunday-based week with week numbers
 43 294 295 296 297 298 299 300   47 322 323 324 325 326 327 328   51 350 351 352 353 354 355 356
 44 301 302 303 304               48 329 330 331 332 333 334       52 357 358 359 360 361 362 363
                                                                   53 364 365                    
-                              2002                             
+                                              2002                                              
 
             January                         February                           March            
    Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat
@@ -67,7 +67,7 @@ Julian - Sunday-based week with week numbers
 43 293 294 295 296 297 298 299   47 321 322 323 324 325 326 327   52 356 357 358 359 360 361 362
 44 300 301 302 303 304           48 328 329 330 331 332 333 334   53 363 364 365                
                                                                                                 
-                              2003                             
+                                              2003                                              
 
             January                         February                           March            
    Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat
@@ -101,7 +101,7 @@ Julian - Sunday-based week with week numbers
 43 292 293 294 295 296 297 298   47 320 321 322 323 324 325 326   52 355 356 357 358 359 360 361
 44 299 300 301 302 303 304       48 327 328 329 330 331 332 333   53 362 363 364 365            
                                  49 334                                                         
-                              2009                             
+                                              2009                                              
 
             January                         February                           March            
    Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat
@@ -135,7 +135,7 @@ Julian - Sunday-based week with week numbers
 43 291 292 293 294 295 296 297   48 326 327 328 329 330 331 332   52 354 355 356 357 358 359 360
 44 298 299 300 301 302 303 304   49 333 334                       53 361 362 363 364 365        
                                                                                                 
-                              2010                             
+                                              2010                                              
 
             January                         February                           March            
    Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat
@@ -169,7 +169,7 @@ Julian - Sunday-based week with week numbers
 43 290 291 292 293 294 295 296   48 325 326 327 328 329 330 331   52 353 354 355 356 357 358 359
 44 297 298 299 300 301 302 303   49 332 333 334                   53 360 361 362 363 364 365    
 45 304                                                                                          
-                              2011                             
+                                              2011                                              
 
             January                         February                           March            
    Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat
@@ -203,7 +203,7 @@ Julian - Sunday-based week with week numbers
 43 289 290 291 292 293 294 295   48 324 325 326 327 328 329 330   52 352 353 354 355 356 357 358
 44 296 297 298 299 300 301 302   49 331 332 333 334               53 359 360 361 362 363 364 365
 45 303 304                                                                                      
-                              2012                             
+                                              2012                                              
 
             January                         February                           March            
    Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat
diff --git a/tests/expected/cal/year-ymj b/tests/expected/cal/year-ymj
index caa3db01d..f3b71439b 100644
--- a/tests/expected/cal/year-ymj
+++ b/tests/expected/cal/year-ymj
@@ -1,5 +1,5 @@
 Julian - Monday-based week
-                           2006                          
+                                          2006                                         
 
           January                       February                       March           
 Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun   Mon Tue Wed Thu Fri Sat Sun
diff --git a/tests/expected/cal/year-ymjw b/tests/expected/cal/year-ymjw
index b62e16703..e6a569ebe 100644
--- a/tests/expected/cal/year-ymjw
+++ b/tests/expected/cal/year-ymjw
@@ -1,5 +1,5 @@
 Julian - Monday-based week with week numbers
-                              2006                             
+                                              2006                                              
 
             January                         February                           March            
    Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun      Mon Tue Wed Thu Fri Sat Sun
diff --git a/tests/expected/cal/year-ysj b/tests/expected/cal/year-ysj
index 080e2579a..2b40099e4 100644
--- a/tests/expected/cal/year-ysj
+++ b/tests/expected/cal/year-ysj
@@ -1,5 +1,5 @@
 Julian - Sunday-based week
-                           2006                          
+                                          2006                                         
 
           January                       February                       March           
 Sun Mon Tue Wed Thu Fri Sat   Sun Mon Tue Wed Thu Fri Sat   Sun Mon Tue Wed Thu Fri Sat
diff --git a/tests/expected/cal/year-ysjw b/tests/expected/cal/year-ysjw
index 69dbae3ad..800ec0cf7 100644
--- a/tests/expected/cal/year-ysjw
+++ b/tests/expected/cal/year-ysjw
@@ -1,5 +1,5 @@
 Julian - Sunday-based week with week numbers
-                              2006                             
+                                              2006                                              
 
             January                         February                           March            
    Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat      Sun Mon Tue Wed Thu Fri Sat
-- 
2.20.1

