Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor.suse.de ([195.135.220.2]:35812 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab1FHNfE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Jun 2011 09:35:04 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id EA6ED74609
	for <util-linux@vger.kernel.org>; Wed,  8 Jun 2011 15:35:02 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH] uuidgen: print warning if uuidd isn't running
Date: Wed,  8 Jun 2011 15:35:01 +0200
Message-Id: <1307540101-6376-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 misc-utils/uuidgen.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index 3cf6ec9..47f8e8f 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -59,7 +59,9 @@ main (int argc, char *argv[])
 
 	switch (do_type) {
 	case DO_TYPE_TIME:
-		uuid_generate_time(uu);
+		if (uuid_generate_time_safe(uu)) {
+			fprintf(stderr, _("Warning: uuidd not running or not operational. Time based uuid may not be unique.\n"));
+		}
 		break;
 	case DO_TYPE_RANDOM:
 		uuid_generate_random(uu);
-- 
1.7.3.4

