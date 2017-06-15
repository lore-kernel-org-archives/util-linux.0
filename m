Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:59066 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751590AbdFOXqT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Jun 2017 19:46:19 -0400
Subject: [PATCH 07/10] parse-date: refactor tm_diff()
To: Karel Zak <kzak@redhat.com>
References: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <c7c83981-f744-303e-aa25-4143ae819aea@gmx.com>
Date: Thu, 15 Jun 2017 19:46:04 -0400
MIME-Version: 1.0
In-Reply-To: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Reported-by: Ruediger Meier <ruediger.meier@ga-group.nl>
Influenced-by: gnulib 30784c4 Paul Eggert <eggert@cs.ucla.edu>
Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/parse-date.y | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/parse-date.y b/lib/parse-date.y
index 620626e..f96fc09 100644
--- a/lib/parse-date.y
+++ b/lib/parse-date.y
@@ -957,7 +957,7 @@ static table const * lookup_zone(parser_control const *pc, char const *name)
  * The body of this function is taken directly from the GNU C Library;
  * see src/strftime.c.
  */
-static long int tm_diff(struct tm const *a, struct tm const *b)
+static int tm_diff(struct tm const *a, struct tm const *b)
 {
 	/**
 	 * Compute intervening leap days correctly even if year is negative.
@@ -970,8 +970,7 @@ static long int tm_diff(struct tm const *a, struct tm const *b)
 	int a400 = SHR (a100, 2);
 	int b400 = SHR (b100, 2);
 	int intervening_leap_days = (a4 - b4) - (a100 - b100) + (a400 - b400);
-	int ayear = a->tm_year;
-	int years = ayear - b->tm_year;
+	int years = a->tm_year - b->tm_year;
 	int days = (365 * years + intervening_leap_days
 			 + (a->tm_yday - b->tm_yday));
 	return (60 * (60 * (24 * days + (a->tm_hour - b->tm_hour))
