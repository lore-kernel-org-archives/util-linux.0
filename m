Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:35881 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812Ab2FLMuS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Jun 2012 08:50:18 -0400
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0M5I00J4M8ZS0C80@damascus.uab.es> for
 util-linux@vger.kernel.org; Tue, 12 Jun 2012 14:50:16 +0200 (CEST)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0M5I0022K8ZS3030@damascus.uab.es>
 forutil-linux@vger.kernel.org; Tue, 12 Jun 2012 14:50:16 +0200 (CEST)
Date: Tue, 12 Jun 2012 14:50:06 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH] partx: use -s option for default output
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1339505406.17574.1.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

It's been around a year and a half now that partx was rewritten, 
and the legacy output should no longer be default.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 partx/partx.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/partx/partx.c b/partx/partx.c
index f19b919..68246db 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -744,9 +744,8 @@ int main(int argc, char **argv)
 	if (ncolumns && !what)
 		what = ACT_SHOW;
 
-	/* backwardly compatible default */
 	if (!what)
-		what = ACT_LIST;
+		what = ACT_SHOW;
 
 	/* --show default, could by modified by -o  */
 	if (what == ACT_SHOW && !ncolumns) {
-- 
1.7.8.3



