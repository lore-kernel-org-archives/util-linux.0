Return-Path: elseifthen@gmx.com
Subject: [PATCH 09/10] parse-date: remove unused ordinal_day_seen
To: Karel Zak <kzak@redhat.com>
References: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ba6fcc9a-778e-123e-64d3-eec286b92eaa@gmx.com>
Date: Thu, 15 Jun 2017 19:48:14 -0400
MIME-Version: 1.0
In-Reply-To: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/parse-date.y | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/parse-date.y b/lib/parse-date.y
index 6ab7ef2..c06616a 100644
--- a/lib/parse-date.y
+++ b/lib/parse-date.y
@@ -207,9 +207,6 @@ typedef struct {
 	size_t times_seen;
 	size_t zones_seen;
 
-	/* 1 if the user specified explicit ordinal day value, */
-	int ordinal_day_seen;
-
 	/* Table of local time zone abbreviations, null terminated. */
 	table local_time_zone_table[3];
 } parser_control;
@@ -480,12 +477,10 @@ day:
 	| tORDINAL tDAY {
 		pc->day_ordinal = $1;
 		pc->day_number = $2;
-		pc->ordinal_day_seen = 1;
 	  }
 	| tUNUMBER tDAY {
 		pc->day_ordinal = $1.value;
 		pc->day_number = $2;
-		pc->ordinal_day_seen = 1;
 	  }
 ;
 
@@ -1366,7 +1361,6 @@ int parse_date(struct timespec *result, char const *p,
 	pc.local_zones_seen = 0;
 	pc.dsts_seen = 0;
 	pc.zones_seen = 0;
-	pc.ordinal_day_seen = 0;
 
 #if HAVE_STRUCT_TM_TM_ZONE
 	pc.local_time_zone_table[0].name = tmp->tm_zone;
