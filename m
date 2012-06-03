Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaid.dreamhost.com ([208.97.132.83]:33873 "EHLO
	homiemail-a37.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753992Ab2FCSPa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jun 2012 14:15:30 -0400
Subject: [PATCH 3/5] fdisk: remove user specified sector size global
 variable
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 03 Jun 2012 20:15:27 +0200
Message-ID: <1338747327.2864.12.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From cbd1e6486580b86aaca9345adaf6da69aeb0b1b4 Mon Sep 17 00:00:00 2001
From: Davidlohr Bueso <dave@gnu.org>
Date: Sun, 3 Jun 2012 19:47:44 +0200
Subject: 

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 654d8f3..d8ef14f 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -141,7 +141,6 @@ sector_t sector_offset = 1, sectors;
 
 unsigned int	heads,
 	cylinders,
-	user_set_sector_size = 0,
 	units_per_sector = 1,
 	display_in_cyl_units = 0;
 
@@ -2061,7 +2060,6 @@ int main(int argc, char **argv)
 			    sector_size != 2048 && sector_size != 4096)
 				usage(stderr);
 			sector_offset = 2;
-			user_set_sector_size = 1;
 			break;
 		case 'C':
 			user_cylinders =  strtou32_or_err(optarg, _("invalid cylinders argument"));
@@ -2110,7 +2108,7 @@ int main(int argc, char **argv)
 
 	fdisk_init_debug(0);
 
-	if (user_set_sector_size && argc-optind != 1)
+	if (sector_size && argc-optind != 1)
 		printf(_("Warning: the -b (set sector size) option should"
 			 " be used with one specified device\n"));
 
@@ -2146,7 +2144,7 @@ int main(int argc, char **argv)
 		cxt = fdisk_new_context_from_filename(argv[optind], 0);
 		if (!cxt)
 			err(EXIT_FAILURE, _("unable to open %s"), argv[optind]);
-		if (user_set_sector_size) /* passed -b option, override autodiscovery */
+		if (sector_size) /* passed -b option, override autodiscovery */
 			cxt->phy_sector_size = cxt->sector_size = sector_size;
 	}
 	else
-- 
1.7.4.1




