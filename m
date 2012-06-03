Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:41755 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477Ab2FCQZt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jun 2012 12:25:49 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] libmount/optstr: trim leading commas from each opt
Date: Sun,  3 Jun 2012 12:25:47 -0400
Message-Id: <1338740747-1809-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fixes a bug in option string parsing wherein a line such as:

  ro,relatime,,nosuid,nodev

Will be seen as only the tokens "ro" and "relatime" after the parser
encounters a zero length (and erroneously declared NULL) option.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 libmount/src/optstr.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libmount/src/optstr.c b/libmount/src/optstr.c
index af5953b..66d2a06 100644
--- a/libmount/src/optstr.c
+++ b/libmount/src/optstr.c
@@ -62,6 +62,11 @@ static int mnt_optstr_parse_next(char **optstr,	 char **name, size_t *namesz,
 	if (valsz)
 		*valsz = 0;
 
+	/* trim leading commas as to not invalidate option
+	 * strings with multiple consecutive commas */
+	while (optstr0 && *optstr0 == ',')
+		optstr0++;
+
 	for (p = optstr0; p && *p; p++) {
 		if (!start)
 			start = p;		/* begin of the option item */
-- 
1.7.10.3

