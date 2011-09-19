Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34161 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934Ab1ISN3Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 Sep 2011 09:29:16 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id C5FF98F0A5
	for <util-linux@vger.kernel.org>; Mon, 19 Sep 2011 15:29:15 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/7] sfdisk: file descriptor is of int type
Date: Mon, 19 Sep 2011 15:29:09 +0200
Message-Id: <1316438955-20790-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
References: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/sfdisk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 46245d3..81a50ee 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -156,7 +156,7 @@ fatal(char *s, ...) {
  */
 
 static int
-sseek(char *dev, unsigned int fd, unsigned long s) {
+sseek(char *dev, int fd, unsigned long s) {
     off_t in, out;
     in = ((off_t) s << 9);
     out = 1;
-- 
1.7.3.4

