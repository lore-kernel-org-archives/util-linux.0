Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:55818 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968246AbcHBRz3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2016 13:55:29 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 2BA21ABE0
	for <util-linux@vger.kernel.org>; Tue,  2 Aug 2016 17:55:28 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 1/8] losetup: Introduce --force
Message-ID: <21122d63-3b4e-9a96-77d6-77c4930ba6f7@suse.cz>
Date: Tue, 2 Aug 2016 19:55:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

To introduce loop device re-use amd conflict checks, we need a new parameter to
force old dangerous behavior that can cause data corruption.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/losetup.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index d9c75b9..0a323a9 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -56,6 +56,7 @@ enum {
 static int no_headings;
 static int raw;
 static int json;
+static int force;
 
 struct colinfo {
 	const char *name;
@@ -390,6 +391,7 @@ static void usage(FILE *out)
 	fputs(_(" -d, --detach <loopdev>...     detach one or more devices\n"), out);
 	fputs(_(" -D, --detach-all              detach all used devices\n"), out);
 	fputs(_(" -f, --find                    find first unused device\n"), out);
+	fputs(_(" -F, --force                   force to create conflicting loop device (dangerous)\n"), out);
 	fputs(_(" -c, --set-capacity <loopdev>  resize the device\n"), out);
 	fputs(_(" -j, --associated <file>       list all devices associated with <file>\n"), out);
 
@@ -467,6 +469,7 @@ int main(int argc, char **argv)
 		{ "detach", 1, 0, 'd' },
 		{ "detach-all", 0, 0, 'D' },
 		{ "find", 0, 0, 'f' },
+		{ "force", 0, 0, 'F' },
 		{ "help", 0, 0, 'h' },
 		{ "associated", 1, 0, 'j' },
 		{ "json", 0, 0, 'J' },
@@ -502,7 +505,7 @@ int main(int argc, char **argv)
 	if (loopcxt_init(&lc, 0))
 		err(EXIT_FAILURE, _("failed to initialize loopcxt"));
 
-	while ((c = getopt_long(argc, argv, "ac:d:Dfhj:Jlno:O:PrvV",
+	while ((c = getopt_long(argc, argv, "ac:d:DfFhj:Jlno:O:PrvV",
 				longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
@@ -534,6 +537,9 @@ int main(int argc, char **argv)
 		case 'f':
 			act = A_FIND_FREE;
 			break;
+		case 'F':
+			force = 1;
+			break;
 		case 'h':
 			usage(stdout);
 			break;
-- 
2.9.2

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
