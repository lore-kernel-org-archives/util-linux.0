Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52080 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750994AbdFVAwP (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 20:52:15 -0400
Subject: [PATCH 1/2] hwclock: remove unused optstring characters
To: Karel Zak <kzak@redhat.com>
References: <22e50897-04c9-a413-3b84-d2f968185c43@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <06ba14cb-e461-0aaf-f592-836b40bba331@gmx.com>
Date: Wed, 21 Jun 2017 20:51:59 -0400
MIME-Version: 1.0
In-Reply-To: <22e50897-04c9-a413-3b84-d2f968185c43@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


getopt_long() opstring contained obsolete entries.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 5433cd0..f6a87c7 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1355,7 +1355,7 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 
 	while ((c = getopt_long(argc, argv,
-				"?hvVDalrsuwAJSFf:", longopts, NULL)) != -1) {
+				"hvVDalrsuwf:", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
