Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:56393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbdFOXjT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Jun 2017 19:39:19 -0400
Subject: [PATCH 02/10] parse-date: remove unused EPOCH_YEAR
To: Karel Zak <kzak@redhat.com>
References: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <78833b6e-0abc-b5b8-9661-b16fd9442c0a@gmx.com>
Date: Thu, 15 Jun 2017 19:39:03 -0400
MIME-Version: 1.0
In-Reply-To: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Reported-by: Ruediger Meier <ruediger.meier@ga-group.nl>
Influenced-by: gnulib 30784c4 Paul Eggert <eggert@cs.ucla.edu>
Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/parse-date.y | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/parse-date.y b/lib/parse-date.y
index f4f9a10..97f4db9 100644
--- a/lib/parse-date.y
+++ b/lib/parse-date.y
@@ -109,7 +109,6 @@
 	 ? (a) >> (b) \
 	 : (a) / (1 << (b)) - ((a) % (1 << (b)) < 0))
 
-#define EPOCH_YEAR 1970
 #define TM_YEAR_BASE 1900
 
 #define HOUR(x) ((x) * 60)
