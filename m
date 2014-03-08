Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f51.google.com ([209.85.219.51]:38346 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbaCHRCK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Mar 2014 12:02:10 -0500
Received: by mail-oa0-f51.google.com with SMTP id i4so5399499oah.24
        for <util-linux@vger.kernel.org>; Sat, 08 Mar 2014 09:02:09 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/5] mkswap: remove unnecessary usage output
Date: Sat,  8 Mar 2014 11:01:53 -0600
Message-Id: <1394298117-16531-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The usage output changes too often making unnecessarily expected output
in test unstable.  Besides in this case the usage ouput does not even
help user, because invalid swap target size error cannot be fixed by
specificing an option.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index a2c6529..ae73f80 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -545,18 +545,16 @@ main(int argc, char **argv) {
 	sz = get_size(device_name);
 	if (!PAGES)
 		PAGES = sz;
-	else if (PAGES > sz && !force) {
+	else if (PAGES > sz && !force)
 		errx(EXIT_FAILURE,
 			_("error: "
 			  "size %llu KiB is larger than device size %llu KiB"),
 			PAGES*(pagesize/1024), sz*(pagesize/1024));
-	}
 
-	if (PAGES < MIN_GOODPAGES) {
-		warnx(_("error: swap area needs to be at least %ld KiB"),
-			(long)(MIN_GOODPAGES * pagesize/1024));
-		usage(stderr);
-	}
+	if (PAGES < MIN_GOODPAGES)
+		errx(EXIT_FAILURE,
+		     _("error: swap area needs to be at least %ld KiB"),
+		     (long)(MIN_GOODPAGES * pagesize / 1024));
 
 #ifdef __linux__
 	if (get_linux_version() >= KERNEL_VERSION(2,3,4))
-- 
1.9.0

