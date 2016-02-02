Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36591 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932840AbcBBRts (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Feb 2016 12:49:48 -0500
Received: by mail-wm0-f68.google.com with SMTP id 128so3488223wmz.3
        for <util-linux@vger.kernel.org>; Tue, 02 Feb 2016 09:49:47 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/3] tests: add colcrt functional tests
Date: Tue,  2 Feb 2016 17:49:38 +0000
Message-Id: <1454435380-1354-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1454435380-1354-1-git-send-email-kerolasa@iki.fi>
References: <1454435380-1354-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Output formats are based on colcrt before recent asan fixes and magic
constant replace, that are the commits ee24ab6f1..70e3fcf29.  It seems the
fixes caused unintentional, and not detected change to output format - which
to me means colcrt has a regression that got to be part of release v2.27.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/colcrt/functional                |   0
 tests/expected/colcrt/functional-half-lines     |  87 ++++++++++++++++++++++++
 tests/expected/colcrt/functional-no-options     |  74 ++++++++++++++++++++
 tests/expected/colcrt/functional-no-underlining |  44 ++++++++++++
 tests/expected/colcrt/functional-short-options  |  87 ++++++++++++++++++++++++
 tests/expected/colcrt/regressions               |   0
 tests/ts/colcrt/functional                      |  50 ++++++++++++++
 tests/ts/colcrt/nasty-input                     | Bin 0 -> 545 bytes
 tests/ts/colcrt/underlines                      |  23 +++++++
 9 files changed, 365 insertions(+)
 create mode 100644 tests/expected/colcrt/functional
 create mode 100644 tests/expected/colcrt/functional-half-lines
 create mode 100644 tests/expected/colcrt/functional-no-options
 create mode 100644 tests/expected/colcrt/functional-no-underlining
 create mode 100644 tests/expected/colcrt/functional-short-options
 create mode 100644 tests/expected/colcrt/regressions
 create mode 100755 tests/ts/colcrt/functional
 create mode 100644 tests/ts/colcrt/nasty-input
 create mode 100644 tests/ts/colcrt/underlines

