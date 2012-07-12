Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:45165 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758798Ab2GLIKu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Jul 2012 04:10:50 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 2D557A4508
	for <util-linux@vger.kernel.org>; Thu, 12 Jul 2012 10:10:49 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 2/2] libblkid: cast blkid_loff_t to unsigned long long
Date: Thu, 12 Jul 2012 10:09:59 +0200
Message-Id: <1342080599-12346-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1342080599-12346-1-git-send-email-petr.uzel@suse.cz>
References: <1342080599-12346-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Get rid of gcc warning and fix build with -Werror

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 libblkid/src/probe.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 33220df..7c1a020 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -1256,7 +1256,7 @@ int blkid_probe_set_magic(blkid_probe pr, blkid_loff_t offset,
 		rc = blkid_probe_set_value(pr, "SBMAGIC", magic, len);
 		if (!rc)
 			rc = blkid_probe_sprintf_value(pr,
-					"SBMAGIC_OFFSET", "%llu", offset);
+					"SBMAGIC_OFFSET", "%llu", (unsigned long long)offset);
 		break;
 	case BLKID_CHAIN_PARTS:
 		if (!(chn->flags & BLKID_PARTS_MAGIC))
@@ -1264,7 +1264,7 @@ int blkid_probe_set_magic(blkid_probe pr, blkid_loff_t offset,
 		rc = blkid_probe_set_value(pr, "PTMAGIC", magic, len);
 		if (!rc)
 			rc = blkid_probe_sprintf_value(pr,
-					"PTMAGIC_OFFSET", "%llu", offset);
+					"PTMAGIC_OFFSET", "%llu", (unsigned long long)offset);
 		break;
 	default:
 		break;
-- 
1.7.7

