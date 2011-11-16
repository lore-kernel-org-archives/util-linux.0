Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp5-g21.free.fr ([212.27.42.5]:60675 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831Ab1KPTKt (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 16 Nov 2011 14:10:49 -0500
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 7FA2CD483E8
	for <util-linux-ng@vger.kernel.org>; Wed, 16 Nov 2011 20:10:41 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id E669060042
	for <util-linux-ng@vger.kernel.org>; Wed, 16 Nov 2011 20:10:39 +0100 (CET)
From: Jim Meyering <jim@meyering.net>
To: List util-linux-ng <util-linux-ng@vger.kernel.org>
Subject: [PATCH] column: avoid memory overrun and/or use of uninitialized buffer
Date: Wed, 16 Nov 2011 20:10:39 +0100
Message-ID: <87fwhn6fyo.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


* text-utils/column.c (maketbl): Use the right starting point
and the right length when zeroing new memory after xrealloc.
---
Hi,

I ran coverity on the latest from git and it caught part of this (the
erroneous offset-by-sizeof).  I noticed that the "int" should be size_t
or -- better -- *lens.  With the latter, there is no risk that
a type change will fail to propagate to this sizeof stmt.

 text-utils/column.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index f8fd350..79d2842 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -305,8 +305,8 @@ static void maketbl(wchar_t **list, int entries, wchar_t *separator)
 				cols = xrealloc(cols, maxcols * sizeof(wchar_t *));
 				lens = xrealloc(lens, maxcols * sizeof(ssize_t));
 				/* zero fill only new memory */
-				memset(lens + ((maxcols - DEFCOLS) * sizeof(ssize_t)), 0,
-				       DEFCOLS * sizeof(int));
+				memset(lens + (maxcols - DEFCOLS), 0,
+				       DEFCOLS * sizeof(*lens));
 			}
 			p = NULL;
 		}
--
1.7.8.rc2
