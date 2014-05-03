Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f171.google.com ([209.85.192.171]:65041 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbaECRma (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 May 2014 13:42:30 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so6275666pdi.30
        for <util-linux@vger.kernel.org>; Sat, 03 May 2014 10:42:29 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH 3/8] libsmartcols/src/smartcolsP.h: add sort flag and related enum
Date: Sat,  3 May 2014 23:41:23 +0600
Message-Id: <1399138888-7554-3-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
References: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Shakur Shams Mullick <shakursmullick@gmail.com>
---
 libsmartcols/src/smartcolsP.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/libsmartcols/src/smartcolsP.h b/libsmartcols/src/smartcolsP.h
index ebdc929..d7b9982 100644
--- a/libsmartcols/src/smartcolsP.h
+++ b/libsmartcols/src/smartcolsP.h
@@ -44,7 +44,7 @@ UL_DEBUG_DECLARE_MASK(libsmartcols);
 struct libscols_iter {
 	struct list_head        *p;		/* current position */
 	struct list_head        *head;		/* start position */
-	int			direction;	/* SCOLS_ITER_{FOR,BACK}WARD */
+	int						direction;	/* SCOLS_ITER_{FOR,BACK}WARD */
 };
 
 /*
@@ -108,11 +108,16 @@ struct libscols_line {
 };
 
 enum {
-	SCOLS_FMT_HUMAN = 0,		/* default, human readable */
+	SCOLS_FMT_HUMAN = 0,	/* default, human readable */
 	SCOLS_FMT_RAW,			/* space separated */
 	SCOLS_FMT_EXPORT		/* COLNAME="data" ... */
 };
 
+enum{
+	SCOLS_SORT_NAME = 0,	/* sort by name */
+	SCOLS_SORT_SIZE     	/* sort by size */
+};
+
 /*
  * The table
  */
@@ -133,13 +138,15 @@ struct libscols_table {
 	struct libscols_symbols	*symbols;
 
 	int	format;		/* SCOLS_FMT_* */
-
+	
+	int sort;		/* SCOLS_SORT_* */
+	
 	/* flags */
 	unsigned int	ascii		:1,	/* don't use unicode */
-			colors_wanted	:1,	/* enable colors */
-			is_term		:1,	/* isatty() */
-			maxout		:1,	/* maximalize output */
-			no_headings	:1;	/* don't print header */
+		colors_wanted	:1,	/* enable colors */
+		is_term		:1,	/* isatty() */
+		maxout		:1,	/* maximalize output */
+		no_headings	:1;	/* don't print header */
 };
 
 #define IS_ITER_FORWARD(_i)	((_i)->direction == SCOLS_ITER_FORWARD)
-- 
1.8.3.2

