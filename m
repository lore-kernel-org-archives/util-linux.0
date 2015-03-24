Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:52746 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085AbbCXUBM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Mar 2015 16:01:12 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id B1A8AAD0F
	for <util-linux@vger.kernel.org>; Tue, 24 Mar 2015 20:01:10 +0000 (UTC)
Message-ID: <5511C286.90500@suse.cz>
Date: Tue, 24 Mar 2015 21:01:10 +0100
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] Fix fsck -C {fd} parsing
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Both fsck(8) and fsck --help documents progress bar redirection as
-C {fd}

This did not work, and only -C{fd} and "-C {fd}" worked.
---
 disk-utils/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 5842da4..817be97 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -1471,7 +1471,7 @@ static void parse_argv(int argc, char *argv[])
 					else
 						goto next_arg;
 				} else if (i+1 < argc && *argv[i+1] != '-') {	/* -C <fd> */
-					progress_fd = string_to_int(argv[i]);
+					progress_fd = string_to_int(argv[i+1]);
 					if (progress_fd < 0)
 						progress_fd = 0;
 					else {
-- 
2.3.3

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
