Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:39353 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755197AbcATUUO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Jan 2016 15:20:14 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 18DB6340754
	for <util-linux@vger.kernel.org>; Wed, 20 Jan 2016 20:20:13 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] mount: allow nofail to silence ENOMEDIUM cases
Date: Wed, 20 Jan 2016 15:20:08 -0500
Message-Id: <1453321208-691-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <20160119232458.GO14840@vapier.lan>
References: <20160119232458.GO14840@vapier.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Allow people to use nofail to ignore empty cd/dvd drive errors.

URL: https://bugs.gentoo.org/559356
Reported-by: William Hubbs <williamh@gentoo.org>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sys-utils/mount.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 73f9d0b..01eaccb 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -628,6 +628,9 @@ try_readonly:
 		break;
 
 	case ENOMEDIUM:
+		if (uflags & MNT_MS_NOFAIL)
+			return MOUNT_EX_SUCCESS;
+
 		warnx(_("no medium found on %s"), src);
 		break;
 
-- 
2.6.2

