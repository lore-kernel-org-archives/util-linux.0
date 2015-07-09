Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.pxnet.com ([89.1.7.7]:37261 "EHLO mail.pxnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbbGINbh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Jul 2015 09:31:37 -0400
Message-Id: <b3afb81b26f958beb642f09c0481a9149335ed73.1436438005.git.tilman@imap.cc>
In-Reply-To: <cover.1436438005.git.tilman@imap.cc>
References: <cover.1436438005.git.tilman@imap.cc>
From: Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 1/3] ldattach: adapt print_table column width to widest entry
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Tilman Schmidt <tilman@imap.cc>,
        Paul Bolle <pebolle@tiscali.nl>, Sami Kerola <kerolasa@iki.fi>
Date: Thu,  9 Jul 2015 15:22:32 +0200 (CEST)
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The hardcoded column width of 10 in print_table() is not enough, as
the currently longest table entry to be printed has 12 characters.

Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---
 sys-utils/ldattach.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/ldattach.c b/sys-utils/ldattach.c
index 33c7aa2..5317d22 100644
--- a/sys-utils/ldattach.c
+++ b/sys-utils/ldattach.c
@@ -161,8 +161,8 @@ static void print_table(FILE * out, const struct ld_table *tab)
 	int i;
 
 	for (t = tab, i = 1; t && t->name; t++, i++) {
-		fprintf(out, "  %-10s", t->name);
-		if (!(i % 6))
+		fprintf(out, "  %-12s", t->name);
+		if (!(i % 5))
 			fputc('\n', out);
 	}
 }
-- 
1.9.2.459.g68773ac

