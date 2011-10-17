Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 37/49] tests: remove obsolete checktty test
Date: Mon, 17 Oct 2011 13:15:16 +0200
Message-Id: <1318850128-23458-38-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 tests/expected/login/checktty |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)
 delete mode 100644 tests/expected/login/checktty

diff --git a/tests/expected/login/checktty b/tests/expected/login/checktty
deleted file mode 100644
index 2e1b2c1..0000000
--- a/tests/expected/login/checktty
+++ /dev/null
@@ -1,8 +0,0 @@
-hnmatch() on 130.225.16.0/255.255.254.0     <-- 130.225.16.1   : match
-hnmatch() on 130.225.16.0/255.255.254.0     <-- 10.20.30.1     : mismatch
-hnmatch() on 130.225.0.0/255.254.0.0        <-- 130.225.16.1   : match
-hnmatch() on 130.225.0.0/255.254.0.0        <-- 130.225.17.1   : match
-hnmatch() on 130.225.0.0/255.254.0.0        <-- 150.160.170.180: mismatch
-hnmatch() on [3ffe:505:2:1::]/64            <-- 3ffe:505:2:1:: : match
-hnmatch() on [3ffe:505:2:1::]/64            <-- 3ffe:505:2:2:: : mismatch
-hnmatch() on [3ffe:505:2:1::]/64            <-- 3ffe:505:2:1:ffff:ffff::: match
-- 
1.7.6.4
