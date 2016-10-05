Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:40807 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752590AbcJESzo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 5 Oct 2016 14:55:44 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6E233AD45
        for <util-linux@vger.kernel.org>; Wed,  5 Oct 2016 18:55:42 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] losetup --nooverlap: fix typo
Message-ID: <fdaaf809-fdbf-e6bf-01d6-caa96a089c0a@suse.cz>
Date: Wed, 5 Oct 2016 20:55:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Option is documented and used as --nooverlap, bud coded as --nooverlaps.
--nooverlap is considered as shortened option, making the typo
invisible.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/losetup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 9083a13..215ab9c 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -579,7 +579,7 @@ int main(int argc, char **argv)
 		{ "detach", 1, 0, 'd' },
 		{ "detach-all", 0, 0, 'D' },
 		{ "find", 0, 0, 'f' },
-		{ "nooverlaps", 0, 0, 'L' },
+		{ "nooverlap", 0, 0, 'L' },
 		{ "help", 0, 0, 'h' },
 		{ "associated", 1, 0, 'j' },
 		{ "json", 0, 0, 'J' },
-- 
2.10.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
