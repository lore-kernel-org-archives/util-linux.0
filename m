Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35038 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932840AbcBBRtu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Feb 2016 12:49:50 -0500
Received: by mail-wm0-f65.google.com with SMTP id l66so3489696wml.2
        for <util-linux@vger.kernel.org>; Tue, 02 Feb 2016 09:49:50 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/3] tests: update colcrt test expectations
Date: Tue,  2 Feb 2016 17:49:40 +0000
Message-Id: <1454435380-1354-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1454435380-1354-1-git-send-email-kerolasa@iki.fi>
References: <1454435380-1354-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The reimplementation caused output to change in some corner cases, such as
how binary inputs, long lines with underscores, and white space trimming,
are handled.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/colcrt/functional-half-lines     |  22 +-
 tests/expected/colcrt/functional-no-options     |  20 +-
 tests/expected/colcrt/functional-no-underlining |  16 +-
 tests/expected/colcrt/functional-short-options  |  18 +-
 tests/expected/colcrt/regressions-crash1        |   1 +
 tests/expected/colcrt/regressions-crash2        | 392 +-----------------------
 6 files changed, 49 insertions(+), 420 deletions(-)

diff --git a/tests/expected/colcrt/functional-half-lines b/tests/expected/colcrt/functional-half-lines
index 07a85ab..a7957f8 100644
--- a/tests/expected/colcrt/functional-half-lines
+++ b/tests/expected/colcrt/functional-half-lines
@@ -1,9 +1,9 @@
 
-   100  
+   100
         -
-   101  
+   101
         --
-   102  
+   102
         ---
    103   x
         - --
@@ -11,9 +11,11 @@
 
    105  esc9
 
-
    106  esc8
-   107  esc7
+
+   107  esc
+
+   108  esc6
 
    109  backspace
 
@@ -27,18 +29,18 @@
 
    114  |   |
          ---
-   115  line longer than 132 characters line longer than 132 characters line longer than 132 characters line longer than 132 ch01234            -      -    -   -          -    -      -    -   -          -    -      -    -   -          -    -      -    -   -
+   115  line longer than 132 characters line longer than 132 characters line longer than 132 characters line longer than 132 ch01234
             -      -    -   -          -    -      -    -   -          -    -      -    -   -          -    -      -    -   -
    116  nulls
 
    117  next line ascii 0 - 127
 
-   118  
+   118
 
-)*+119/0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^ `abcdefghijklmnopqrstuvwxyz{|}~
-                                                      -
+   119
+                                                                        -
 
-   200  
+   200
         ---
    201  abc
 
diff --git a/tests/expected/colcrt/functional-no-options b/tests/expected/colcrt/functional-no-options
index 3ee7c07..4b41b07 100644
--- a/tests/expected/colcrt/functional-no-options
+++ b/tests/expected/colcrt/functional-no-options
@@ -1,16 +1,16 @@
-   100  
+   100
         -
-   101  
+   101
         --
-   102  
+   102
         ---
    103   x
         - --
    104  shift
    105  esc9
-
    106  esc8
-   107  esc7
+   107  esc
+   108  esc6
    109  backspace
    110  tab     tab
    111  abc  efg
@@ -19,14 +19,14 @@
    113  | x |
    114  |   |
          ---
-   115  line longer than 132 characters line longer than 132 characters line longer than 132 characters line longer than 132 ch01234            -      -    -   -          -    -      -    -   -          -    -      -    -   -          -    -      -    -   -
+   115  line longer than 132 characters line longer than 132 characters line longer than 132 characters line longer than 132 ch01234
             -      -    -   -          -    -      -    -   -          -    -      -    -   -          -    -      -    -   -
    116  nulls
    117  next line ascii 0 - 127
-   118  
-)*+119/0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^ `abcdefghijklmnopqrstuvwxyz{|}~
-                                                      -
-   200  
+   118
+   119
+                                                                        -
+   200
         ---
    201  abc
    202   abc
diff --git a/tests/expected/colcrt/functional-no-underlining b/tests/expected/colcrt/functional-no-underlining
index e0e877f..306734c 100644
--- a/tests/expected/colcrt/functional-no-underlining
+++ b/tests/expected/colcrt/functional-no-underlining
@@ -1,12 +1,12 @@
-   100  
-   101  
-   102  
+   100
+   101
+   102
    103   x
    104  shift
    105  esc9
-
    106  esc8
-   107  esc7
+   107  esc
+   108  esc6
    109  backspace
    110  tab     tab
    111  abc  efg
@@ -16,9 +16,9 @@
    115  line longer than 132 characters line longer than 132 characters line longer than 132 characters line longer than 132 ch01234
    116  nulls
    117  next line ascii 0 - 127
-   118  
-)*+119/0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^ `abcdefghijklmnopqrstuvwxyz{|}~
-   200  
+   118
+   119
+   200
    201  abc
    202   abc
    203  a bc
diff --git a/tests/expected/colcrt/functional-short-options b/tests/expected/colcrt/functional-short-options
index 09a870e..bd2d44b 100644
--- a/tests/expected/colcrt/functional-short-options
+++ b/tests/expected/colcrt/functional-short-options
@@ -1,9 +1,9 @@
 
-   100  
+   100
 
-   101  
+   101
 
-   102  
+   102
 
    103   x
 
@@ -11,9 +11,11 @@
 
    105  esc9
 
-
    106  esc8
-   107  esc7
+
+   107  esc
+
+   108  esc6
 
    109  backspace
 
@@ -33,12 +35,12 @@
 
    117  next line ascii 0 - 127
 
-   118  
+   118
 
-)*+119/0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^ `abcdefghijklmnopqrstuvwxyz{|}~
+   119
 
 
-   200  
+   200
 
    201  abc
 
diff --git a/tests/expected/colcrt/regressions-crash1 b/tests/expected/colcrt/regressions-crash1
index a221b56..67a7b1c 100644
--- a/tests/expected/colcrt/regressions-crash1
+++ b/tests/expected/colcrt/regressions-crash1
@@ -1 +1,2 @@
+ W U;    U;  D  f U;  D  f    D  f    >     @W  ]~   K- -  ----  -- -- -  -- -- ---- -- ---- --  -  --  --- --
 return value: 0
diff --git a/tests/expected/colcrt/regressions-crash2 b/tests/expected/colcrt/regressions-crash2
index a4472fa..11ebf74 100644
--- a/tests/expected/colcrt/regressions-crash2
+++ b/tests/expected/colcrt/regressions-crash2
@@ -1,386 +1,10 @@
-        
-
-FGHIKIJKN\|
-
-MN9|    
-XYZRnT RnTUV|   NXP:w|  
 
+FGHIKIJKN\
+MN9|
+XYZRnT RnTUV|   NXP:w
 MN
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-'QRnTUVWXYZQRnTU|
-
-MN9|    
-|       
-
-return value: 0
+'QRnTUVWXYZQRnTU
+MN9|
+XYZ nT RnTUV|   NXP:w
+   -
+MNOP.return value: 0
-- 
2.7.0

