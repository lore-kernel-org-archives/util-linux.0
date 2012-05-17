Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:38542 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759523Ab2EQHlP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 May 2012 03:41:15 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id F137D8FA98
	for <util-linux@vger.kernel.org>; Thu, 17 May 2012 09:41:14 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 1/4] last: use min() from c.h
Date: Thu, 17 May 2012 09:41:06 +0200
Message-Id: <1337240469-24539-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 login-utils/last.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 34558bb..62fc55c 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -72,15 +72,11 @@ static struct utmp	utmpbuf;
 #define	LMAX	(int)sizeof(utmpbuf.ut_line)	/* size of utmp tty field */
 #define	NMAX	(int)sizeof(utmpbuf.ut_name)	/* size of utmp name field */
 
-#ifndef MIN
-#define MIN(a,b)	(((a) < (b)) ? (a) : (b))
-#endif
-
 /* maximum sizes used for printing */
 /* probably we want a two-pass version that computes the right length */
-int hmax = MIN(HMAX, 16);
-int lmax = MIN(LMAX, 8);
-int nmax = MIN(NMAX, 16);
+int hmax = min(HMAX, 16);
+int lmax = min(LMAX, 8);
+int nmax = min(NMAX, 16);
 
 typedef struct arg {
 	char	*name;				/* argument */
-- 
1.7.7

