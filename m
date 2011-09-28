Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48104 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab1I1O0U (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 28 Sep 2011 10:26:20 -0400
Received: by eya28 with SMTP id 28so5673896eya.19
        for <util-linux@vger.kernel.org>; Wed, 28 Sep 2011 07:26:19 -0700 (PDT)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 2/3] ipcrm: use ternary operator in "(key|id) failed" message
Date: Wed, 28 Sep 2011 16:25:30 +0200
Message-Id: <1317219931-20496-2-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1317219931-20496-1-git-send-email-cosoleto@gmail.com>
References: <1317219931-20496-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 sys-utils/ipcrm.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index dc47f90..f6482ab 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -107,9 +107,7 @@ static int remove_id(int type, int iskey, int id)
 			errmsg = iskey ? _("already removed key") : _("already removed id");
 			break;
 		default:
-			if (iskey)
-				err(EXIT_FAILURE, _("key failed"));
-			err(EXIT_FAILURE, _("id failed"));
+			err(EXIT_FAILURE, iskey ? _("key failed") : _("id failed"));
 		}
 		warnx("%s (%d)", errmsg, id);
 		return 1;
-- 
1.7.3.4

