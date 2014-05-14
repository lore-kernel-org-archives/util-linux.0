Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f53.google.com ([209.85.160.53]:43025 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbaENFK4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 14 May 2014 01:10:56 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so1189361pbc.26
        for <util-linux@vger.kernel.org>; Tue, 13 May 2014 22:10:56 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH v3 3/5] libsmartcols/src/smartcolsP.h: add field to struct libscols_column
Date: Wed, 14 May 2014 11:09:58 +0600
Message-Id: <1400044200-9196-3-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1400044200-9196-1-git-send-email-shakursmullick@gmail.com>
References: <1400044200-9196-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Shakur Shams Mullick <shakursmullick@gmail.com>
---
 libsmartcols/src/smartcolsP.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsmartcols/src/smartcolsP.h b/libsmartcols/src/smartcolsP.h
index ebdc929..ee3ee1a 100644
--- a/libsmartcols/src/smartcolsP.h
+++ b/libsmartcols/src/smartcolsP.h
@@ -82,7 +82,9 @@ struct libscols_column {
 	int	flags;
 	int	is_extreme;
 	char	*color;		/* default column color */
-
+	
+	int (*compare_data)(struct libscols_cell *, struct libscols_cell *, void *); /* comparison function to use*/
+	
 	struct libscols_cell	header;
 	struct list_head	cl_columns;
 };
-- 
1.8.3.2

