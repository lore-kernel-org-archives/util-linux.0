Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:45659 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab2GZOEd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 10:04:33 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: dave@gnu.org
Subject: [PATCH 2/5] fdisk: fix typo
Date: Thu, 26 Jul 2012 16:04:25 +0200
Message-Id: <1343311468-20206-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1343311468-20206-1-git-send-email-petr.uzel@suse.cz>
References: <1343311468-20206-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisks/fdisk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 0aa8a0b..3eddfa1 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -1561,7 +1561,7 @@ expert_command_prompt(struct fdisk_context *cxt)
 			if (dos_compatible_flag)
 				fprintf(stderr, _("Warning: setting "
 					"sector offset for DOS "
-					"compatiblity\n"));
+					"compatibility\n"));
 			update_sector_offset(cxt);
 			update_units(cxt);
 			break;
-- 
1.7.7

