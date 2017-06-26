Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:52206 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751402AbdFZQUO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Jun 2017 12:20:14 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiTF6-1e2APr1Y8S-00clCh for
 <util-linux@vger.kernel.org>; Mon, 26 Jun 2017 18:20:07 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] uuidparse: fix getopt crash
Date: Mon, 26 Jun 2017 18:20:06 +0200
Message-Id: <20170626162006.25240-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

$ ./uuidparse --unknownopt
Segmentation fault (core dumped)

Hehe, this is the first real bug found by 'make checkusage'.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/uuidparse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc-utils/uuidparse.c b/misc-utils/uuidparse.c
index 0938b8559..09a6b46a8 100644
--- a/misc-utils/uuidparse.c
+++ b/misc-utils/uuidparse.c
@@ -299,6 +299,7 @@ int main(int argc, char **argv)
 		{"raw",        no_argument,       NULL, 'r'},
 		{"version",    no_argument,       NULL, 'V'},
 		{"help",       no_argument,       NULL, 'h'},
+		{NULL, 0, NULL, 0}
 	};
 	static const ul_excl_t excl[] = {
 		{'J', 'r'},
-- 
2.12.3

