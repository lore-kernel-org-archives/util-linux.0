Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.186]:62788 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab2FONmP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 15 Jun 2012 09:42:15 -0400
Message-ID: <4FDB3BB4.8060509@bernhard-voelker.de>
Date: Fri, 15 Jun 2012 15:42:12 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] lsblk: permit option --exclude more than once
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


>From 03746408a33cfc393370caabbe8da1bdfef5f484 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Fri, 15 Jun 2012 15:40:35 +0200
Subject: [PATCH] lsblk: permit option --exclude more than once

Previously, `lsblk -e 8 -e 11` did not exlude maj:8 as requested.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 misc-utils/lsblk.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 24fb44f..bd5e6b7 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -153,8 +153,8 @@ struct lsblk *lsblk;	/* global handler */
 int columns[NCOLS];/* enabled columns */
 int ncolumns;		/* number of enabled columns */

-int excludes[256];
-size_t nexcludes;
+static int excludes[256];
+static size_t nexcludes;

 static struct libmnt_table *mtab, *swaps;
 static struct libmnt_cache *mntcache;
@@ -1080,8 +1080,6 @@ leave:

 static void parse_excludes(const char *str)
 {
-	nexcludes = 0;
-
 	while (str && *str) {
 		char *end = NULL;
 		unsigned long n;
-- 
1.7.7


