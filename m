Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:54268 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933614AbdCWUg2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 23 Mar 2017 16:36:28 -0400
Subject: [PATCH] hwclock: try the 'new' rtc class first
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <b1d10b04-eb5a-627d-b227-c23cc2a5bae2@gmx.com>
Date: Thu, 23 Mar 2017 16:36:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


* sys-utils/hwclock-rtc.c: try to open the 'new' rtc class driver first.
* sys-utils/hwclock.8.in: document this.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
The following changes since commit 24d746f705c488b28693b1c18c730de3c7202b3d:

  build-sys: add missing header file (2017-03-23 15:59:58 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git hwclock-date7-1

for you to fetch changes up to 1811900a91be856e794005511eac7859adb8e383:

  hwclock-rtc.c: try the 'new' rtc class first (2017-03-23 16:14:01 -0400)

----------------------------------------------------------------
J William Piggott (1):
      hwclock-rtc.c: try the 'new' rtc class first

 sys-utils/hwclock-rtc.c | 2 +-
 sys-utils/hwclock.8.in  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index 411ec43..077db73 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -110,8 +110,8 @@ static int open_rtc(const struct hwclock_control *ctl)
 		"/dev/efirtc",
 		"/dev/misc/efirtc",
 #endif
-		"/dev/rtc",
 		"/dev/rtc0",
+		"/dev/rtc",
 		"/dev/misc/rtc"
 	};
 	size_t i;
diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 78e53ae..45ff73f 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -337,10 +337,10 @@ default rtc device file name.  Otherwise it will
 use the first one found in this order:
 .in +4
 .br
-.I /dev/rtc
-.br
 .I /dev/rtc0
 .br
+.I /dev/rtc
+.br
 .I /dev/misc/rtc
 .br
 .in
@@ -1010,10 +1010,10 @@ Device files
 .B hwclock
 may try for Hardware Clock access:
 .br
-.I /dev/rtc
-.br
 .I /dev/rtc0
 .br
+.I /dev/rtc
+.br
 .I /dev/misc/rtc
 .br
 .I /dev/efirtc