diff --git a/tests/expected/colcrt/functional b/tests/expected/colcrt/functional
new file mode 100644
index 0000000..e69de29
diff --git a/tests/expected/colcrt/functional-half-lines b/tests/expected/colcrt/functional-half-lines
new file mode 100644
index 0000000..07a85ab
--- /dev/null
+++ b/tests/expected/colcrt/functional-half-lines
@@ -0,0 +1,87 @@
+
+   100  
+        -
+   101  
+        --
+   102  
+        ---
+   103   x
+        - --
+   104  shift
+
+   105  esc9
+
+
+   106  esc8
+   107  esc7
+
+   109  backspace
+
+   110  tab     tab
+
+   111  abc  efg
+           -    -
+   112  |---|
+
+   113  | x |
+
+   114  |   |
+         ---
+   115  line longer than 132 characters line longer than 132 characters line longer than 132 characters line longer than 132 ch01234            -      -    -   -          -    -      -    -   -          -    -      -    -   -          -    -      -    -   -
+            -      -    -   -          -    -      -    -   -          -    -      -    -   -          -    -      -    -   -
+   116  nulls
+
+   117  next line ascii 0 - 127
+
+   118  
+
+)*+119/0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^ `abcdefghijklmnopqrstuvwxyz{|}~
+                                                      -
+
+   200  
+        ---
+   201  abc
+
+   202   abc
+        -
+   203  a bc
+         -
+   204  ab c
+          -
+   205  abc
+           -
+   206    abc
+        --
+   207  a  bc
+         --
+   208  ab  c
+          --
+   209  abc
+           --
+   210   a bc
+        - -
+   211   ab c
+        -  -
+   212  a b c
+         - -
+   213  a  bc
+         --
+   214  a bc
+         -  -
+   215  abc
+           --
+   216   abc
+        -   -
+   217   a b c
+        - - -
+   218   a  bc
+        - --
+   219  a  bc
+         --  -
+   220   abc
+        -   --
+   221     abc
+        ---
+   222  abc
+           ---
+return value: 0
diff --git a/tests/expected/colcrt/functional-no-options b/tests/expected/colcrt/functional-no-options
new file mode 100644
index 0000000..3ee7c07
--- /dev/null
+++ b/tests/expected/colcrt/functional-no-options
@@ -0,0 +1,74 @@
+   100  
+        -
+   101  
+        --
+   102  
+        ---
+   103   x
+        - --
+   104  shift
+   105  esc9
+
+   106  esc8
+   107  esc7
+   109  backspace
+   110  tab     tab
+   111  abc  efg
+           -    -
+   112  |---|
+   113  | x |
+   114  |   |
+         ---
+   115  line longer than 132 characters line longer than 132 characters line longer than 132 characters line longer than 132 ch01234            -      -    -   -          -    -      -    -   -          -    -      -    -   -          -    -      -    -   -
+            -      -    -   -          -    -      -    -   -          -    -      -    -   -          -    -      -    -   -
+   116  nulls
+   117  next line ascii 0 - 127
+   118  
+)*+119/0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^ `abcdefghijklmnopqrstuvwxyz{|}~
+                                                      -
+   200  
+        ---
+   201  abc
+   202   abc
+        -
+   203  a bc
+         -
+   204  ab c
+          -
+   205  abc
+           -
+   206    abc
+        --
+   207  a  bc
+         --
+   208  ab  c
+          --
+   209  abc
+           --
+   210   a bc
+        - -
+   211   ab c
+        -  -
+   212  a b c
+         - -
+   213  a  bc
+         --
+   214  a bc
+         -  -
+   215  abc
+           --
+   216   abc
+        -   -
+   217   a b c
+        - - -
+   218   a  bc
+        - --
+   219  a  bc
+         --  -
+   220   abc
+        -   --
+   221     abc
+        ---
+   222  abc
+           ---
+return value: 0
diff --git a/tests/expected/colcrt/functional-no-underlining b/tests/expected/colcrt/functional-no-underlining
new file mode 100644
index 0000000..e0e877f
--- /dev/null
+++ b/tests/expected/colcrt/functional-no-underlining
@@ -0,0 +1,44 @@
+   100  
+   101  
+   102  
+   103   x
+   104  shift
+   105  esc9
+
+   106  esc8
+   107  esc7
+   109  backspace
+   110  tab     tab
+   111  abc  efg
+   112  |---|
+   113  | x |
+   114  |   |
+   115  line longer than 132 characters line longer than 132 characters line longer than 132 characters line longer than 132 ch01234
+   116  nulls
+   117  next line ascii 0 - 127
+   118  
+)*+119/0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^ `abcdefghijklmnopqrstuvwxyz{|}~
+   200  
+   201  abc
+   202   abc
+   203  a bc
+   204  ab c
+   205  abc
+   206    abc
+   207  a  bc
+   208  ab  c
+   209  abc
+   210   a bc
+   211   ab c
+   212  a b c
+   213  a  bc
+   214  a bc
+   215  abc
+   216   abc
+   217   a b c
+   218   a  bc
+   219  a  bc
+   220   abc
+   221     abc
+   222  abc
+return value: 0
diff --git a/tests/expected/colcrt/functional-short-options b/tests/expected/colcrt/functional-short-options
new file mode 100644
index 0000000..09a870e
--- /dev/null
+++ b/tests/expected/colcrt/functional-short-options
@@ -0,0 +1,87 @@
+
+   100  
+
+   101  
+
+   102  
+
+   103   x
+
+   104  shift
+
+   105  esc9
+
+
+   106  esc8
+   107  esc7
+
+   109  backspace
+
+   110  tab     tab
+
+   111  abc  efg
+
+   112  |---|
+
+   113  | x |
+
+   114  |   |
+
+   115  line longer than 132 characters line longer than 132 characters line longer than 132 characters line longer than 132 ch01234
+
+   116  nulls
+
+   117  next line ascii 0 - 127
+
+   118  
+
+)*+119/0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^ `abcdefghijklmnopqrstuvwxyz{|}~
+
+
+   200  
+
+   201  abc
+
+   202   abc
+
+   203  a bc
+
+   204  ab c
+
+   205  abc
+
+   206    abc
+
+   207  a  bc
+
+   208  ab  c
+
+   209  abc
+
+   210   a bc
+
+   211   ab c
+
+   212  a b c
+
+   213  a  bc
+
+   214  a bc
+
+   215  abc
+
+   216   abc
+
+   217   a b c
+
+   218   a  bc
+
+   219  a  bc
+
+   220   abc
+
+   221     abc
+
+   222  abc
+
+return value: 0
diff --git a/tests/expected/colcrt/regressions b/tests/expected/colcrt/regressions
new file mode 100644
index 0000000..e69de29
diff --git a/tests/ts/colcrt/functional b/tests/ts/colcrt/functional
new file mode 100755
index 0000000..5c97d24
--- /dev/null
+++ b/tests/ts/colcrt/functional
@@ -0,0 +1,50 @@
+#!/bin/bash
+
+#
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
+#
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="functional"
+
+export LC_CTYPE='C'
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_COLCRT"
+
+ts_init_subtest 'no-options'
+$TS_CMD_COLCRT < $TS_SELF/nasty-input >> $TS_OUTPUT 2>&1
+$TS_CMD_COLCRT < $TS_SELF/underlines >> $TS_OUTPUT 2>&1
+echo "return value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+ts_init_subtest 'no-underlining'
+$TS_CMD_COLCRT --no-underlining < $TS_SELF/nasty-input >> $TS_OUTPUT 2>&1
+$TS_CMD_COLCRT --no-underlining < $TS_SELF/underlines >> $TS_OUTPUT 2>&1
+echo "return value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+ts_init_subtest 'half-lines'
+$TS_CMD_COLCRT --half-lines < $TS_SELF/nasty-input >> $TS_OUTPUT 2>&1
+$TS_CMD_COLCRT --half-lines < $TS_SELF/underlines >> $TS_OUTPUT 2>&1
+echo "return value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+ts_init_subtest 'short-options'
+$TS_CMD_COLCRT - -2 $TS_SELF/nasty-input >> $TS_OUTPUT 2>&1
+$TS_CMD_COLCRT - -2 $TS_SELF/underlines >> $TS_OUTPUT 2>&1
+echo "return value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+ts_finalize
diff --git a/tests/ts/colcrt/nasty-input b/tests/ts/colcrt/nasty-input
new file mode 100644
index 0000000000000000000000000000000000000000..5e541bc32f9e8c5869d825b514c01e5835a9f5e6
GIT binary patch
literal 545
zcmcJL2UEf@7>02Z9Jp5<anEW~pu@fQ-aCd`Xr&gUMXOf*>rw*x3(Q^ao+n>&_vVEV
zB8~$%06jne=ZVi!9zy^-1rCE6OVeX^klv2~)ly_erY3kMF%mV=Gm#OgNuCLeKurcw
zq9m*oQB;5K1aZJ7QEyX4fJ7Ax)mWT{Ks<0+mUZbg1YGFAyo7<9jhdGTgobXa*hrdj
zHH~eJm>7k4tY{=n6kAPO_@Cw+;zQwxAWF0hBmm#<GBbu@6^wpC1g7fPxv-E}impQr
zvJmmKE+he8QE^FWS$TyY&<8T8tg5aF*4EWGG&VK2w6?V~9i3g>u&1}Le_(KEcw}^J
zoSm5bi!n7lGdnlGu(-6mvbwguvAMOqv%9x{aCmfla(Z@tad~xpb9;yHvpqj#Yu5C~
Ygz;o1Q_pG3&b+)jZ|@)O=ht`O2N;uykN^Mx

literal 0
HcmV?d00001

diff --git a/tests/ts/colcrt/underlines b/tests/ts/colcrt/underlines
new file mode 100644
index 0000000..940c7a8
--- /dev/null
+++ b/tests/ts/colcrt/underlines
@@ -0,0 +1,23 @@
+   200	___
+   201	abc
+   202	_abc
+   203	a_bc
+   204	ab_c
+   205	abc_
+   206	__abc
+   207	a__bc
+   208	ab__c
+   209	abc__
+   210	_a_bc
+   211	_ab_c
+   212	a_b_c
+   213	a__bc
+   214	a_bc_
+   215	abc__
+   216	_abc_
+   217	_a_b_c
+   218	_a__bc
+   219	a__bc_
+   220	_abc__
+   221	___abc
+   222	abc___
-- 
2.7.0

