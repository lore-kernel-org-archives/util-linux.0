Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:48515 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758806AbcHDSQA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 4 Aug 2016 14:16:00 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id B77FAABF2
	for <util-linux@vger.kernel.org>; Thu,  4 Aug 2016 18:15:58 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] sfdisk: Add --show-pt-geometry compatibility code
Message-ID: <83b22751-8099-958c-d337-bc357b8f9abc@suse.cz>
Date: Thu, 4 Aug 2016 20:15:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--show-pt-geometry existed since cf3f26bf (2006), and it is used by third party
tools. To prevent failure of these tools, add a minimal compatibility code.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 disk-utils/sfdisk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index d51b261..589cca9 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -1886,6 +1886,7 @@ int main(int argc, char *argv[])
 		{ "reorder", no_argument,       NULL, 'r' },
 		{ "show-size", no_argument,	NULL, 's' },
 		{ "show-geometry", no_argument, NULL, 'g' },
+		{ "show-pt-geometry", no_argument, NULL, 'G' },
 		{ "quiet",   no_argument,       NULL, 'q' },
 		{ "verify",  no_argument,       NULL, 'V' },
 		{ "version", no_argument,       NULL, 'v' },
@@ -1912,7 +1913,7 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "aAbcdfFghJlLo:O:nN:qrsTu:vVX:Y:w:W:",
+	while ((c = getopt_long(argc, argv, "aAbcdfFgGhJlLo:O:nN:qrsTu:vVX:Y:w:W:",
 					longopts, &longidx)) != -1) {
 		switch(c) {
 		case 'A':
@@ -1947,6 +1948,8 @@ int main(int argc, char *argv[])
 		case 'f':
 			sf->force = 1;
 			break;
+		case 'G':
+			warnx(_("--show-pt-geometry is no more implemented. Using --show-geometry."));
 		case 'g':
 			sf->act = ACT_SHOW_GEOM;
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
