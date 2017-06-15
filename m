Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:52839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbdFOXrQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Jun 2017 19:47:16 -0400
Subject: [PATCH 08/10] parse-date: remove unused year_seen
To: Karel Zak <kzak@redhat.com>
References: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <54b798d9-f88e-a2dd-f2ab-45d972fbfd4a@gmx.com>
Date: Thu, 15 Jun 2017 19:47:06 -0400
MIME-Version: 1.0
In-Reply-To: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/parse-date.y | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/parse-date.y b/lib/parse-date.y
index f96fc09..6ab7ef2 100644
--- a/lib/parse-date.y
+++ b/lib/parse-date.y
@@ -206,7 +206,6 @@ typedef struct {
 	size_t dsts_seen;
 	size_t times_seen;
 	size_t zones_seen;
-	size_t year_seen;
 
 	/* 1 if the user specified explicit ordinal day value, */
 	int ordinal_day_seen;
@@ -229,7 +228,6 @@ static void digits_to_date_time(parser_control *pc, textint text_int)
 {
 	if (pc->dates_seen && ! pc->year.digits
 	    && ! pc->rels_seen && (pc->times_seen || 2 < text_int.digits)) {
-		pc->year_seen++;
 		pc->year = text_int;
 	} else {
 		if (4 < text_int.digits) {
@@ -1368,7 +1366,6 @@ int parse_date(struct timespec *result, char const *p,
 	pc.local_zones_seen = 0;
 	pc.dsts_seen = 0;
 	pc.zones_seen = 0;
-	pc.year_seen = 0;
 	pc.ordinal_day_seen = 0;
 
 #if HAVE_STRUCT_TM_TM_ZONE
