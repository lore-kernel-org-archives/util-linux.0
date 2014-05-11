Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f175.google.com ([209.85.192.175]:64895 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbaEKIVV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 04:21:21 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so5327062pdj.34
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 01:21:20 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH v2 3/8] libsmartcols/src/smartcolsP.h: add new field to struct libscols_table
Date: Sun, 11 May 2014 14:20:33 +0600
Message-Id: <1399796438-5495-3-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
References: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 libsmartcols/src/smartcolsP.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/libsmartcols/src/smartcolsP.h b/libsmartcols/src/smartcolsP.h
index ebdc929..c686c2b 100644
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
@@ -82,6 +82,8 @@ struct libscols_column {
 	int	flags;
 	int	is_extreme;
 	char	*color;		/* default column color */
+	
+	int (*compar)(struct libscols_cell *, struct libscols_cell *, void *); /* comparison function to use*/
 
 	struct libscols_cell	header;
 	struct list_head	cl_columns;
@@ -108,7 +110,7 @@ struct libscols_line {
 };
 
 enum {
-	SCOLS_FMT_HUMAN = 0,		/* default, human readable */
+	SCOLS_FMT_HUMAN = 0,	/* default, human readable */
 	SCOLS_FMT_RAW,			/* space separated */
 	SCOLS_FMT_EXPORT		/* COLNAME="data" ... */
 };
@@ -131,15 +133,16 @@ struct libscols_table {
 	struct list_head	tb_columns;
 	struct list_head	tb_lines;
 	struct libscols_symbols	*symbols;
+	struct libscols_column *key_cl; /* key column */
 
 	int	format;		/* SCOLS_FMT_* */
-
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

