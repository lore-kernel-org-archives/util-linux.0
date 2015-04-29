Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:48428 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966386AbbD2Qtt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 29 Apr 2015 12:49:49 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 06B37ABBB
	for <util-linux@vger.kernel.org>; Wed, 29 Apr 2015 16:49:48 +0000 (UTC)
Message-ID: <55410BAB.4030009@suse.cz>
Date: Wed, 29 Apr 2015 18:49:47 +0200
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] fsck: Fix parsing of -r
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fix regression introduced by commit 658c089: -r cannot be used as a last
option:

fsck -r /dev/sda1
fsck: invalid argument -r: '/dev/sda1'

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 disk-utils/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index bd2bf36..465e6d3 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -1525,7 +1525,7 @@ static void parse_argv(int argc, char *argv[])
 				if (arg[j+1]) {					/* -r<fd> */
 					report_stats_fd = strtou32_or_err(arg+j+1, _("invalid argument -r"));
 					goto next_arg;
-				} else if (i+1 < argc && *argv[i+1] != '-') {	/* -r <fd> */
+				} else if (i+1 < argc && *argv[i+1] >= '0' && *argv[i+1] <= '9') {	/* -r <fd> */
 					report_stats_fd = strtou32_or_err(argv[i+1], _("invalid argument -r"));
 					++i;
 					goto next_arg;
-- 
2.3.5

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
